Return-Path: <SRS0=aKpC=P3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 492B5C61CE4
	for <linuxppc-dev@archiver.kernel.org>; Sat, 19 Jan 2019 13:02:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65CAE2086D
	for <linuxppc-dev@archiver.kernel.org>; Sat, 19 Jan 2019 13:02:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="x2mZvkm7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65CAE2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43hdHz16g0zDr10
	for <linuxppc-dev@archiver.kernel.org>; Sun, 20 Jan 2019 00:02:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=vkoul@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="x2mZvkm7"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43hdFy06QvzDqnF
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 20 Jan 2019 00:00:21 +1100 (AEDT)
Received: from localhost (unknown [122.178.235.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9D79C20821;
 Sat, 19 Jan 2019 13:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1547902818;
 bh=3CCAL02seb2V7PNjw/dmp1yigpVZKTd9thzpm4sfrfQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=x2mZvkm7bZeOyCG0Im/zoLp+mDwvJL1WekPA6kvY2n05RMTXJSUlp07STm5odfL83
 klzNGujXNAXQ0O4Vj+RuCIDBj1uAlpKBLnPDHjknYCsgcasxY2AuhvrsL4P8zyclTY
 zJV3lCW2K2brEFnkjoExCf8CalxdfhOu44HcM6wo=
Date: Sat, 19 Jan 2019 18:28:41 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Peng Ma <peng.ma@nxp.com>
Subject: Re: [PATCH] dmaengine: fsldma: Add 64-bit I/O accessors for powerpc64
Message-ID: <20190119125841.GE4635@vkoul-mobl>
References: <20181222043445.GA29462@home.buserror.net>
 <VI1PR04MB443154AEE42853B62234075EEDBB0@VI1PR04MB4431.eurprd04.prod.outlook.com>
 <193b66f8bcc52c4900144b4cd742cacd001c9830.camel@buserror.net>
 <VI1PR04MB4431C33B5155312CF7035584EDBB0@VI1PR04MB4431.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <VI1PR04MB4431C33B5155312CF7035584EDBB0@VI1PR04MB4431.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: Wen He <wen.he_1@nxp.com>, Leo Li <leoyang.li@nxp.com>,
 Scott Wood <oss@buserror.net>, Zhang Wei <zw@zh-kernel.org>,
 "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 24-12-18, 05:29, Peng Ma wrote:
> Hi Scott,
> 
> Oh, I did not see the in_XX64/out_XX64 supported only __powerpc64__ just now.
> Thanks for your reminder.

Can you send the formal patch for this...

FWIW, fsl patches were not merged last cycle because of reported
regression...

> 
> #ifdef __powerpc64__
> 
> #ifdef __BIG_ENDIAN__
> DEF_MMIO_OUT_D(out_be64, 64, std);
> DEF_MMIO_IN_D(in_be64, 64, ld);
> 
> /* There is no asm instructions for 64 bits reverse loads and stores */
> static inline u64 in_le64(const volatile u64 __iomem *addr)
> {
>         return swab64(in_be64(addr));
> }
> 
> static inline void out_le64(volatile u64 __iomem *addr, u64 val)
> {
>         out_be64(addr, swab64(val));
> }
> #else
> DEF_MMIO_OUT_D(out_le64, 64, std);
> DEF_MMIO_IN_D(in_le64, 64, ld);
> 
> /* There is no asm instructions for 64 bits reverse loads and stores */
> static inline u64 in_be64(const volatile u64 __iomem *addr)
> {
>         return swab64(in_le64(addr));
> }
> 
> static inline void out_be64(volatile u64 __iomem *addr, u64 val)
> {
>         out_le64(addr, swab64(val));
> }
> 
> #endif
> #endif /* __powerpc64__ */
> 
> Best Regards,
> Peng
> >-----Original Message-----
> >From: Scott Wood <oss@buserror.net>
> >Sent: 2018年12月24日 12:46
> >To: Peng Ma <peng.ma@nxp.com>; Leo Li <leoyang.li@nxp.com>; Zhang Wei
> ><zw@zh-kernel.org>
> >Cc: linuxppc-dev@lists.ozlabs.org; dmaengine@vger.kernel.org; Wen He
> ><wen.he_1@nxp.com>
> >Subject: Re: [PATCH] dmaengine: fsldma: Add 64-bit I/O accessors for
> >powerpc64
> >
> >On Mon, 2018-12-24 at 03:42 +0000, Peng Ma wrote:
> >> Hi Scott,
> >>
> >> You are right, we should support powerpc64, so could I changed it as
> >> fallows:
> >>
> >> diff --git a/drivers/dma/fsldma.h b/drivers/dma/fsldma.h index
> >> 88db939..057babf 100644
> >> --- a/drivers/dma/fsldma.h
> >> +++ b/drivers/dma/fsldma.h
> >> @@ -202,35 +202,10 @@ struct fsldma_chan {
> >>  #define fsl_iowrite32(v, p)    out_le32(p, v)
> >>  #define fsl_iowrite32be(v, p)  out_be32(p, v)
> >>
> >> -#ifndef __powerpc64__
> >> -static u64 fsl_ioread64(const u64 __iomem *addr) -{
> >> -       u32 fsl_addr = lower_32_bits(addr);
> >> -       u64 fsl_addr_hi = (u64)in_le32((u32 *)(fsl_addr + 1)) << 32;
> >> -
> >> -       return fsl_addr_hi | in_le32((u32 *)fsl_addr);
> >> -}
> >> -
> >> -static void fsl_iowrite64(u64 val, u64 __iomem *addr) -{
> >> -       out_le32((u32 __iomem *)addr + 1, val >> 32);
> >> -       out_le32((u32 __iomem *)addr, (u32)val);
> >> -}
> >> -
> >> -static u64 fsl_ioread64be(const u64 __iomem *addr) -{
> >> -       u32 fsl_addr = lower_32_bits(addr);
> >> -       u64 fsl_addr_hi = (u64)in_be32((u32 *)fsl_addr) << 32;
> >> -
> >> -       return fsl_addr_hi | in_be32((u32 *)(fsl_addr + 1));
> >> -}
> >> -
> >> -static void fsl_iowrite64be(u64 val, u64 __iomem *addr) -{
> >> -       out_be32((u32 __iomem *)addr, val >> 32);
> >> -       out_be32((u32 __iomem *)addr + 1, (u32)val);
> >> -}
> >> -#endif
> >> +#define fsl_ioread64(p)                in_le64(p)
> >> +#define fsl_ioread64be(p)      in_be64(p)
> >> +#define fsl_iowrite64(v, p)    out_le64(p, v)
> >> +#define fsl_iowrite64be(v, p)  out_be64(p, v)
> >>  #endif
> >
> >Then you'll break 32-bit, assuming those fake-it-with-two-32-bit-accesses
> >were actually needed.
> >
> >-Scott
> >
> 

-- 
~Vinod
