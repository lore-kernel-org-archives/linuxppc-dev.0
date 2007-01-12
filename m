Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17831.627.162751.166002@cargo.ozlabs.ibm.com>
Date: Fri, 12 Jan 2007 14:37:23 +1100
From: Paul Mackerras <paulus@samba.org>
To: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH] add restart function for mpc52xx
In-Reply-To: <20070111152137.GG11226@localhost.localdomain>
References: <20070111122855.GF11226@localhost.localdomain>
	<37B2A6BB-4F36-4765-A1C2-A4F8D30D4503@kernel.crashing.org>
	<20070111152137.GG11226@localhost.localdomain>
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

Sascha Hauer writes:

> > This suffers from the same bug mpc83xx_restart has.  We can NOT do an  
> > ioremap inside the restart function.  We may get called from  
> > interrupt context on a panic and will not be able to do the ioremap 
> > ().  The simplest thing is to do the mapping earlier in an init call  
> > and save the pointer, its not perfect, but better.
> > 
> 
> I'm beginning to hate this whole pseudo OF thing for embedded systems.

Not being able to ioremap at interrupt time has absolutely _nothing_
to do with the device tree.

> All we need to know is that we have a mpc52xx processor.

... until we get a system with a mpc52xx and some extra stuff.  Then
you say "OK, we just need a boardinfo_t" and then we get 57 different
variants of boardinfo_t and then we're back in the mess that arch/ppc
got into.

Paul.
