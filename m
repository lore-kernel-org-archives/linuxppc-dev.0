Return-Path: <SRS0=X2ql=PB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 752D1C43387
	for <linuxppc-dev@archiver.kernel.org>; Mon, 24 Dec 2018 04:47:47 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C6822173C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 24 Dec 2018 04:47:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C6822173C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=buserror.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43NRYX06srzDqWb
	for <linuxppc-dev@archiver.kernel.org>; Mon, 24 Dec 2018 15:47:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=buserror.net
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=buserror.net
 (client-ip=165.227.176.147; helo=baldur.buserror.net;
 envelope-from=oss@buserror.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=buserror.net
Received: from baldur.buserror.net (baldur.buserror.net [165.227.176.147])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43NRWL4zs5zDqVq
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Dec 2018 15:45:49 +1100 (AEDT)
Received: from [2601:449:8400:7293:12bf:48ff:fe84:c9a0]
 by baldur.buserror.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.89) (envelope-from <oss@buserror.net>)
 id 1gbI7c-0005Pd-Kd; Sun, 23 Dec 2018 22:45:44 -0600
Message-ID: <193b66f8bcc52c4900144b4cd742cacd001c9830.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: Peng Ma <peng.ma@nxp.com>, Leo Li <leoyang.li@nxp.com>, Zhang Wei
 <zw@zh-kernel.org>
Date: Sun, 23 Dec 2018 22:45:43 -0600
In-Reply-To: <VI1PR04MB443154AEE42853B62234075EEDBB0@VI1PR04MB4431.eurprd04.prod.outlook.com>
References: <20181222043445.GA29462@home.buserror.net>
 <VI1PR04MB443154AEE42853B62234075EEDBB0@VI1PR04MB4431.eurprd04.prod.outlook.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2601:449:8400:7293:12bf:48ff:fe84:c9a0
X-SA-Exim-Rcpt-To: peng.ma@nxp.com, leoyang.li@nxp.com, zw@zh-kernel.org,
 linuxppc-dev@lists.ozlabs.org, dmaengine@vger.kernel.org, wen.he_1@nxp.com
X-SA-Exim-Mail-From: oss@buserror.net
Subject: Re: [PATCH] dmaengine: fsldma: Add 64-bit I/O accessors for powerpc64
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on baldur.buserror.net)
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
Cc: "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
 Wen He <wen.he_1@nxp.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 2018-12-24 at 03:42 +0000, Peng Ma wrote:
> Hi Scott,
> 
> You are right, we should support powerpc64, so could I changed it as
> fallows:
> 
> diff --git a/drivers/dma/fsldma.h b/drivers/dma/fsldma.h
> index 88db939..057babf 100644
> --- a/drivers/dma/fsldma.h
> +++ b/drivers/dma/fsldma.h
> @@ -202,35 +202,10 @@ struct fsldma_chan {
>  #define fsl_iowrite32(v, p)    out_le32(p, v)
>  #define fsl_iowrite32be(v, p)  out_be32(p, v)
>  
> -#ifndef __powerpc64__
> -static u64 fsl_ioread64(const u64 __iomem *addr)
> -{
> -       u32 fsl_addr = lower_32_bits(addr);
> -       u64 fsl_addr_hi = (u64)in_le32((u32 *)(fsl_addr + 1)) << 32;
> -
> -       return fsl_addr_hi | in_le32((u32 *)fsl_addr);
> -}
> -
> -static void fsl_iowrite64(u64 val, u64 __iomem *addr)
> -{
> -       out_le32((u32 __iomem *)addr + 1, val >> 32);
> -       out_le32((u32 __iomem *)addr, (u32)val);
> -}
> -
> -static u64 fsl_ioread64be(const u64 __iomem *addr)
> -{
> -       u32 fsl_addr = lower_32_bits(addr);
> -       u64 fsl_addr_hi = (u64)in_be32((u32 *)fsl_addr) << 32;
> -
> -       return fsl_addr_hi | in_be32((u32 *)(fsl_addr + 1));
> -}
> -
> -static void fsl_iowrite64be(u64 val, u64 __iomem *addr)
> -{
> -       out_be32((u32 __iomem *)addr, val >> 32);
> -       out_be32((u32 __iomem *)addr + 1, (u32)val);
> -}
> -#endif
> +#define fsl_ioread64(p)                in_le64(p)
> +#define fsl_ioread64be(p)      in_be64(p)
> +#define fsl_iowrite64(v, p)    out_le64(p, v)
> +#define fsl_iowrite64be(v, p)  out_be64(p, v)
>  #endif

Then you'll break 32-bit, assuming those fake-it-with-two-32-bit-accesses were
actually needed.

-Scott


