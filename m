Return-Path: <srs0=zpq8=3b=au1.ibm.com=michael.neuling@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vq9ns0MCjzDq95
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Mar 2017 15:45:05 +1100 (AEDT)
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3vq9nr6vzxz8xD1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Mar 2017 15:45:04 +1100 (AEDT)
Message-ID: <1490330705.28113.59.camel@au1.ibm.com>
Subject: Re: [PATCH v3 03/10] VAS: Define vas_init() and vas_exit()
From: Michael Neuling <michael.neuling@au1.ibm.com>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>, Michael Ellerman
 <mpe@ellerman.id.au>
Cc: stewart@linux.vnet.ibm.com, linuxppc-dev@ozlabs.org,
 apopple@au1.ibm.com,  oohall@gmail.com
Date: Fri, 24 Mar 2017 15:45:05 +1100
In-Reply-To: <1489721642-5657-4-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1489721642-5657-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1489721642-5657-4-git-send-email-sukadev@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-03-16 at 20:33 -0700, Sukadev Bhattiprolu wrote:
> Implement vas_init() and vas_exit() functions for a new VAS module.
> This VAS module is essentially a library for other device drivers
> and kernel users of the NX coprocessors like NX-842 and NX-GZIP.
>=20
> Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
> ---
> Changelog[v3]:
> 	- Zero vas_instances memory on allocation
> 	- [Haren Myneni] Fix description in Kconfig
> Changelog[v2]:
> 	- Get HVWC, UWC and window address parameters from device tree.
> ---
> =C2=A0MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=
=C2=A0=C2=A0=C2=A08 ++-
> =C2=A0arch/powerpc/include/asm/reg.h=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A01 +
> =C2=A0drivers/misc/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A01 +
> =C2=A0drivers/misc/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A01 +
> =C2=A0drivers/misc/vas/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0|=C2=A0=C2=A021 ++++++
> =C2=A0drivers/misc/vas/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
|=C2=A0=C2=A0=C2=A03 +
> =C2=A0drivers/misc/vas/vas-internal.h |=C2=A0=C2=A0=C2=A03 +
> =C2=A0drivers/misc/vas/vas-window.c=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A019 ++++=
+
> =C2=A0drivers/misc/vas/vas.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0| 155
> ++++++++++++++++++++++++++++++++++++++++
> =C2=A09 files changed, 210 insertions(+), 2 deletions(-)
> =C2=A0create mode 100644 drivers/misc/vas/Kconfig
> =C2=A0create mode 100644 drivers/misc/vas/Makefile
> =C2=A0create mode 100644 drivers/misc/vas/vas-window.c
> =C2=A0create mode 100644 drivers/misc/vas/vas.c
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2a910c9..4037252 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3673,8 +3673,6 @@ F:	arch/powerpc/platforms/powernv/pci-cxl.c
> =C2=A0F:	drivers/misc/cxl/
> =C2=A0F:	include/misc/cxl*
> =C2=A0F:	include/uapi/misc/cxl.h
> -F:	Documentation/powerpc/cxl.txt
> -F:	Documentation/ABI/testing/sysfs-class-cxl

err?

> =C2=A0CXLFLASH (IBM Coherent Accelerator Processor Interface CAPI Flash) =
SCSI
> DRIVER
> =C2=A0M:	Manoj N. Kumar <manoj@linux.vnet.ibm.com>
> @@ -3686,6 +3684,12 @@ F:	drivers/scsi/cxlflash/
> =C2=A0F:	include/uapi/scsi/cxlflash_ioctls.h
> =C2=A0F:	Documentation/powerpc/cxlflash.txt
> =C2=A0
> +VAS (IBM Virtual Accelerator Switch) DRIVER
> +M:	Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
> +L:	linuxppc-dev@lists.ozlabs.org
> +S:	Supported
> +F:	drivers/misc/vas/
> +

This was already added in patch 1.

> =C2=A0STMMAC ETHERNET DRIVER
> =C2=A0M:	Giuseppe Cavallaro <peppe.cavallaro@st.com>
> =C2=A0M:	Alexandre Torgue <alexandre.torgue@st.com>
> diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/re=
g.h
> index fc879fd..7a45ff7 100644
> --- a/arch/powerpc/include/asm/reg.h
> +++ b/arch/powerpc/include/asm/reg.h
> @@ -1225,6 +1225,7 @@
> =C2=A0#define PVR_POWER8E	0x004B
> =C2=A0#define PVR_POWER8NVL	0x004C
> =C2=A0#define PVR_POWER8	0x004D
> +#define PVR_POWER9	0x004E

Can you send this up separately? =20

