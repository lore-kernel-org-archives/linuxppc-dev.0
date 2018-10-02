Return-Path: <SRS0=LYrz=MO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF98CC43143
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 07:13:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BE4C206B2
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 07:13:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BE4C206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=popple.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42PVjw1B4DzF3G8
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 17:13:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=popple.id.au
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=popple.id.au
 (client-ip=150.101.137.131; helo=ipmail07.adl2.internode.on.net;
 envelope-from=alistair@popple.id.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=popple.id.au
Received: from ipmail07.adl2.internode.on.net (ipmail07.adl2.internode.on.net
 [150.101.137.131])
 by lists.ozlabs.org (Postfix) with ESMTP id 42PVgv2WYrzF373
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Oct 2018 17:11:39 +1000 (AEST)
Received: from static-82-10.transact.net.au (HELO new-mexico.localnet)
 ([122.99.82.10])
 by ipmail07.adl2.internode.on.net with ESMTP; 02 Oct 2018 16:41:39 +0930
From: Alistair Popple <alistair@popple.id.au>
To: Mark Hairgrove <mhairgrove@nvidia.com>
Subject: Re: [PATCH 2/3] powerpc/powernv/npu: Use size-based ATSD invalidates
Date: Tue, 02 Oct 2018 17:11:32 +1000
Message-ID: <1843554.67Higpl3JC@new-mexico>
User-Agent: KMail/5.2.3 (Linux/4.17.0-0.bpo.1-amd64; KDE/5.28.0; x86_64; ; )
In-Reply-To: <1538090591-28519-3-git-send-email-mhairgrove@nvidia.com>
References: <1538090591-28519-1-git-send-email-mhairgrove@nvidia.com>
 <1538090591-28519-3-git-send-email-mhairgrove@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
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
Cc: linuxppc-dev@lists.ozlabs.org, Reza Arbab <arbab@us.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Thanks Mark,

Looks like some worthwhile improvments to be had. I've added a couple of
comments inline below.

> +#define PAGE_64K (64UL * 1024) +#define PAGE_2M (2UL * 1024 * 1024) +#define
> PAGE_1G (1UL * 1024 * 1024 * 1024)

include/linux/sizes.h includes definitions for SZ_64K, SZ_2M, SZ_1G, etc. so
unless they're redefined here for some reason I personally think it's cleaner to
use those.

>  /*
> - * Invalidate either a single address or an entire PID depending on
> - * the value of va.
> + * Invalidate a virtual address range
>   */
> -static void mmio_invalidate(struct npu_context *npu_context, int va,
> -			unsigned long address, bool flush)
> +static void mmio_invalidate(struct npu_context *npu_context,
> +			unsigned long start, unsigned long size, bool flush)

With this optimisation every caller of mmio_invalidate() sets flush == true so
it no longer appears to be used. We should drop it as a parameter unless you
think there might be some reason to use it in future?

Therefore we could also drop it as a parameter to get_atsd_launch_val(),
mmio_invalidate_pid() and mmio_invalidate_range() as well as I couldn't find any
callers of those that set it to anything other than true.

>  	struct mmio_atsd_reg mmio_atsd_reg[NV_MAX_NPUS];
>  	unsigned long pid = npu_context->mm->context.id;
> +	unsigned long atsd_start = 0;
> +	unsigned long end = start + size - 1;
> +	int atsd_psize = MMU_PAGE_COUNT;
> +
> +	/*
> +	 * Convert the input range into one of the supported sizes. If the range
> +	 * doesn't fit, use the next larger supported size. Invalidation latency
> +	 * is high, so over-invalidation is preferred to issuing multiple
> +	 * invalidates.
> +	 */
> +	if (size == PAGE_64K) {

We also support 4K page sizes on PPC. If I am not mistaken this means every ATSD
would invalidate the entire GPU TLB for a the given PID on those systems. Could
we change the above check to `if (size <= PAGE_64K)` to avoid this?

> +		atsd_start = start;

Which would also require:

      	    atsd_start = ALIGN_DOWN(start, PAGE_64K);

> +		atsd_psize = MMU_PAGE_64K;
> +	} else if (ALIGN_DOWN(start, PAGE_2M) == ALIGN_DOWN(end, PAGE_2M)) {

Wouldn't this lead to under invalidation in ranges which happen to cross a 2M
boundary? For example invalidating a 128K (ie. 2x64K pages) range with start ==
0x1f0000 and end == 0x210000 would result in an invalidation of the range 0x0 -
0x200000 incorrectly leaving 0x200000 - 0x210000 in the GPU TLB.

> +		atsd_start = ALIGN_DOWN(start, PAGE_2M);
> +		atsd_psize = MMU_PAGE_2M;
> +	} else if (ALIGN_DOWN(start, PAGE_1G) == ALIGN_DOWN(end, PAGE_1G)) {

Ditto.

> +		atsd_start = ALIGN_DOWN(start, PAGE_1G);
> +		atsd_psize = MMU_PAGE_1G;
> +	}
>  

- Alistair
