Return-Path: <glikely@secretlab.ca>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 9F0F9B6F31
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  4 Aug 2009 04:20:34 +1000 (EST)
Received: from mail-gx0-f212.google.com (mail-gx0-f212.google.com
	[209.85.217.212]) by ozlabs.org (Postfix) with ESMTP id F2FFBDDDB6
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Aug 2009 04:20:33 +1000 (EST)
Received: by gxk8 with SMTP id 8so6479748gxk.9
	for <linuxppc-dev@ozlabs.org>; Mon, 03 Aug 2009 11:20:31 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1249317654.3404.0@antares>
References: <1249317654.3404.0@antares>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 3 Aug 2009 11:50:05 -0600
Message-ID: <fa686aa40908031050g2d03abb5s9dfe4dceb2072af6@mail.gmail.com>
Subject: Re: [PATCH] powerpc/mpc52xx/wdt: Fix 5200 wdt always being used as
	gpt
To: =?ISO-8859-1?Q?Albrecht_Dre=DF?= <albrecht.dress@arcor.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Linux PPC Development <linuxppc-dev@ozlabs.org>, wim@iguana.be
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Aug 3, 2009 at 10:40 AM, Albrecht Dre=DF<albrecht.dress@arcor.de> w=
rote:
> In the current code, all MPC5200 timers are registered by the mpc52xx_gpt
> driver, even if gpt0 (the only one with this capability) shall be used as
> hardware watchdog which is indicated by the "fsl,has-wdt" or "has-wdt"
> property in the device tree. =A0Thus, the watchdog driver does never find=
 any
> watchdog and simply doesn't work.
>
> This trivial patch protects timers with a "(fsl,)?has-wdt" property from
> being probed as gpt's. =A0The watchdog timer now works just fine.

Blech.  This does solve one problem, but it causes another.  Just
about all mpc5200 device trees have the fsl,has-wdt property on GPT0
even when it isn't used as a watchdog.  The boards using GPT0 as a
GPIO or timer will be broken by this patch.

I know it is a lot more work, but the correct solution is to merge the
GPT watchdog driver into the regular GPT driver so that we don't have
two device drivers trying to bind against the same device.

g.


--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