> =C2=A0#define PVR_BE		0x0070
> =C2=A0#define PVR_PA6T	0x0090
> =C2=A0
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index c290990..97d652e 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -783,4 +783,5 @@ source "drivers/misc/mic/Kconfig"
> =C2=A0source "drivers/misc/genwqe/Kconfig"
> =C2=A0source "drivers/misc/echo/Kconfig"
> =C2=A0source "drivers/misc/cxl/Kconfig"
> +source "drivers/misc/vas/Kconfig"
> =C2=A0endmenu
> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> index 7a3ea89..5201ffd 100644
> --- a/drivers/misc/Makefile
> +++ b/drivers/misc/Makefile
> @@ -53,6 +53,7 @@ obj-$(CONFIG_GENWQE)		+=3D genwqe/
> =C2=A0obj-$(CONFIG_ECHO)		+=3D echo/
> =C2=A0obj-$(CONFIG_VEXPRESS_SYSCFG)	+=3D vexpress-syscfg.o
> =C2=A0obj-$(CONFIG_CXL_BASE)		+=3D cxl/
> +obj-$(CONFIG_VAS)		+=3D vas/
> =C2=A0obj-$(CONFIG_PANEL)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0+=3D panel.o
> =C2=A0
> =C2=A0lkdtm-$(CONFIG_LKDTM)		+=3D lkdtm_core.o
> diff --git a/drivers/misc/vas/Kconfig b/drivers/misc/vas/Kconfig
> new file mode 100644
> index 0000000..43cedda
> --- /dev/null
> +++ b/drivers/misc/vas/Kconfig
> @@ -0,0 +1,21 @@
> +#
> +# IBM Virtual Accelarator Switchboard (VAS) compatible devices
> +#depends on PPC_POWERNV && PCI_MSI && EEH
> +#
> +
> +config VAS
> +	tristate "Support for IBM Virtual Accelerator Switchboard (VAS)"
> +	depends on PPC_POWERNV
> +	default n
> +	help
> +	=C2=A0=C2=A0Select this option to enable driver support for IBM Virtual
> +	=C2=A0=C2=A0Accelerator Switchboard (VAS).
> +
> +	=C2=A0=C2=A0VAS allows accelerators in co processors like NX-842 to be
> +	=C2=A0=C2=A0directly available to a user process. This driver enables
> +	=C2=A0=C2=A0userspace programs to access these accelerators via device
> +	=C2=A0=C2=A0nodes like /dev/crypto/nx-gzip.

I though this was kernel only users for now?

> +
> +	=C2=A0=C2=A0VAS adapters are found in POWER9 based systems.
> +
> +	=C2=A0=C2=A0If unsure, say N.
> diff --git a/drivers/misc/vas/Makefile b/drivers/misc/vas/Makefile
> new file mode 100644
> index 0000000..7dd7139
> --- /dev/null
> +++ b/drivers/misc/vas/Makefile
> @@ -0,0 +1,3 @@
> +ccflags-y			:=3D $(call cc-disable-warning, unused-const-
> variable)
> +ccflags-$(CONFIG_PPC_WERROR)	+=3D -Werror
> +obj-$(CONFIG_VAS)		+=3D vas.o vas-window.o
> diff --git a/drivers/misc/vas/vas-internal.h b/drivers/misc/vas/vas-inter=
nal.h
> index ce48f14..15b62e0 100644
> --- a/drivers/misc/vas/vas-internal.h
> +++ b/drivers/misc/vas/vas-internal.h

Just call this file vas.h.=20

Internal one is here.  Kernel api one lives in include/misc.  User API live=
s in
./include/uapi/misc. =C2=A0

eg. CXL does this:

% find . -name cxl.h
./include/uapi/misc/cxl.h
./include/misc/cxl.h
./drivers/misc/cxl/cxl.h


> @@ -389,4 +389,7 @@ struct vas_winctx {
> =C2=A0	enum vas_notify_after_count notify_after_count;
> =C2=A0};
> =C2=A0
> +extern int vas_initialized;

I would probably make this a function.

