Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DBD9767A05
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Jun 2005 08:15:52 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Wolfram Quester <wolfi@mittelerde.physik.uni-konstanz.de>
In-Reply-To: <20050602130502.GA6151@halley.zuhause>
References: <1117424155.5228.28.camel@gaston>
	<3db27390050530145939d260e4@mail.gmail.com>
	<20050602130502.GA6151@halley.zuhause>
Content-Type: text/plain
Date: Fri, 03 Jun 2005 08:15:03 +1000
Message-Id: <1117750504.31082.76.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	"debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>
Subject: Re: ppc32: Rework power management take #3
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Today I applied the two mentioned patches to rc5-git6. There were quite
> a lot of offsets and one time fuzz 2 (hunk 10 in via-pm.c). But still I
> get a freeze on my PowerBook6,2 (12", 1Ghz from Dec. 2004) when I
> suspend to disk from X. If I suspend from tty1 the first time, the
> following suspends work well even from X.
> 
> Thanks for your work,

Bizarre... The kernel is normally first opens a new tty and switches to
it before suspend. It seems that this opening of a new tty is
conflicting in some way with X "nv" driver and causing that freeze. Are
you also using an fbdev like rivafb or nvidiafb or are you defaulting to
offb ? If you do, Can you try booting with video=ofonly and tell me if
it helps ?

Ben.
