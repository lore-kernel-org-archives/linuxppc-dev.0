Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6C2FDB7BEA
	for <linuxppc-dev@ozlabs.org>; Sat,  3 Oct 2009 20:57:42 +1000 (EST)
Subject: Re: [PATCH] powerpc/8xx: fix regression introduced by cache
	coherency rewrite
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
In-Reply-To: <OF0216D5A2.8B77DD30-ONC1257644.0031FDC4-C1257644.0033A760@transmode.se>
References: <OF490DC464.F75531A6-ONC1257640.002AC41C-C1257640.002D2820@transmode.se>
	<1254212198.5256.0.camel@pasglop>
	<OF94793A12.243E8E02-ONC1257640.0040DE05-C1257640.00419DBD@transmode.se>
	<20090929210331.GA25779@laura.chatsunix.int.mrv.com>
	<OF5D06EC36.28A07DB5-ONC1257641.00299A2D-C1257641.002BE7B1@transmode.se>
	<OFFEC1BDFB.17183440-ONC1257641.002D81B9-C1257641.002DC24F@transmode.se>
	<20090930090002.GA2928@compile2.chatsunix.int.mrv.com>
	<OF46F87EEF.62BE7D78-ONC1257641.003D4172-C1257641.003E1445@transmode.se>
	<OFC29CE070.42D58057-ONC1257641.005F19FD-C1257641.005F8ED3@transmode.se>
	<1254350159.5699.21.camel@pasglop>
	<20091002214949.GA20514@b07421-ec1.am.freescale.net>
	<OF4175DD8E.796930EB-ONC1257644.002A7135-C1257644.002C7929@transmode.se>
	<1254558678.7122.7.camel@pasglop>
	<OF0216D5A2.8B77DD30-ONC1257644.0031FDC4-C1257644.0033A760@transmode.se>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 03 Oct 2009 20:57:28 +1000
Message-Id: <1254567448.7122.8.camel@pasglop>
Mime-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Rex Feany <RFeany@mrv.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2009-10-03 at 11:24 +0200, Joakim Tjernlund wrote:
> 
> So yes, there is a missing _tlbil_va() missing for 8xx somewhere
> but there is something more too.
> Maybe your new filter functions and my
>  powerpc, 8xx: DTLB Error must check for more errors.
> will do the trick?

Well, if we can't tell between a load and a store on a TLB miss, then
we should probably let it create an unpopulated entry in all cases,
so that we do take a proper DSI/ISI the second time around, which
would then tell us where we come from...

Ben.
