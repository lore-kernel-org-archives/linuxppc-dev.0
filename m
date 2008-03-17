Return-Path: <joakim.tjernlund@transmode.se>
Received: from tmnt04.transmode.se (mail.transmode.se [83.241.175.147])
	by ozlabs.org (Postfix) with ESMTP id B4C37DDF61
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Mar 2008 10:53:45 +1100 (EST)
Subject: Re: [PATCH] [POWERPC] 83xx: MPC837xRDB's VSC7385 ethernet switch
	isn't on the MDIO bus
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
To: Timur Tabi <timur@freescale.com>
In-Reply-To: <47DEF9E7.5030808@freescale.com>
References: <20080317175208.GA17844@localhost.localdomain>
	<1205782935.7589.55.camel@gentoo-jocke.transmode.se>
	<47DEE6CF.7040801@freescale.com>
	<1205792537.7589.64.camel@gentoo-jocke.transmode.se>
	<47DEF9E7.5030808@freescale.com>
Content-Type: text/plain
Date: Tue, 18 Mar 2008 00:53:42 +0100
Message-Id: <1205798023.7589.76.camel@gentoo-jocke.transmode.se>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: joakim.tjernlund@transmode.se
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mon, 2008-03-17 at 18:08 -0500, Timur Tabi wrote:
> Joakim Tjernlund wrote:
> 
> > eth0 is also up, was it commit 4942bd80e83d13bf394df4a8109bee39d861820f
> > that fixed that bug?
> 
> Yep.  Unfortunately, I don't really know enough about the ucc_geth driver to
> know what could be wrong.  I just noticed your message and remembered that old bug.
> 

I noticed that ugeth_graceful_stop_rx() is lacking in_8()/out_8() so I
am adding that, but I cant test until tmw.

Also notice that there is a lot of in_beX()/out_beX() in the driver and
those functions use the sync instruction. Won't that much suny usage
hurt performance and is sync really needed?

 Jocke
