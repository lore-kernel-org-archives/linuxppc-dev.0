Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qR2gW1W9SzDq5s
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Mar 2016 09:13:43 +1100 (AEDT)
Received: from localhost.localdomain (localhost [127.0.0.1])
 by ozlabs.org (Postfix) with ESMTP id 3qR2gW0Q87z9sBM
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Mar 2016 09:13:43 +1100 (AEDT)
Message-ID: <1458252822.6622.30.camel@neuling.org>
Subject: Re: [PATCH] cxl: Don't fail initialization if PSL timebase can't be
 synced
From: Michael Neuling <mikey@neuling.org>
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>, imunsie@au1.ibm.com,
 linuxppc-dev@lists.ozlabs.org
Date: Fri, 18 Mar 2016 09:13:42 +1100
In-Reply-To: <1458247932-14100-1-git-send-email-fbarrat@linux.vnet.ibm.com>
References: <1458247932-14100-1-git-send-email-fbarrat@linux.vnet.ibm.com>
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

> [PATCH] cxl: Don't fail initialization if PSL timebase can't be
synced

Nice double negative.. How about:

  cxl: Allow initialization on timebase sync failures

> Failure to synchronize the PSL timebase currently prevents the
> initialization of the cxl card, thus rendering the card useless. This
> is too extreme for a feature which is rarely used, if at all.

I'd probably mention that no hardware AFUs or software currently use
timebase at all.

> This patch still tries to synchronize the PSL timebase when the card
> is initialized, but doesn't fail if it can't. Instead, it reports a
> status via /sys.

"...doesn't fail if it can't".. triple negative, awesome! :-P

Other than these minor nits..

Acked-by: Michael Neuling <mikey@neuling.org>

> Signed-off-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
> ---
>=20
> Patch will need a small update for next, due to the powerVM patchset.
Will send that as soon as this one is agreed upon.
>=20
>  Documentation/ABI/testing/sysfs-class-cxl |  8 ++++++++
>  drivers/misc/cxl/cxl.h                    |  1 +
>  drivers/misc/cxl/pci.c                    | 21 ++++++++++++---------
>  drivers/misc/cxl/sysfs.c                  | 10 ++++++++++
>  4 files changed, 31 insertions(+), 9 deletions(-)
>=20
> diff --git a/Documentation/ABI/testing/sysfs-class-cxl
b/Documentation/ABI/testing/sysfs-class-cxl
> index b07e86d..ba33cdf 100644
> --- a/Documentation/ABI/testing/sysfs-class-cxl
> +++ b/Documentation/ABI/testing/sysfs-class-cxl
> @@ -233,3 +233,11 @@ Description:> 	  read/write
>   	  	  0 =3D don't trust, the image may be different
(default)
>   	  	  1 =3D trust that the image will not change.
>  Users:> 	  	https://github.com/ibm-capi/libcxl
> +
> +What:           /sys/class/cxl/<card>/psl_timebase_synced
> +Date:           March 2016
> +Contact:        linuxppc-dev@lists.ozlabs.org
> +Description:    read only
> +                Returns 1 if the psl timebase register is
synchronized
> +                with the core timebase register, 0 otherwise.

Thinking forward, for libcxl we'll want a cxl_tb_synced() call which
will need to return true, false and unknown.  "unknown" is when this
file doesn't exists, when a new libcxl is run on an older kernel.

Do we want to same interface here?  Probably not, but something to
consider.

