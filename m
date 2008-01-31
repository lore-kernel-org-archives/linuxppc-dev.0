Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from outbound8-dub-R.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id C68C6DDE0E
	for <linuxppc-dev@ozlabs.org>; Fri,  1 Feb 2008 05:42:14 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH] [XILINX][HWICAP] Xilinx Internal Configuration Access
	Port device driver.
Date: Thu, 31 Jan 2008 10:41:34 -0800
In-Reply-To: <871wa1xrhc.fsf@macbook.be.48ers.dk>
References: <20071204235725.61AD6A08071@mail81-dub.bigfish.com>
	<871wa1xrhc.fsf@macbook.be.48ers.dk>
From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
To: "Peter Korsgaard" <jacmet@sunsite.dk>
Message-Id: <20080131184140.E98E11628070@mail172-dub.bigfish.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Peter,

Sorry, this has taken so long...  I've undertaken some significant
refactorings, and included support for the new EDK9.2 xps_hwicap.
Responses below.

> Please don't put the HWICAP option in the middle of the HVC options.

oops!  fixed.

>=20
> > +config XILINX_HWICAP
> > +	tristate "Xilinx OPB HWICAP Support"
> > +	depends on XILINX_VIRTEX
> > +	help
> > +	This option enables support for Xilinx Internal=20
> Configuration Access Port (ICAP) driver.
>=20
> Line too long.

fixed.  checkpatch passes now.

> > +obj-$(CONFIG_XILINX_HWICAP) +=3D xilinx_hwicap_m.o=20
> > +=20
> > +xilinx_hwicap_m-y :=3D xilinx_hwicap.o xhwicap_srp.o
>=20
> Those files are both quite small, couldn't you merge them and get rid
> of the global symbols and the xilinx_hwicap directory?

Its somewhat an artifact of the original EDK code that it is derived
from,
but your probably right.  I've refactored the code to look a little bit
nicer, and now there is a new C file for the fifo-based xps_hwicap.  I
think it really does make sense to have multiple files, now.

> Could you please you a smaller / standard GPL header instead?

Although most copyrights are shorter, in poking through the code, there
others which are of comparable size/language.

> Please use std kerneldoc format.

Fixed.

> No CamelCase, Uppercase parameters.

Fixed.

> > +	if (XHwIcap_mGetDoneReg(InstancePtr->baseAddress) =3D=3D=20
> XHI_NOT_FINISHED) {
> > +		return -EBUSY;
> > +	}
>=20
> No curly brackets around single statement. In general, please run the
> patch through checkpatch.pl and fixup stuff.

Gah... force of habit.  Does anyone have an emacs mode that comes close
to the linux coding style?

> Why don't you request official major/minor numbers?
> (Documentation/devices.txt)

I sent a request to lanana over amonth ago, but haven't received a
response.  For embedded targets the dynamically allocated device is
annoying, but without a static number I don't see what else to do.  In
any event, it is easy to change when a static device number is
allocated.

> > +static struct device_driver xhwicap_module_driver =3D {
> > +	.name =3D DRIVER_NAME,
> > +	.bus =3D &platform_bus_type,
> > +
> > +	.probe =3D xhwicap_drv_probe,
> > +	.remove =3D xhwicap_drv_remove,
> > +};
>=20
> Please use struct platform_driver instead.

That's what I get for copying old code.  I also realized that there is a
better way of dealing with the of_platform_device part.  It's been
rewritten to follow the pattern that Grant and I have been following.

> > +
> > +static int __init xhwicap_module_init(void)
> > +{
> > +	dev_t devt;
> > +	int retval;
> > +
> > +	icap_class =3D class_create(THIS_MODULE, "xilinx_config");
>=20
> What's that for?

To get this:

-bash-3.00# pwd
/sys/class
-bash-3.00# find xilinx_config
xilinx_config
xilinx_config/xilinx_icap
xilinx_config/xilinx_icap/subsystem
xilinx_config/xilinx_icap/uevent
xilinx_config/xilinx_icap/dev

I started trying to do more with this, but I could never quite figure
out how to get sysfs to do what I wanted to.  There's a couple of things
(like the IDCODE) that would be interesting to see here, I think.

> > +#ifdef CONFIG_XILINX_VIRTEX_4_FX
> > +#define XHI_FAMILY virtex4
> > +#else
> > +#define XHI_FAMILY virtex2
> > +#endif
>=20
> So having a single kernel with v2p/v4 support is not an option?

I've fixed this to add a level of indirection, and to select the right
value based on the device tree.  This required a slight modification to
the mhs->dts generator to make the 'xlnx,family' attribute visible.
Note that we currently can't build a real v2/v4 kernel because of some
v2pro errata.  Currently, I enable the errata even in v4, which is not
so nice.

> > +#define XHwIcap_mGetSizeReg(BaseAddress) \
> > +    (in_be32((u32 *)((BaseAddress) + XHI_SIZE_REG_OFFSET)))
> > +
> >=20
> +/************************************************************
> ****************/
>=20
> Why not a single getter with a offset/register parameter instead of
> all these? And use inline functions instead of macros.

Historical artifact to some extent, but I think it makes cleaner code
than trying to read the constants, and in some cases, it's not a
straightforward register read.  In any event, they've been changed to be
static inlines.  In general, I cleaned the code up alot.

> Bye, Peter Korsgaard

Thanks!  An update will be coming around shortly.

Steve
