Return-Path: <SRS0=LYrz=MO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7240C43143
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 07:15:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 518722089A
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 07:15:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 518722089A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=popple.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42PVlv6DsTzF3Fc
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 17:15:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=popple.id.au
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=popple.id.au
 (client-ip=150.101.137.131; helo=ipmail07.adl2.internode.on.net;
 envelope-from=alistair@popple.id.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=popple.id.au
Received: from ipmail07.adl2.internode.on.net (ipmail07.adl2.internode.on.net
 [150.101.137.131])
 by lists.ozlabs.org (Postfix) with ESMTP id 42PVjC1hLXzF3F0
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Oct 2018 17:12:47 +1000 (AEST)
Received: from static-82-10.transact.net.au (HELO new-mexico.localnet)
 ([122.99.82.10])
 by ipmail07.adl2.internode.on.net with ESMTP; 02 Oct 2018 16:42:47 +0930
From: Alistair Popple <alistair@popple.id.au>
To: Mark Hairgrove <mhairgrove@nvidia.com>
Subject: Re: [PATCH 3/3] powerpc/powernv/npu: Remove atsd_threshold debugfs
 setting
Date: Tue, 02 Oct 2018 17:12:46 +1000
Message-ID: <2584602.ukHKReRI4X@new-mexico>
User-Agent: KMail/5.2.3 (Linux/4.17.0-0.bpo.1-amd64; KDE/5.28.0; x86_64; ; )
In-Reply-To: <1538090591-28519-4-git-send-email-mhairgrove@nvidia.com>
References: <1538090591-28519-1-git-send-email-mhairgrove@nvidia.com>
 <1538090591-28519-4-git-send-email-mhairgrove@nvidia.com>
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

Looks good to me, thanks!

Reviewed-by: Alistair Popple <alistair@popple.id.au>

On Thursday, 27 September 2018 4:23:11 PM AEST Mark Hairgrove wrote:
> This threshold is no longer used now that all invalidates issue a single
> ATSD to each active NPU.
> 
> Signed-off-by: Mark Hairgrove <mhairgrove@nvidia.com>
> ---
>  arch/powerpc/platforms/powernv/npu-dma.c |   13 -------------
>  1 files changed, 0 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/powernv/npu-dma.c b/arch/powerpc/platforms/powernv/npu-dma.c
> index e471a1a..426df1b 100644
> --- a/arch/powerpc/platforms/powernv/npu-dma.c
> +++ b/arch/powerpc/platforms/powernv/npu-dma.c
> @@ -42,14 +42,6 @@
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
> @@ -968,11 +960,6 @@ int pnv_npu2_init(struct pnv_phb *phb)
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


