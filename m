Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sv1Gs5y7QzDsrc
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Oct 2016 15:34:29 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u9C4T4eO096148
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Oct 2016 00:34:27 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2615buk72b-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Oct 2016 00:34:26 -0400
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 12 Oct 2016 00:34:26 -0400
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: kernel test robot <xiaolong.ye@intel.com>
Cc: lkp@01.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, akpm@linux-foundation.org
Subject: Re: [mm] c4344e8035: WARNING: CPU: 0 PID: 101 at mm/memory.c:303
 __tlb_remove_page_size+0x25/0x99
In-Reply-To: <57fd4fd5.kG/XPlHvJ/oBp+pH%xiaolong.ye@intel.com>
References: <57fd4fd5.kG/XPlHvJ/oBp+pH%xiaolong.ye@intel.com>
Date: Wed, 12 Oct 2016 10:04:18 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87bmyqb2yd.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

kernel test robot <xiaolong.ye@intel.com> writes:

> FYI, we noticed the following commit:
>
> https://github.com/0day-ci/linux Aneesh-Kumar-K-V/mm-Use-the-correct-page-size-when-removing-the-page/20161012-013446
> commit c4344e80359420d7574b3b90fddf53311f1d24e6 ("mm: Remove the page size change check in tlb_remove_page")
>
> in testcase: boot
>
> on test machine: qemu-system-i386 -enable-kvm -cpu Haswell,+smep,+smap -m 360M
>
> caused below changes:
>
>
> +------------------------------------------------+------------+------------+
> |                                                | eff764128d | c4344e8035 |
> +------------------------------------------------+------------+------------+
> | boot_successes                                 | 59         | 0          |
> | boot_failures                                  | 0          | 43         |
> | WARNING:at_mm/memory.c:#__tlb_remove_page_size | 0          | 43         |
> | calltrace:SyS_execve                           | 0          | 43         |
> | calltrace:run_init_process                     | 0          | 21         |
> +------------------------------------------------+------------+------------+
>
>
>
> [    4.096204] Write protecting the kernel text: 3148k
> [    4.096911] Write protecting the kernel read-only data: 1444k
> [    4.120357] ------------[ cut here ]------------
> [    4.121078] WARNING: CPU: 0 PID: 101 at mm/memory.c:303 __tlb_remove_page_size+0x25/0x99
> [    4.122380] Modules linked in:
> [    4.122788] CPU: 0 PID: 101 Comm: run-parts Not tainted 4.8.0-mm1-00315-gc4344e8 #5
> [    4.123956]  bd145dc4 b111e5e6 bd145de0 b10320dc 0000012f b10974d1 bd145e70 c4954170
> [    4.125277]  c4954170 bd145df4 b103215f 00000009 00000000 00000000 bd145e04 b10974d1
> [    4.126424]  c4954170 bd145e70 bd145e14 b10263ca bd145e70 bd47bafc bd145e40 b109767a
> [    4.127622] Call Trace:

Thanks for the report. The below change should fix this.

commit 18c929e7cf672da617dc218c6265366bf78b1644
Author: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Date:   Wed Oct 12 08:40:41 2016 +0530

    update mmu gather page size before flushing page table cache

diff --git a/mm/memory.c b/mm/memory.c
index 26d1ba8c87e6..7e7eccb82a2b 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -526,7 +526,11 @@ void free_pgd_range(struct mmu_gather *tlb,
 		end -= PMD_SIZE;
 	if (addr > end - 1)
 		return;
-
+	/*
+	 * We add page table cache pages with PAGE_SIZE,
+	 * (see pte_free_tlb()), flush the tlb if we need
+	 */
+	tlb_remove_check_page_size_change(tlb, PAGE_SIZE);
 	pgd = pgd_offset(tlb->mm, addr);
 	do {
 		next = pgd_addr_end(addr, end);
