Return-Path: <SRS0=gbiG=P5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE28C2F42E
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Jan 2019 15:25:27 +0000 (UTC)
Received: from lists.ozlabs.org (unknown [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D5902085A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Jan 2019 15:25:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D5902085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43jwNP1SmszDqSt
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Jan 2019 02:25:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.210.67; helo=mail-ot1-f67.google.com;
 envelope-from=robherring2@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Received: from mail-ot1-f67.google.com (mail-ot1-f67.google.com
 [209.85.210.67])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43jwLL4dX1zDqR5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Jan 2019 02:23:38 +1100 (AEDT)
Received: by mail-ot1-f67.google.com with SMTP id v23so20806299otk.9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Jan 2019 07:23:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=BTprJiQSSd9oFHbZyZXiPAZoKdv8sPvXoKx1czOhrmU=;
 b=Y02TfKKKvnhyvSt4N7SOrxR7nuTd0+1pHrcEc41elYefAIxWHz1wURGLMO7dk1cVEA
 Y+ydr0+smV1aSJnOjUzn2CCh4kSSpcr1utDOxm4JupvHCOeH+PNWdBqHiBx4pTG3LwKC
 XgUmVrFABuLSuvV+h9dmwJDVmh3gmvsEUkx9xVHfBo1eIjQA8loBCpzUo/IWwRENlMD6
 ht4eZVFcZGbWFys6u0FcrsxP2QfwtS5RhjuhJ+s7k/b5whI98OByAwywFDqy3yPbOw+q
 gzkG+ocpWsf96jkE1qMqfctcnkk499A/23QqoA47wTKQ5qRuo1W30AURIWjrnSilDyR1
 0WjQ==
X-Gm-Message-State: AJcUukcS7KwS2EEAtjxjAchCRcoijbZXPzGyhWdYBPWa3Fb1L0AA141c
 z8szZYX8mVAsYr5YoEL+KQ==
X-Google-Smtp-Source: ALg8bN6xc+jSfPAKy2Jra85r9CopBZTNymVHnRS/reb5iZw0WoCBIEeYC1EJ5mp4BFF+u1O3X6KY4g==
X-Received: by 2002:a05:6830:1453:: with SMTP id
 w19mr14226713otp.213.1548084216296; 
 Mon, 21 Jan 2019 07:23:36 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id i7sm5256034oth.57.2019.01.21.07.23.35
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 21 Jan 2019 07:23:35 -0800 (PST)
Date: Mon, 21 Jan 2019 09:23:35 -0600
From: Rob Herring <robh@kernel.org>
To: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH v3 0/4] Add NXP AUDMIX device and machine drivers
Message-ID: <20190121152335.GA12284@bogus>
References: <1547729177-14317-1-git-send-email-viorel.suman@nxp.com>
 <20190117161804.GA5760@bogus> <1547817384.11482.33.camel@nxp.com>
 <20190118194642.GA11798@Asurada-Nvidia.nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190118194642.GA11798@Asurada-Nvidia.nvidia.com>
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
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "timur@kernel.org" <timur@kernel.org>,
 "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
 "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
 "S.j. Wang" <shengjiu.wang@nxp.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Daniel Baluta <daniel.baluta@nxp.com>, "tiwai@suse.com" <tiwai@suse.com>,
 "viorel.suman@gmail.com" <viorel.suman@gmail.com>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "broonie@kernel.org" <broonie@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 Viorel Suman <viorel.suman@nxp.com>, Cosmin Samoila <cosmin.samoila@nxp.com>,
 "perex@perex.cz" <perex@perex.cz>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Jan 18, 2019 at 11:46:42AM -0800, Nicolin Chen wrote:
> On Fri, Jan 18, 2019 at 01:16:24PM +0000, Viorel Suman wrote:
> > > > 1. Moved "dais" node from machine driver DTS node to device driver
> > > > DTS node
> > > >   as suggested by Rob.
> > > That was not what I suggested. You still have a virtual node which
> > > looks to me to be unnecessary.
> > 
> > To me removing virtual node implies that AUDMIX machine driver (imx-
> > audmix.c + virtual node) shall be removed and machine driver code
> > merged into device driver (fsl_audmix.c + device node) - please let me
> > know if my understanding is wrong.
> 
> We could use a non-DT configuration right? From the driver logic,
> DT just registers a device corresponding to the machine driver so
> that it can probe(). We could register one in fsl_audmix instead.
> Please refer to how fsl_ssi registers the sound card device. The
> machine driver can get audmix_np from the parent device pointer,
> and I think that's all you need.

Yes.

> Or maybe someone else would provide a better way. But it'd work.

Or the machine driver could create the audmix device. That probably 
makes less sense, but either way there doesn't have to be a 1-1 
correspondence of DT nodes and (platform) devices.

I'm not an ASoC expert, but why can't the machine driver just control 
the audmix directly (with DAIs as separate drivers)? Is the audmix ever 
going to a be a component for a different machine driver?

Rob

