Return-Path: <SRS0=yyDT=PY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22D3EC43387
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Jan 2019 14:59:57 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94C20205C9
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Jan 2019 14:59:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="w4Gj/294"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94C20205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43fr3G2SM0zDqdW
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Jan 2019 01:59:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=robh@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="w4Gj/294"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43fr1F1yf5zDqSF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Jan 2019 01:58:08 +1100 (AEDT)
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com
 [209.85.160.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7894F2086D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Jan 2019 14:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1547650686;
 bh=nt0t9pYYsdnSuuPbQv9J52WaQ4atxiCDmVt76SSqRfE=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=w4Gj/294M9xsXIyGGPb6u6u2bJKtX8cZPwwEEKmrd17Es66QdsgWd7/g1emDN1Q8q
 qNKCzwpIZTdMtSB+LPadUh4eTayc4MB2G59TmneGms+gTa2H2Nca3JcFrVnP1EjmgE
 sHFEVb9aMYpfYEitbi/co8OYfV6PJPKIrG5Vnvic=
Received: by mail-qt1-f178.google.com with SMTP id t13so7439476qtn.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Jan 2019 06:58:06 -0800 (PST)
X-Gm-Message-State: AJcUukcN9DnL/zhFkivCyrY7COSc1YH2ilwf6WQmArOArw350NZcIa86
 bijZXRW34T0hoTH924pcDTqe6xq4VKRdTKoeAA==
X-Google-Smtp-Source: ALg8bN5/JPYhJySu8yj+5+78GK5ulWxogQKP9CP+KUx7IZPKBDkRJqkdxOSoKlnmasroQ3tGSb2ajhyDrHSVYk2220o=
X-Received: by 2002:a0c:9e05:: with SMTP id p5mr7196569qve.246.1547650685554; 
 Wed, 16 Jan 2019 06:58:05 -0800 (PST)
MIME-Version: 1.0
References: <1546952716-2743-1-git-send-email-viorel.suman@nxp.com>
 <1546952716-2743-5-git-send-email-viorel.suman@nxp.com>
 <20190115205755.GA4022@bogus>
 <CAEnQRZBn7nM-KrGSvnzPWuU=a+jyRxfEKhZSsDD4wTqr6spkwg@mail.gmail.com>
In-Reply-To: <CAEnQRZBn7nM-KrGSvnzPWuU=a+jyRxfEKhZSsDD4wTqr6spkwg@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Wed, 16 Jan 2019 08:57:53 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKzmqubd8BVPdju2hLwZNMsen-1+uuHT+S-yirXaSNyHw@mail.gmail.com>
Message-ID: <CAL_JsqKzmqubd8BVPdju2hLwZNMsen-1+uuHT+S-yirXaSNyHw@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH v2 4/4] ASoC: add imx-audmix DT binding
 documentation
To: Daniel Baluta <daniel.baluta@gmail.com>
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>, "S.j. Wang" <shengjiu.wang@nxp.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Daniel Baluta <daniel.baluta@nxp.com>, Takashi Iwai <tiwai@suse.com>,
 Nicolin Chen <nicoleotsuka@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>,
 Mark Brown <broonie@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 Viorel Suman <viorel.suman@nxp.com>, Viorel Suman <viorel.suman@gmail.com>,
 Cosmin Samoila <cosmin.samoila@nxp.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Jan 16, 2019 at 2:22 AM Daniel Baluta <daniel.baluta@gmail.com> wrote:
>
> On Tue, Jan 15, 2019 at 10:58 PM Rob Herring <robh@kernel.org> wrote:
> >
> > On Tue, Jan 08, 2019 at 01:05:51PM +0000, Viorel Suman wrote:
> > > Add the DT binding documentation for Audio Mixer
> > > machine driver.
> > >
> > > Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
> > > ---
> > >  .../devicetree/bindings/sound/imx-audmix.txt       | 24 ++++++++++++++++++++++
> > >  1 file changed, 24 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/sound/imx-audmix.txt
> > >
> > > diff --git a/Documentation/devicetree/bindings/sound/imx-audmix.txt b/Documentation/devicetree/bindings/sound/imx-audmix.txt
> > > new file mode 100644
> > > index 0000000..6ac1230
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/sound/imx-audmix.txt
> > > @@ -0,0 +1,24 @@
> > > +NXP Audio Mixer (AUDMIX) machine driver.
> > > +
> > > +Required properties:
> > > +===================================
> > > +  - compatible               : Compatible list, contains "fsl,imx-audmix"
> > > +
> > > +  - model            : Short audio card description.
> > > +
> > > +  - dais             : Must contain a list of phandles to AUDMIX connected
> > > +                       DAIs. The current implementation requires two phandles
> > > +                       to SAI interfaces to be provided, the first SAI in the
> > > +                       list being used to route the AUDMIX output.
> > > +
> > > +  - audmix-controller        : Must contain the phandle to the AUDMIX device node.
> >
> > I don't think you need 2 nodes for this as this one is just a virtual
> > device. Just add the dais property to the audmix node.
>
> Hi Rob,
>
> Thanks for the suggestion. We want to understand better the reasoning
> behind this.
>
> Is it because dais are physically connected to AUDMIX node?
>
> In ALSA we usually add all the components inside the
> associated machine driver virtual node.

Yes, but in those cases, there's a bunch of components (DAIs, DMA,
DSP, amp, codecs, etc.) with no main device. That doesn't really
appear to be the case here (or your example was incomplete).

It's simply that we try to avoid such virtual devices unless
absolutely necessary.

Rob
