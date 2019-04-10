Return-Path: <SRS0=mr1i=SM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28DB6C10F11
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 14:28:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D96720830
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 14:28:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hxvZOSVX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D96720830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44fRMg6pgwzDqQ4
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 00:27:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::242; helo=mail-lj1-x242.google.com;
 envelope-from=festevam@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="hxvZOSVX"; 
 dkim-atps=neutral
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com
 [IPv6:2a00:1450:4864:20::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44fRKg2sNMzDqBY
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2019 00:26:15 +1000 (AEST)
Received: by mail-lj1-x242.google.com with SMTP id t4so2342750ljc.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Apr 2019 07:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=eNT8cKVfeIi7uAkEe1ZbC3EOVjlhbfRiqWYvgGhOSpU=;
 b=hxvZOSVXLpGJNzR/H4f9Gz91udtTQtL3pLwAum6no4hIHKAfCWMPLqTxlnU15oLf6N
 Qh4GV5NbbOp+zkWnubOICh6csky4HsdginEzcvKqnKm+rLubBCz5lhd5WpwEwwyrm0aK
 xu+geq0OyR21JmiMtJ6tkO1HNudtM5eN6E7VBN30sjtTtBu1kesNKpxIyGwTjc/5xM7y
 RlqHCq5rCW+0hZtXGDEz6pxEWRJJmuoNQwFr/W7LdHf8ISA8ZDUpAKtkQ/W8iNu8KhrD
 rGsPjf7h3ZX232vDRcEZd6fbSiVF+S1W7Kzo4TVbB0BCUONoVMI99FnHlAjGm8BwPs/v
 /tAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=eNT8cKVfeIi7uAkEe1ZbC3EOVjlhbfRiqWYvgGhOSpU=;
 b=WNrURyUhMLHCviPMypbXux/xX1jMsdxzZ4rK0TO1Cc6JxE+r49ZF248eFtke5sFLhS
 gMKcvBJy0oTxflMpLRkc3yTvt6UUD+HzNHh/MN1EihhbQ1RYYB9hFZ6d9QUDAIGew7/h
 C7yicUTKeYMfEDLYcdW+q/oxyRhnDcalShjVNWUA7lEzGQSCpnWTi3U5r+kQZG2D4ZS/
 2G++jEtjzmKPnovmXA8NSRWibiIfYdfcxVhF1eU4OsFFy5e4c9WJ4MEy5xS++s0oQ24c
 qcVpKiaPSLPXiz1gylTIDKvWdBN+P3ALM8NdzkJgbCuxTlvuWHVPC2U2BFdHC/Z28k1m
 jRXg==
X-Gm-Message-State: APjAAAWO6oloeVBbjbCHgvZg4G1akHc0dAy+p/WmfBeGY3PXSPsZyD6i
 S/GvLnVFcji91np0Q08x+DFjfrIkHrbtPHBA+yo=
X-Google-Smtp-Source: APXvYqxHd755icfvww8fjK4Q1wSOaGRHRC+OMoeABHe27VJHeKhddhShRkz0ROeDCtpxUMloeEdgGPQRNSXS/l3sPEo=
X-Received: by 2002:a2e:5d94:: with SMTP id v20mr23144071lje.138.1554906370195; 
 Wed, 10 Apr 2019 07:26:10 -0700 (PDT)
MIME-Version: 1.0
References: <1554894380-25153-1-git-send-email-viorel.suman@nxp.com>
 <1554894380-25153-3-git-send-email-viorel.suman@nxp.com>
In-Reply-To: <1554894380-25153-3-git-send-email-viorel.suman@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 10 Apr 2019 11:26:04 -0300
Message-ID: <CAOMZO5Aw=Z1-jKkG07mHCTmVhFE6GLG90-qiuMQfNUXAoze_xw@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] ASoC: fsl_audmix: remove "model" attribute from DT
 document
To: Viorel Suman <viorel.suman@nxp.com>
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
Cc: Mark Rutland <mark.rutland@arm.com>, Viorel Suman <viorel.suman@gmail.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Julia Lawall <Julia.Lawall@lip6.fr>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Mark Brown <broonie@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Shawn Guo <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Apr 10, 2019 at 8:06 AM Viorel Suman <viorel.suman@nxp.com> wrote:
>
> Remove "model" attribute from fsl_audmix DT document.

Please provide the reasoning.
