Return-Path: <chzigotzky@xenosoft.de>
Received: from mo6-p00-ob.smtp.rzone.de (mo6-p00-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5300::8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rMJ9j4J41zDq80
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 Jun 2016 21:08:38 +1000 (AEST)
Subject: Kernel 4.7: PAGE_GUARDED and _PAGE_NO_CACHE
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org, darren@stevens-zone.net,
 Michael Ellerman <michaele@au1.ibm.com>, Julian Margetson
 <runaway@candw.ms>, Adrian Cox <adrian@humboldt.co.uk>,
 "R.T.Dickinson" <rtd@a-eon.com>, "R.T.Dickinson" <rtd2@xtra.co.nz>,
 Pat Wall <pjwall@mac.com>, Pat Wall <pjwall@me.com>,
 "contact@a-eon.com" <contact@a-eon.com>, Matthew Leaman <matthew@a-eon.biz>,
 luigi burdo <intermediadc@hotmail.com>, Christian Zigotzky <info@xenosoft.de>
References: <8B4C4AB7-5C17-4992-935A-361153472793@xenosoft.de>
 <1463990507.3078.16.camel@kernel.crashing.org>
 <cff72fd8-3297-b61b-4ddc-8c491b565f80@xenosoft.de>
 <1464088614.3078.79.camel@kernel.crashing.org>
 <1298e1f6-beb7-5487-72a1-366ebd140c17@xenosoft.de>
 <87d1obqxg9.fsf@skywalker.in.ibm.com>
 <9690f9a4-70c7-8acc-42d0-779bcc93db52@xenosoft.de>
 <66397458-c40a-4e83-c5e5-0ba69fb48986@xenosoft.de>
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Message-ID: <fa666396-4b81-f317-18e2-48078233bb57@xenosoft.de>
Date: Sat, 4 Jun 2016 13:08:22 +0200
MIME-Version: 1.0
In-Reply-To: <66397458-c40a-4e83-c5e5-0ba69fb48986@xenosoft.de>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi All,

I compiled the latest git version of kernel 4.7 with all PowerPC 
commits. Maybe the latest commit powerpc-4.7-2 solved the boot issues. 
Our latest Nemo patch 4.7-1 works without any problems with the latest 
git version.

I got the following error message:

arch/powerpc/kernel/pci-common.c: In function 
‘pci_process_bridge_OF_ranges’:
arch/powerpc/kernel/pci-common.c:732:59: error: ‘_PAGE_GUARDED’ 
undeclared (first use in this function)
                                 range.size, _PAGE_NO_CACHE|_PAGE_GUARDED);
                                                            ^
arch/powerpc/kernel/pci-common.c:732:59: note: each undeclared 
identifier is reported only once for each function it appears in
make[1]: *** [arch/powerpc/kernel/pci-common.o] Error 1
make: *** [arch/powerpc/kernel] Error 2

I replaced

__ioremap_at(range.cpu_addr, (void *)ISA_IO_BASE,
                                range.size, _PAGE_NO_CACHE|_PAGE_GUARDED);

with

__ioremap_at(range.cpu_addr, (void *)ISA_IO_BASE,
                                range.size, 
pgprot_val(pgprot_noncached(__pgprot(0))));

After that it compiled.

Unfortunately it doesn't boot. :-(

Which files are responsible for the early boot phase in the commit 
powerpc-4.7-1? Perhaps the problem is there.

Cheers,

Christian

