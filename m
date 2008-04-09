Return-Path: <sha@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C25B4DE1C9
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Apr 2008 02:51:53 +1000 (EST)
Date: Wed, 9 Apr 2008 18:53:24 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] FCC: fix confused base / offset
Message-ID: <20080409165324.GF10465@pengutronix.de>
References: <20080409130610.GE10465@pengutronix.de>
	<20080409161110.GA5296@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080409161110.GA5296@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Apr 09, 2008 at 11:11:10AM -0500, Scott Wood wrote:
> On Wed, Apr 09, 2008 at 03:06:10PM +0200, Sascha Hauer wrote:
> > This patch fixes a mixup in struct fs_platform_info. The struct has a field
> > dpram_offset which really is no offset but an io pointer to the dpram
> > (casted to u32).
> 
> Right, I didn't want to touch that as the old-binding code should be
> going away soon anyway.

Right, so it's probably not worth the effort. I stumbled on this while
porting my board to the new binding code. I was quite confused when
seeing this so I made this fix to understand what's going on here.

BTW have you tested the FCC driver with the new binding code? I do not
manage to get it working. Everything seems to be fine but
fs_enet_start_xmit does not send a packet and no interrupts are
arriving.



> Does this break arch/ppc, BTW?

Yes. arch=ppc is out of my scope, so I forget about it regularly, sorry.
It breaks arch/ppc/platforms/mpc8272ads_setup.c which can be easily
fixed though. But as the mpc8272ads is supported with arch=powerpc,
shouldn't it go away anyway?

Sascha



-- 
Pengutronix e.K. - Linux Solutions for Science and Industry
-----------------------------------------------------------
Kontakt-Informationen finden Sie im Header dieser Mail oder
auf der Webseite -> http://www.pengutronix.de/impressum/ <-
