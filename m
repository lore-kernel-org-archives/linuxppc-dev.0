Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7AEBC1A01D8
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Feb 2016 17:20:05 +1100 (AEDT)
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [125.16.236.2])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id C511B140AD9
 for <linuxppc-dev@ozlabs.org>; Tue,  2 Feb 2016 17:20:04 +1100 (AEDT)
Received: from localhost
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 2 Feb 2016 11:50:01 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u126JvK926542302
 for <linuxppc-dev@ozlabs.org>; Tue, 2 Feb 2016 11:49:58 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u12BnkKc028225
 for <linuxppc-dev@ozlabs.org>; Tue, 2 Feb 2016 17:19:47 +0530
Message-ID: <56B04A8B.5080300@linux.vnet.ibm.com>
Date: Tue, 02 Feb 2016 11:49:55 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 1/2] powerpc/mm: Enable HugeTLB page migration
References: <1453972285-8822-1-git-send-email-khandual@linux.vnet.ibm.com>
 <87io2dyda8.fsf@linux.vnet.ibm.com> <56AB2DB0.7060908@linux.vnet.ibm.com>
In-Reply-To: <56AB2DB0.7060908@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/29/2016 02:45 PM, Anshuman Khandual wrote:
> On 01/28/2016 08:14 PM, Aneesh Kumar K.V wrote:
>> > Anshuman Khandual <khandual@linux.vnet.ibm.com> writes:
>> > 
>>> >> This enables HugeTLB page migration for PPC64_BOOK3S systems which implement
>>> >> HugeTLB page at the PMD level. It enables the kernel configuration option
>>> >> CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION by default which turns on the function
>>> >> hugepage_migration_supported() during migration. After the recent changes
>>> >> to the PTE format, HugeTLB page migration happens successfully.
>>> >>
>>> >> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
>>> >> ---
>>> >>  arch/powerpc/Kconfig | 4 ++++
>>> >>  1 file changed, 4 insertions(+)
>>> >>
>>> >> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
>>> >> index e4824fd..65d52a0 100644
>>> >> --- a/arch/powerpc/Kconfig
>>> >> +++ b/arch/powerpc/Kconfig
>>> >> @@ -82,6 +82,10 @@ config GENERIC_HWEIGHT
>>> >>  config ARCH_HAS_DMA_SET_COHERENT_MASK
>>> >>          bool
>>> >>
>>> >> +config ARCH_ENABLE_HUGEPAGE_MIGRATION
>>> >> +	def_bool y
>>> >> +	depends on PPC_BOOK3S_64 && HUGETLB_PAGE && MIGRATION
>>> >> +
>>> >>  config PPC
>>> >>  	bool
>>> >>  	default y
>> > 
>> > 
>> > Are you sure this is all that is needed ? We will get a FOLL_GET with hugetlb
>> > migration and our follow_huge_addr will BUG_ON on that. Look at
>> > e66f17ff71772b209eed39de35aaa99ba819c93d (" mm/hugetlb: take page table
>> > lock in follow_huge_pmd()").
> HugeTLB page migration was successful without any error and data integrity
> check passed on them as well. But yes there might be some corner cases which
> trigger the race condition we have not faced yet. Will try to understand the
> situation there and get back.

Aneesh,

The current test which passed successfully in moving HugeTLB pages is
driven from the soft offline sysfs interface taking PFN (from pagemap
interface) as the argument. Its kind of directly calls migrate_pages()
handing out the page struct list as the argument. But the sample test
case in commit e66f17ff71772b ("mm/hugetlb: take page table lock in
follow_huge_pmd()") is able to crash the kernel at the BUG_ON as you
had mentioned before.

CPU: 2 PID: 6386 Comm: movepages Not tainted 4.5.0-rc2-00002-gc3ac0a3 #3
task: c0000003e8792400 ti: c0000003f65cc000 task.ti: c0000003f65cc000
NIP: c0000000001f485c LR: c0000000001f4844 CTR: 0000000000000000
REGS: c0000003f65cfa20 TRAP: 0700   Not tainted  (4.5.0-rc2-00002-gc3ac0a3)
MSR: 800000010282b033 <SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE,TM[E]>  CR: 28044488  XER: 00000000
CFAR: c000000000050310 SOFTE: 1 
GPR00: c0000000001f4844 c0000003f65cfca0 c000000000d82e00 f000000000ec0000 
GPR04: 00003efff6000000 c0000003f65cfc74 c0000003f65cfc70 0000000000000001 
GPR08: f000000000000000 0000000000000000 fffffffffffff000 0000000000000000 
GPR12: 0000000000004400 c00000000ea70800 fffffffffffffff2 c0000003d3330000 
GPR16: 0000000000000a00 c0000003f65cfd30 0000000000000000 c0000003d3330000 
GPR20: c000000000239f50 0000000000000100 fffffffffffff000 0000000001320122 
GPR24: c0000003ed267ee8 c0000003f65cfd70 00003efff6000000 c0000003f65cfd80 
GPR28: 000000000000008c c0000003ed267e80 c0000003ed2299d0 0000000000000004 
NIP [c0000000001f485c] follow_page_mask+0x7c/0x440
LR [c0000000001f4844] follow_page_mask+0x64/0x440
Call Trace:
[c0000003f65cfca0] [c0000000001f4844] follow_page_mask+0x64/0x440 (unreliable)
[c0000003f65cfd10] [c00000000023d2d8] SyS_move_pages+0x518/0x820
[c0000003f65cfe30] [c000000000009260] system_call+0x38/0xd0
Instruction dump:
7cdb3378 7c9a2378 eba30040 91260000 7fa3eb78 4be5b9f9 60000000 3940f000 
7fa35040 41dd0044 57ff077a 7bff0020 <0b1f0000> 38210070 e8010010 eae1ffb8

In the function follow_page_mask() we have this code block right at the
front where it fails.

	page = follow_huge_addr(mm, address, flags & FOLL_WRITE);
	if (!IS_ERR(page)) {
		BUG_ON(flags & FOLL_GET);
		return page;
	}

As you mentioned, currently we dont implement CONFIG_ARCH_WANT_GENERAL_HUGETLB.
So we define follow_huge_addr() function which returns a valid page struct
for any given address. But then dont understand why we bug on for FOLL_GET.
move_pages() had called follow_page() with FOLL_GET flag at the first place.
So this condition is going to be true all the time. I am still digging into
this but meanwhile if you can throw some light on why we have BUG_ON for
FOLL_GET flag it will really be helpful. Did not get much clues looking into
the previous commit which added this BUG_ON.
