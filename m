Return-Path: <SRS0=eC6l=QW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 379C7C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 19:06:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A45092192B
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 19:06:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s+CP5nR1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A45092192B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 441N5n1hJ7zDqKL
	for <linuxppc-dev@archiver.kernel.org>; Sat, 16 Feb 2019 06:06:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::643; helo=mail-pl1-x643.google.com;
 envelope-from=nicoleotsuka@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="s+CP5nR1"; 
 dkim-atps=neutral
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20::643])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 441N3w6R0SzDqT3
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Feb 2019 06:04:44 +1100 (AEDT)
Received: by mail-pl1-x643.google.com with SMTP id k15so5381611pls.8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Feb 2019 11:04:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=vAmkJKpKjbcU4YV6qJDo5SKqHHC6M8bye+VBPOPUYfk=;
 b=s+CP5nR19k91190z515VCZ8SVidFb2UurVRqtYT3iwX2HscarCw18wZFWzILIfO/6G
 2MJFdqTUBnh+/IjP98ER/g8mQ8Jzu4VNE1A13rqK5wkeOCMQW4fRRIQ1bG6BaMP3DKRV
 PBJnc8oASGtspH9cnShlHctK5FniUCE7dvAA2p4Kv4EW2ZA/aHwCF5g6G6AT99NpOEaJ
 vc8hStHHtAEicD5lex/E9sjdlV0JvldqRhRYWl6p+qdTwX30qyxgTdPnx+qjyP6fhFk2
 NDTxuhO8G8trrnpnWUQt+lFn8Ee0h1yL2tdn9FFXX5s53+mNP7gFb3DzGEJCFbC7xp0I
 dnlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=vAmkJKpKjbcU4YV6qJDo5SKqHHC6M8bye+VBPOPUYfk=;
 b=D3r5ebVVgSM4THOkJ5zVZj+hl85qCzAmjuKXoihHNBH/s+EV4kb4TPT247leQlCpqU
 MoFtbQ6dOk0EEo5vrP7Lni4W4Ft4V+cJPVuFy5YB+OCb74LaFXXzvgPcWz7ngFbK2xtL
 BLm+wXsr0Tf2+DqV1xo8EflfsbsGWH3b7JxAFJLwpcTY8oRagQwEor1U3v6M1Cg95vF8
 iUex7Kb6rCG753yhxm6vK2/8hZgv5UzzyHVnyZ2rQl7KYGN9K8xmln7QuL3TrCd/tCmY
 aZqNruxWaRYpRfyUC5qIcAXdwz7MUfjRSX2JWbBoFXpnlTqdLB+PUGzv0my1IiDVEox7
 f/ZA==
X-Gm-Message-State: AHQUAubwuTaBMTNQgyPuvRCDPmDfJnQwNi3HV9RG2nGsBmQLMUfaCp/H
 dWk73XdLjUwuNSloVnelxw8=
X-Google-Smtp-Source: AHgI3IZX40vn+XPUzARhqOkTlnNb5+igf/ucD5TK3wbuZU2Aop03oXppp6EuCpRNz7LMIudJoexS4w==
X-Received: by 2002:a17:902:c05:: with SMTP id
 5mr11779238pls.155.1550257482128; 
 Fri, 15 Feb 2019 11:04:42 -0800 (PST)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
 [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id f6sm10225864pfc.88.2019.02.15.11.04.41
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 15 Feb 2019 11:04:41 -0800 (PST)
Date: Fri, 15 Feb 2019 11:04:39 -0800
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Viorel Suman <viorel.suman@nxp.com>
Subject: Re: [PATCH v5 0/3] Add NXP AUDMIX device and machine drivers
Message-ID: <20190215190438.GB19299@Asurada-Nvidia.nvidia.com>
References: <1550239285-12587-1-git-send-email-viorel.suman@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550239285-12587-1-git-send-email-viorel.suman@nxp.com>
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "S.j. Wang" <shengjiu.wang@nxp.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Takashi Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Viorel Suman <viorel.suman@gmail.com>,
 Cosmin Samoila <cosmin.samoila@nxp.com>, Mark Brown <broonie@kernel.org>,
 dl-linux-imx <linux-imx@nxp.com>, Fabio Estevam <fabio.estevam@nxp.com>,
 Jaroslav Kysela <perex@perex.cz>, Daniel Baluta <daniel.baluta@nxp.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Feb 15, 2019 at 02:01:32PM +0000, Viorel Suman wrote:
> The patchset adds NXP Audio Mixer (AUDMIX) device and machine
> drivers and related DT bindings documentation.

For this series,

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

And Rob gave his at the previous version already.

Thanks.

> Changes since V4:
> 1. Removed "model" attribute from device driver DT bindings documentation
>    as suggested by Nicolin.
> 
> Changes since V3:
> 1. Removed machine driver DT bindings documentation.
> 2. Trigger machine driver probe from device driver as suggested by Nicolin.
> 
> Changes since V2:
> 1. Moved "dais" node from machine driver DTS node to device driver DTS node
>   as suggested by Rob.
> 
> Changes since V1:
> 1. Original patch split into distinct patches for the device driver and
>   DT binding documentation.
> 2. Replaced AMIX with AUDMIX in both code and file names as it looks more
>   RM-compliant.
> 3. Removed polarity control from CPU DAI driver as suggested by Nicolin.
> 4. Added machine driver and related DT binding documentation.
> 
> Viorel Suman (3):
>   ASoC: fsl: Add Audio Mixer CPU DAI driver
>   ASoC: add fsl_audmix DT binding documentation
>   ASoC: fsl: Add Audio Mixer machine driver
> 
>  .../devicetree/bindings/sound/fsl,audmix.txt       |  50 ++
>  sound/soc/fsl/Kconfig                              |  16 +
>  sound/soc/fsl/Makefile                             |   5 +
>  sound/soc/fsl/fsl_audmix.c                         | 578 +++++++++++++++++++++
>  sound/soc/fsl/fsl_audmix.h                         | 102 ++++
>  sound/soc/fsl/imx-audmix.c                         | 327 ++++++++++++
>  6 files changed, 1078 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/fsl,audmix.txt
>  create mode 100644 sound/soc/fsl/fsl_audmix.c
>  create mode 100644 sound/soc/fsl/fsl_audmix.h
>  create mode 100644 sound/soc/fsl/imx-audmix.c
> 
> -- 
> 2.7.4
> 
