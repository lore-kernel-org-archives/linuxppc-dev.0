Return-Path: <srs0=h86y=3b=linux.vnet.ibm.com=sukadev@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vqbwL0l5MzDqY4
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Mar 2017 08:22:10 +1100 (AEDT)
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3vqbwL04Kzz8t6y
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Mar 2017 08:22:10 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vqbwK3GCMz9s3s
 for <linuxppc-dev@ozlabs.org>; Sat, 25 Mar 2017 08:22:08 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2OLIeku131039
 for <linuxppc-dev@ozlabs.org>; Fri, 24 Mar 2017 17:22:05 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
 by mx0b-001b2d01.pphosted.com with ESMTP id 29cmcbw8t4-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Fri, 24 Mar 2017 17:22:04 -0400
Received: from localhost
 by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Fri, 24 Mar 2017 17:22:04 -0400
Date: Fri, 24 Mar 2017 14:21:50 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Neuling <michael.neuling@au1.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, stewart@linux.vnet.ibm.com,
 linuxppc-dev@ozlabs.org, apopple@au1.ibm.com, oohall@gmail.com
Subject: Re: [PATCH v3 03/10] VAS: Define vas_init() and vas_exit()
References: <1489721642-5657-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1489721642-5657-4-git-send-email-sukadev@linux.vnet.ibm.com>
 <1490330705.28113.59.camel@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1490330705.28113.59.camel@au1.ibm.com>
Message-Id: <20170324212150.GC8330@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Neuling [michael.neuling@au1.ibm.com] wrote:
> On Thu, 2017-03-16 at 20:33 -0700, Sukadev Bhattiprolu wrote:
> > Implement vas_init() and vas_exit() functions for a new VAS module.
> > This VAS module is essentially a library for other device drivers
> > and kernel users of the NX coprocessors like NX-842 and NX-GZIP.
> >=20
> > Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
> > ---
> > Changelog[v3]:
> > 	- Zero vas_instances memory on allocation
> > 	- [Haren Myneni] Fix description in Kconfig
> > Changelog[v2]:
> > 	- Get HVWC, UWC and window address parameters from device tree.
> > ---
> > =A0MAINTAINERS=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0|=A0=A0=A08 ++-
> > =A0arch/powerpc/include/asm/reg.h=A0=A0|=A0=A0=A01 +
> > =A0drivers/misc/Kconfig=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0|=A0=A0=A01 +
> > =A0drivers/misc/Makefile=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0|=A0=A0=A01 +
> > =A0drivers/misc/vas/Kconfig=A0=A0=A0=A0=A0=A0=A0=A0|=A0=A021 ++++++
> > =A0drivers/misc/vas/Makefile=A0=A0=A0=A0=A0=A0=A0|=A0=A0=A03 +
> > =A0drivers/misc/vas/vas-internal.h |=A0=A0=A03 +
> > =A0drivers/misc/vas/vas-window.c=A0=A0=A0|=A0=A019 +++++
> > =A0drivers/misc/vas/vas.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0| 155
> > ++++++++++++++++++++++++++++++++++++++++
> > =A09 files changed, 210 insertions(+), 2 deletions(-)
> > =A0create mode 100644 drivers/misc/vas/Kconfig
> > =A0create mode 100644 drivers/misc/vas/Makefile
> > =A0create mode 100644 drivers/misc/vas/vas-window.c
> > =A0create mode 100644 drivers/misc/vas/vas.c
> >=20
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 2a910c9..4037252 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -3673,8 +3673,6 @@ F:	arch/powerpc/platforms/powernv/pci-cxl.c
> > =A0F:	drivers/misc/cxl/
> > =A0F:	include/misc/cxl*
> > =A0F:	include/uapi/misc/cxl.h
> > -F:	Documentation/powerpc/cxl.txt
> > -F:	Documentation/ABI/testing/sysfs-class-cxl
>=20
> err?

Yeah, something got messed up here and

>=20
> > =A0CXLFLASH (IBM Coherent Accelerator Processor Interface CAPI Flash) S=
CSI
> > DRIVER
> > =A0M:	Manoj N. Kumar <manoj@linux.vnet.ibm.com>
> > @@ -3686,6 +3684,12 @@ F:	drivers/scsi/cxlflash/
> > =A0F:	include/uapi/scsi/cxlflash_ioctls.h
> > =A0F:	Documentation/powerpc/cxlflash.txt
> > =A0
> > +VAS (IBM Virtual Accelerator Switch) DRIVER
> > +M:	Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
> > +L:	linuxppc-dev@lists.ozlabs.org
> > +S:	Supported
> > +F:	drivers/misc/vas/
> > +
>=20
> This was already added in patch 1.

here. Will fix

>=20
> > =A0STMMAC ETHERNET DRIVER
> > =A0M:	Giuseppe Cavallaro <peppe.cavallaro@st.com>
> > =A0M:	Alexandre Torgue <alexandre.torgue@st.com>
> > diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/=
reg.h
> > index fc879fd..7a45ff7 100644
> > --- a/arch/powerpc/include/asm/reg.h
> > +++ b/arch/powerpc/include/asm/reg.h
> > @@ -1225,6 +1225,7 @@
> > =A0#define PVR_POWER8E	0x004B
> > =A0#define PVR_POWER8NVL	0x004C
> > =A0#define PVR_POWER8	0x004D
> > +#define PVR_POWER9	0x004E
>=20
> Can you send this up separately? =20

Sure.

