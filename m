Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3D857DDE06
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 27 Aug 2008 00:03:56 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m7QE3fJ4022697 for <linuxppc-embedded@ozlabs.org>;
	Tue, 26 Aug 2008 07:03:42 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m7QE3RTb013154
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 26 Aug 2008 09:03:27 -0500 (CDT)
Date: Tue, 26 Aug 2008 09:03:24 -0500
From: Scott Wood <scottwood@freescale.com>
To: Chris Skepper <skepper@ukf.net>
Subject: Re: Early boot problem with MPC8247 and Linux 2.6.26
Message-ID: <20080826140324.GB3783@ld0162-tx32.am.freescale.net>
References: <Pine.LNX.4.62.0808221515450.31216@chara.vm.bytemark.co.uk>
	<48AEF220.7080506@freescale.com>
	<Pine.LNX.4.62.0808261219210.3327@chara.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.62.0808261219210.3327@chara.vm.bytemark.co.uk>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, Aug 26, 2008 at 01:00:05PM +0100, Chris Skepper wrote:
> >How are you determining that it never gets to that point?  If it's via 
> >serial I/O or similar, be aware that I/O isn't going to work when caches 
> >are enabled but the MMU is not.
> 
> I'm triggering an LED which is connected to port A.  Are you saying that 
> wouldn't work once the caching is enabled?

It's quite possible.  What other registers are in the same cache line as
the LED, and are any of them non-memory-like?  And even if all registers
in the cache line are OK with this sort of access, you need to use dcbf
afterwards.

It's usually easiest to just trust that that part of the code works (in
my experience, that's rarely where a hang actually occurs when bringing
up a new board), and resume tracing after the MMU is on and you've
inserted a caching-inhibited BAT entry.

-Scott
