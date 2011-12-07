Return-Path: <suzuki@in.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp07.in.ibm.com", Issuer "GeoTrust SSL CA" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 00ECF1007D1
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Dec 2011 23:41:09 +1100 (EST)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <suzuki@in.ibm.com>;
 Wed, 7 Dec 2011 18:11:01 +0530
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 pB7CevKm1597590
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 7 Dec 2011 18:10:57 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 pB7CetoP021674
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 7 Dec 2011 23:40:56 +1100
Message-ID: <4EDF5ED7.2030709@in.ibm.com>
Date: Wed, 07 Dec 2011 18:10:55 +0530
From: Suzuki Poulose <suzuki@in.ibm.com>
MIME-Version: 1.0
To: Josh Boyer <jwboyer@gmail.com>
Subject: Re: [PATCH v3 2/8] [booke] Rename mapping based RELOCATABLE to
 DYNAMIC_MEMSTART for BookE
References: <20111114053749.23410.63745.stgit@suzukikp.in.ibm.com>
 <20111114054144.23410.65704.stgit@suzukikp.in.ibm.com>
 <CA+5PVA6uVpB6XUFkjUABJCcVjubFiWWEQgmuMijTQpdAiN7PdQ@mail.gmail.com>
 <4ED4126D.7000201@freescale.com>
 <CA+5PVA7r215N3NZV9gaTiXzeiwBnPBMbssX0Qo3zJ-9eGJaypA@mail.gmail.com>
In-Reply-To: <CA+5PVA7r215N3NZV9gaTiXzeiwBnPBMbssX0Qo3zJ-9eGJaypA@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Scott Wood <scottwood@freescale.com>,
 Josh Poimboeuf <jpoimboe@linux.vnet.ibm.com>,
 David Laight <David.Laight@aculab.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/30/11 20:11, Josh Boyer wrote:
> On Mon, Nov 28, 2011 at 5:59 PM, Scott Wood<scottwood@freescale.com>  wrote:
>> On 11/23/2011 10:47 AM, Josh Boyer wrote:
>>> On Mon, Nov 14, 2011 at 12:41 AM, Suzuki K. Poulose<suzuki@in.ibm.com>  wrote:
>>>> The current implementation of CONFIG_RELOCATABLE in BookE is based
>>>> on mapping the page aligned kernel load address to KERNELBASE. This
>>>> approach however is not enough for platforms, where the TLB page size
>>>> is large (e.g, 256M on 44x). So we are renaming the RELOCATABLE used
>>>> currently in BookE to DYNAMIC_MEMSTART to reflect the actual method.
>>
>> Should reword the config help to make it clear what the alignment
>> restriction is, or where to find the information for a particular
>> platform.  Someone reading "page aligned" without any context that we're
>> talking about special large pages is going to think 4K -- and on e500,
>> many large page sizes are supported, so the required alignment is found
>> in Linux init code rather than a CPU manual.
>>
>>>>
>>>> The CONFIG_RELOCATABLE for PPC32(BookE) based on processing of the
>>>> dynamic relocations will be introduced in the later in the patch series.
>>>>
>>>> This change would allow the use of the old method of RELOCATABLE for
>>>> platforms which can afford to enforce the page alignment (platforms with
>>>> smaller TLB size).
>>>
>>> I'm OK with the general direction, but this touches a lot of non-4xx
>>> code.  I'd prefer it if Ben took this directly on whatever final
>>> solution is done.
>>>
>>>> I haven tested this change only on 440x. I don't have an FSL BookE to verify
>>>> the changes there.
>>>>
>>>> Scott,
>>>> Could you please test this patch on FSL and let me know the results ?
>>>
>>> Scott, did you ever get around to testing this?  In my opinion, this
>>> shouldn't go in without a Tested-by: from someone that tried it on an
>>> FSL platform.
>>
>> Booted OK for me on e500v2 with RAM starting at 256M.
>>
>> Tested-by: Scott Wood<scottwood@freescale.com>
>>
>>> We add DYNAMIC_MEMSTART for 32-bit, and we have RELOCATABLE for
>>> 64-bit.  Then throughout almost the rest of the patch, all we're doing
>>> is duplicating what RELOCATABLE already did (e.g. if ! either thing).
>>> It works, but it is kind of ugly.
>>>
>>> Instead, could we define a helper config variable that can be used in
>>> place of that construct?  Something like:
>>>
>>> config NONSTATIC_KERNEL (or whatever)
>>>      bool
>>>      default n
>>>
>>> ...
>>>
>>> config DYNAMIC_MEMSTART
>>>      <blah>
>>>      select NONSTATIC_KERNEL
>>>
>>> ...
>>>
>>> config RELOCATABLE
>>>      <blah>
>>>      select NONSTATIC_KERNEL
>>
>> I agree.
>
> Suzie do you think you could respin this patch with the suggested
> changes and include Scott's Tested-by?  The rest of the series looks
> fine and I'd like to get it included in my next branch.
>
Josh,

I rebased my patches to 3.2.0-rc3 and was able to verify it on my QEMU setup.
However I am facing problems getting the my boards booted with the network cards
(even without the patches). Here is what I see :


Creating 2 MTD partitions on "1ff800000.large-flash":
0x000000000000-0x000000380000 : "fs"
0x000000380000-0x000000400000 : "firmware"
PPC 4xx OCP EMAC driver, version 3.54
mal0: failed to map interrupts !
ZMII /plb/opb/emac-zmii@40000780 initialized
/plb/opb/ethernet@40000800: Timeout waiting for dependent devices
/plb/opb/ethernet@40000900: Timeout waiting for dependent devices
TCP cubic registered
NET: Registered protocol family 17
Root-NFS: no NFS server address
VFS: Unable to mount root fs via NFS, trying floppy.
VFS: Cannot open root device "(null)" or unknown-block(2,0)
Please append a correct "root=" boot option; here are the available partitions:
1f00             512 mtdblock0  (driver?)
1f01            3584 mtdblock1  (driver?)
1f02             512 mtdblock2  (driver?)
Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(2,0)

Have you come across this message ?


Thanks
Suzuki
