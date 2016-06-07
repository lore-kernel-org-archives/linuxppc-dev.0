Return-Path: <chzigotzky@xenosoft.de>
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de
 [81.169.146.161])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rPNLV5MdpzDqG1
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Jun 2016 06:23:30 +1000 (AEST)
Subject: Kernel 4.7: PAGE_GUARDED and _PAGE_NO_CACHE
To: Michael Ellerman <mpe@ellerman.id.au>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org, darren@stevens-zone.net,
 Michael Ellerman <michaele@au1.ibm.com>, Julian Margetson
 <runaway@candw.ms>, Adrian Cox <adrian@humboldt.co.uk>,
 "R.T.Dickinson" <rtd@a-eon.com>, "R.T.Dickinson" <rtd2@xtra.co.nz>,
 Pat Wall <pjwall@mac.com>, Pat Wall <pjwall@me.com>,
 "contact@a-eon.com" <contact@a-eon.com>, Matthew Leaman <matthew@a-eon.biz>,
 luigi burdo <intermediadc@hotmail.com>
References: <8B4C4AB7-5C17-4992-935A-361153472793@xenosoft.de>
 <1463990507.3078.16.camel@kernel.crashing.org>
 <cff72fd8-3297-b61b-4ddc-8c491b565f80@xenosoft.de>
 <1464088614.3078.79.camel@kernel.crashing.org>
 <1298e1f6-beb7-5487-72a1-366ebd140c17@xenosoft.de>
 <87d1obqxg9.fsf@skywalker.in.ibm.com>
 <9690f9a4-70c7-8acc-42d0-779bcc93db52@xenosoft.de>
 <66397458-c40a-4e83-c5e5-0ba69fb48986@xenosoft.de>
 <874m99uibc.fsf@skywalker.in.ibm.com>
 <ab51f49d-fc8f-24ce-6763-c641b949971e@xenosoft.de>
 <1465174304.12265.0.camel@ellerman.id.au>
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Message-ID: <50194690-18ac-edfd-42cb-8f1cc96055c9@xenosoft.de>
Date: Tue, 7 Jun 2016 22:17:08 +0200
MIME-Version: 1.0
In-Reply-To: <1465174304.12265.0.camel@ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michael,

On 06 June 2016 at 02:51 AM, Michael Ellerman wrote:
> On Sat, 2016-06-04 at 17:07 +0200, Christian Zigotzky wrote:
>
>> Aneesh,
>>
>> Shall I bisect the kernel from the powerpc git?
> No just use linus' tree.
>
>> Shall I start with the following commit?
>>
>> https://git.kernel.org/cgit/linux/kernel/git/powerpc/linux.git/commit/?id=8ffb4103f5e28d7e7890ed4774d8e009f253f56e
> Yeah that would be a good one to start with.
>
> Then mark rc1 as bad and bisect should do the rest.
>
> cheers
>
>
"range.size, pgprot_val(pgprot_noncached(__pgprot(0))));" isn't the 
problem. :-) It works.

764041e0f43cc7846f6d8eb246d65b53cc06c764 is the first bad commit
commit 764041e0f43cc7846f6d8eb246d65b53cc06c764
Author: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Date:   Fri Apr 29 23:26:09 2016 +1000

     powerpc/mm/radix: Add checks in slice code to catch radix usage

     Radix doesn't need slice support. Catch incorrect usage of slice code
     when radix is enabled.

     Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
     Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Cheers,

Christian


Git Log:

git clone 
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git linux-git

git bisect start

git bisect good 8ffb4103f5e28d7e7890ed4774d8e009f253f56e

git bisect bad 1a695a905c18548062509178b98bc91e67510864 (Linux 4.7-rc1)

Output:

Bisecting: 6333 revisions left to test after this (roughly 13 steps)
[4741526b83c5d3a3d661d1896f9e7414c5730bcb] mm, page_alloc: restore the 
original nodemask if the fast path allocation failed

----

git bisect good (Linux AmigaoneX1000 
4.6.0_A-EON_AmigaONE_X1000_Nemo-05145-g4741526-dirty #1 SMP Mon Jun 6 
14:35:01 CEST 2016 ppc64 GNU/Linux)

Output:

Bisecting: 3014 revisions left to test after this (roughly 12 steps)
[2f37dd131c5d3a2eac21cd5baf80658b1b02a8ac] Merge tag 'staging-4.7-rc1' 
of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging

----

I had to replace

__ioremap_at(range.cpu_addr, (void *)ISA_IO_BASE,
                                range.size, _PAGE_NO_CACHE|_PAGE_GUARDED);

with

