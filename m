Return-Path: <SRS0=1oDC=MP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8273FC64EBC
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 01:13:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC79A206B2
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 01:13:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="bSDuui5y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC79A206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Pyh01vs4zF38c
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 11:13:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=nvidia.com header.i=@nvidia.com header.b="bSDuui5y";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nvidia.com
 (client-ip=216.228.121.64; helo=hqemgate15.nvidia.com;
 envelope-from=mhairgrove@nvidia.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=nvidia.com header.i=@nvidia.com header.b="bSDuui5y"; 
 dkim-atps=neutral
Received: from hqemgate15.nvidia.com (hqemgate15.nvidia.com [216.228.121.64])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42PydR556nzF38J
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Oct 2018 11:11:07 +1000 (AEST)
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5bb417110001>; Tue, 02 Oct 2018 18:10:41 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
 by hqpgpgate102.nvidia.com (PGP Universal service);
 Tue, 02 Oct 2018 18:11:02 -0700
X-PGP-Universal: processed;
 by hqpgpgate102.nvidia.com on Tue, 02 Oct 2018 18:11:02 -0700
Received: from mdh-linux64-2.nvidia.com (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 3 Oct
 2018 01:11:02 +0000
Date: Tue, 2 Oct 2018 18:10:31 -0700
From: Mark Hairgrove <mhairgrove@nvidia.com>
To: Alistair Popple <alistair@popple.id.au>
Subject: Re: [PATCH 2/3] powerpc/powernv/npu: Use size-based ATSD invalidates
In-Reply-To: <1843554.67Higpl3JC@new-mexico>
Message-ID: <alpine.DEB.2.00.1810021750110.16676@mdh-linux64-2.nvidia.com>
References: <1538090591-28519-1-git-send-email-mhairgrove@nvidia.com>
 <1538090591-28519-3-git-send-email-mhairgrove@nvidia.com>
 <1843554.67Higpl3JC@new-mexico>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-NVConfidentiality: public
MIME-Version: 1.0
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="US-ASCII"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1538529041; bh=mLcwORTpet6eohMRgBNvz2G64ZtcWBo3EFzFhWhRI5A=;
 h=X-PGP-Universal:Date:From:To:CC:Subject:In-Reply-To:Message-ID:
 References:User-Agent:X-NVConfidentiality:MIME-Version:
 X-Originating-IP:X-ClientProxiedBy:Content-Type;
 b=bSDuui5yDdvG1TG1yxSSPDTh3NIvW47sGZkPTpqW59W8ydnjngRMMMcGKQtReCSv5
 B25RbjP1rtxEJWboY4N/GLlVh0qu6PTqUr6JGI/Wv8tTBRN+uvNZNEY8s1JwbTAZ58
 jXDz8itNvzC9cJdyp3OqI6TJDn6htEhpx++Swz01At006K54vm+u/JTmx06AJcHKsF
 XuTlY/ohsNSraztp3cUK/Gf66mvrKZGyREtLE5DQ9siERfNaGhmX9YT14X9c+DreUB
 EeEaEO2hE3+vVJD7cTjvAOKB7cYKPI0512923DXrp9uscQcbXkdutTXo0WZgBCt/Iy
 j+NhSoZFKjM/g==
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


Thanks for the review. Comments below.

On Tue, 2 Oct 2018, Alistair Popple wrote:

> Thanks Mark,
> 
> Looks like some worthwhile improvments to be had. I've added a couple of
> comments inline below.
> 
> > +#define PAGE_64K (64UL * 1024) +#define PAGE_2M (2UL * 1024 * 1024) +#define
> > PAGE_1G (1UL * 1024 * 1024 * 1024)
> 
> include/linux/sizes.h includes definitions for SZ_64K, SZ_2M, SZ_1G, etc. so
> unless they're redefined here for some reason I personally think it's cleaner to
> use those.

Agreed, will fix. Thanks for the pointer.


> 
> >  /*
> > - * Invalidate either a single address or an entire PID depending on
> > - * the value of va.
> > + * Invalidate a virtual address range
> >   */
> > -static void mmio_invalidate(struct npu_context *npu_context, int va,
> > -			unsigned long address, bool flush)
> > +static void mmio_invalidate(struct npu_context *npu_context,
> > +			unsigned long start, unsigned long size, bool flush)
> 
> With this optimisation every caller of mmio_invalidate() sets flush == true so
> it no longer appears to be used. We should drop it as a parameter unless you
> think there might be some reason to use it in future?
> 
> Therefore we could also drop it as a parameter to get_atsd_launch_val(),
> mmio_invalidate_pid() and mmio_invalidate_range() as well as I couldn't find any
> callers of those that set it to anything other than true.

Yeah, good catch. I'll simplify all of those.


> 
> >  	struct mmio_atsd_reg mmio_atsd_reg[NV_MAX_NPUS];
> >  	unsigned long pid = npu_context->mm->context.id;
> > +	unsigned long atsd_start = 0;
> > +	unsigned long end = start + size - 1;
> > +	int atsd_psize = MMU_PAGE_COUNT;
> > +
> > +	/*
> > +	 * Convert the input range into one of the supported sizes. If the range
> > +	 * doesn't fit, use the next larger supported size. Invalidation latency
> > +	 * is high, so over-invalidation is preferred to issuing multiple
> > +	 * invalidates.
> > +	 */
> > +	if (size == PAGE_64K) {
> 
> We also support 4K page sizes on PPC. If I am not mistaken this means every ATSD
> would invalidate the entire GPU TLB for a the given PID on those systems. Could
> we change the above check to `if (size <= PAGE_64K)` to avoid this?

PPC supports 4K pages but the GPU ATS implementation does not. For that
reason I didn't bother handling invalidates smaller than 64K. I'll add a
comment on that.

I don't know that this requirement is enforced anywhere though. I could
add a PAGE_SIZE == 64K check to pnv_npu2_init_context if you think it
would be useful.


> 
> > +		atsd_start = start;
> 
> Which would also require:
> 
>       	    atsd_start = ALIGN_DOWN(start, PAGE_64K);
> 
> > +		atsd_psize = MMU_PAGE_64K;
> > +	} else if (ALIGN_DOWN(start, PAGE_2M) == ALIGN_DOWN(end, PAGE_2M)) {
> 
> Wouldn't this lead to under invalidation in ranges which happen to cross a 2M
> boundary? For example invalidating a 128K (ie. 2x64K pages) range with start ==
> 0x1f0000 and end == 0x210000 would result in an invalidation of the range 0x0 -
> 0x200000 incorrectly leaving 0x200000 - 0x210000 in the GPU TLB.

In this example:
start                         0x1f0000
size                          0x020000
end (start + size - 1)        0x20ffff
ALIGN_DOWN(start, PAGE_2M)    0x000000
ALIGN_DOWN(end, PAGE_2M)      0x200000

Since ALIGN_DOWN(start, PAGE_2M) != ALIGN_DOWN(end, PAGE_2M), the
condition fails and we move to the 1G clause. Then
ALIGN_DOWN(start, PAGE_1G) == ALIGN_DOWN(end, PAGE_1G) == 0, so we
invalidate the range [0, 1G).
