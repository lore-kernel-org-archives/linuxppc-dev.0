Return-Path: <SRS0=1PmZ=FA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BB38C63697
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Nov 2020 13:00:11 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B667321D46
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Nov 2020 13:00:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kwtYBwhP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B667321D46
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ChdCB70RrzDqll
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Nov 2020 00:00:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=infradead.org
 (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org;
 envelope-from=willy@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256
 header.s=casper.20170209 header.b=kwtYBwhP; 
 dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Chd6v3DYYzDqNr
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2020 23:56:23 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=Wzqquq5/8D9FV29EVrzwmTN0u25CnsZPxZTtTznyxuY=; b=kwtYBwhPT/xZPaiK1qJKZ2HGr7
 4quVpggBZGhRHOmciM0yyjUsYzXiVZmu3u3Pk0PSig7f3bnc2DnWNmqGhsEXLpcsUy8MqOLtxFiPq
 yemCSvOVi6L6aCTSF2KLJeKgK0w82yTmoe0CxCovoaDO5mvJy7nZ4nCW8E68MWCxGd2ei90UVJblp
 wjU+bSg380UGlOMpwS3X7MTXxRAqzF6205FfNpCb7yw6bDwdEkNv5ouvbb9HlNrYY5ea2yPOYigEc
 K+PjYbYftBbGrPwt+LbQsB5Y9gsJ1NFNEQ3pDT5Lwhzv5zJAgu57y3r7Y1Puc6/9zMPZ9dv+rxV/k
 q2rhtnRQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1kiGog-0003FD-PN; Thu, 26 Nov 2020 12:56:07 +0000
Date: Thu, 26 Nov 2020 12:56:06 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 3/6] perf/core: Fix arch_perf_get_page_size()
Message-ID: <20201126125606.GR4327@casper.infradead.org>
References: <20201126120114.071913521@infradead.org>
 <20201126121121.164675154@infradead.org>
 <20201126123458.GO4327@casper.infradead.org>
 <20201126124207.GM3040@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201126124207.GM3040@hirez.programming.kicks-ass.net>
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
Cc: mark.rutland@arm.com, aneesh.kumar@linux.ibm.com,
 linux-arch@vger.kernel.org, catalin.marinas@arm.com, will@kernel.org,
 alexander.shishkin@linux.intel.com, linuxppc-dev@lists.ozlabs.org,
 npiggin@gmail.com, linux-kernel@vger.kernel.org, acme@kernel.org,
 davem@davemloft.net, dave.hansen@intel.com, ak@linux.intel.com,
 eranian@google.com, sparclinux@vger.kernel.org, jolsa@redhat.com,
 mingo@kernel.org, kirill.shutemov@linux.intel.com, kan.liang@linux.intel.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Nov 26, 2020 at 01:42:07PM +0100, Peter Zijlstra wrote:
> +	pgdp = pgd_offset(mm, addr);
> +	pgd = READ_ONCE(*pgdp);

I forget how x86-32-PAE maps to Linux's PGD/P4D/PUD/PMD scheme, but
according to volume 3, section 4.4.2, PAE paging uses a 64-bit PDE, so
whether a PDE is a PGD or a PMD, we're only reading it with READ_ONCE
rather than the lockless-retry method used by ptep_get_lockless().
So it's potentially racy?  Do we need a pmdp_get_lockless() or
pgdp_get_lockless()?

[...]
> +	pmdp = pmd_offset_lockless(pudp, pud, addr);
> +	pmd = READ_ONCE(*pmdp);
> +	if (!pmd_present(pmd))
>  		return 0;
>  
> +	if (pmd_leaf(pmd))
> +		return pmd_leaf_size(pmd);
>  
