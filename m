Return-Path: <mgreer@mvista.com>
Date: Mon, 2 Apr 2007 11:15:53 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Yoder Stuart-B08248 <stuart.yoder@freescale.com>,
	"Mark A. Greer" <mgreer@mvista.com>,
	linuxppc-dev <Linuxppc-dev@ozlabs.org>,
	Dale Farnsworth <dfarnsworth@mvista.com>
Subject: Re: [RFC 3/3] powerpc: Add DTS file for the Motorola PrPMC2800
	platform
Message-ID: <20070402181553.GH2132@mag.az.mvista.com>
References: <20070328011924.GA1586@mag.az.mvista.com>
	<20070328012206.GD1586@mag.az.mvista.com>
	<9696D7A991D0824DBA8DFAC74A9C5FA302BDAB3E@az33exm25.fsl.freescale.net>
	<20070329003550.GB25652@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070329003550.GB25652@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Mar 29, 2007 at 10:35:50AM +1000, David Gibson wrote:
> On Wed, Mar 28, 2007 at 09:43:16AM -0700, Yoder Stuart-B08248 wrote:
> [snip]
> > > +
> > > +	mv64x60@f1000000 { /* Marvell Discovery */
> > > +		#address-cells = <1>;
> > > +		#size-cells = <1>;
> > > +		#interrupt-cells = <1>;
> > > +		device_type = "mv64360";
> > > +		compatible = "mv64x60";
> > > +		clock-frequency = <7f28155>;		/* 
> > > 133.333333 Mhz */
> > > +		reg = <f1000000 00010000>;
> > > +		virtual-reg = <f1000000>;
> > 
> > What is virtual-reg for?  I gather it is related to the bootwrapper
> > needed virtual addresses for devices reg blocks.  But, I counted
> > 12 instances of the property in this file.  Are all needed by the
> > bootwrapper??
> 
> That does seem like a lot.

It is.  They need to be culled.

> The only thing that should need
> virtual-reg properties is serial ports.  In fact, specifically, only
> serial ports that the zImage is actually expected to use.

Not true.  Any reg block you're going to access in the bootwrapper needs
this or some equivalent method for determining where to access those regs.
Either that, parse BAT & page/hash tables, or provide ioremap in the
bootwrapper (which, at the time virtual-reg materialized, was deemed
overkill for the bootwrapper--presumably the same goes for parsing hash
tables).

> In fact, with Scott's addition of xlate_reg() to the bootwrapper,
> virtual-reg should only be needed on systems that enter the zImage
> with MMU on.

True and that's the whole purpose of 'virtual-reg'.

> > Does anyone where this property came from historically?  If it's
> > specifically for a Linux bootwrapper the name should reflect 
> > that-- linux,bootwrapper-reg-vaddr -- or something...
> 
> > I also wonder if there is a better place to put this information.
> > The device nodes strictly speaking should be describing the devices
> > _physical_ characteristics.
> 
> Yes, but where else is there?  virtual-reg is a hack, but a very
> useful one.

Agreed.  Dale Farnsworth suggested a 'ranges' type property at the top
level that's used for phys->virt mappings.  That is much cleaner IMHO
and eliminates the need to parse hash tables or add ioremap code to the
bootwrapper.

Mark
