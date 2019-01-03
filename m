Return-Path: <SRS0=6Lu7=PL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA27EC43387
	for <linuxppc-dev@archiver.kernel.org>; Thu,  3 Jan 2019 20:04:48 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5F7E208E3
	for <linuxppc-dev@archiver.kernel.org>; Thu,  3 Jan 2019 20:04:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kNQL2FJI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5F7E208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43VzR14MqTzDqNy
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Jan 2019 07:04:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::543; helo=mail-pg1-x543.google.com;
 envelope-from=nicoleotsuka@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="kNQL2FJI"; 
 dkim-atps=neutral
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43VzPV48BpzDqD2
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Jan 2019 07:03:26 +1100 (AEDT)
Received: by mail-pg1-x543.google.com with SMTP id y4so16425376pgc.12
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 03 Jan 2019 12:03:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=olj6AXhV3ckEyDgorbspb3FsaV2Sn7quCe97kH4w3xc=;
 b=kNQL2FJIy8UTZcFNGxYGFtPJ/5DWWZ16x+WqmHgwMWu+xyJ1w89sTnzqKdQ9yMST2X
 DjZ6s04yT7Ezeid/rfsDCtm7p4FS1tpEftsx3S1WmWLXte05SnkklmFUssNZFEPCA/7W
 RFZ8SRiMCNiDi6bQkf8g6OXesJMwgwgZ49t5B24AsWWRQFMnjyTI4qLwJc964m7JWrn5
 PtdWS7ewW62gWN8ftmbkfbunoPCQySQh9zM3tSC6Xppyn+7ZRGH5SD9Gn8d70kCw0QOD
 nNGfbx+bU+FHyC2qcLN792IGinT6kubzsKYu3mk22vdYOAXIEUSVgxW9ivnJ2LTOmEDs
 Jq/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=olj6AXhV3ckEyDgorbspb3FsaV2Sn7quCe97kH4w3xc=;
 b=Oexk16B4jWIYZtyH4SJntLAcMiVZANYIS3ZbVUaY7M04+WwBtcu7r0BxB9IeMkPiQO
 vEJ03o3I9O0L9k0fwMsS8WwlJVq5rQw5MKz7r6ypHQPZyQ4Mz0gYJcajE15eiQbd4qTy
 xjlHsu6sQ/xfzLhQ3NRW/3vtAl1G43z7SvXTtMoSZdAu6KVFc3qvYWOhHKYPUmsbLL4J
 wPPrc0Z/8pmIvYg9/znSZ0ZucSeDL/nTffd0Dig9Zp45avyQoZkxer7ncH4RaCTHK1Td
 Q70dGeKuYTsS/ALP+R9MgC4AicLzI8oK11CbcEOa9ITRAQC6TL3jnJq7hgV+2q3ElhLN
 0v5A==
X-Gm-Message-State: AJcUukcqwzMHInA3SKcja6NH9RD9oNsSCmLQfzP8awjfmewmM3nWjSdH
 jrNe+6gksCtkRwEI8EmTFR4=
