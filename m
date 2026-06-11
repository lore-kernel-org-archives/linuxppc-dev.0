Return-Path: <linuxppc-dev+bounces-22513-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45F07CD98C7
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Jun 2026 16:37:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gbpG070X7z3brC;
	Fri, 12 Jun 2026 02:37:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::52f" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781195832;
	cv=pass; b=dRKz9N0Fv16JMwQOK0rud9WoDGrFFDLZflm3V755RWfy+RB0oJnQRpykRtWuOJdPxTYScCIqZXI7Y7g95hgDhlXA0gXeygpieX7cXkVmE4N7GpL4qtP+G4Dtwgb7nHegWqEPDWm3AKE15HYP3vIG857c7K7qnXah2HeEt21a3VLVb5DryMKBefloCrA3HPuqgDcO8Ot58i2kfmqmuvZvCG4W2cMlDX4iXnQSno36Qybf3jbh6G3ov6P2+/p8R+CnmPd2uifODYgK5YUWbAY5GICGYf8pVDc9N9fPSSgfyZ4+x9PmdyEsRV//mbooBXwuBdpjOLOsETIWGI89E2zOlA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781195832; c=relaxed/relaxed;
	bh=4DStYhYQsSipTicO46WKSDE7hgZDuh6T94LBB/5C16M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SwcY3yi5bbDV0ueBwatbHkbZgoKpqrLI1agoBgnIikPa8RBFaWPhou8iYtrQk3Zym6c7nGRmlzlJ/sfSd8/ma4SypnVrS0xTpY/fFwU8lByPApopPJw40+wAZXE+uNqCS4OGyQp1kkzhq20orF3+wqMS6KX+KhwlX0YfgfxZNX+aBRf6+Ka+RN/XBVKromy6B7tKWadNp74tvkOQfLWJ5SRqD8sE1tsP+pkAcfcSK8GIhFYEX4IktWz1NaOJNJZJ/GB2TiW3WySf9CR9kbcTWBZK9uIeyEQOhgf6Xda7wqw5ZEkWe7U8hJIZoZSCXsHzwwXKA0e6Fl74q2/LdkRC6A==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=K5qX7sC5; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::52f; helo=mail-ed1-x52f.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=K5qX7sC5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::52f; helo=mail-ed1-x52f.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gbpFz6K8vz3bpP
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jun 2026 02:37:11 +1000 (AEST)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-6912f4acca4so68136a12.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2026 09:37:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781195828; cv=none;
        d=google.com; s=arc-20240605;
        b=cYxOpqiCp2o4H59XaniLB2O7Ts7TbvmFhuNXrscY5sQitKDlFshfqes2BuU4F6gN5T
         FQupSYty9+XRmLf3azVCdsSSwacVJREMEO2fiK79ar2hHyJXr4CTkoEpeUPMYxKXIeOZ
         Zy0ZBhv9MMWlHAoVpW8JYvyyU2kEIZziFRfYIzJo/hPwHzp+jlRh2/MORUSP+IjhVBuA
         tOzMPT2y4Kl83ZhQfALp9lu1AJmoxD6lxjItONbauEDSAgiV3XCN4zXe8bi467Vq1PlK
         08j1UUkWIKxQUwdMlFzpwuxqRG68YipfpaTNp2/929miNhOLIftsFpC30B22IpUjYCUP
         OE8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4DStYhYQsSipTicO46WKSDE7hgZDuh6T94LBB/5C16M=;
        fh=yBO99/lG4je4I9D+58WuzJHmoTy6q3hmEXfZR5DdUu0=;
        b=XmxPGluBkzsnaDRppsg+a7Uq96o8O7cOGqZUqMEcbAXWi8GG8wmPwLK12vw+tCeoJH
         zws3GITySosbkdeRjLif7Pu6/zjMyDrOfOooNmT0AhKdCCI4r7FnIyJ7I2bdYb+tLFMO
         4IUUgKAfSwjmDKdz5S5Sd7/Bd3Z96nXgDh4hU9qo45nhaWHxoMU5RAPQEi4J+fiFqxcB
         AJhUpZUakmDFSmyzWiuHr9dLlygZCUg3bdmKr2YjYbFgcD9egDgUZZyD18IDIBN+BGQl
         cEssioHeQQrqfbbWculDq47n5goY3K0gXHUraz/is2A114aeSWlg//aWoCI6X01j57ob
         KYrw==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781195828; x=1781800628; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4DStYhYQsSipTicO46WKSDE7hgZDuh6T94LBB/5C16M=;
        b=K5qX7sC5RvGtrIYA+kjBinLZnNvLvHyMp2i/4NPzcZwYUb+IdBOJdXpnVNkJGGj9Pd
         solK2bdzy/jUiTnSK9MyJFJgnQLuT2Zl1/ihExk/q8B5tGJ0NM0crpJBQHk48VZQVFpK
         E/moYWr7iMPKAk7PCbnCVYCZk+TcdiiZi5n8No6IR+BFbzcTE+lI3ygpIu5bPE1fjToz
         beeORYyLauc/8jDJCtsRXb23qfXF03ECshorGXcd9vo/PzawFVpYOGFBiEq0taVMZqcl
         W+p7hBj9Vome1R4n32Y2NfuzPZyi0rFiGoJIo4SZMytBwmaVgrVjsZ0K+97zSlHjQuyV
         Lamw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781195828; x=1781800628;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4DStYhYQsSipTicO46WKSDE7hgZDuh6T94LBB/5C16M=;
        b=DMzyv+3/qRA3eHRvXHF2hDapkZ8wQXcZsJMXT2yJRKlQSSXqS9lAiVhEp9snhd5gTw
         k1ZCLG5k2eN/8fSotwP7Al2eGbwQGk8qxlvn9pZCC2rofuqdUhVPEP2+2OkljlcEhpNa
         4hPndfWgThtkMl0t8VY/pk4Fr3EkxTHilJl2kqzjo6KlnUT2/8+IhNeoT/Qok8F0wetD
         9cX6dkxa8Be8msjp5NtYpZRX8zmWqbnyhsBKLpCVchMbB3TB5XGKJ9cj0hQKvQmxrYUq
         ImS5LBLqUPOqwsevoYRzAWS4sgtIUHAfrJuh60I/mTMKpNQDjm/cIUW1TRyC1KpnAUWS
         +YGQ==
