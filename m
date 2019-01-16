Return-Path: <SRS0=yyDT=PY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D18BFC43387
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Jan 2019 08:23:41 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4847F20859
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Jan 2019 08:23:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="khRVGQJS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4847F20859
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43fgG24vhpzDqWg
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Jan 2019 19:23:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::543; helo=mail-ed1-x543.google.com;
 envelope-from=daniel.baluta@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="khRVGQJS"; 
 dkim-atps=neutral
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com
 [IPv6:2a00:1450:4864:20::543])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43fgDN05D9zDqTw
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Jan 2019 19:22:08 +1100 (AEDT)
Received: by mail-ed1-x543.google.com with SMTP id b3so4743442ede.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Jan 2019 00:22:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=aPWM1AqWAmZUC/KtGael9gqXqDnamd2rhQqXFyqQd3M=;
 b=khRVGQJS6dPOfa2vFbkTo7tuY9Me8XKCVkflHPDCbNrFC3N+nMY4wRg79Ee3LkEp2i
 +lScQRVIjdSaTy4uyjMXZ+fynsgkLk5aX0nz6hROR8CVFcPxzw6o/8P6UzGzc7a+lJ7+
 6kFaKBAFNla3gZTReW/I0O3DRz+cjFK+vO/kqcPGYsIOwls1HgXQmHkE4mRDOgn30/UE
 c99fifx6oPMI7a0jnay9G0C3rERTVY41OVabgv/7z2AApq7PZXvBXLHNbVgDX+Jx7oFW
 yUPKOMZ8+V1XiqDy3kfQJ81VmMiya7d8npCtxNzym2+6tqEWB15R+bYeWl3o4UtAgN6z
 L6kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=aPWM1AqWAmZUC/KtGael9gqXqDnamd2rhQqXFyqQd3M=;
 b=eJHbnlHOwyKa8nVCBocFLo73caktReo4JHeTnsnXQdHx3Fe6mNX20ZuSjRChciSyyV
 XwEpCUc0Wrp3IiZFG0Z+CBrwX41zNkWB+TqTSpBFrzKSiXos9Bf4+T/6J7RqDa/C4nHn
 CahY8JZNJPBjcJS7eKeLg175vxvLFG1WY9lP70pJEnBJDTbhaYuExG7l7iHQUkMZyxp2
 wOBbT1nwFLBG//XwsKlWyvaDtwHBvcb2kUkqiGMYeHsKJX1aEhyLIDsTeVedK9ps6byh
 NxFtmoXoIP8vj5Odgz6peZWFfY51Gwxnwvv/h3WyfbdXS+qTv9sHwIWsrtY2HYKxLYzf
 J28w==
X-Gm-Message-State: AJcUukfT6S+cgqHHQyiKLMmHxEjw+taAYcsZMAlBZPgiLqdUXxwVaCcH
 bR1hrFBhR+UzIr/WQW80MwUwGu4Ja7Y/rK9SoSI=
X-Google-Smtp-Source: ALg8bN5G8+j3piIu1jyD1/QrlP+u8pPbCrvw1t8ary/awQnXCyTt2aEO1EXKQeuLvuc2Gb5cfxfuDUE0lNysbn/8p3A=
X-Received: by 2002:a50:a125:: with SMTP id 34mr6560393edj.175.1547626923895; 
 Wed, 16 Jan 2019 00:22:03 -0800 (PST)
MIME-Version: 1.0
References: <1546952716-2743-1-git-send-email-viorel.suman@nxp.com>
 <1546952716-2743-5-git-send-email-viorel.suman@nxp.com>
 <20190115205755.GA4022@bogus>
In-Reply-To: <20190115205755.GA4022@bogus>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Wed, 16 Jan 2019 10:21:52 +0200
Message-ID: <CAEnQRZBn7nM-KrGSvnzPWuU=a+jyRxfEKhZSsDD4wTqr6spkwg@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH v2 4/4] ASoC: add imx-audmix DT binding
 documentation
To: Rob Herring <robh@kernel.org>
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

On Tue, Jan 15, 2019 at 10:58 PM Rob Herring <robh@kernel.org> wrote:
>
> On Tue, Jan 08, 2019 at 01:05:51PM +0000, Viorel Suman wrote:
> > Add the DT binding documentation for Audio Mixer
> > machine driver.
> >
> > Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
> > ---
> >  .../devicetree/bindings/sound/imx-audmix.txt       | 24 ++++++++++++++++++++++
> >  1 file changed, 24 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/sound/imx-audmix.txt
> >
> > diff --git a/Documentation/devicetree/bindings/sound/imx-audmix.txt b/Documentation/devicetree/bindings/sound/imx-audmix.txt
> > new file mode 100644
> > index 0000000..6ac1230
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/sound/imx-audmix.txt
> > @@ -0,0 +1,24 @@
> > +NXP Audio Mixer (AUDMIX) machine driver.
> > +
> > +Required properties:
> > +===================================
> > +  - compatible               : Compatible list, contains "fsl,imx-audmix"
> > +
> > +  - model            : Short audio card description.
> > +
> > +  - dais             : Must contain a list of phandles to AUDMIX connected
> > +                       DAIs. The current implementation requires two phandles
> > +                       to SAI interfaces to be provided, the first SAI in the
> > +                       list being used to route the AUDMIX output.
> > +
> > +  - audmix-controller        : Must contain the phandle to the AUDMIX device node.
>
> I don't think you need 2 nodes for this as this one is just a virtual
> device. Just add the dais property to the audmix node.

Hi Rob,

Thanks for the suggestion. We want to understand better the reasoning
behind this.

Is it because dais are physically connected to AUDMIX node?

In ALSA we usually add all the components inside the
associated machine driver virtual node.

thanks,
Daniel.
