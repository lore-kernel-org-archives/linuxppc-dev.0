Return-Path: <Alexandre.Bounine@idt.com>
Received: from mxout1.idt.com (mxout1.idt.com [157.165.5.25])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mxout1.idt.com", Issuer "idt.com" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0DE702C010D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Apr 2013 07:13:55 +1000 (EST)
From: "Bounine, Alexandre" <Alexandre.Bounine@idt.com>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: RE: [PATCH 1/3] rapidio: make enumeration/discovery configurable
Date: Thu, 25 Apr 2013 21:00:22 +0000
Message-ID: <8D983423E7EDF846BB3056827B8CC5D14BC26E06@corpmail1.na.ads.idt.com>
References: <1366813919-13766-1-git-send-email-alexandre.bounine@idt.com>
 <1366813919-13766-2-git-send-email-alexandre.bounine@idt.com>
 <20130424143714.4911405aa979bff27887765a@linux-foundation.org>
In-Reply-To: <20130424143714.4911405aa979bff27887765a@linux-foundation.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Micha Nelissen <micha.nelissen@Prodrive.nl>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Andre van Herk <andre.van.herk@Prodrive.nl>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wednesday, April 24, 2013 5:37 PM Andrew Morton wrote:
>=20
> On Wed, 24 Apr 2013 10:31:57 -0400 Alexandre Bounine
> <alexandre.bounine@idt.com> wrote:
>=20
> > Rework to implement RapidIO enumeration/discovery method selection
> > combined with ability to use enumeration/discovery as a kernel module.
> >
> > ...
> >
> > @@ -1421,3 +1295,46 @@ enum_done:
> >  bail:
> >  	return -EBUSY;
> >  }
> > +
> > +struct rio_scan rio_scan_ops =3D {
> > +	.enumerate =3D rio_enum_mport,
> > +	.discover =3D rio_disc_mport,
> > +};
> > +
> > +
> > +#ifdef MODULE
>=20
> Why the `ifdef MODULE'?  The module parameters are still accessible if
> the driver is statically linked and we do want the driver to behave in
> the same way regardless of how it was linked and loaded.

Marked for review.

> > +static bool scan;
> > +module_param(scan, bool, 0);
> > +MODULE_PARM_DESC(scan, "Start RapidIO network enumeration/discovery
> "
> > +			"(default =3D 1)");
> > +
> > +/**
> > + * rio_basic_attach:
> > + *
> > + * When this enumeration/discovery method is loaded as a module this f=
unction
> > + * registers its specific enumeration and discover routines for all av=
ailable
> > + * RapidIO mport devices. The "scan" command line parameter controls a=
bility of
> > + * the module to start RapidIO enumeration/discovery automatically.
> > + *
> > + * Returns 0 for success or -EIO if unable to register itself.
> > + *
> > + * This enumeration/discovery method cannot be unloaded and therefore =
does not
> > + * provide a matching cleanup_module routine.
> > + */
> > +
> > +int __init rio_basic_attach(void)
>=20
> static

My miss. Will fix.

> > +{
> > +	if (rio_register_scan(RIO_MPORT_ANY, &rio_scan_ops))
> > +		return -EIO;
> > +	if (scan)
> > +		rio_init_mports();
> > +	return 0;
> > +}
> > +
> > +module_init(rio_basic_attach);
> > +
> > +MODULE_DESCRIPTION("Basic RapidIO enumeration/discovery");
> > +MODULE_LICENSE("GPL");
> > +
> > +#endif /* MODULE */
> > diff --git a/drivers/rapidio/rio.c b/drivers/rapidio/rio.c
> > index d553b5d..e36628a 100644
> > --- a/drivers/rapidio/rio.c
> > +++ b/drivers/rapidio/rio.c
> > @@ -31,6 +31,9 @@
> >
> >  #include "rio.h"
> >
> > +LIST_HEAD(rio_devices);
>=20
> static?
>=20
> > +DEFINE_SPINLOCK(rio_global_list_lock);
>=20
> static?

These two have been very tempting for me to make them static.
But because a goal was simple code move and they have been visible
from very beginning of RapidIO code, I decided to keep the scope "as is".
While I am against using the device list directly, I am not sure that this
patch is a good place to change the existing scope.

Because keeping them global prompted your comment I will happily make them
static and see if anyone will complain about it.
=20
> > +
> >  static LIST_HEAD(rio_mports);
> >  static unsigned char next_portid;
> >  static DEFINE_SPINLOCK(rio_mmap_lock);
> >
> > ...
> >
> > +/**
> > + * rio_switch_init - Sets switch operations for a particular vendor sw=
itch
> > + * @rdev: RIO device
> > + * @do_enum: Enumeration/Discovery mode flag
> > + *
> > + * Searches the RIO switch ops table for known switch types. If the vi=
d
> > + * and did match a switch table entry, then call switch initialization
> > + * routine to setup switch-specific routines.
> > + */
> > +void rio_switch_init(struct rio_dev *rdev, int do_enum)
> > +{
> > +	struct rio_switch_ops *cur =3D __start_rio_switch_ops;
> > +	struct rio_switch_ops *end =3D __end_rio_switch_ops;
>=20
> huh, I hadn't noticed that RIO has its very own vmlinux section.  How
> peculair.

Yes it is there (since 2.6.15). We will address it at some point later.
At this moment just moving the code from one file to another.
=20
> > +	while (cur < end) {
> > +		if ((cur->vid =3D=3D rdev->vid) && (cur->did =3D=3D rdev->did)) {
> > +			pr_debug("RIO: calling init routine for %s\n",
> > +				 rio_name(rdev));
> > +			cur->init_hook(rdev, do_enum);
> > +			break;
> > +		}
> > +		cur++;
> > +	}
> > +
> > +	if ((cur >=3D end) && (rdev->pef & RIO_PEF_STD_RT)) {
> > +		pr_debug("RIO: adding STD routing ops for %s\n",
> > +			rio_name(rdev));
> > +		rdev->rswitch->add_entry =3D rio_std_route_add_entry;
> > +		rdev->rswitch->get_entry =3D rio_std_route_get_entry;
> > +		rdev->rswitch->clr_table =3D rio_std_route_clr_table;
> > +	}
> > +
> > +	if (!rdev->rswitch->add_entry || !rdev->rswitch->get_entry)
> > +		printk(KERN_ERR "RIO: missing routing ops for %s\n",
> > +		       rio_name(rdev));
> > +}
> > +EXPORT_SYMBOL_GPL(rio_switch_init);
> >
> > ...
> >
> > +int rio_register_scan(int mport_id, struct rio_scan *scan_ops)
> > +{
> > +	struct rio_mport *port;
> > +	int rc =3D -EBUSY;
> > +
> > +	list_for_each_entry(port, &rio_mports, node) {
>=20
> How come the driver has no locking for rio_mports?  If a bugfix isn't
> needed here then a code comment is!

Locking is not needed at this moment, but has to be added sooner or later a=
nyway.
I will add it now to avoid fixing it later.=20
=20
> > +		if (port->id =3D=3D mport_id || mport_id =3D=3D RIO_MPORT_ANY) {
> > +			if (port->nscan && mport_id =3D=3D RIO_MPORT_ANY)
> > +				continue;
> > +			else if (port->nscan)
> > +				break;
> > +
> > +			port->nscan =3D scan_ops;
> > +			rc =3D 0;
> > +
> > +			if (mport_id !=3D RIO_MPORT_ANY)
> > +				break;
> > +		}
> > +	}
> > +
> > +	return rc;
> > +}
> >
> > ...