X-Forwarded-Encrypted: i=1; AFNElJ8dEV4xu0hE20wSBR2XG93iA4ZjZCPSG/wqfEgUctkitntAyEuBrYFDThpdEQiJHb8hMpAt7nj7GI4gkU4=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YysPvw7x0ezY7yFaK11Bdo96U1XWhi4hUWp3P/B9OuwpPo8iEbq
	kFhSM/IiUhUvJB9zYp4OYrxniZNEEVDsaKdWuSvhPv7xhmuOA968V5GZWXZgIm0QWYFJkDBdDKy
	aAnDI41aff50/4gwIHlAtyiz8wkSAUeyxoA==
X-Gm-Gg: Acq92OEVf4S0JX0KlKjZkLdTomx4yd46O/y5b0s2cC/mCHfqwAFVMP77/M2Nu0qGXE2
	vVQY6/BHdhABjatWXUJjOYN9jSFCE9k3A3O0CxwwKAbCG2hboE/2uHejQJhzOxywFBAvH5Q9kd4
	o8SgjiyujX/cjzsdguZR/x/r85wZgamj7sipHUjGut8Z8K7WO/3WbCvdUqdMHC3n6ItkbkVjVRv
	DE9dKRrQfS0NG6JmcDtzWySxrTU7LxvIe5mr/hwBGWtLN+edx225P7oEpO1Emy1FDL1aVfm9TW1
	JygBDIPT+fO8hj7b3k1lgPi4EJJLSmN2sV2DoSTNzEpe4K6B3lquFk9iCZu5ujBh0CGG+pKyG9b
	dcKX5GRF4Ave9TtZFDQ/qU/rRBDmwCib9WkO3TVr+Swmist9vbDf9ZL8y
X-Received: by 2002:a05:6402:358d:b0:687:1c98:a19a with SMTP id
 4fb4d7f45d1cf-6930e2b5e6fmr2054888a12.13.1781195827845; Thu, 11 Jun 2026
 09:37:07 -0700 (PDT)
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
References: <20260611035245.13439-1-rosenp@gmail.com> <20260611035245.13439-12-rosenp@gmail.com>
 <airV8Wm3yyY4hTQP@lizhi-Precision-Tower-5810> <CAKxU2N9QNMo9u0s_MfYG8qfiWsHqwuB9ax_qbf6gbxA0syOiaw@mail.gmail.com>
 <airjMsF-YPGSt3-S@lizhi-Precision-Tower-5810>
