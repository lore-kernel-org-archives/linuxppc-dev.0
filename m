Return-Path: <SRS0=YLyy=SL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB589C10F0E
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Apr 2019 08:18:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B8262084F
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Apr 2019 08:18:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B8262084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44dgCB5zNGzDqJc
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Apr 2019 18:17:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44dg8v30JCzDqGZ
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Apr 2019 18:15:57 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x3989cdS079856
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 9 Apr 2019 04:15:53 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2rrng6dfas-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Apr 2019 04:15:53 -0400
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Tue, 9 Apr 2019 09:15:51 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 9 Apr 2019 09:15:49 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x398FnRO41746522
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 9 Apr 2019 08:15:49 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D9E4AAE057;
 Tue,  9 Apr 2019 08:15:48 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D45DCAE05D;
 Tue,  9 Apr 2019 08:15:47 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.85.92.227])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Tue,  9 Apr 2019 08:15:47 +0000 (GMT)
X-Mailer: emacs 26.1 (via feedmail 11-beta-1 I)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2] powerpc/64s/radix: Fix radix segment exception handling
In-Reply-To: <20190409031643.20405-1-npiggin@gmail.com>
References: <20190409031643.20405-1-npiggin@gmail.com>
Date: Tue, 09 Apr 2019 13:45:46 +0530
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 19040908-0028-0000-0000-0000035ED2A8
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19040908-0029-0000-0000-0000241DEF79
Message-Id: <87lg0jmw5p.fsf@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-04-09_03:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904090055
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Anton Blanchard <anton@samba.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Nicholas Piggin <npiggin@gmail.com> writes:

> Commit 48e7b76957 ("powerpc/64s/hash: Convert SLB miss handlers to C")
> broke the radix-mode segment exception handler. In radix mode, this is
> exception is not an SLB miss, rather it signals that the EA is outside
> the range translated by any page table.
>
> The commit lost the radix feature alternate code patch, which can
> cause faults to some EAs to kernel BUG at arch/powerpc/mm/slb.c:639!
>
> The original radix code would send faults to slb_miss_large_addr,
> which would end up faulting due to slb_addr_limit being 0. This patch
> sends radix directly to do_bad_slb_fault, which is a bit clearer.
>

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

