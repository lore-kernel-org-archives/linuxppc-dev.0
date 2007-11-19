Return-Path: <jonsmirl@gmail.com>
Message-ID: <9e4733910711190855g19605bf5o91d3428523961b6a@mail.gmail.com>
Date: Mon, 19 Nov 2007 11:55:45 -0500
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Timur Tabi" <timur@freescale.com>
Subject: Re: Revisited, audio codec device tree entries.
In-Reply-To: <4741BD5D.2090502@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <9e4733910711181010q50c08d2ek8413af74d58cf0ce@mail.gmail.com>
	<4741A56D.9050808@freescale.com>
	<fa686aa40711190733vd1ffac0k62bf32186eb57aff@mail.gmail.com>
	<4741BD5D.2090502@freescale.com>
Cc: PowerPC dev list <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 11/19/07, Timur Tabi <timur@freescale.com> wrote:
> Grant Likely wrote:
>
> > You probably mean "don't use the of_platform bus to load the fabric
> > driver".
>
> Yes, that is what I meant.
>
> > He still needs to use the data in the device tree to decide
> > what fabric drivers to use.
>
> I'm not sure about that.  The fabric driver is tied to the platform itself,
> mostly because the fabric driver isn't really a device driver.  It's a
> platform driver, in that its job is to initialize the other device drivers, or
> make sure the kernel initializes them.  It's also responsible for telling ALSA
>   which driver does what and how they're connected.
>
> With the current version of ASoC (V1), I don't think it's possible to have an
> independent platform driver.  V2 is in development, but it's not ready yet and
> I haven't had a chance to study it.  V2 is intended to address the problems
> that a device tree model raises.

I'm using the v2 code. The v2 code is modeled after the i2c bus code
which is the correct way to do drivers for open firmware.

v1 creates asoc core as a platform device which was completely wrong
since it is a driver core, not a device. That is fixed in v2 where it
initializes with a subsysinit() call and then creates a bus. The whole
driver organization of v2 is superior to v1. Open firmware support was
the main motivation behind v2.


>
> > In this case; it probably is appropriate to have the platform code
> > instantiate a platform_device for the fabric (instead of an
> > of_platform device) which the fabric driver can bind against.
> >
> > Another option is to explicitly call of_platform_device_create in the
> > platform code on the fabric node (which should be a child of the root
> > node) so that you can have an of_platform_bus fabric driver.
>
> I don't fully understand platform drivers.  Do we really need a full-blown OF
> platform driver for this?
>
> --
> Timur Tabi
> Linux Kernel Developer @ Freescale
>


-- 
Jon Smirl
jonsmirl@gmail.com
