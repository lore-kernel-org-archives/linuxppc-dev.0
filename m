Return-Path: <jonsmirl@gmail.com>
Message-ID: <9e4733910710211433r7e0cf4b4sf6aed12c57dda375@mail.gmail.com>
Date: Sun, 21 Oct 2007 17:33:30 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Segher Boessenkool" <segher@kernel.crashing.org>
Subject: Re: Device trees and audio codecs
In-Reply-To: <a76a128145ec8a8f779727a7e11925ac@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <9e4733910710200833x5d1c55b5l2cd400f77c13ec87@mail.gmail.com>
	<a76a128145ec8a8f779727a7e11925ac@kernel.crashing.org>
Cc: PowerPC dev list <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 10/21/07, Segher Boessenkool <segher@kernel.crashing.org> wrote:
> > I'm working on ALSA ASoC support for a codec chip on my mpc5200 based
> > target hardware.
>
> What is ASoC?

asoc = ALSA System on a Chip. It is in sound/soc

> > Under ASoC the device drivers for the codec chips are platform
> > independent.  In the current ASoC model there are three device
> > drivers: i2s (or spi, etc), the generic codec, and a platform specific
> > 'fabric' driver.  Some codecs are linked to both i2c and i2s.
>
> The i2s driver is simply for data transport, the codec driver does,
> well, what codecs do; and what is the fabric driver for?  Just to
> know which output ports are which, etc.?

Fabric driver tells how the generic codec is hooked up on the specific
board. Some of the codecs are extremely flexible and can be hooked up
hundreds of different ways. It is like GPIO pins, they are wired in
however is convenient for the design.

> > The fabric driver corresponds to the 'layout-id' in the Apple model.
> > It tells how to configure the generic codec driver for the specific
> > configuration needed by the actual platform hardware.
>
> The apple layout-id selects one of several tables with *lots* of info.
> I think you want a subset of that only.

The fabric/layout-id stuff is platform specific.

> > My target hardware has a codec that is linked to both i2s and i2c. How
> > should it be represented?
>
> Since the codec is addressable on i2c, and not on i2s, it should be
> a child node of the i2c bus it sits on; and then you put a property
> in the codec node pointing to the i2s bus node it is connected to.
> Multiple of those (or multiple entries) if it is connected to more
> than one i2s bus.  "i2s-parent" might be a good name for such a prop.

How do we want to be consistent with the Efika which uses an AC97
codec that only connects to i2s?

> > Apple has three entries. One for i2s, one for the codec, and one for
> > soundchip. What is the soundchip entry, does it correspond to real
> > hardware?
> >
> > /proc/device-tree/pci@f2000000/mac-io@17/i2s@0/i2s-a@10000:
>
> This is one of the i2s channels on the macio.  Dunno why they put
> all those platform-XXX entries in here, (most of) these don't
> logically belong here.

Actually those platform-XXX entries may be the solution I am looking
for. I can use the generic i2s driver to load a fabric driver as an
ALSA module.

> > /proc/device-tree/pci@f2000000/mac-io@17/i2s@0/i2s-a@10000/sound:
>
> The codec.  I guess Apple puts this here for their weirdo platform-do
> stuff; don't imitate this :-)
>
> > /proc/device-tree/pci@f2000000/mac-io@17/i2c@18000/i2c-bus@0/codec@6a:
>
> The codec.  _Do_ put it here in your tree :-)

-- 
Jon Smirl
jonsmirl@gmail.com
