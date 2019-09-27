Return-Path: <SRS0=CCuM=XW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C948C4360C
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Sep 2019 22:57:41 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6ACAF20863
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Sep 2019 22:57:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ACAF20863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46g6dG110xzDr34
	for <linuxppc-dev@archiver.kernel.org>; Sat, 28 Sep 2019 08:57:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=lst.de
 (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=lst.de
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46g6bF3yk4zDqyp
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Sep 2019 08:55:51 +1000 (AEST)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 5A6E068B05; Sat, 28 Sep 2019 00:55:45 +0200 (CEST)
Date: Sat, 28 Sep 2019 00:55:45 +0200
From: Christoph Hellwig <hch@lst.de>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Subject: Re: [PATCH] powerpc: use <asm-generic/dma-mapping.h>
Message-ID: <20190927225545.GA18497@lst.de>
References: <20190807150752.17894-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190807150752.17894-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
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
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

ping?

On Wed, Aug 07, 2019 at 06:07:52PM +0300, Christoph Hellwig wrote:
> The powerpc version of dma-mapping.h only contains a version of
> get_arch_dma_ops that always return NULL.  Replace it with the
> asm-generic version that does the same.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/powerpc/include/asm/Kbuild        |  1 +
>  arch/powerpc/include/asm/dma-mapping.h | 18 ------------------
>  2 files changed, 1 insertion(+), 18 deletions(-)
>  delete mode 100644 arch/powerpc/include/asm/dma-mapping.h
> 
> diff --git a/arch/powerpc/include/asm/Kbuild b/arch/powerpc/include/asm/Kbuild
> index 9a1d2fc6ceb7..15bb09ad5dc2 100644
> --- a/arch/powerpc/include/asm/Kbuild
> +++ b/arch/powerpc/include/asm/Kbuild
> @@ -4,6 +4,7 @@ generated-y += syscall_table_64.h
>  generated-y += syscall_table_c32.h
>  generated-y += syscall_table_spu.h
>  generic-y += div64.h
> +generic-y += dma-mapping.h
>  generic-y += export.h
>  generic-y += irq_regs.h
>  generic-y += local64.h
> diff --git a/arch/powerpc/include/asm/dma-mapping.h b/arch/powerpc/include/asm/dma-mapping.h
> deleted file mode 100644
> index 565d6f74b189..000000000000
> --- a/arch/powerpc/include/asm/dma-mapping.h
> +++ /dev/null
> @@ -1,18 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -/*
> - * Copyright (C) 2004 IBM
> - */
> -#ifndef _ASM_DMA_MAPPING_H
> -#define _ASM_DMA_MAPPING_H
> -
> -static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
> -{
> -	/* We don't handle the NULL dev case for ISA for now. We could
> -	 * do it via an out of line call but it is not needed for now. The
> -	 * only ISA DMA device we support is the floppy and we have a hack
> -	 * in the floppy driver directly to get a device for us.
> -	 */
> -	return NULL;
> -}
> -
> -#endif	/* _ASM_DMA_MAPPING_H */
> -- 
> 2.20.1
---end quoted text---
