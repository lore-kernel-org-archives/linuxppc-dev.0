Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6ACBC2BDB5
	for <linuxppc-dev@ozlabs.org>; Sun, 21 Nov 2004 11:02:01 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
In-Reply-To: <1100852423.3855.2.camel@gaston>
References: <1100847411.25521.42.camel@gaston> <1100852423.3855.2.camel@gaston>
Content-Type: text/plain
Date: Sun, 21 Nov 2004 11:01:08 +1100
Message-Id: <1100995268.3796.39.camel@gaston>
Mime-Version: 1.0
Cc: gentoo-ppc-user@gentoo.org
Subject: Re: TEST: Sleep suppport for iBook G4 & Aluminium PowerBooks (ATI
	based)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2004-11-19 at 19:20 +1100, Benjamin Herrenschmidt wrote:
> On Fri, 2004-11-19 at 17:56 +1100, Benjamin Herrenschmidt wrote:
> > So here's the new patch, it replaces the previous one for Aluminium
> > PowerBooks, and is still against 2.6.9. I'll do something against 2.6.10
> > when that one is out (it's a bit late to get that merged with Linus,
> > 2.6.10 is in freeze mode now) and I hope to get all of that in 2.6.11.
> >
> > .../...
> 
> Ok, I already found a bug, occasional lockups on boot and when setting
> the backlight. I uploaded a new version at:

Here's a 3rd version. It may or may not help, as I didn't have a chance
to test this one on either albook or ibook g4 yet. I added saving and
restoring of a few more registers that may fix the Xv problem (or not...
depends what X does at this point) and eventually some corruption
problem (the bandwidth related registers weren't restored).

It also adds an unrelated fix to the cpufreq code for powerbooks using
PMU-based frequency switching which would occasionally cause hangs at
boot.

http://gate.crashing.org/~benh/albook-ibookg4-sleep-3.diff

Ben.
