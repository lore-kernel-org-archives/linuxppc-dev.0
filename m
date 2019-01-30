Return-Path: <SRS0=D1of=QG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 720FEC282D7
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Jan 2019 16:34:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC6932087F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Jan 2019 16:34:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC6932087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43qTTr66LmzDqTj
	for <linuxppc-dev@archiver.kernel.org>; Thu, 31 Jan 2019 03:34:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.210.66; helo=mail-ot1-f66.google.com;
 envelope-from=robherring2@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Received: from mail-ot1-f66.google.com (mail-ot1-f66.google.com
 [209.85.210.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43qTRV61j4zDqTN
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Jan 2019 03:32:22 +1100 (AEDT)
Received: by mail-ot1-f66.google.com with SMTP id s13so136008otq.4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Jan 2019 08:32:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=CCc7VRu+xIf8LlmE1sgRH/1JKjZPxbmkQ0otpsDVsWU=;
 b=tMv0wLd7VVoNIF+S5t3VDfDMyHf0EnG0Zqh5AD4z+5ImmW/Z4RZZ8xI3QwvHIQY3rR
 7H1oFSzPij2iqaSQnA3vXBuM0QklM/XnToALQCs3hcS+OvR6GlPOl+2sZL8861au3z9q
 rFoLpfQTf+72eSagoOiP8VAIZAc1zeH0CFrjEGZTt0lV94uXsoHtwnuqtpwTqRBERQHI
 WA5PiWmS/CNOMCU/4qCl+pchpwRbymSLSktp/dOETNLaJB7nCAOlew+STEEzRvzQFhe8
 +fXqOv+s2lyN0+pC1fkukuB2BzT1jgTDa9RrIlw45mGhEclXe/aIeZt+3V8xW57VdU+K
 jvxw==
X-Gm-Message-State: AJcUuke/Odf4R2MAw4s7NQ7dHs+VZLOuRGGgCglJlewQk4E8nocsexff
 XRuQftmDNs8vFQqBywkCpw==
X-Google-Smtp-Source: ALg8bN6vaGcMZMlDWk7hmFJNxnFLtmAg50rVV1bYGtQAoxAEI1Sgzix7nj6Fmf09sAeBahDUcogVAA==
X-Received: by 2002:a9d:a48:: with SMTP id 66mr23218918otg.308.1548865940392; 
 Wed, 30 Jan 2019 08:32:20 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id a15sm672572otd.66.2019.01.30.08.32.19
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 30 Jan 2019 08:32:19 -0800 (PST)
Date: Wed, 30 Jan 2019 10:32:18 -0600
From: Rob Herring <robh@kernel.org>
To: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH v4 2/3] ASoC: add fsl_audmix DT binding documentation
Message-ID: <20190130163218.GA16270@bogus>
References: <1548155654-12985-1-git-send-email-viorel.suman@nxp.com>
 <1548155654-12985-3-git-send-email-viorel.suman@nxp.com>
 <20190125194315.GA21222@Asurada-Nvidia.nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190125194315.GA21222@Asurada-Nvidia.nvidia.com>
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "S.j. Wang" <shengjiu.wang@nxp.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Viorel Suman <viorel.suman@gmail.com>, Cosmin Samoila <cosmin.samoila@nxp.com>,
 Mark Brown <broonie@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 Viorel Suman <viorel.suman@nxp.com>, Fabio Estevam <fabio.estevam@nxp.com>,
 Jaroslav Kysela <perex@perex.cz>, Daniel Baluta <daniel.baluta@nxp.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Jan 25, 2019 at 11:43:16AM -0800, Nicolin Chen wrote:
> On Tue, Jan 22, 2019 at 11:14:27AM +0000, Viorel Suman wrote:
> > Add the DT binding documentation for NXP Audio Mixer
> > CPU DAI driver.
> > 
> > Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
> > ---
> >  .../devicetree/bindings/sound/fsl,audmix.txt       | 54 ++++++++++++++++++++++
> >  1 file changed, 54 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/sound/fsl,audmix.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/sound/fsl,audmix.txt b/Documentation/devicetree/bindings/sound/fsl,audmix.txt
> > new file mode 100644
> > index 0000000..45f807e
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/sound/fsl,audmix.txt
> > @@ -0,0 +1,54 @@
> > +NXP Audio Mixer (AUDMIX).
> > +
> > +The Audio Mixer is a on-chip functional module that allows mixing of two
> > +audio streams into a single audio stream. Audio Mixer has two input serial
> > +audio interfaces. These are driven by two Synchronous Audio interface
> > +modules (SAI). Each input serial interface carries 8 audio channels in its
> > +frame in TDM manner. Mixer mixes audio samples of corresponding channels
> > +from two interfaces into a single sample. Before mixing, audio samples of
> > +two inputs can be attenuated based on configuration. The output of the
> > +Audio Mixer is also a serial audio interface. Like input interfaces it has
> > +the same TDM frame format. This output is used to drive the serial DAC TDM
> > +interface of audio codec and also sent to the external pins along with the
> > +receive path of normal audio SAI module for readback by the CPU.
> > +
> > +The output of Audio Mixer can be selected from any of the three streams
> > + - serial audio input 1
> > + - serial audio input 2
> > + - mixed audio
> > +
> > +Mixing operation is independent of audio sample rate but the two audio
> > +input streams must have same audio sample rate with same number of channels
> > +in TDM frame to be eligible for mixing.
> > +
> > +Device driver required properties:
> > +=================================
> > +  - compatible		: Compatible list, contains "fsl,imx8qm-audmix"
> > +
> > +  - reg			: Offset and length of the register set for the device.
> > +
> > +  - clocks		: Must contain an entry for each entry in clock-names.
> > +
> > +  - clock-names		: Must include the "ipg" for register access.
> > +
> > +  - power-domains	: Must contain the phandle to AUDMIX power domain node
> > +
> > +  - dais		: Must contain a list of phandles to AUDMIX connected
> > +			  DAIs. The current implementation requires two phandles
> > +			  to SAI interfaces to be provided, the first SAI in the
> > +			  list being used to route the AUDMIX output.
> > +
> > +  - model		: Must contain machine driver name which will configure
> > +			  and instantiate the appropriate audio card.
> 
> I don't feel this is necessary for DT node. The driver should be
> able to figure out a proper name for the machine driver: it could
> use the compatible string to get "imx8qm-audmix" as the name like
> fsl_ssi; Or it could have built-in "imx-audmix" of_device_id data
> corresponding to "fsl,imx8qm-audmix" compatible string -- for any
> non-imx compatible in the future, use something else.

I tend to agree, but either way:

Rob Herring <robh@kernel.org>