> Fixes: 48e7b76957 ("powerpc/64s/hash: Convert SLB miss handlers to C")
> Cc: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> Reported-by: Anton Blanchard <anton@samba.org>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
> - Add a selftests that triggers the crash
>
>  arch/powerpc/kernel/exceptions-64s.S          | 12 +++
>  tools/testing/selftests/powerpc/mm/Makefile   |  3 +-
>  .../selftests/powerpc/mm/access_tests.c       | 94 +++++++++++++++++++
>  3 files changed, 108 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/powerpc/mm/access_tests.c
>
> diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
> index a5b8fbae56a0..9481a117e242 100644
> --- a/arch/powerpc/kernel/exceptions-64s.S
> +++ b/arch/powerpc/kernel/exceptions-64s.S
> @@ -656,11 +656,17 @@ EXC_COMMON_BEGIN(data_access_slb_common)
>  	ld	r4,PACA_EXSLB+EX_DAR(r13)
>  	std	r4,_DAR(r1)
>  	addi	r3,r1,STACK_FRAME_OVERHEAD
> +BEGIN_MMU_FTR_SECTION
> +	/* HPT case, do SLB fault */
>  	bl	do_slb_fault
>  	cmpdi	r3,0
>  	bne-	1f
>  	b	fast_exception_return
>  1:	/* Error case */
> +MMU_FTR_SECTION_ELSE
> +	/* Radix case, access is outside page table range */
> +	li	r3,-EFAULT
> +ALT_MMU_FTR_SECTION_END_IFCLR(MMU_FTR_TYPE_RADIX)
>  	std	r3,RESULT(r1)
>  	bl	save_nvgprs
>  	RECONCILE_IRQ_STATE(r10, r11)
> @@ -705,11 +711,17 @@ EXC_COMMON_BEGIN(instruction_access_slb_common)
>  	EXCEPTION_PROLOG_COMMON(0x480, PACA_EXSLB)
>  	ld	r4,_NIP(r1)
>  	addi	r3,r1,STACK_FRAME_OVERHEAD
> +BEGIN_MMU_FTR_SECTION
> +	/* HPT case, do SLB fault */
>  	bl	do_slb_fault
>  	cmpdi	r3,0
>  	bne-	1f
>  	b	fast_exception_return
>  1:	/* Error case */
> +MMU_FTR_SECTION_ELSE
> +	/* Radix case, access is outside page table range */
> +	li	r3,-EFAULT
> +ALT_MMU_FTR_SECTION_END_IFCLR(MMU_FTR_TYPE_RADIX)
>  	std	r3,RESULT(r1)
>  	bl	save_nvgprs
>  	RECONCILE_IRQ_STATE(r10, r11)
> diff --git a/tools/testing/selftests/powerpc/mm/Makefile b/tools/testing/selftests/powerpc/mm/Makefile
> index 43d68420e363..68b7add5086d 100644
> --- a/tools/testing/selftests/powerpc/mm/Makefile
> +++ b/tools/testing/selftests/powerpc/mm/Makefile
> @@ -2,7 +2,7 @@
>  noarg:
>  	$(MAKE) -C ../
>  
> -TEST_GEN_PROGS := hugetlb_vs_thp_test subpage_prot prot_sao segv_errors wild_bctr
> +TEST_GEN_PROGS := hugetlb_vs_thp_test subpage_prot prot_sao segv_errors wild_bctr access_tests
>  TEST_GEN_FILES := tempfile
>  
>  top_srcdir = ../../../../..
> @@ -13,6 +13,7 @@ $(TEST_GEN_PROGS): ../harness.c
>  $(OUTPUT)/prot_sao: ../utils.c
>  
>  $(OUTPUT)/wild_bctr: CFLAGS += -m64
> +$(OUTPUT)/access_tests: CFLAGS += -m64
>  
>  $(OUTPUT)/tempfile:
>  	dd if=/dev/zero of=$@ bs=64k count=1
> diff --git a/tools/testing/selftests/powerpc/mm/access_tests.c b/tools/testing/selftests/powerpc/mm/access_tests.c
> new file mode 100644
> index 000000000000..ad300d7d9d43
> --- /dev/null
> +++ b/tools/testing/selftests/powerpc/mm/access_tests.c
> @@ -0,0 +1,94 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * Copyright 2017 John Sperbeck
> + *
> + * Test faults to "interesting" locations.
> + */
> +
> +#include <stdbool.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <unistd.h>
> +#include <signal.h>
> +#include <sys/mman.h>
> +#include <assert.h>
> +#include <ucontext.h>
> +
> +#include "utils.h"
> +
> +#define PAGE_SIZE	(64*1024)
> +#define TB		(1024ULL*1024*1024*1024)
> +static volatile bool faulted;
> +static volatile int si_code;
> +
> +static void segv_handler(int n, siginfo_t *info, void *ctxt_v)
> +{
> +	ucontext_t *ctxt = (ucontext_t *)ctxt_v;
> +	struct pt_regs *regs = ctxt->uc_mcontext.regs;
> +
> +	faulted = true;
> +	si_code = info->si_code;
> +	regs->nip += 4;
> +}
> +
> +int test_segv_errors(void)
> +{
> +	struct sigaction act = {
> +		.sa_sigaction = segv_handler,
> +		.sa_flags = SA_SIGINFO,
> +	};
> +	static unsigned long ptrs[] = {
> +		0x0f00000000000000ULL, /* Radix Q0 out of pgtable range */
> +		0x4000000000000000ULL, /* Radix Q1 */
> +		0x4f00000000000000ULL, /* Radix Q1 out of pgtable range */
> +		0x8000000000000000ULL, /* Radix Q2 */
> +		0x8f00000000000000ULL, /* Radix Q2 out of pgtable range */
> +		0xc000000000000000ULL, /* Radix Q3 */
> +		0xcf00000000000000ULL, /* Radix Q3 out of pgtable range */
> +		0xc000000000000000ULL, /* Hash kernel region */
> +		0xc000000000000000ULL + TB, /* Hash kernel region + 1 segment */
> +		0xc000000000000000ULL + TB - 1,
> +		0xd000000000000000ULL, /* Hash vmalloc region */
> +		0xd000000000000000ULL + TB,
> +		0xd000000000000000ULL + TB - 1,
> +		0xe000000000000000ULL,
> +		0xe000000000000000ULL + TB,
> +		0xe000000000000000ULL + TB - 1,
> +		0xf000000000000000ULL, /* Hash vmemmap region */
> +		0xf000000000000000ULL + TB,
> +		0xf000000000000000ULL + TB - 1,
> +	};
> +	size_t i;
> +
> +	FAIL_IF(sigaction(SIGSEGV, &act, NULL) != 0);
> +
> +	for (i = 0; i < sizeof(ptrs)/sizeof(ptrs[0]); i++) {
> +		volatile char *p = (void *)ptrs[i];
> +
> +		/*
> +		 * We just need a compiler barrier, but mb() works and has the
> +		 * nice property of being easy to spot in the disassembly.
> +		 */
> +		printf("testing %p...\n", p);
> +		faulted = false;
> +		si_code = 0;
> +		mb();
> +		(void)*p;
> +		mb();
> +		FAIL_IF(!faulted);
> +		FAIL_IF(si_code != SEGV_MAPERR && si_code != SEGV_BNDERR);
> +		/*
> +		 * Some accesses throw MAPERR, others BNDERR. Possibly all
> +		 * Q>0 accesses should cause BNDERR.
> +		 */
> +	}
> +
> +	return 0;
> +}
> +
> +int main(void)
> +{
> +	return test_harness(test_segv_errors, "segv_errors");
> +}
> -- 
> 2.20.1