> +Users:          https://github.com/ibm-capi/libcxl
> \ No newline at end of file
> diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
> index a521bc7..baa5052 100644
> --- a/drivers/misc/cxl/cxl.h
> +++ b/drivers/misc/cxl/cxl.h
> @@ -517,6 +517,7 @@ struct cxl {
>    	  bool perst_loads_image;
>    	  bool perst_select_user;
>    	  bool perst_same_image;
> +  	  bool psl_timebase_synced;
>  };
> =20
>  int cxl_alloc_one_irq(struct cxl *adapter);
> diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
> index 0c6c17a1..625df03 100644
> --- a/drivers/misc/cxl/pci.c
> +++ b/drivers/misc/cxl/pci.c
> @@ -374,22 +374,24 @@ static int
init_implementation_adapter_regs(struct cxl *adapter, struct pci_dev
>  #define TBSYNC_CNT(n) (((u64)n & 0x7) << (63-6))
>  #define _2048_250MHZ_CYCLES 1
> =20
> -static int cxl_setup_psl_timebase(struct cxl *adapter, struct
pci_dev *dev)
> +static void cxl_setup_psl_timebase(struct cxl *adapter, struct
pci_dev *dev)
>  {
>    	  u64 psl_tb;
>    	  int delta;
>    	  unsigned int retry =3D 0;
>    	  struct device_node *np;
> =20
> +  	  adapter->psl_timebase_synced =3D false;
> +
>    	  if (!(np =3D pnv_pci_get_phb_node(dev)))
> -  	  	  return -ENODEV;
> +  	  	  return;
> =20
>    	  /* Do not fail when CAPP timebase sync is not supported
by OPAL */
>    	  of_node_get(np);
>    	  if (! of_get_property(np, "ibm,capp-timebase-sync",
NULL)) {
>    	  	  of_node_put(np);
> -  	  	  pr_err("PSL: Timebase sync: OPAL support
missing\n");
> -  	  	  return 0;
> +  	  	  dev_info(&dev->dev, "PSL timebase inactive:
OPAL support missing\n");
> +  	  	  return;
>    	  }
>    	  of_node_put(np);
> =20
> @@ -408,8 +410,8 @@ static int cxl_setup_psl_timebase(struct cxl
*adapter, struct pci_dev *dev)
>    	  do {
>    	  	  msleep(1);
>    	  	  if (retry++ > 5) {
> -  	  	  	  pr_err("PSL: Timebase sync: giving
up!\n");
> -  	  	  	  return -EIO;
> +  	  	  	  dev_info(&dev->dev, "PSL timebase
can't synchronize\n");
> +  	  	  	  return;
>    	  	  }
>    	  	  psl_tb =3D cxl_p1_read(adapter,
CXL_PSL_Timebase);
>    	  	  delta =3D mftb() - psl_tb;
> @@ -417,7 +419,8 @@ static int cxl_setup_psl_timebase(struct cxl
*adapter, struct pci_dev *dev)
>    	  	  	  delta =3D -delta;
>    	  } while (tb_to_ns(delta) > 16000);
> =20
> -  	  return 0;
> +  	  adapter->psl_timebase_synced =3D true;
> +  	  return;
>  }
> =20
>  static int init_implementation_afu_regs(struct cxl_afu *afu)
> @@ -1189,8 +1192,8 @@ static int cxl_configure_adapter(struct cxl
*adapter, struct pci_dev *dev)
>    	  if ((rc =3D pnv_phb_to_cxl_mode(dev,
OPAL_PHB_CAPI_MODE_SNOOP_ON)))
>    	  	  goto err;
> =20
> -  	  if ((rc =3D cxl_setup_psl_timebase(adapter, dev)))
> -  	  	  goto err;
> +  	  /* psl timebase not syncing shouldn't prevent device
init */

/* Adapter init is not dependant on timebase sync */

> +  	  cxl_setup_psl_timebase(adapter, dev);
> =20
>    	  if ((rc =3D cxl_register_psl_err_irq(adapter)))
>    	  	  goto err;
> diff --git a/drivers/misc/cxl/sysfs.c b/drivers/misc/cxl/sysfs.c
> index 02006f71..b4bb9b2 100644
> --- a/drivers/misc/cxl/sysfs.c
> +++ b/drivers/misc/cxl/sysfs.c
> @@ -57,6 +57,15 @@ static ssize_t image_loaded_show(struct device
*device,
>    	  return scnprintf(buf, PAGE_SIZE, "factory\n");
>  }
> =20
> +static ssize_t psl_timebase_synced_show(struct device *device,
> +  	  	  	  	  	  struct
device_attribute *attr,
> +  	  	  	  	  	  char *buf)
> +{
> +  	  struct cxl *adapter =3D to_cxl_adapter(device);
> +
> +  	  return scnprintf(buf, PAGE_SIZE, "%i\n", adapter
->psl_timebase_synced);
> +}
> +
>  static ssize_t reset_adapter_store(struct device *device,
>    	  	  	  	     struct device_attribute
*attr,
>    	  	  	  	     const char *buf, size_t
count)
> @@ -142,6 +151,7 @@ static struct device_attribute adapter_attrs[] =3D
{
>    	  __ATTR_RO(psl_revision),
>    	  __ATTR_RO(base_image),
>    	  __ATTR_RO(image_loaded),
> +  	  __ATTR_RO(psl_timebase_synced),
>    	  __ATTR_RW(load_image_on_perst),
>    	  __ATTR_RW(perst_reloads_same_image),
>    	  __ATTR(reset, S_IWUSR, NULL, reset_adapter_store),