On 04 June 2016 at 09:40 AM, Christian Zigotzky wrote:
> Aneesh,
>
> Could you please send me only your patch for the Power ISA 3.0 
> (Power9) Radix Tree MMU? You have done the most modifications for the 
> kernel 4.7. If the kernel boots with your modifications then I have to 
> look to the other few modifications.
>
> Thanks in advance,
>
> Christian
>
> On 04 June 2016 at 09:19 AM, Christian Zigotzky wrote:
>> Hi All,
>>
>> The commit powerpc-4.7-2 [2] was released yesterday.
>>
>> There is a conflict in my local kernel git directory if I use git 
>> pull because I have reverted the commit powerpc-4.7-1. [1]
>>
>> The commit powerpc-4.7-2 [2] needs the commit powerpc-4.7-1. [1]
>>
>> I created a new local kernel git directory for the RC2 with:
>>
>> git clone 
>> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 
>> linux-git-without-powerpc-commits
>>
>> After that I reverted the two commits:
>>
>> powerpc-4.7-2 [2]:
>>
>> git revert 5306d766f15e72bc79c61d88f77e5a6b1fcc0e68 -m 1
>>
>> powerpc-4.7-1 [1]:
>>
>> git revert c04a5880299eab3da8c10547db96ea9cdffd44a6 -m 1
>>
>> Afterwards I successfully tested our latest Nemo patch 4.7-1 [3] with 
>> the following commands:
>>
>> cp -R linux-git-without-powerpc-commits linux-4.7
>>
>> patch -p0 < nemo_4.7-1.patch
>>
>> I tried to solve the boot issue last week. I modified the code a lot 
>> and I replaced some files. Unfortunately without any success. The RC1 
>> without the commit powerpc-4.7-1 [1] boots and works fantastic. I 
>> don't have any ideas anymore. Please help me to solve the boot problems.
>>
>> Thanks in advance,
>>
>> Christian
>>
>> [1] 
>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=c04a5880299eab3da8c10547db96ea9cdffd44a6
>> [2] 
>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=5306d766f15e72bc79c61d88f77e5a6b1fcc0e68
>> [3] http://www.xenosoft.de/nemo_4.7-1.patch
>>
>> On 28 May 2016 at 8:51 PM, Darren Stevens wrote:
>>> Hello Adrian
>>>
>>> On 28/05/2016, Adrian Cox wrote:
>>>>> From: Christian Zigotzky [mailto:chzigotzky@xenosoft.de]
>>>>> Sent: 28 May 2016 07:06
>>>>> Adrian, what is the expected WIMG bit mapping for the Nemo board?
>>>>>
>>>> I'm not able to help much here, I'm afraid. I don't have a Nemo 
>>>> board at
>>>> the moment, and it's been a few years. From memory all the peripherals
>>>> required standard uncached and guarded mappings on Nemo.
>>> Before everybody gets too involved, from what I've seen with my 
>>> tests today
>>> the kernel is crashing long before it gets to the pci-common code.
>>>
>>> I've attached 2 boot logs, one from a 4.4 kernel I've been working 
>>> on, and
>>> from a build of the latest git.
>>>
>>> You can see from this that the 4.7 kernel hangs right after the 
>>> booting linux
>>> via __start(), whereas in the 4.4 there's about 29 lines of output 
>>> before it
>>> gets to the Initialised io_base_virt printk in our patch.
>>>
>>> The last time we had a hang this early in the boot it turned out to 
>>> be a
>>> problem in head_64.S, I think there is something else wrong in the 
>>> commit
>>> Christian has identified
>>>
>>> I will see if this is something I can fix, but it may need better 
>>> low level
>>> knowledge of PPC hardware than I have.
>>>
>>> Regards
>>> Darren
>>
>> On 28 May 2016 at 6:53 PM, Adrian Cox wrote:
>>>> From: Christian Zigotzky [mailto:chzigotzky@xenosoft.de]
>>>> Sent: 28 May 2016 07:06
>>>> Adrian, what is the expected WIMG bit mapping for the Nemo board?
>>>>
>>> I'm not able to help much here, I'm afraid. I don't have a Nemo 
>>> board at the moment, and it's been a few years. From memory all the 
>>> peripherals required standard uncached and guarded mappings on Nemo.
>>>
>>> The difficult bit that usually breaks on kernel upgrades is not the 
>>> WIMG settings, but the PCI probing routine.  The SB600 doesn't 
>>> follow normal PCIe address decoding rules, as in its original use as 
>>> an AMD south bridge it was designed to appear as if it were 
>>> integrated into the north bridge.
>>>
>>> -- 
>>> Adrian
>>>
>>
>>
>>
>
>
