Return-Path: <glikely@secretlab.ca>
Date: Wed, 16 Jul 2008 08:30:42 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [RFC] I2C: fsl-i2c: make device probing configurable via FDT
Message-ID: <20080716143042.GF24045@secretlab.ca>
References: <487DD1BD.8040701@grandegger.com>
	<9e4733910807160547q28f49865o11ec878d98987329@mail.gmail.com>
	<487DF304.7090205@grandegger.com>
	<9e4733910807160724s136ef980weeeea2488ad7adf2@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9e4733910807160724s136ef980weeeea2488ad7adf2@mail.gmail.com>
Sender: Grant Likely <glikely@secretlab.ca>
Cc: Jean Delvare <khali@linux-fr.org>, Linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jul 16, 2008 at 10:24:22AM -0400, Jon Smirl wrote:
> On 7/16/08, Wolfgang Grandegger <wg@grandegger.com> wrote:
> > Jon Smirl wrote:
> >
> > > On 7/16/08, Wolfgang Grandegger <wg@grandegger.com> wrote:
> > >
> > > > Currently, the I2C buses are probed for HWMON I2C devices, which might
> > > >  not be acceptable in same cases. This patch makes device probing
> > > >  configurable through the property "probe" of the FDT I2C device node:
> > > >
> > >
> > > All this patch seems to be doing is removing class I2C_CLASS_HWMON via
> > > a device tree flag, PROBE.
> 
> If this is implemented it shouldn't be a device tree option, it should
> be a compile time option in the Kconfig system. We don't want to
> pollute a platform independent device tree with Linux clutter.

I'm not sure about this.  It is somewhat describing the hardware.  It
sounds like it is saying "hey, I've got an i2c bus here, but I don't
know what is on it; so instead of providing a set of child nodes, you
should probe this bus to find out what it has".

I don't see any problem specifying it in the device tree.

Making it a Kconfig option forces *all* i2c busses on supported
platforms into either probe or no-probe mode.  Not a multiplatform
friendly solution.  Heck, we've got multiple i2c busses on some chips and
it is conceivable that only one would need to be probed.

Cheers,
g.