__ioremap_at(range.cpu_addr, (void *)ISA_IO_BASE,
                                range.size, 
pgprot_val(pgprot_noncached(__pgprot(0))));


in the file "pci-common.c". After that it compiled but it doesn't boot 
so "git bisect bad"

Output:

Bisecting: 1693 revisions left to test after this (roughly 11 steps)
[54cf809b9512be95f53ed4a5e3b631d1ac42f0fa] locking,qspinlock: Fix 
spin_is_locked() and spin_unlock_wait()

----

I had to replace

__ioremap_at(range.cpu_addr, (void *)ISA_IO_BASE,
                                range.size, _PAGE_NO_CACHE|_PAGE_GUARDED);

with

__ioremap_at(range.cpu_addr, (void *)ISA_IO_BASE,
                                range.size, 
pgprot_val(pgprot_noncached(__pgprot(0))));


in the file "pci-common.c". After that it compiled but it doesn't boot 
so "git bisect bad"

Output:

Bisecting: 721 revisions left to test after this (roughly 10 steps)
[f4c80d5a16eb4b08a0d9ade154af1ebdc63f5752] Merge tag 'sound-4.7-rc1' of 
git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound

----

git bisect good (Linux AmigaoneX1000 
4.6.0_A-EON_AmigaONE_X1000_Nemo-05931-gf4c80d5-dirty #1 SMP Mon Jun 6 
19:13:42 CEST 2016 ppc64 GNU/Linux)

Output:

Bisecting: 324 revisions left to test after this (roughly 9 steps)
[c04a5880299eab3da8c10547db96ea9cdffd44a6] Merge tag 'powerpc-4.7-1' of 
git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux

----

I had to replace

__ioremap_at(range.cpu_addr, (void *)ISA_IO_BASE,
                                range.size, _PAGE_NO_CACHE|_PAGE_GUARDED);

with

__ioremap_at(range.cpu_addr, (void *)ISA_IO_BASE,
                                range.size, 
pgprot_val(pgprot_noncached(__pgprot(0))));


in the file "pci-common.c". After that it compiled but it doesn't boot 
so "git bisect bad"

Output:

Bisecting: 186 revisions left to test after this (roughly 8 steps)
[e9ad9b9bd3a3b95c89a29b2a197476e662db4233] Merge tag 'docs-for-linus' of 
git://git.lwn.net/linux

----

git bisect good (Linux AmigaoneX1000 
4.6.0_A-EON_AmigaONE_X1000_Nemo-06141-ge9ad9b9-dirty #1 SMP Tue Jun 7 
08:32:33 CEST 2016 ppc64 GNU/Linux)

Bisecting: 93 revisions left to test after this (roughly 7 steps)
[0e5b5ba17ac33a05d9f4a48b5eb8b5e30f2274d7] cxl: Remove duplicate #defines

----

I had to replace

__ioremap_at(range.cpu_addr, (void *)ISA_IO_BASE,
                                range.size, _PAGE_NO_CACHE|_PAGE_GUARDED);

with

__ioremap_at(range.cpu_addr, (void *)ISA_IO_BASE,
                                range.size, 
pgprot_val(pgprot_noncached(__pgprot(0))));


in the file "pci-common.c". After that it compiled but it doesn't boot 
so "git bisect bad"

Output:

Bisecting: 46 revisions left to test after this (roughly 6 steps)
[764041e0f43cc7846f6d8eb246d65b53cc06c764] powerpc/mm/radix: Add checks 
in slice code to catch radix usage

----

It doesn't boot. Booting Linux via __start()... didn't appear in the CFE.

git bisect bad

Output:

Bisecting: 22 revisions left to test after this (roughly 5 steps)
[2e8735198af0392d9032a356ee6c82686afca779] powerpc/mm: Move common pte 
bits and accessors to book3s/64/pgtable.h

----

I had to replace

__ioremap_at(range.cpu_addr, (void *)ISA_IO_BASE,
                                range.size, _PAGE_NO_CACHE|_PAGE_GUARDED);

with

__ioremap_at(range.cpu_addr, (void *)ISA_IO_BASE,
                                range.size, 
pgprot_val(pgprot_noncached(__pgprot(0))));


in the file "pci-common.c". After that it compiled and booted with 
"range.size, pgprot_val(pgprot_noncached(__pgprot(0))));". That means, 
"range.size, pgprot_val(pgprot_noncached(__pgprot(0))));" isn't the 
problem. :-)

git bisect good (Linux AmigaoneX1000 
4.6.0-rc3_A-EON_AmigaONE_X1000_Nemo-00067-g2e87351-dirty #1 SMP Tue Jun 
7 15:29:19 CEST 2016 ppc64 GNU/Linux)

