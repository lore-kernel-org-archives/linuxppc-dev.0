Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C389ACDB47E
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Oct 2023 16:37:43 +0000 (UTC)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=AcK5zXeW;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4S5wKf2lTjz3cll
	for <linuxppc-dev@archiver.kernel.org>; Fri, 13 Oct 2023 03:37:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=AcK5zXeW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=infradead.org (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=geoff@infradead.org; receiver=lists.ozlabs.org)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4S5wJZ3gzLz2ygx
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Oct 2023 03:36:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=FSonfJ43zgcuW47KrZQgDGNzqMRjSofTrzRRTIZpHxw=; b=AcK5zXeWq6cVOul5gredeXoI3t
	7pceXZIXjt6v//yo13Ykd6hmIKqGaVf8Euj9mIAxAX+gs1j8yYwly9Fqt8jn2G3uAOFZXJGkV5PZD
	DmYOXr712vrJ2F7eIB3L2S1ryBex2vA8uGFzSMWZ0JpEeqrhZJ39ktHwJDgsCNZbK77YUWJt02jcy
	tubb6Lb7EKT/fXiREytmIdkjUpIRL1yS9EOP3iX14D5Ab0pDzhNm1nWl2hhavT8iHjI4XIHOb3SMc
	9V2c4zfH8VPG4L9AnDrfUIeiW/ucau1GS2+LnOkzvSucMCLiciR2vPwmNeCZpYxDFimKbmhQS1MvG
	E98Cg9pw==;
Received: from 173.red-88-11-240.dynamicip.rima-tde.net ([88.11.240.173] helo=[192.168.100.242])
	by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1qqyfP-000KOI-5s; Thu, 12 Oct 2023 16:36:07 +0000
Message-ID: <39719eae-f166-4059-a70d-c6b74ecd46e2@infradead.org>
Date: Thu, 12 Oct 2023 18:36:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [RFC] wireless: move obsolete drivers to staging
To: Johannes Berg <johannes@sipsolutions.net>,
 Geert Uytterhoeven <geert@linux-m68k.org>
References: <20231010155444.858483-1-arnd@kernel.org>
 <2023101051-unmasked-cleaver-79b3@gregkh> <87y1g94szz.fsf@kernel.org>
 <2023101139-pyromania-game-2237@gregkh> <87r0m1fwg9.fsf@kernel.org>
 <20231011080955.1beeb010@kernel.org> <87sf6g2hc8.fsf@kernel.org>
 <63e57ef8-c9f2-489a-8df8-51dcffd437c6@app.fastmail.com>
 <b1c87f71abef5aba6b39893a417466bf9f65c2d5.camel@sipsolutions.net>
 <CAMuHMdX3F9rvD3Fzbc1dwm7Vm73VW1x5ETbxkk-jJm3Bpr5i+A@mail.gmail.com>
 <d336126d58e12e8e67078c8142a524c667cc5639.camel@sipsolutions.net>
Content-Language: en-US
From: Geoff Levand <geoff@infradead.org>
In-Reply-To: <d336126d58e12e8e67078c8142a524c667cc5639.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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
Cc: Arnd Bergmann <arnd@kernel.org>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kalle Valo <kvalo@kernel.org>, linux-staging@lists.linux.dev, linux-wireless@vger.kernel.org, Nicolas Ferre <nicolas.ferre@microchip.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, linux-arm-kernel@lists.infradead.org, Pavel Machek <pavel@ucw.cz>, Jakub Kicinski <kuba@kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, "David S . Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org, Larry Finger <Larry.Finger@lwfinger.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 10/12/23 17:41, Johannes Berg wrote:
> But seriously - is it worth to try to keep a wireless driver for it if
> we don't even know anyone using a PS3 at all?

There is still a considerable user base for the PS3, so we
must keep the ps3-gelic-wireless driver.

-Geoff

