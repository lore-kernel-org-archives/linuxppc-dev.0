Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC3C4C54EBD
	for <linuxppc-dev@archiver.kernel.org>; Sun,  8 Jan 2023 20:28:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NqpYw1ychz3c73
	for <linuxppc-dev@archiver.kernel.org>; Mon,  9 Jan 2023 07:28:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ravnborg.org header.i=@ravnborg.org header.a=rsa-sha256 header.s=rsa2 header.b=c4k0VDpx;
	dkim=fail reason="signature verification failed" header.d=ravnborg.org header.i=@ravnborg.org header.a=ed25519-sha256 header.s=ed2 header.b=8bywcp24;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=ravnborg.org (client-ip=2a02:2350:5:404::1; helo=mailrelay5-1.pub.mailoutpod2-cph3.one.com; envelope-from=sam@ravnborg.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ravnborg.org header.i=@ravnborg.org header.a=rsa-sha256 header.s=rsa2 header.b=c4k0VDpx;
	dkim=pass header.d=ravnborg.org header.i=@ravnborg.org header.a=ed25519-sha256 header.s=ed2 header.b=8bywcp24;
	dkim-atps=neutral
Received: from mailrelay5-1.pub.mailoutpod2-cph3.one.com (mailrelay5-1.pub.mailoutpod2-cph3.one.com [IPv6:2a02:2350:5:404::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NqpXr5HyZz3bPL
	for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Jan 2023 07:27:40 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=rsa2;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=0Oz9SWY2JCaWSnIle2Meml1ISZbxlYPbGXUmEDFt7b8=;
	b=c4k0VDpxJMQjtdxfViIx8A4vMqEbPLJ0Sq3DyrBnuHwdXBmsuYmxJ0mgIijMxw920JZFjygLve5RX
	 URLMTmnVnSjkgoU+0vL9dllcJEw2bAGMxN8dMV8uKuodEI0CQ70gZ82sBi4XUSnk5DihUj8lSmlxg3
	 sgUzA2J1yEisx714es4oV7j9eveKW/sPclA58anYo8xJowPRrGFHI1etKHjped0gNixlWX75/91nJu
	 TyiPd9rMgC6S4IbTa2fGXjvmVw1k013QfD6fNt7BmPrD4YP/7xQ77PkJv6ahbIPyBTGp510nmjfkaT
	 7+MJr7Q779Lz3Bcx/tDnhmxA6aI4BUA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=ed2;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=0Oz9SWY2JCaWSnIle2Meml1ISZbxlYPbGXUmEDFt7b8=;
	b=8bywcp24ZOE+2c7c1Vg1sP1h7ookPnbOgjKq1sM5xNiCxjrSNN8hMTywYKr2r+1SXf71v0cxxxiuY
	 OXp1pTxAQ==
X-HalOne-ID: bf923e41-8f92-11ed-a312-7703b0afff57
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
	by mailrelay5 (Halon) with ESMTPSA
	id bf923e41-8f92-11ed-a312-7703b0afff57;
	Sun, 08 Jan 2023 20:26:37 +0000 (UTC)
Date: Sun, 8 Jan 2023 21:26:36 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Helge Deller <deller@gmx.de>
Subject: Re: [PATCH 01/15] video: fbdev: atmel_lcdfb: Rework backlight
 handling
Message-ID: <Y7sm/EJcTbw3Ic4n@ravnborg.org>
References: <20230107-sam-video-backlight-drop-fb_blank-v1-0-1bd9bafb351f@ravnborg.org>
 <20230107-sam-video-backlight-drop-fb_blank-v1-1-1bd9bafb351f@ravnborg.org>
 <553AE999-CAF1-4E59-9F3F-68591ED192DE@sk2.org>
 <Y7nb2q6SDota/rTU@ravnborg.org>
 <811a392a-d634-5557-dd58-57f1580e28f2@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <811a392a-d634-5557-dd58-57f1580e28f2@gmx.de>
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
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, linux-staging@lists.linux.dev, Stephen Kitt <steve@sk2.org>, Antonino Daplas <adaplas@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Robin van der Gracht <robin@protonic.nl>, Lee Jones <lee@kernel.org>, Nicolas Ferre <nicolas.ferre@microchip.com>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Ludovic Desroches <ludovic.desroches@microchip.com>, Paul Mackerras <paulus@samba.org>, linux-fbdev@vger.kernel.org, Jingoo Han <jingoohan1@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, Sam Ravnborg via B4 Submission Endpoint <devnull+sam.ravnborg.org@kernel.org>, Daniel Thompson <daniel.thompson@linaro.org>, linux-omap@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Claudiu Beznea <claudiu.beznea@microchip.com>, linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Helge,

> > 
> > Helge - could you pick the reviewed patches from:
> > https://lore.kernel.org/all/20220607192335.1137249-1-steve@sk2.org/
> > [This is the same mail as Stephen refer to above - looked up via lore].
> 
> I just pulled those 7 patches into fbdev/for-next.
> If you need more, please let me know,

Thanks, we have one pending patch for atmel_lcdfb, but it need a small
adjustment before it is ready.

With this all fbdev drivers have the backlight_properties.fb_blank
removed.

	Sam
