Return-Path: <sha@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) by ozlabs.org (Postfix) with ESMTP id D31F8DDE11
	for <linuxppc-dev@ozlabs.org>; Wed,  7 May 2008 23:22:38 +1000 (EST)
Date: Wed, 7 May 2008 15:25:14 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: jffs2 and unaligned access
Message-ID: <20080507132514.GF4326@pengutronix.de>
References: <20080507102724.GE4326@pengutronix.de>
	<1210157630.25560.884.camel@pmac.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1210157630.25560.884.camel@pmac.infradead.org>
Cc: linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, May 07, 2008 at 11:53:49AM +0100, David Woodhouse wrote:
> On Wed, 2008-05-07 at 12:27 +0200, Sascha Hauer wrote:
> > memcpy_from/to_io() use word aligned accesses on the io side of memory.
> > The MPC5200 local plus bus where our flashes are connected does not
> > allow unaligned accesses, so we have to use the io versions of memcpy.
> 
> But this region of flash is marked as suitable for execute-in-place,
> otherwise the point() function wouldn't be working to give a direct
> pointer to it. It sounds like we shouldn't be allowing that.

It actually is suitable for execute-in-place. It's the flash U-Boot
starts from. The compiler will generate a proper alignment for you.

> 
> Which in turn means that perhaps we should have a property in the
> corresponding node in the device-tree which indicates that it's not
> suitable for direct access?

So far we did not work with the device-tree flash binding but with the
physmap-flash driver, but ok, this is subject to change anyway.

I gave it a quick try to disable direct accesses. It works, but has a
1:10 performance impact on mounting a jffs2. At least it's a clean
solution.

Sascha


-- 
Pengutronix e.K. - Linux Solutions for Science and Industry
-----------------------------------------------------------
Kontakt-Informationen finden Sie im Header dieser Mail oder
auf der Webseite -> http://www.pengutronix.de/impressum/ <-
