Return-Path: <sha@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) by ozlabs.org (Postfix) with ESMTP id 20F7DDDE35
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jan 2007 19:46:28 +1100 (EST)
Date: Fri, 12 Jan 2007 09:46:12 +0100
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] add restart function for mpc52xx
Message-ID: <20070112084612.GJ11226@localhost.localdomain>
References: <20070111122855.GF11226@localhost.localdomain>
	<37B2A6BB-4F36-4765-A1C2-A4F8D30D4503@kernel.crashing.org>
	<20070111152137.GG11226@localhost.localdomain>
	<17831.627.162751.166002@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <17831.627.162751.166002@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev Development <linuxppc-dev@ozlabs.org>,
	Sylvain Munaut <tnt@246tNt.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Jan 12, 2007 at 02:37:23PM +1100, Paul Mackerras wrote:
> Sascha Hauer writes:
> 
> > > This suffers from the same bug mpc83xx_restart has.  We can NOT do an  
> > > ioremap inside the restart function.  We may get called from  
> > > interrupt context on a panic and will not be able to do the ioremap 
> > > ().  The simplest thing is to do the mapping earlier in an init call  
> > > and save the pointer, its not perfect, but better.
> > > 
> > 
> > I'm beginning to hate this whole pseudo OF thing for embedded systems.
> 
> Not being able to ioremap at interrupt time has absolutely _nothing_
> to do with the device tree.

No, not directly..

> 
> > All we need to know is that we have a mpc52xx processor.
> 
> ... until we get a system with a mpc52xx and some extra stuff.  Then
> you say "OK, we just need a boardinfo_t" and then we get 57 different
> variants of boardinfo_t and then we're back in the mess that arch/ppc
> got into.

OK, nobody wants that. I can only compare to arm where we have one
single number per board (not per SoC, I misrepresented that). This
number is perfectly enough to know what SoC we are on (to map the
register space and select timing/irq code and the like). The rest of a
particular board is described in one single board file.
On system with real open firmware it's surely the way to go to use it,
but on systems without OF it's just painful. Not being able to implement
a restart function without changing the device tree shows that.

Sascha

-- 
 Dipl.-Ing. Sascha Hauer | http://www.pengutronix.de
  Pengutronix - Linux Solutions for Science and Industry
    Handelsregister: Amtsgericht Hildesheim, HRA 2686
      Hannoversche Str. 2, 31134 Hildesheim, Germany
    Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9
