Return-Path: <schmitz@zirkon.biophys.uni-duesseldorf.de>
Received: from zirkon.biophys.uni-duesseldorf.de
	(zirkon.biophys.uni-duesseldorf.de [134.99.176.3])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 830952BDEB
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Nov 2004 23:28:20 +1100 (EST)
Date: Tue, 23 Nov 2004 13:28:08 +0100 (CET)
From: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1101160237.13598.121.camel@gaston>
Message-ID: <Pine.LNX.4.44.0411231224150.7434-100000@zirkon.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	"debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>
Subject: Re: TEST: Sleep patch #4
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> It reads them from OF at boot. What do you mean by "freak out" ? the
> usual problem with those models where the display gets all fuzzy ? I'm
> not completely sure what's up, I tend to blame the panel power sequence
> nowadays ...

Just got a garbled display when waking up from sleep. That seems to
support your panel powerup idea. A second sleep/wake cycle fixed it.

Looking at radeon_base.c:radeon_screen_blank() (line 1045) we have:

                        val &= ~(LVDS_BL_MOD_EN);
                        udelay(100);
                        val &= ~(LVDS_ON | LVDS_EN);
                        OUTREG(LVDS_GEN_CNTL, val);


Is there an OUTREG(LVDS_GEN_CNTL, val); missing before the udelay(100) ??

That's in the panel blank code, not the unblank code though. Doesn't seem
to hurt to put the OUTREG in.

	Michael
