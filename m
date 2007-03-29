Return-Path: <dgibson@ozlabs.org>
Date: Thu, 29 Mar 2007 10:35:50 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Yoder Stuart-B08248 <stuart.yoder@freescale.com>
Subject: Re: [RFC 3/3] powerpc: Add DTS file for the Motorola PrPMC2800
	platform
Message-ID: <20070329003550.GB25652@localhost.localdomain>
References: <20070328011924.GA1586@mag.az.mvista.com>
	<20070328012206.GD1586@mag.az.mvista.com>
	<9696D7A991D0824DBA8DFAC74A9C5FA302BDAB3E@az33exm25.fsl.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9696D7A991D0824DBA8DFAC74A9C5FA302BDAB3E@az33exm25.fsl.freescale.net>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>,
	Dale Farnsworth <dfarnsworth@mvista.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Mar 28, 2007 at 09:43:16AM -0700, Yoder Stuart-B08248 wrote:
[snip]
> > +
> > +	mv64x60@f1000000 { /* Marvell Discovery */
> > +		#address-cells = <1>;
> > +		#size-cells = <1>;
> > +		#interrupt-cells = <1>;
> > +		device_type = "mv64360";
> > +		compatible = "mv64x60";
> > +		clock-frequency = <7f28155>;		/* 
> > 133.333333 Mhz */
> > +		reg = <f1000000 00010000>;
> > +		virtual-reg = <f1000000>;
> 
> What is virtual-reg for?  I gather it is related to the bootwrapper
> needed virtual addresses for devices reg blocks.  But, I counted
> 12 instances of the property in this file.  Are all needed by the
> bootwrapper??

That does seem like a lot.  The only thing that should need
virtual-reg properties is serial ports.  In fact, specifically, only
serial ports that the zImage is actually expected to use.

In fact, with Scott's addition of xlate_reg() to the bootwrapper,
virtual-reg should only be needed on systems that enter the zImage
with MMU on.

> Does anyone where this property came from historically?  If it's
> specifically for a Linux bootwrapper the name should reflect 
> that-- linux,bootwrapper-reg-vaddr -- or something...

> I also wonder if there is a better place to put this information.
> The device nodes strictly speaking should be describing the devices
> _physical_ characteristics.

Yes, but where else is there?  virtual-reg is a hack, but a very
useful one.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
