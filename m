Return-Path: <SRS0=M5iZ=SX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87878C10F14
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Apr 2019 08:28:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BFD420859
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Apr 2019 08:28:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rcElJI4x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BFD420859
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44n2sG3ZRBzDqRp
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Apr 2019 18:28:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::441; helo=mail-pf1-x441.google.com;
 envelope-from=nicoleotsuka@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="rcElJI4x"; 
 dkim-atps=neutral
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20::441])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44n2qc6MMdzDqQc
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 Apr 2019 18:26:34 +1000 (AEST)
Received: by mail-pf1-x441.google.com with SMTP id w25so4337431pfi.9
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 Apr 2019 01:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=7xtJDXk9MnspBzmfRWUTSL1NCl1WF1RAaR95qRXy3Kc=;
 b=rcElJI4x2bboUOsG7PlhBFgwQYf9j3PbmcXFLwrWJvLv4a0m1ETcoy/J98zxiS7bQU
 ajKt9JC3AFo3qjqLc1OOua98R1f0C49PFeJO7OJmslGKV4XPZ0ccwW3bLKjGO3SvV2Rt
 P+rG/hHOyi8W/GIXV3Lq0hI7Df0z4353ZNW1D78Z+T5GJgzd3JbF1Sr7BCwCq8HJvUc/
 YTKXne5uT3yPM9QmOWmfYVEsAHt9us9HPtKhPnx8Ab7FpJQK6eKf0efM5vA1iChvgIAG
 kP8gSWzyqO1Gz2gejImhUQt4QhC/Mv3ggv+BxIiD8dROZ0iHGSYOl78q/XPGtu48+eZD
 EfZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=7xtJDXk9MnspBzmfRWUTSL1NCl1WF1RAaR95qRXy3Kc=;
 b=uhM90jIjgEHkUqy8SvBaW9OM8lBXuUjpFDuw6mgq7WpBVeK+cLT1WgIW7/284TEy/A
 pGLFh4dc0zWmrKq/jGviWQ6Dmf2p91mLLa+mb1z+eaJBTUNKryG8fj+xkaR1jmw8FyTJ
 npDjKxQjSE8imjUfr5T29TqYiMqIErb3lg/Y/9AfJ3E8XbMmqMdVeEsHIegjR7GKwXjP
 Ap1kOe92AvB9NtyPJLrmSxdYaCEzQPX2IGAgpnakCGrCXjn/7X35vVJ4m6KYeXImbnlE
 o7Kgi28B8S+zyyyL186PNqdiNtUUg+Y18l9f2/oPWJXM8fQNqVsozfVWMbanyta69ZiF
 4XIA==
X-Gm-Message-State: APjAAAXZmlsDX8mad5/7nu9CX+0bFJUe9EN4d5MplC6ul1WlfxRnxGoc
 CODgkLOGJOoKkKGFQlzzWgM=
X-Google-Smtp-Source: APXvYqwVKgwHheUglkAjUvWdJTWy7ZvTdu5JlRuq+OCTYY6yw1QnhYg6gRfWDDOsCVABrSd9gNUWbg==
X-Received: by 2002:a62:aa06:: with SMTP id e6mr14056562pff.254.1555835192758; 
 Sun, 21 Apr 2019 01:26:32 -0700 (PDT)
Received: from Asurada (c-98-248-47-108.hsd1.ca.comcast.net. [98.248.47.108])
 by smtp.gmail.com with ESMTPSA id
 d3sm13373174pfn.113.2019.04.21.01.26.31
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 21 Apr 2019 01:26:32 -0700 (PDT)
Date: Sun, 21 Apr 2019 01:26:28 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Daniel Baluta <daniel.baluta@gmail.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: fsl: sai: Fix clock source for mclk0
Message-ID: <20190421082627.GB8304@Asurada>
References: <20190420154038.14576-1-daniel.baluta@nxp.com>
 <20190421053749.GA5552@Asurada>
 <CAEnQRZDs_gnS8ehjM2M_y+Yw0Ge-Sq=A2c9BV-g=P_d0+O40hQ@mail.gmail.com>
 <20190421080439.GA8784@Asurada>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190421080439.GA8784@Asurada>
User-Agent: Mutt/1.5.22 (2013-10-16)
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "timur@kernel.org" <timur@kernel.org>,
 "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
 Daniel Baluta <daniel.baluta@nxp.com>, "S.j. Wang" <shengjiu.wang@nxp.com>,
 "tiwai@suse.com" <tiwai@suse.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
 "broonie@kernel.org" <broonie@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 "festevam@gmail.com" <festevam@gmail.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sun, Apr 21, 2019 at 01:04:39AM -0700, Nicolin Chen wrote:
> On Sun, Apr 21, 2019 at 10:26:40AM +0300, Daniel Baluta wrote:
> > > Firstly, according to your commit message, neither imx8qm nor
> > > imx6sx has an "mclk0" clock in the clock list. Either of them
> > > starts with "mclk1". So, before you change the driver, I don't
> > > think it's even a right thing to define an "mclk0" in the DT.
> > 
> > From what I understand mclk0 means option 00b of MSEL bits which is:
> > * busclk for i.MX8
> > * mclk1 for i.MX6/7.
> 
> MSEL bit is used for an internal clock MUX to select four clock
> inputs. However,  these four clock inputs aren't exactly 1:1 of
> SAI's inputs. As fas as I can tell, SAI only has one bus clock
> and three MCLK[1-3]; the internal clock MUX maps the bus clock
> or MCLK1 to its input0, and then linearly maps MCLK[1-3] to its
> inputs[1-3]. So it doesn't sound right to me that you define an
> "MCLK0" in the DT, as it's supposed to describe input clocks of
> SAI block, other than its internal clock MUX's.

Daniel, I think I's saying this too confident, though I do feel
so :) But if you can prove me wrong and justify that there is an
"MCLK0" as an external input of the SAI block, I will agree with
this change.

Thanks
