Return-Path: <RFeany@mrv.com>
Received: from bos-spam.mrv.com (mx5.mrv.com [140.179.254.12])
	by ozlabs.org (Postfix) with ESMTP id 329C5B7BC2
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Sep 2009 19:00:08 +1000 (EST)
Date: Wed, 30 Sep 2009 02:00:02 -0700
From: Rex Feany <RFeany@mrv.com>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Subject: Re: [PATCH] powerpc/8xx: fix regression introduced by cache
	coherency	rewrite
Message-ID: <20090930090002.GA2928@compile2.chatsunix.int.mrv.com>
References: <1253843480.7103.492.camel@pasglop>
	<20090929012106.GA22798@compile2.chatsunix.int.mrv.com>
	<OF1870F4D5.BB673882-ONC1257640.00233638-C1257640.00236DC9@transmode.se>
	<1254208057.5771.7.camel@pasglop>
	<OF490DC464.F75531A6-ONC1257640.002AC41C-C1257640.002D2820@transmode.se>
	<1254212198.5256.0.camel@pasglop>
	<OF94793A12.243E8E02-ONC1257640.0040DE05-C1257640.00419DBD@transmode.se>
	<20090929210331.GA25779@laura.chatsunix.int.mrv.com>
	<OF5D06EC36.28A07DB5-ONC1257641.00299A2D-C1257641.002BE7B1@transmode.se>
	<OFFEC1BDFB.17183440-ONC1257641.002D81B9-C1257641.002DC24F@transmode.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <OFFEC1BDFB.17183440-ONC1257641.002D81B9-C1257641.002DC24F@transmode.se>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Thus spake Joakim Tjernlund (joakim.tjernlund@transmode.se):

> > Ok, I have made some minor tweaks and added debug code in
> > do_page_fault(). Would be great if you could try on both
> > .31 and top of tree.
> >
> >  Jocke
> 
> OOPS, found a bug. Use this one instead:

.31 - no change, it worked before your patch and it works after.
None of your debugging printks show up. I tried removing the tlbil_va()
from do_dcache_icache_coherency() and userspace goes back to be being
slow/non functional.

top of tree - userspace is slow and unstable, random segfaults,
and none of your debugging printks show up :(

take care!
/rex