In-Reply-To: <airjMsF-YPGSt3-S@lizhi-Precision-Tower-5810>
From: Rosen Penev <rosenp@gmail.com>
Date: Thu, 11 Jun 2026 09:36:56 -0700
X-Gm-Features: AVVi8CdY6DBOq_Kf9XCWgkvqCE4_jbHsMoVYEFsNT-EymPwcj5ekivftZTICTTw
Message-ID: <CAKxU2N9aaQhtmYjA+sQqSmgGDoeqEJc=8WFppWN=Q-i=0oPRMA@mail.gmail.com>
Subject: Re: [PATCHv4 11/15] dmaengine: fsldma: convert channel allocation to devm_kzalloc()
To: Frank Li <Frank.li@oss.nxp.com>
Cc: dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>, 
	Frank Li <Frank.Li@kernel.org>, Zhang Wei <zw@zh-kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:FREESCALE DMA DRIVER" <linuxppc-dev@lists.ozlabs.org>, 
	"open list:CLANG/LLVM BUILD SUPPORT:Keyword:b(?i:clang|llvm)b" <llvm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2026 at 9:33=E2=80=AFAM Frank Li <Frank.li@oss.nxp.com> wro=
te:
>
> On Thu, Jun 11, 2026 at 09:08:32AM -0700, Rosen Penev wrote:
> > On Thu, Jun 11, 2026 at 8:36=E2=80=AFAM Frank Li <Frank.li@oss.nxp.com>=
 wrote:
> > >
> > > On Wed, Jun 10, 2026 at 08:52:41PM -0700, Rosen Penev wrote:
> > > > Convert fsl_dma_chan_probe from kzalloc_obj() to devm_kzalloc(), ty=
ing
> > > > the channel lifetime to the parent DMA device. Remove kfree(chan) i=
n both
> > > > the probe error path and the remove function.
> > > >
> > > > Assisted-by: opencode:big-pickle
> > > > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > > > ---
> > >
> > > If use flexible array, needn't allocate channel
> > Not sure what you mean. A regular array avoids that as well.
>
> Yes, consider only max 8 channel. Now the common method is
>
> fsl
> {
>         ....
>         int chan_count;
>         fsl_chan chan[] __count_by can_count;
> }
>
> scan children node to get total number
right. allocation happens on two compatible strings currently. I guess
it's safe to assume one of each is present in each child.
>
> devm_kzalloc(..., struct_size(fsl, chan_count)) ...
>
> Frank
>
> > >
> > > Frank
> > >
> > > >  drivers/dma/fsldma.c | 12 +++---------
> > > >  1 file changed, 3 insertions(+), 9 deletions(-)
> > > >
> > > > diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
> > > > index e4a3315a7d9d..0df09789187d 100644
> > > > --- a/drivers/dma/fsldma.c
> > > > +++ b/drivers/dma/fsldma.c
> > > > @@ -1114,11 +1114,9 @@ static int fsl_dma_chan_probe(struct fsldma_=
device *fdev,
> > > >       int err;
> > > >
> > > >       /* alloc channel */
> > > > -     chan =3D kzalloc_obj(*chan);
> > > > -     if (!chan) {
> > > > -             err =3D -ENOMEM;
> > > > -             goto out_return;
> > > > -     }
> > > > +     chan =3D devm_kzalloc(fdev->dev, sizeof(*chan), GFP_KERNEL);
> > > > +     if (!chan)
> > > > +             return -ENOMEM;
> > > >
> > > >       /* ioremap registers for use */
> > > >       chan->regs =3D of_iomap(node, 0);
> > > > @@ -1200,9 +1198,6 @@ static int fsl_dma_chan_probe(struct fsldma_d=
evice *fdev,
> > > >
> > > >  out_iounmap_regs:
> > > >       iounmap(chan->regs);
> > > > -out_free_chan:
> > > > -     kfree(chan);
> > > > -out_return:
> > > >       return err;
> > > >  }
> > > >
> > > > @@ -1215,7 +1210,6 @@ static void fsl_dma_chan_remove(struct fsldma=
_chan *chan)
> > > >       tasklet_kill(&chan->tasklet);
> > > >       list_del(&chan->common.device_node);
> > > >       iounmap(chan->regs);
> > > > -     kfree(chan);
> > > >  }
> > > >
> > > >  static void fsldma_device_release(struct dma_device *dma_dev);
> > > > --
> > > > 2.54.0
> > > >

