Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5FA7AB7CB8
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Jan 2010 20:45:07 +1100 (EST)
Subject: Re: [PATCH]: powerpc: Fix build breakage due to incorrect location
	of autoconf.h
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
In-Reply-To: <OF7EAC50CA.1271BCB8-ONC12576AB.00321D31-C12576AB.00329588@transmode.se>
References: <20100112022150.GE12666@kryten>
	<20100112140136.c8ccc357.sfr@canb.auug.org.au>
	<OFF0BABDB9.D573B5F9-ONC12576A9.0041BA69-C12576A9.0041D76A@transmode.se>
	<FB3DFBD5-9976-4D03-828A-EB4E6E08DAA4@kernel.crashing.org>
	<1263412963.724.223.camel@pasglop>
	<OF20873087.ECC43BEB-ONC12576AB.0029EA9A-C12576AB.002AC5CA@transmode.se>
	<1263459431.724.352.camel@pasglop>
	<OF7EAC50CA.1271BCB8-ONC12576AB.00321D31-C12576AB.00329588@transmode.se>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 14 Jan 2010 20:43:44 +1100
Message-ID: <1263462224.724.356.camel@pasglop>
Mime-Version: 1.0
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Roel Kluin <roel.kluin@gmail.com>,
	"linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>,
	Richard Purdie <rpurdie@rpsys.net>, Anton Blanchard <anton@samba.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Woodhouse <dwmw2@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2010-01-14 at 10:12 +0100, Joakim Tjernlund wrote:
> > No, that was on purpose. If an arch doesn't have efficient unaligned
> > accesses, then they should not use the optimization since it will
> result
> > in a lot of unaligned accesses :-) In which case they are better off
> > falling back to the old byte-by-byte method.
> 
> Not quite, it is only 1 of 4 accesses that uses unaligned and
> that accesses is only unaligned 50% in average, it might still
> be faster. We will never know now.

Why ? If you think it's a win, then it's easy to make a patch to turn
it to __KERNEL__ and ask some people from ARM and MIPS or even sparc
land for example to give it a spin. If it's indeed a win, then submit it
to Linus and/or Andrew and there's no reason for it not to go in.

I simply took a more conservative approach for post -rc4

Cheers,
Ben.