Output:

Bisecting: 11 revisions left to test after this (roughly 4 steps)
[2bfd65e45e877fb5704730244da67c748d28a1b8] powerpc/mm/radix: Add radix 
callbacks for early init routines

----

I had to replace

__ioremap_at(range.cpu_addr, (void *)ISA_IO_BASE,
                                range.size, _PAGE_NO_CACHE|_PAGE_GUARDED);

with

__ioremap_at(range.cpu_addr, (void *)ISA_IO_BASE,
                                range.size, 
pgprot_val(pgprot_noncached(__pgprot(0))));


in the file "pci-common.c". After that it compiled and it also booted 
with "range.size, pgprot_val(pgprot_noncached(__pgprot(0))));"!

git bisect good (Linux AmigaoneX1000 
4.6.0-rc3_A-EON_AmigaONE_X1000_Nemo-00078-g2bfd65e-dirty #1 SMP Tue Jun 
7 16:50:47 CEST 2016 ppc64 GNU/Linux)

Output:

Bisecting: 5 revisions left to test after this (roughly 3 steps)
[676012a66f651a98808459bc8ab75661828ed96f] powerpc/mm: Hash abstraction 
for tlbflush routines

----

I had to replace

__ioremap_at(range.cpu_addr, (void *)ISA_IO_BASE,
                                range.size, _PAGE_NO_CACHE|_PAGE_GUARDED);

with

__ioremap_at(range.cpu_addr, (void *)ISA_IO_BASE,
                                range.size, 
pgprot_val(pgprot_noncached(__pgprot(0))));


in the file "pci-common.c". After that it compiled and it also booted 
with "range.size, pgprot_val(pgprot_noncached(__pgprot(0))));"!

git bisect good (Linux AmigaoneX1000 
4.6.0-rc3_A-EON_AmigaONE_X1000_Nemo-00084-g676012a-dirty #1 SMP Tue Jun 
7 19:03:59 CEST 2016 ppc64 GNU/Linux)

Output:

Bisecting: 2 revisions left to test after this (roughly 2 steps)
[a8ed87c92adf1fd45142323e04f15b522117d575] powerpc/mm/radix: Add 
MMU_FTR_RADIX

----

I had to replace

__ioremap_at(range.cpu_addr, (void *)ISA_IO_BASE,
                                range.size, _PAGE_NO_CACHE|_PAGE_GUARDED);

with

__ioremap_at(range.cpu_addr, (void *)ISA_IO_BASE,
                                range.size, 
pgprot_val(pgprot_noncached(__pgprot(0))));


in the file "pci-common.c". After that it compiled and it also booted 
with "range.size, pgprot_val(pgprot_noncached(__pgprot(0))));"!

git bisect good (Linux AmigaoneX1000 
4.6.0-rc3_A-EON_AmigaONE_X1000_Nemo-00087-ga8ed87c-dirty #1 SMP Tue Jun 
7 20:25:11 CEST 2016 ppc64 GNU/Linux)

Output:

Bisecting: 0 revisions left to test after this (roughly 1 step)
[d8c476eeb697c9aac46b390e9cbd7af7032814f1] powerpc/mm/radix: Isolate 
hash table function from pseries guest code

----

I had to replace

__ioremap_at(range.cpu_addr, (void *)ISA_IO_BASE,
                                range.size, _PAGE_NO_CACHE|_PAGE_GUARDED);

with

__ioremap_at(range.cpu_addr, (void *)ISA_IO_BASE,
                                range.size, 
pgprot_val(pgprot_noncached(__pgprot(0))));


in the file "pci-common.c". After that it compiled and it also booted 
with "range.size, pgprot_val(pgprot_noncached(__pgprot(0))));"!

git bisect good (Linux AmigaoneX1000 
4.6.0-rc3_A-EON_AmigaONE_X1000_Nemo-00089-gd8c476e-dirty #1 SMP Tue Jun 
7 21:53:24 CEST 2016 ppc64 GNU/Linux)

Output:

764041e0f43cc7846f6d8eb246d65b53cc06c764 is the first bad commit
commit 764041e0f43cc7846f6d8eb246d65b53cc06c764
Author: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Date:   Fri Apr 29 23:26:09 2016 +1000

     powerpc/mm/radix: Add checks in slice code to catch radix usage

     Radix doesn't need slice support. Catch incorrect usage of slice code
     when radix is enabled.

     Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
     Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

:040000 040000 e66f81f989a42a4de238a49a2191f787ae65d4a2 
6b7b4380d14db00d9aae28b5990e5dd8d6cf23a0 M    arch
