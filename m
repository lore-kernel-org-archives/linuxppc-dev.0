Return-Path: <SRS0=t5Ns=QU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 423C9C282C2
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 19:31:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85B93222CF
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 19:31:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="MRdSBbmo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85B93222CF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4408lB31GjzDq7g
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Feb 2019 06:31:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=robh@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="MRdSBbmo"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4408gj1pyBzDqSF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Feb 2019 06:28:00 +1100 (AEDT)
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com
 [209.85.160.175])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 81E3C222D7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Feb 2019 19:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550086078;
 bh=d4USaxOaZ5zIs0Yd6AYwU7IxGiiMG63YyGPnEEw7QQk=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=MRdSBbmokqMe8z+9FVsMJsm648JqGS4TxplBfDvE4kg//D3ih8EgoUzNEvOm+uwxn
 OfG3inpBJ3aRJziIpru75JaWAPGejKP+rW0jT753boDgWR4cniOiayP/gg5vgcXp5C
 PoMWr+zmo30lm/AU8BhVR7120eozOfZ2/B37L/HE=
Received: by mail-qt1-f175.google.com with SMTP id e5so3974251qtr.12
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Feb 2019 11:27:58 -0800 (PST)
X-Gm-Message-State: AHQUAubRfSO6YrbVgtYVGBgD1zx44ykFX7Ex6bwI9Q3YDFhkkMlwQrX6
 K+zB2vsW9s0rTWBmdcAYvI3DcTcCxPTEctyg3A==
X-Google-Smtp-Source: AHgI3Ia7ZzDKkBkWUQYA6sU/9ZdcsVSBsmd/pRgt7FkqYjFxVtDglXsm4TWC21OgiOFhLerCX65ssWFBeBIZC5R9+H0=
X-Received: by 2002:a0c:9e05:: with SMTP id p5mr1699437qve.246.1550086077695; 
 Wed, 13 Feb 2019 11:27:57 -0800 (PST)
MIME-Version: 1.0
References: <20190211133554.30055-1-hch@lst.de>
 <20190211133554.30055-7-hch@lst.de>
 <CAL_JsqL+LiJTF5kZz2hXGbQcH+D4U0jAQE376VSUVMQmdg=XFA@mail.gmail.com>
 <20190213182435.GA19906@lst.de>
In-Reply-To: <20190213182435.GA19906@lst.de>
From: Rob Herring <robh@kernel.org>
Date: Wed, 13 Feb 2019 13:27:45 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLCr4Jk_-cWUFGs5zfk+NKksc+bs0bpiBeQHsZFthaM1Q@mail.gmail.com>
Message-ID: <CAL_JsqLCr4Jk_-cWUFGs5zfk+NKksc+bs0bpiBeQHsZFthaM1Q@mail.gmail.com>
Subject: Re: [PATCH 06/12] dma-mapping: improve selection of
 dma_declare_coherent availability
To: Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
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
Cc: linux-xtensa@linux-xtensa.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 SH-Linux <linux-sh@vger.kernel.org>, devicetree@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, x86@kernel.org,
 linux-mips@vger.kernel.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Linux IOMMU <iommu@lists.linux-foundation.org>,
 linux-riscv@lists.infradead.org, arcml <linux-snps-arc@lists.infradead.org>,
 Lee Jones <lee.jones@linaro.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Feb 13, 2019 at 12:24 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Tue, Feb 12, 2019 at 02:40:23PM -0600, Rob Herring wrote:
> > > diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
> > > index 3607fd2810e4..f8c66a9472a4 100644
> > > --- a/drivers/of/Kconfig
> > > +++ b/drivers/of/Kconfig
> > > @@ -43,6 +43,7 @@ config OF_FLATTREE
> > >
> > >  config OF_EARLY_FLATTREE
> > >         bool
> > > +       select DMA_DECLARE_COHERENT
> >
> > Is selecting DMA_DECLARE_COHERENT okay on UML? We run the unittests with UML.
>
> No, that will fail with undefined references to memunmap.
>
> I gues this needs to be
>
>         select DMA_DECLARE_COHERENT if HAS_DMA
>
> > Maybe we should just get rid of OF_RESERVED_MEM. If we support booting
> > from DT, then it should always be enabled anyways.
>
> Fine with me.  Do you want me to respin the series to just remove
> it?

Either now or it can wait. I don't want to hold this up any.

Rob
