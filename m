Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E67B7DDE17
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Apr 2008 10:59:23 +1000 (EST)
Subject: Re: mpc5200b custom board upstreamable?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sascha Hauer <s.hauer@pengutronix.de>
In-Reply-To: <20080424162813.GL6692@pengutronix.de>
References: <20080424151237.GI6692@pengutronix.de>
	<fa686aa40804240813p66889769y3bee6eb0111741f7@mail.gmail.com>
	<20080424155303.GK6692@pengutronix.de>
	<fa686aa40804240907w7e36b579y4d2c63f00dd30848@mail.gmail.com>
	<20080424162813.GL6692@pengutronix.de>
Content-Type: text/plain
Date: Fri, 25 Apr 2008 10:58:49 +1000
Message-Id: <1209085129.9060.221.camel@pasglop>
Mime-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Thu, 2008-04-24 at 18:28 +0200, Sascha Hauer wrote:
> 
> At the moment my compatible entry looks like this:
> 
> compatible = "phytec,pcm030","generic-mpc52xx";
> 
> What I think would be nice is that "phytec,pcm030" support is used
> when available and "generic-mpc52xx" as a fallback. We do not have any
> platform specific hacks at the moment, but we may have later. Having
> "phytec,pcm030" in the simple machine would prevent us from doing so.

No, please avoid that 'generic' stuff for now, for all the good reasons
Grant gave. It might be nice but we aren't there yet. It's trivial to
add phytec,pcm030 to the list we support and use that for now.

If you do a rev tomorrow that is still compatible and in fact is very
close to the pcm030 programmatically and call it pcm035, then you could
do something like

compatible = "phytec,pcm035", "phytec,pcm030".

But don't toy with "generic" things, they sound like good ideas but they
ultimately come back and bite us.

Cheers,
Ben.
