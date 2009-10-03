Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 20209B7BC0
	for <linuxppc-dev@ozlabs.org>; Sat,  3 Oct 2009 18:31:31 +1000 (EST)
Subject: Re: [PATCH] powerpc/8xx: fix regression introduced by cache
	coherency rewrite
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
In-Reply-To: <OF4175DD8E.796930EB-ONC1257644.002A7135-C1257644.002C7929@transmode.se>
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
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 03 Oct 2009 18:31:18 +1000
Message-Id: <1254558678.7122.7.camel@pasglop>
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

On Sat, 2009-10-03 at 10:05 +0200, Joakim Tjernlund wrote:
> Cannot shake the feeling that it this snip of code that causes it
>         lwz     r11, 0(r10)     /* Get the level 1 entry */
>         rlwinm. r10, r11,0,0,19 /* Extract page descriptor page
> address */
>         beq     2f              /* If zero, don't try to find a pte */
> Perhaps we can do something better? I still feel that we need to
> force a TLB Error as the TLBMiss does not set DSISR so we have no way
> of
> knowing if it is an load or store.

Can't we manufacture a DSISR and branch to the right function ?

Ben.
