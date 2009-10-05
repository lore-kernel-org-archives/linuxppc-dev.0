Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8BBC7B7B86
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Oct 2009 07:28:16 +1100 (EST)
Subject: Re: [PATCH] powerpc/8xx: fix regression introduced by cache
	coherency rewrite
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
In-Reply-To: <OFA4FCE21A.BE62CF0F-ONC1257646.0069703B-C1257646.0069E5EB@transmode.se>
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
	<OF7C895670.A7F16A1A-ONC1257645.00620A4D-C1257645.006ED40F@transmode.se>
	<1254688118.7122.30.camel@pasglop>
	<OFA4FCE21A.BE62CF0F-ONC1257646.0069703B-C1257646.0069E5EB@transmode.se>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 06 Oct 2009 07:28:05 +1100
Message-Id: <1254774485.7122.37.camel@pasglop>
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

On Mon, 2009-10-05 at 21:16 +0200, Joakim Tjernlund wrote:
> Ben, for my understanding: It seems to that the TLB Miss routines in
> head_32.S are less than optimal as it too touches the pte every time
> it hits. Would it not be better to test if ACCESSED and friends are
> already set
> and skip storing the same pte over and over again?

I wouldn't think it's a big deal, but then, the 32-bit hash code
has to also update _PAGE_HASHPTE etc... overall I wouldn't touch
it for now.

However, 8xx should instead look at what I do in recent versions
of head_44x.S or what Kumar did in head_fsl_booke.S

Cheers,
Ben.
