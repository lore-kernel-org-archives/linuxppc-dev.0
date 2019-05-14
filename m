Return-Path: <SRS0=tOPa=TO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9D41C04AB4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 May 2019 06:41:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19463206A3
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 May 2019 06:41:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19463206A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4537QC3kGJzDqMk
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 May 2019 16:41:55 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4537Ns0RGNzDqGC
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 May 2019 16:40:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4537Nq5FQYz9sBV;
 Tue, 14 May 2019 16:40:43 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, npiggin@gmail.com,
 paulus@samba.org
Subject: Re: [PATCH] powerpc/mm: Handle page table allocation failures
In-Reply-To: <20190514010543.29896-1-aneesh.kumar@linux.ibm.com>
References: <20190514010543.29896-1-aneesh.kumar@linux.ibm.com>
Date: Tue, 14 May 2019 16:40:43 +1000
Message-ID: <87ftphtu6s.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: Sachin Sant <sachinp@linux.vnet.ibm.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:
> This fix the below crash that arise due to not handling page table allocation
> failures while allocating hugetlb page table.
>
>  BUG: Kernel NULL pointer dereference at 0x0000001c
>  Faulting instruction address: 0xc000000001d1e58c
>  Oops: Kernel access of bad area, sig: 11 [#1]
>  LE PAGE_SIZE=4K MMU=Hash SMP NR_CPUS=2048 NUMA pSeries
>
>  CPU: 3 PID: 4635 Comm: futex_wake04 Tainted: G        W  O      5.1.0-next-20190507-autotest #1
>  NIP:  c000000001d1e58c LR: c000000001d1e54c CTR: 0000000000000000
>  REGS: c000000004937890 TRAP: 0300   Tainted: G        W  O       (5.1.0-next-20190507-autotest)
>  MSR:  8000000000009033 <SF,EE,ME,IR,DR,RI,LE>  CR: 22424822  XER: 00000000
>  CFAR: c00000000183e9e0 DAR: 000000000000001c DSISR: 40000000 IRQMASK: 0
>  GPR00: c000000001901a80 c000000004937b20 c000000003938700 0000000000000000
>  GPR04: 0000000000400cc0 000000000003efff 000000027966e000 c000000003ba8700
>  GPR08: c000000003ba8700 000000000d601125 c000000003ba8700 0000000080000000
>  GPR12: 0000000022424822 c00000001ecae280 0000000000000000 0000000000000000
>  GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
>  GPR20: 0000000000000018 c0000000039e2d30 c0000000039e2d28 c0000002762da460
>  GPR24: 000000000000001c 0000000000000000 0000000000000001 c000000001901a80
>  GPR28: 0000000000400cc0 0000000000000000 0000000000000000 0000000000400cc0
>  NIP [c000000001d1e58c] kmem_cache_alloc+0xbc/0x5a0
>  LR [c000000001d1e54c] kmem_cache_alloc+0x7c/0x5a0
>  Call Trace:
>   [c000000001c91150] __pud_alloc+0x160/0x200 (unreliable)
>   [c000000001901a80] huge_pte_alloc+0x580/0x950
>   [c000000001cf7910] hugetlb_fault+0x9a0/0x1250
>   [c000000001c94a80] handle_mm_fault+0x490/0x4a0
>   [c0000000018d529c] __do_page_fault+0x77c/0x1f00
>   [c0000000018d6a48] do_page_fault+0x28/0x50
>   [c00000000183b0d4] handle_page_fault+0x18/0x38
>
> Fixes: e2b3d202d1db ("powerpc: Switch 16GB and 16MB explicit hugepages to a different page table format")
> Reported-by: Sachin Sant <sachinp@linux.vnet.ibm.com>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> ---
>
> Note: I did add a recent commit for the Fixes tag. But in reality we never checked for page table
> allocation failure there. If we want to go to that old commit, then we may need.

If we never checked for failure in that path, is there some reason we've
only just noticed the crashes? Are we just testing under memory pressure
more effectively than we used to?

cheers