X-Google-Smtp-Source: ALg8bN4yzvYb8d+TjzizzUJM2jVGbVhTDj424/lHfD6Nk1s5Cii23DQnCQki+jIixq4TC4wJQ3B16Q==
X-Received: by 2002:a63:da45:: with SMTP id l5mr18325287pgj.111.1546545804093; 
 Thu, 03 Jan 2019 12:03:24 -0800 (PST)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
 [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id r4sm111994797pgn.54.2019.01.03.12.03.23
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 03 Jan 2019 12:03:23 -0800 (PST)
Date: Thu, 3 Jan 2019 12:03:19 -0800
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Viorel Suman <viorel.suman@nxp.com>
Subject: Re: [RFC PATCH] ASoC: fsl: Add Audio Mixer CPU DAI driver
Message-ID: <20190103200319.GA2586@Asurada-Nvidia.nvidia.com>
References: <1545150569-14897-1-git-send-email-viorel.suman@nxp.com>
 <CAGoOwPQvc5w05NOVsp6Qw-Ee3CJJCcaU2Dtzwbf+7bUe_kFEbA@mail.gmail.com>
 <1546531006.14398.83.camel@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1546531006.14398.83.camel@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
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
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "timur@kernel.org" <timur@kernel.org>,
 "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
 "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Daniel Baluta <daniel.baluta@nxp.com>, "tiwai@suse.com" <tiwai@suse.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 Fabio Estevam <fabio.estevam@nxp.com>, "perex@perex.cz" <perex@perex.cz>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi,

On Thu, Jan 03, 2019 at 03:56:46PM +0000, Viorel Suman wrote:
> > >  sound/soc/fsl/fsl_amix.c                           | 554
> > > +++++++++++++++++++++
> > >  sound/soc/fsl/fsl_amix.h                           | 101 ++++
> > I aimn't against the naming here, but it seems to be AUDMIX in RM?
> > 
> > Would it be better to align with that? It's your decision though.
> 
> To me "AUDMIX" sounds more like some RTL high level integration module,
> I would prefer to keep it as it is if there is no strong reason to 
> rename it.

We had AUDMUX, so "AUDMIX" doesn't sound bad to me at all. The only
reason that we are discussing this is because RM uses more "AUDMIX"s
over "amix"s. I'd have chosen AUDMIX if I were you, yet not strongly
as I said. And it looks like Rob is asking you to use AUDMIX in DT
binding doc.

> > > +Device driver configuration example:
> > > +======================================
> > > +  amix: amix@59840000 {
> > > +    compatible = "fsl,imx8qm-amix";
> > > +    reg = <0x0 0x59840000 0x0 0x10000>;
> > > +    clocks = <&clk IMX8QXP_AUD_AMIX_IPG>;
> > > +    clock-names = "ipg";
> > > +    power-domains = <&pd_amix>;
> > > +  };
> > From the description of DT and RM, I don't see how it connects to
> > SAIs.
> > 
> > Are they fixed to SAI0 and SAI1 in imx8qm? Wondering if it'd be
> > better to have such information in the doc.
> 
> Please check chapter "16.1.2.2 Audio Mixer" in RM: it has two dedicated
> SAI interfaces, SAI4 and SAI5. Audio Mixer operates on bit clock of one
> of these interfaces.

OK. I am actually more wondering how you connect it with SAI on
the software level: for imx8qm, SAI4/5 are used, but later SoCs
might use other SAI blocks. So it might be necessary to indicate
the connections in DT.

> > > +static int fsl_amix_dai_set_fmt(struct snd_soc_dai *dai, unsigned
> > > int fmt)
> > > +{
> > > +       /* For playback the AMIX is slave, and for record is master
> > > */
> > > +       switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
> > > +       case SND_SOC_DAIFMT_CBM_CFM:
> > > +       case SND_SOC_DAIFMT_CBS_CFS:
> > So it's used either for playback or capture only, not both at same
> > time?
> 
> From IP functional perspective AMIX capture is the result of AMIX
> playback - AMIX output represents the resulting mixed audio stream
> routed to SAI4 RX signals (bit & frame clocks and data). So once we
> have playback on either SAI4 or SAI5 (or both) - we can capture the
> AMIX output on SAI4.

Ah, it sounds like a looping block then, receiving bclk from SAI4
-- slave, and routing the bclk back to SAI4 -- master; SAI4 works
at ASYNC mode?

> I guess it would be nice to send the machine driver as part of this
> patchset also - it defines two input SAI interfaces as frontends and
> AMIX - as backend. Userspace sees only two SAI interfaces exposed, both
> of them having playback enabled, and only SAI4 having capture enabled.

DPCM? So you are having the links in the sound DT nodes, i.e. the
machine driver?

Thanks
Nicolin