>=20
> > =A0#define PVR_BE		0x0070
> > =A0#define PVR_PA6T	0x0090
> > =A0
> > diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> > index c290990..97d652e 100644
> > --- a/drivers/misc/Kconfig
> > +++ b/drivers/misc/Kconfig
> > @@ -783,4 +783,5 @@ source "drivers/misc/mic/Kconfig"
> > =A0source "drivers/misc/genwqe/Kconfig"
> > =A0source "drivers/misc/echo/Kconfig"
> > =A0source "drivers/misc/cxl/Kconfig"
> > +source "drivers/misc/vas/Kconfig"
> > =A0endmenu
> > diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> > index 7a3ea89..5201ffd 100644
> > --- a/drivers/misc/Makefile
> > +++ b/drivers/misc/Makefile
> > @@ -53,6 +53,7 @@ obj-$(CONFIG_GENWQE)		+=3D genwqe/
> > =A0obj-$(CONFIG_ECHO)		+=3D echo/
> > =A0obj-$(CONFIG_VEXPRESS_SYSCFG)	+=3D vexpress-syscfg.o
> > =A0obj-$(CONFIG_CXL_BASE)		+=3D cxl/
> > +obj-$(CONFIG_VAS)		+=3D vas/
> > =A0obj-$(CONFIG_PANEL)=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0+=3D panel=
=2Eo
> > =A0
> > =A0lkdtm-$(CONFIG_LKDTM)		+=3D lkdtm_core.o
> > diff --git a/drivers/misc/vas/Kconfig b/drivers/misc/vas/Kconfig
> > new file mode 100644
> > index 0000000..43cedda
> > --- /dev/null
> > +++ b/drivers/misc/vas/Kconfig
> > @@ -0,0 +1,21 @@
> > +#
> > +# IBM Virtual Accelarator Switchboard (VAS) compatible devices
> > +#depends on PPC_POWERNV && PCI_MSI && EEH
> > +#
> > +
> > +config VAS
> > +	tristate "Support for IBM Virtual Accelerator Switchboard (VAS)"
> > +	depends on PPC_POWERNV
> > +	default n
> > +	help
> > +	=A0=A0Select this option to enable driver support for IBM Virtual
> > +	=A0=A0Accelerator Switchboard (VAS).
> > +
> > +	=A0=A0VAS allows accelerators in co processors like NX-842 to be
> > +	=A0=A0directly available to a user process. This driver enables
> > +	=A0=A0userspace programs to access these accelerators via device
> > +	=A0=A0nodes like /dev/crypto/nx-gzip.
>=20
> I though this was kernel only users for now?

Yes, its only kernel for now. Will drop the last sentence.
>=20
> > +
> > +	=A0=A0VAS adapters are found in POWER9 based systems.
> > +
> > +	=A0=A0If unsure, say N.
> > diff --git a/drivers/misc/vas/Makefile b/drivers/misc/vas/Makefile
> > new file mode 100644
> > index 0000000..7dd7139
> > --- /dev/null
> > +++ b/drivers/misc/vas/Makefile
> > @@ -0,0 +1,3 @@
> > +ccflags-y			:=3D $(call cc-disable-warning, unused-const-
> > variable)
> > +ccflags-$(CONFIG_PPC_WERROR)	+=3D -Werror
> > +obj-$(CONFIG_VAS)		+=3D vas.o vas-window.o
> > diff --git a/drivers/misc/vas/vas-internal.h b/drivers/misc/vas/vas-int=
ernal.h
> > index ce48f14..15b62e0 100644
> > --- a/drivers/misc/vas/vas-internal.h
> > +++ b/drivers/misc/vas/vas-internal.h
>=20
> Just call this file vas.h.=20
>=20
> Internal one is here.  Kernel api one lives in include/misc.  User API li=
ves in
> ./include/uapi/misc. =A0
>=20
> eg. CXL does this:
>=20
> % find . -name cxl.h
> ./include/uapi/misc/cxl.h
> ./include/misc/cxl.h
> ./drivers/misc/cxl/cxl.h

Sure, makes sense.

>=20
>=20
> > @@ -389,4 +389,7 @@ struct vas_winctx {
> > =A0	enum vas_notify_after_count notify_after_count;
> > =A0};
> > =A0
> > +extern int vas_initialized;
>=20
> I would probably make this a function.

Ok.

>=20
> > +extern int vas_window_reset(struct vas_instance *vinst, int winid);
> > +extern struct vas_instance *find_vas_instance(int vasid);
> > =A0#endif
> > diff --git a/drivers/misc/vas/vas-window.c b/drivers/misc/vas/vas-windo=
w.c
> > new file mode 100644
> > index 0000000..468f3bf
> > --- /dev/null
> > +++ b/drivers/misc/vas/vas-window.c
> > @@ -0,0 +1,19 @@
> > +/*
> > + * Copyright 2016 IBM Corp.
> > + *
> > + * This program is free software; you can redistribute it and/or
> > + * modify it under the terms of the GNU General Public License
> > + * as published by the Free Software Foundation; either version
> > + * 2 of the License, or (at your option) any later version.
> > + */
> > +
> > +#include <linux/types.h>
> > +#include <linux/mutex.h>
> > +#include <asm/vas.h>
> > +#include "vas-internal.h"
> > +
> > +/* stub for now */
> > +int vas_window_reset(struct vas_instance *vinst, int winid)
> > +{
> > +	return 0;
>=20
> No biggy, but best to return an error if it's just a stub in case sometim=
e tries
> to use it.

Sure.

Thanks

Sukadev