> +extern int vas_window_reset(struct vas_instance *vinst, int winid);
> +extern struct vas_instance *find_vas_instance(int vasid);
> =C2=A0#endif
> diff --git a/drivers/misc/vas/vas-window.c b/drivers/misc/vas/vas-window.=
c
> new file mode 100644
> index 0000000..468f3bf
> --- /dev/null
> +++ b/drivers/misc/vas/vas-window.c
> @@ -0,0 +1,19 @@
> +/*
> + * Copyright 2016 IBM Corp.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version
> + * 2 of the License, or (at your option) any later version.
> + */
> +
> +#include <linux/types.h>
> +#include <linux/mutex.h>
> +#include <asm/vas.h>
> +#include "vas-internal.h"
> +
> +/* stub for now */
> +int vas_window_reset(struct vas_instance *vinst, int winid)
> +{
> +	return 0;

No biggy, but best to return an error if it's just a stub in case sometime =
tries
to use it.

> +}
> diff --git a/drivers/misc/vas/vas.c b/drivers/misc/vas/vas.c
> new file mode 100644
> index 0000000..75e55f9
> --- /dev/null
> +++ b/drivers/misc/vas/vas.c
> @@ -0,0 +1,155 @@
> +/*
> + * Copyright 2016 IBM Corp.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version
> + * 2 of the License, or (at your option) any later version.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/export.h>
> +#include <linux/types.h>
> +#include <linux/slab.h>
> +#include <linux/of.h>
> +#include <asm/vas.h>
> +#include "vas-internal.h"
> +
> +int vas_initialized;
> +int vas_num_instances;
> +struct vas_instance *vas_instances;
> +
> +static void init_vas_chip(struct vas_instance *vinst)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < VAS_MAX_WINDOWS_PER_CHIP; i++)
> +		vas_window_reset(vinst, i);
> +}
> +
> +static int init_vas_instance(struct device_node *dn,
> +				struct vas_instance *vinst)
> +{
> +	int rc;
> +	const __be32 *p;
> +
> +	ida_init(&vinst->ida);
> +	mutex_init(&vinst->mutex);
> +
> +	p =3D of_get_property(dn, "vas-id", NULL);
> +	if (!p) {
> +		pr_err("VAS: NULL vas-id? %p\n", p);
> +		return -ENODEV;
> +	}
> +
> +	vinst->vas_id =3D of_read_number(p, 1);
> +
> +	rc =3D of_property_read_u64(dn, "hvwc-bar-start", &vinst-
> >hvwc_bar_start);
> +	if (rc)
> +		return rc;
> +
> +	rc =3D of_property_read_u64(dn, "hvwc-bar-size", &vinst->hvwc_bar_len);
> +	if (rc)
> +		return rc;
> +
> +	rc =3D of_property_read_u64(dn, "uwc-bar-start", &vinst-
> >uwc_bar_start);
> +	if (rc)
> +		return rc;
> +
> +	rc =3D of_property_read_u64(dn, "uwc-bar-size", &vinst->uwc_bar_len);
> +	if (rc)
> +		return rc;
> +
> +	rc =3D of_property_read_u64(dn, "window-base", &vinst->win_base_addr);
> +	if (rc)
> +		return rc;
> +
> +	rc =3D of_property_read_u64(dn, "window-shift", &vinst->win_id_shift);
> +	if (rc)
> +		return rc;
> +
> +	init_vas_chip(vinst);
> +
> +	return 0;
> +}
> +
> +/*
> + * Although this is read/used multiple times, it is written to only
> + * during initialization.
> + */
> +struct vas_instance *find_vas_instance(int vasid)
> +{
> +	int i;
> +	struct vas_instance *vinst;
> +
> +	for (i =3D 0; i < vas_num_instances; i++) {
> +		vinst =3D &vas_instances[i];
> +		if (vinst->vas_id =3D=3D vasid)
> +			return vinst;
> +	}
> +	pr_err("VAS instance for vas-id %d not found\n", vasid);
> +	WARN_ON_ONCE(1);
> +	return NULL;
> +}
> +
> +
> +int vas_init(void)
> +{
> +	int rc;
> +	struct device_node *dn;
> +	struct vas_instance *vinst;
> +
> +	if (!pvr_version_is(PVR_POWER9))
> +		return -ENODEV;
> +
> +	vas_num_instances =3D 0;
> +	for_each_node_by_name(dn, "vas")
> +		vas_num_instances++;
> +
> +	if (!vas_num_instances)
> +		return -ENODEV;
> +
> +	vas_instances =3D kcalloc(vas_num_instances, sizeof(*vinst),
> GFP_KERNEL);
> +	if (!vas_instances)
> +		return -ENOMEM;
> +
> +	vinst =3D &vas_instances[0];
> +	for_each_node_by_name(dn, "vas") {
> +		rc =3D init_vas_instance(dn, vinst);
> +		if (rc) {
> +			pr_err("Error %d initializing VAS instance %ld\n",
> rc,
> +					(vinst-&vas_instances[0]));
> +			goto cleanup;
> +		}
> +		vinst++;
> +	}
> +
> +	rc =3D -ENODEV;
> +	if (vinst =3D=3D &vas_instances[0]) {
> +		/* Should not happen as we saw some above. */
> +		pr_err("VAS: Did not find any VAS DT nodes now!\n");
> +		goto cleanup;
> +	}
> +
> +	pr_devel("VAS: Initialized %d instances\n", vas_num_instances);
> +	vas_initialized =3D 1;
> +
> +	return 0;
> +
> +cleanup:
> +	kfree(vas_instances);
> +	return rc;
> +}
> +
> +void vas_exit(void)
> +{
> +	vas_initialized =3D 0;
> +	kfree(vas_instances);
> +}
> +
> +module_init(vas_init);
> +module_exit(vas_exit);
> +MODULE_DESCRIPTION("IBM Virtual Accelerator Switchboard");
> +MODULE_AUTHOR("Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>");
> +MODULE_LICENSE("GPL");
