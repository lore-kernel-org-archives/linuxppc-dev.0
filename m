Return-Path: <dgibson@ozlabs.org>
Date: Mon, 6 Aug 2007 14:02:49 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Yoder Stuart-B08248 <stuart.yoder@freescale.com>
Subject: Re: [PATCH 3/3] First cut at PReP support for arch/powerpc
Message-ID: <20070806040249.GA6103@localhost.localdomain>
References: <9696D7A991D0824DBA8DFAC74A9C5FA303156076@az33exm25.fsl.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9696D7A991D0824DBA8DFAC74A9C5FA303156076@az33exm25.fsl.freescale.net>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Aug 03, 2007 at 02:55:16PM -0700, Yoder Stuart-B08248 wrote:
> 
> > > > > +		MPIC: interrupt-controller@d {
> > > > > +			device_type = "open-pic";
> > > > > 
> > > > > device_type = "interrupt-controller".
> > > 
> > > Not according to the binding in booting-without-of.txt
> > 
> > My understanding here, though possibly flawed, is that the current
> > implementation has "open-pic" but _should_ have "interrupt-controller"
> > as that is the officially correct name.
> > 
> > I _think_ this means we need a transitional period where we update
> > the code to look for "interrupt-controller", and obsoletedly, looks
> > for the "open-pic", while we transition to the new, correct name.
> 
> "open-pic" is the correct value for the device_type property.
> See the binding at:
> http://playground.sun.com/1275/bindings/chrp/chrp1_8a.ps
> That is the definition for open pic interrupt controllers (AFAIK).
> 
> I am not aware of any official binding with "interrupt-controller" 
> as the device_type.

That's what I thought.

> However, the interrupt mapping spec says that all interrupt
> controller (regardless of device_type) must have a 
> property named "interrupt-controller" to identify
> the device node as an interrupt controller and root of
> a interrupt tree.
> See: http://playground.sun.com/1275/practice/imap/imap0_9d.html

Ah, yes.  Added to both the mpic and 8259.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
