Return-Path: <dgibson@ozlabs.org>
Date: Tue, 3 Apr 2007 10:55:02 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: "Mark A. Greer" <mgreer@mvista.com>
Subject: Re: [RFC 3/3] powerpc: Add DTS file for the Motorola PrPMC2800
	platform
Message-ID: <20070403005502.GA31273@localhost.localdomain>
References: <20070328011924.GA1586@mag.az.mvista.com>
	<20070328012206.GD1586@mag.az.mvista.com>
	<9696D7A991D0824DBA8DFAC74A9C5FA302BDAB3E@az33exm25.fsl.freescale.net>
	<20070329003550.GB25652@localhost.localdomain>
	<20070402181553.GH2132@mag.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070402181553.GH2132@mag.az.mvista.com>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>,
	Yoder Stuart-B08248 <stuart.yoder@freescale.com>,
	Dale Farnsworth <dfarnsworth@mvista.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Apr 02, 2007 at 11:15:53AM -0700, Mark A. Greer wrote:
> On Thu, Mar 29, 2007 at 10:35:50AM +1000, David Gibson wrote:
> > On Wed, Mar 28, 2007 at 09:43:16AM -0700, Yoder Stuart-B08248 wrote:
> > [snip]
> > > > +
> > > > +	mv64x60@f1000000 { /* Marvell Discovery */
> > > > +		#address-cells = <1>;
> > > > +		#size-cells = <1>;
> > > > +		#interrupt-cells = <1>;
> > > > +		device_type = "mv64360";
> > > > +		compatible = "mv64x60";
> > > > +		clock-frequency = <7f28155>;		/* 
> > > > 133.333333 Mhz */
> > > > +		reg = <f1000000 00010000>;
> > > > +		virtual-reg = <f1000000>;
> > > 
> > > What is virtual-reg for?  I gather it is related to the bootwrapper
> > > needed virtual addresses for devices reg blocks.  But, I counted
> > > 12 instances of the property in this file.  Are all needed by the
> > > bootwrapper??
> > 
> > That does seem like a lot.
> 
> It is.  They need to be culled.
> 
> > The only thing that should need
> > virtual-reg properties is serial ports.  In fact, specifically, only
> > serial ports that the zImage is actually expected to use.
> 
> Not true.  Any reg block you're going to access in the bootwrapper needs
> this or some equivalent method for determining where to access those regs.
> Either that, parse BAT & page/hash tables, or provide ioremap in the
> bootwrapper (which, at the time virtual-reg materialized, was deemed
> overkill for the bootwrapper--presumably the same goes for parsing hash
> tables).

And examples of such reg blocks other than serial would be...?

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
