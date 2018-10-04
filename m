Return-Path: <SRS0=m9yV=MQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A436BC64EB8
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 05:26:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 082C720877
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 05:26:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 082C720877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=popple.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42QhF40sNWzF3Bd
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 15:26:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=popple.id.au
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=popple.id.au
 (client-ip=150.101.137.136; helo=ipmail01.adl6.internode.on.net;
 envelope-from=alistair@popple.id.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=popple.id.au
Received: from ipmail01.adl6.internode.on.net (ipmail01.adl6.internode.on.net
 [150.101.137.136])
 by lists.ozlabs.org (Postfix) with ESMTP id 42Qh7c3TY1zF3BG
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Oct 2018 15:21:16 +1000 (AEST)
Received: from static-82-10.transact.net.au (HELO new-mexico.localnet)
 ([122.99.82.10])
 by ipmail01.adl6.internode.on.net with ESMTP; 04 Oct 2018 14:51:15 +0930
From: Alistair Popple <alistair@popple.id.au>
To: Mark Hairgrove <mhairgrove@nvidia.com>
Subject: Re: [PATCH v2 3/3] powerpc/powernv/npu: Remove atsd_threshold debugfs
 setting
Date: Thu, 04 Oct 2018 15:21:15 +1000
Message-ID: <139905864.gJqQYWy3ZL@new-mexico>
User-Agent: KMail/5.2.3 (Linux/4.17.0-0.bpo.1-amd64; KDE/5.28.0; x86_64; ; )
In-Reply-To: <1538592694-18739-4-git-send-email-mhairgrove@nvidia.com>
References: <1538592694-18739-1-git-send-email-mhairgrove@nvidia.com>
 <1538592694-18739-4-git-send-email-mhairgrove@nvidia.com>
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

Reviewed-by: Alistair Popple <alistair@popple.id.au>

On Wednesday, 3 October 2018 11:51:34 AM AEST Mark Hairgrove wrote:
> This threshold is no longer used now that all invalidates issue a single
> ATSD to each active NPU.
> 
> Signed-off-by: Mark Hairgrove <mhairgrove@nvidia.com>
> ---
>  arch/powerpc/platforms/powernv/npu-dma.c |   14 --------------
>  1 files changed, 0 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/powernv/npu-dma.c b/arch/powerpc/platforms/powernv/npu-dma.c
> index e4c0fab..6f60e09 100644
> --- a/arch/powerpc/platforms/powernv/npu-dma.c
> +++ b/arch/powerpc/platforms/powernv/npu-dma.c
> @@ -17,7 +17,6 @@
>  #include <linux/pci.h>
>  #include <linux/memblock.h>
>  #include <linux/iommu.h>
> -#include <linux/debugfs.h>
>  #include <linux/sizes.h>
>  
>  #include <asm/debugfs.h>
> @@ -43,14 +42,6 @@
>  static DEFINE_SPINLOCK(npu_context_lock);
>  
>  /*
> - * When an address shootdown range exceeds this threshold we invalidate the
> - * entire TLB on the GPU for the given PID rather than each specific address in
> - * the range.
> - */
> -static uint64_t atsd_threshold = 2 * 1024 * 1024;
> -static struct dentry *atsd_threshold_dentry;
> -
> -/*
>   * Other types of TCE cache invalidation are not functional in the
>   * hardware.
>   */
> @@ -966,11 +957,6 @@ int pnv_npu2_init(struct pnv_phb *phb)
>  	static int npu_index;
>  	uint64_t rc = 0;
>  
> -	if (!atsd_threshold_dentry) {
> -		atsd_threshold_dentry = debugfs_create_x64("atsd_threshold",
> -				   0600, powerpc_debugfs_root, &atsd_threshold);
> -	}
> -
>  	phb->npu.nmmu_flush =
>  		of_property_read_bool(phb->hose->dn, "ibm,nmmu-flush");
>  	for_each_child_of_node(phb->hose->dn, dn) {
> 


