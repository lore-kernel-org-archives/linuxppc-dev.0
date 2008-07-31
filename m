Return-Path: <glikely@secretlab.ca>
Date: Thu, 31 Jul 2008 13:14:51 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] powerpc: i2c-mpc: make speed registers configurable
	via FDT
Message-ID: <20080731191451.GC29097@secretlab.ca>
References: <20080727012722.GH12191@secretlab.ca>
	<4891A744.6060005@grandegger.com>
	<9e4733910807310849g7e5612dbk9536733e061af8ad@mail.gmail.com>
	<4891F4D8.9090905@grandegger.com>
	<fa686aa40807311031r66f6451aw206faf54509c14d9@mail.gmail.com>
	<4891FC3A.7040609@freescale.com>
	<20080731180959.GA29057@secretlab.ca>
	<489200B6.9060906@freescale.com>
	<20080731182810.GB29097@secretlab.ca>
	<48920607.5040606@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <48920607.5040606@freescale.com>
Sender: Grant Likely <glikely@secretlab.ca>
Cc: Scott Wood <scottwood@freescale.com>, Linuxppc-dev@ozlabs.org,
	Linux I2C <i2c@lm-sensors.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jul 31, 2008 at 01:35:51PM -0500, Timur Tabi wrote:
> Grant Likely wrote:
> 
> > No it doesn't, it depends on the register interface to decide
> > compatibility.  Clock interface is part of that. 
> 
> I don't think so.  The interface for programming the clock registers is
> identical on all 8[356]xx parts.  The only thing that matters is what specific
> values to put in the FDR and DFSR registers to get a desired I2C bus speed.
> That answer is dependent on the actual clock input to the device, which is
> external to the device.  I wouldn't call the input frequency a property of the
> I2C device.

Okay, I accept that argument.  Make input frequency a property and be
done with it.

> > I suggested encoding
> > the clock divider directly in compatible (implicit in the SoC version),
> > but it doesn't have to be that way.  If clock freq is obtained from
> > another property or some other method then that is okay too.
> 
> I think we agree on that.

indeed.

> > There is nothing wrong with it (as long as we agree and it gets
> > documented).  I certainly don't have a problem with doing it this way.
> 
> I propose the property "clock-frequency", like this:
> 
> 		i2c@3000 {
> 			#address-cells = <1>;
> 			#size-cells = <0>;
> 			cell-index = <0>;
> 			compatible = "fsl-i2c";
> 			reg = <0x3000 0x100>;
> 			interrupts = <14 0x8>;
> 			interrupt-parent = <&ipic>;
> 			dfsrr;
> 			clock-frequency = <0xblablabla>;  <-- added by U-Boot
> 		};

I'm okay with this.

> Note that the dfsrr property already differentiates between 8xxx and 52xx, so
> maybe we don't need any other device tree changes.

The whole dfsrr property is a really bad idea, and it just replaces the
equally bad idea of an "mpc5200-clocking" property which is currently in
use.  This bit should definitely be determined via compatible.

g.
