Return-Path: <fweimer@redhat.com>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 401PRP0gpRzDqy0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Mar 2018 19:05:36 +1100 (AEDT)
Subject: Re: [PATCH] x86, powerpc : pkey-mprotect must allow pkey-0
From: Florian Weimer <fweimer@redhat.com>
To: Ram Pai <linuxram@us.ibm.com>
Cc: mpe@ellerman.id.au, mingo@redhat.com, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, x86@kernel.org,
 linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 dave.hansen@intel.com, benh@kernel.crashing.org, paulus@samba.org,
 khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 bsingharora@gmail.com, hbabu@us.ibm.com, mhocko@kernel.org,
 bauerman@linux.vnet.ibm.com, ebiederm@xmission.com, corbet@lwn.net,
 arnd@arndb.de, msuchanek@suse.com, Ulrich.Weigand@de.ibm.com
References: <1520583161-11741-1-git-send-email-linuxram@us.ibm.com>
 <ec90ed75-2810-bcc3-8439-8dc85a6b46ac@redhat.com>
 <20180309200017.GR1060@ram.oc3035372033.ibm.com>
 <f71b583f-2b66-e9ed-b08b-fddff228a5a7@redhat.com>
Message-ID: <0a6981b3-dcd2-4dce-3209-7f8055d8548f@redhat.com>
Date: Wed, 14 Mar 2018 09:05:30 +0100
MIME-Version: 1.0
In-Reply-To: <f71b583f-2b66-e9ed-b08b-fddff228a5a7@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/14/2018 09:00 AM, Florian Weimer wrote:
> On 03/09/2018 09:00 PM, Ram Pai wrote:
>> On Fri, Mar 09, 2018 at 12:04:49PM +0100, Florian Weimer wrote:
>>> On 03/09/2018 09:12 AM, Ram Pai wrote:
>>>> Once an address range is associated with an allocated pkey, it 
>>>> cannot be
>>>> reverted back to key-0. There is no valid reason for the above 
>>>> behavior.
>>>
>>> mprotect without a key does not necessarily use key 0, e.g. if
>>> protection keys are used to emulate page protection flag combination
>>> which is not directly supported by the hardware.
>>>
>>> Therefore, it seems to me that filtering out non-allocated keys is
>>> the right thing to do.
>>
>> I am not sure, what you mean. Do you agree with the patch or otherwise?
> 
> I think it's inconsistent to make key 0 allocated, but not the key which 
> is used for PROT_EXEC emulation, which is still reserved.  Even if you 
> change the key 0 behavior, it is still not possible to emulate mprotect 
> behavior faithfully with an allocated key.

Ugh.  Should have read the code first before replying:

         /* Do we need to assign a pkey for mm's execute-only maps? */
         if (execute_only_pkey == -1) {
                 /* Go allocate one to use, which might fail */
                 execute_only_pkey = mm_pkey_alloc(mm);
                 if (execute_only_pkey < 0)
                         return -1;
                 need_to_set_mm_pkey = true;
         }

So we do allocate the PROT_EXEC-only key, and I assume it means that the 
key can be restored using pkey_mprotect.  So the key 0 behavior is a 
true exception after all, and it makes sense to realign the behavior 
with the other keys.

Thanks,
Florian
