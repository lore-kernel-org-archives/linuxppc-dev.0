Return-Path: <dgibson@ozlabs.org>
Date: Thu, 24 May 2007 10:52:15 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Porting RapidIO from ppc arch to powerpc arch in support of
	MPC8641D
Message-ID: <20070524005215.GA14320@localhost.localdomain>
References: <1179862732.25914.40.camel@pterry-fc6.micromemory.com>
	<46B96294322F7D458F9648B60E15112C234AE6@zch01exm26.fsl.freescale.net>
	<Pine.LNX.4.64.0705230916170.535@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.64.0705230916170.535@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, Zhang Wei-r63237 <Wei.Zhang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, May 23, 2007 at 09:21:48AM -0500, Kumar Gala wrote:
> On Wed, 23 May 2007, Zhang Wei-r63237 wrote:
> 
> > > So I'm taking the boot/dts/mpc8641_hpcn.dts and producing a new
> > > mpc8641D_umem.dts with the following addition to the soc.
> > >
> > > srio@c0000 {
> > >                 device_type = "srio";
> > >                 compatible = "86xx,85xx";

This is quite tangential to the rest of this discussion, but "xx"s in
compatible properties always alarm me if they're the only thing
listed.  It's generally best to give a precise model, then a more
general one: the trade-off is that if you're too precise, it's fairly
easy for the driver to workaround by recognizing and binding to
multiple compatible strings, whereas if you're too general you risk
the driver not being able to determine whether it needs a
model-specific workaround or not.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
