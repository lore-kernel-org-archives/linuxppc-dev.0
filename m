Return-Path: <jbaron@akamai.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vT16M0M7DzDq5g
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Feb 2017 02:11:23 +1100 (AEDT)
Received: from prod-mail-xrelay07.akamai.com (prod-mail-xrelay07.akamai.com
 [23.79.238.175])
 by ozlabs.org (Postfix) with ESMTP id 3vT16L08l4z9s7d
 for <linuxppc-dev@ozlabs.org>; Thu, 23 Feb 2017 02:11:21 +1100 (AEDT)
Subject: Re: next-20170217 boot on POWER8 LPAR : WARNING
 @kernel/jump_label.c:287
To: Michael Ellerman <mpe@ellerman.id.au>,
 Sachin Sant <sachinp@linux.vnet.ibm.com>,
 Steven Rostedt <rostedt@goodmis.org>
References: <E6A8A7A8-6A55-4989-BAE9-39274876CA3C@linux.vnet.ibm.com>
 <1dffdaac-be8b-0052-52d4-a65fed39f894@akamai.com>
 <02B52EFB-4608-47F3-A81C-B8B52DB11233@linux.vnet.ibm.com>
 <20c53e88-acf5-4c4f-cea9-4dd8745814b5@akamai.com>
 <877f4in5tn.fsf@concordia.ellerman.id.au>
Cc: linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 linuxppc-dev@ozlabs.org
From: Jason Baron <jbaron@akamai.com>
Message-ID: <44116d94-20f8-29e1-5046-1f8c49fb67ed@akamai.com>
Date: Wed, 22 Feb 2017 10:11:18 -0500
MIME-Version: 1.0
In-Reply-To: <877f4in5tn.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/22/2017 12:38 AM, Michael Ellerman wrote:
> Jason Baron <jbaron@akamai.com> writes:
> 
>> On 02/20/2017 10:05 PM, Sachin Sant wrote:
>>>
>>>> On 20-Feb-2017, at 8:27 PM, Jason Baron <jbaron@akamai.com
>>>> <mailto:jbaron@akamai.com>> wrote:
>>>>
>>>> Hi,
>>>>
>>>> On 02/19/2017 09:07 AM, Sachin Sant wrote:
>>>>> While booting next-20170217 on a POWER8 LPAR following
>>>>> warning is displayed.
>>>>>
>>>>> Reverting the following commit helps boot cleanly.
>>>>> commit 3821fd35b5 :  jump_label: Reduce the size of struct static_key
>>>>>
>>>>> [   11.393008] ------------[ cut here ]------------
>>>>> [   11.393031] WARNING: CPU: 5 PID: 2890 at kernel/jump_label.c:287
>>>>> static_key_set_entries.isra.10+0x3c/0x50
>>>>
>>>> Thanks for the report. So this is saying that the jump_entry table is
>>>> not at least 4-byte aligned. I wonder if this fixes it up?
>>>>
>>>
>>> Yes. With this patch the warning is gone.
>>
>> Hi,
>>
>> Thanks for testing. We probably need something like the following to 
>> make sure we don't hit this on other arches. Steve - I will send 4 
>> separate patches for this to get arch maintainers' acks for this?
> 
> What's the 4 byte alignment requirement from?
>

The 4 byte alignment is coming from this patch in linux-next:

https://lkml.org/lkml/2017/2/3/558

It reduces the size of 'struct static_key' by making use of the two
least significant bits of the static_key::entry pointer. Thus, the
jump_entry table needs to be 4 byte aligned to make it work. I added a
WARN_ON() to make sure the jump_entry table is in fact 4 byte aligned,
and that is what we hit here.

> On 64-bit our JUMP_ENTRY_TYPE is 8 bytes, should we be aligning to 8
> bytes?
> 

4 bytes should be sufficient and apparently fixes the WARN_ON() that was
hit.

>> diff --git a/arch/powerpc/include/asm/jump_label.h 
>> b/arch/powerpc/include/asm/jump_label.h
>> index 9a287e0ac8b1..f870a85bac46 100644
>> --- a/arch/powerpc/include/asm/jump_label.h
>> +++ b/arch/powerpc/include/asm/jump_label.h
>> @@ -24,6 +24,7 @@ static __always_inline bool arch_static_branch(struct 
>> static_key *key, bool bran
>>          asm_volatile_goto("1:\n\t"
>>                   "nop # arch_static_branch\n\t"
>>                   ".pushsection __jump_table,  \"aw\"\n\t"
>> +                ".balign 4 \n\t"
> 
> Can you line those up vertically?
> 
> (That may just be an email artifact)

sure will fix.

Thanks,

-Jason

> 
>>                   JUMP_ENTRY_TYPE "1b, %l[l_yes], %c0\n\t"
>>                   ".popsection \n\t"
>>                   : :  "i" (&((char *)key)[branch]) : : l_yes);
>> @@ -38,6 +39,7 @@ static __always_inline bool 
>> arch_static_branch_jump(struct static_key *key, bool
>>          asm_volatile_goto("1:\n\t"
>>                   "b %l[l_yes] # arch_static_branch_jump\n\t"
>>                   ".pushsection __jump_table,  \"aw\"\n\t"
>> +                ".balign 4 \n\t"
>>                   JUMP_ENTRY_TYPE "1b, %l[l_yes], %c0\n\t"
>>                   ".popsection \n\t"
>>                   : :  "i" (&((char *)key)[branch]) : : l_yes);
>> @@ -63,6 +65,7 @@ struct jump_entry {
>>   #define ARCH_STATIC_BRANCH(LABEL, KEY)         \
>>   1098:  nop;                                    \
>>          .pushsection __jump_table, "aw";        \
>> +       .balign 4;                              \
>>          FTR_ENTRY_LONG 1098b, LABEL, KEY;       \
>>          .popsection
>>   #endif
> 
> Otherwise that looks fine assuming 4 bytes is the correct alignment.
> 
> cheers
> 
