Return-Path: <David.Daney@cavium.com>
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-cys01nam02on0087.outbound.protection.outlook.com [104.47.37.87])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vXCH45cRFzDqC0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Feb 2017 06:59:59 +1100 (AEDT)
Subject: Re: [PATCH] jump_label: align jump_entry table to at least 4-bytes
To: Jason Baron <jbaron@akamai.com>, rostedt@goodmis.org
References: <1488221364-13905-1-git-send-email-jbaron@akamai.com>
 <f7532548-7007-1a32-f669-4520792805b3@caviumnetworks.com>
 <93219edf-0f6d-5cc7-309c-c998f16fe7ac@akamai.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
 Ingo Molnar <mingo@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Anton Blanchard <anton@samba.org>, Rabin Vincent <rabin@rab.in>,
 Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>,
 Chris Metcalf <cmetcalf@mellanox.com>, Zhigang Lu <zlu@ezchip.com>
From: David Daney <ddaney@caviumnetworks.com>
Message-ID: <aa139c18-1b04-2c20-2e22-89d74503b3cf@caviumnetworks.com>
Date: Mon, 27 Feb 2017 11:59:50 -0800
MIME-Version: 1.0
In-Reply-To: <93219edf-0f6d-5cc7-309c-c998f16fe7ac@akamai.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/27/2017 11:18 AM, Jason Baron wrote:
>
>
> On 02/27/2017 01:57 PM, David Daney wrote:
>> On 02/27/2017 10:49 AM, Jason Baron wrote:
>>> The core jump_label code makes use of the 2 lower bits of the
>>> static_key::[type|entries|next] field. Thus, ensure that the jump_entry
>>> table is at least 4-byte aligned.
>>>
>> [...]
>>> diff --git a/arch/mips/include/asm/jump_label.h
>>> b/arch/mips/include/asm/jump_label.h
>>> index e77672539e8e..243791f3ae71 100644
>>> --- a/arch/mips/include/asm/jump_label.h
>>> +++ b/arch/mips/include/asm/jump_label.h
>>> @@ -31,6 +31,7 @@ static __always_inline bool
>>> arch_static_branch(struct static_key *key, bool bran
>>>      asm_volatile_goto("1:\t" NOP_INSN "\n\t"
>>>          "nop\n\t"
>>>          ".pushsection __jump_table,  \"aw\"\n\t"
>>> +        ".balign 4\n\t"
>>>          WORD_INSN " 1b, %l[l_yes], %0\n\t"
>>>          ".popsection\n\t"
>>>          : :  "i" (&((char *)key)[branch]) : : l_yes);
>>> @@ -45,6 +46,7 @@ static __always_inline bool
>>> arch_static_branch_jump(struct static_key *key, bool
>>>      asm_volatile_goto("1:\tj %l[l_yes]\n\t"
>>>          "nop\n\t"
>>>          ".pushsection __jump_table,  \"aw\"\n\t"
>>> +        ".balign 4\n\t"
>>>          WORD_INSN " 1b, %l[l_yes], %0\n\t"
>>>          ".popsection\n\t"
>>>          : :  "i" (&((char *)key)[branch]) : : l_yes);
>>
>>
>> I will speak only for the MIPS part.
>>
>> If the section is not already properly aligned, this change will add
>> padding, which is probably not what we want.
>>
>> Have you ever seen a problem with misalignment in the real world?
>>
>
> Hi,
>
> Yes, there was a WARN_ON() reported on POWER here:
>
> https://lkml.org/lkml/2017/2/19/85
>
> The WARN_ON() triggers if either of the 2 lsb are set. More
> specifically, its coming from 'static_key_set_entries()' from the
> following patch, which was recently added to linux-next:
>
> https://lkml.org/lkml/2017/2/3/558
>
> So this was not seen on mips, but I included all arches in this patch
> that I though might be affected.
>
>> If so, I think a better approach might be to set properties on the
>> __jump_table section to force the proper alignment, or do something in
>> the linker script.
>>
>
> So in include/asm-generic/vmlinux.lds.h, we are already setting
> 'ALIGN(8)', but that does not appear to be sufficient for POWER...

Yes, I just looked at that.  The ALIGN(8), combined with the fact that 
on MIPS, WORD_INSN will always be of size 4 or 8 (32-bit vs. 64-bit 
kernel), seems to make any additional .balign completely unnecessary.


Really, I think you need to figure out why on powerpc the alignments are 
getting screwed up.  The struct jump_entry entries are on a stride of 12 
(for a 32-bit kernel) or 24 (for a 64-bit kernel), any alignment padding 
added by .balign 4 will surely screw that up.

This patch seems like it is papering over a bigger issue that is not 
understood.

I think a proper fix would be to fix whatever is causing the powerpc 
JUMP_ENTRY_TYPE to misbehave.


>
> Also, I checked the size of the vmlinux generated after this change on
> all 4 arches, and it was rather minimal. I think POWER increased the
> most, but the other arches increased by only a few bytes.

For me the size is not the important issue, it is the alignment of the 
struct jump_entry entries in the table.  I don't understand how your 
patch helps, and I cannot Acked-by unless I understand what is being 
done and can see that it is both correct and necessary.

David.
