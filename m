Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CB12D1007D4
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Jan 2010 19:58:40 +1100 (EST)
Subject: Re: [PATCH]: powerpc: Fix build breakage due to incorrect location
	of autoconf.h
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
In-Reply-To: <OF20873087.ECC43BEB-ONC12576AB.0029EA9A-C12576AB.002AC5CA@transmode.se>
References: <20100112022150.GE12666@kryten>
	<20100112140136.c8ccc357.sfr@canb.auug.org.au>
	<OFF0BABDB9.D573B5F9-ONC12576A9.0041BA69-C12576A9.0041D76A@transmode.se>
	<FB3DFBD5-9976-4D03-828A-EB4E6E08DAA4@kernel.crashing.org>
	<1263412963.724.223.camel@pasglop>
	<OF20873087.ECC43BEB-ONC12576AB.0029EA9A-C12576AB.002AC5CA@transmode.se>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 14 Jan 2010 19:57:11 +1100
Message-ID: <1263459431.724.352.camel@pasglop>
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


> Seen it now as it is in Linus tree:
> 
> 1) IMHO it would have been nicer to use #ifdef __KERNEL__
>    instead of CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
>    as then arches that don't define CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
>    at all will never use the new optimization or was that what you intended?

No, that was on purpose. If an arch doesn't have efficient unaligned
accesses, then they should not use the optimization since it will result
in a lot of unaligned accesses :-) In which case they are better off
falling back to the old byte-by-byte method.

The advantage also of doing it this way is that x86 will benefit from
the optimisation at boot time since it does include autoconf.h in its
boot wrapper (and deals with unaligned accesses just fine at any time)
though something tells me that it won't make much of a difference in
performances on any recent x86 (it might on some of the newer low power
embedded ones, I don't know for sure).

> 2) You really should add an comment in the Makefile about not using
>    autoconf.h/-D__KERNEL__

That's true :-)

Cheers,
Ben.
