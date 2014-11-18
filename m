Return-Path: <liviu.dudau@arm.com>
Received: from service87.mimecast.com (service87.mimecast.com [91.220.42.44])
 by lists.ozlabs.org (Postfix) with ESMTP id 924CF1A0620
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Nov 2014 02:42:47 +1100 (AEDT)
Date: Tue, 18 Nov 2014 15:42:43 +0000
From: Liviu Dudau <Liviu.Dudau@arm.com>
To: Yijing Wang <wangyijing@huawei.com>
Subject: Re: [RFC PATCH 08/16] PCI: Introduce pci_scan_host_bridge() and
 pci_host_info
Message-ID: <20141118154243.GM12037@e106497-lin.cambridge.arm.com>
References: <1416219710-26088-1-git-send-email-wangyijing@huawei.com>
 <1416219710-26088-9-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
In-Reply-To: <1416219710-26088-9-git-send-email-wangyijing@huawei.com>
Content-Type: text/plain; charset=UTF-8
Cc: Liviu Dudau <liviu@dudau.co.uk>, Tony Luck <tony.luck@intel.com>,
 Russell King <linux@arm.linux.org.uk>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "x86@kernel.org" <x86@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "huxinwei@huawei.com" <huxinwei@huawei.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Yijing Wang <wangyijing0307@gmail.com>,
 "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Wuyun <wuyun.wu@huawei.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Nov 17, 2014 at 10:21:42AM +0000, Yijing Wang wrote:
> From: Yijing Wang <wangyijing0307@gmail.com>
>=20
> Now pci_host_bridge has been ripped out from pci root
> bus creation. Currently pci_scan_root_bus() lacks
> scalability, so platform host drivers have no proper
> way to configure pci_host_bridge. E.g we should assign
> msi_controller to pci_host_bridge, add argument for
> pci_scan_root_bus() is not a good idea, it has already
> five, so introudce struct pci_host_info to make
> pci scan interfaces more scalable. Because almost
> all host drivers need to configure host resources,
> so we put .init_res() in it first, and add other
> hooks when need.
>=20
> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
> ---
>  drivers/pci/host-bridge.c |   27 +++++++++-------
>  drivers/pci/probe.c       |   73 +++++++++++++++++++++++++++++++++++++++=
+++--
>  include/linux/pci.h       |   20 ++++++++++++-
>  3 files changed, 103 insertions(+), 17 deletions(-)
>=20
> diff --git a/drivers/pci/host-bridge.c b/drivers/pci/host-bridge.c
> index e31604f..49b6c21 100644
> --- a/drivers/pci/host-bridge.c
> +++ b/drivers/pci/host-bridge.c
> @@ -8,9 +8,6 @@
> =20
>  #include "pci.h"
> =20
> -LIST_HEAD(pci_host_bridge_list);
> -DECLARE_RWSEM(pci_host_bridge_sem);
> -
>  static struct resource busn_resource =3D {
>  =09.name=09=3D "PCI busn",
>  =09.start=09=3D 0,
> @@ -18,6 +15,9 @@ static struct resource busn_resource =3D {
>  =09.flags=09=3D IORESOURCE_BUS,
>  };
> =20
> +LIST_HEAD(pci_host_bridge_list);
> +DECLARE_RWSEM(pci_host_bridge_sem);
> +
>  static void pci_release_host_bridge_dev(struct device *dev)
>  {
>  =09struct pci_host_bridge *bridge =3D to_pci_host_bridge(dev);
> @@ -29,14 +29,12 @@ static void pci_release_host_bridge_dev(struct device=
 *dev)
>  }
> =20
>  struct pci_host_bridge *pci_create_host_bridge(
> -=09=09struct device *parent, u32 db,=20
> -=09=09struct pci_ops *ops, void *sysdata,=20
> -=09=09struct list_head *resources)
> +=09=09struct device *parent, u32 db, struct pci_ops *ops,=20
> +=09=09struct pci_host_info *info)
>  {
>  =09int error;
>  =09struct pci_bus *b;
>  =09struct pci_host_bridge *host, *h;
> -=09struct pci_host_bridge_window *window, *n;
> =20
>  =09down_read(&pci_host_bridge_sem);
>  =09list_for_each_entry(h, &pci_host_bridge_list, list) {
> @@ -53,7 +51,7 @@ struct pci_host_bridge *pci_create_host_bridge(
>  =09if (!host)
>  =09=09return NULL;
> =20
> -=09host->sysdata =3D sysdata;
> +=09host->sysdata =3D info->arg;
>  =09host->busnum =3D PCI_BUSNUM(db);
>  =09host->domain =3D PCI_DOMAIN(db);
>  =09host->ops =3D ops;
> @@ -63,18 +61,23 @@ struct pci_host_bridge *pci_create_host_bridge(
> =20
>  =09/* this is hack, just for build, will be removed later*/

Why do you need this hack? Just for calling pci_domain_nr() ?

>  =09b =3D kzalloc(sizeof(*b), GFP_KERNEL);
> -=09b->sysdata =3D sysdata;
> +=09b->sysdata =3D host->sysdata;
>  =09pci_bus_assign_domain_nr(b, parent);
>  =09host->domain =3D pci_domain_nr(b);
> +=09kfree(b);
> =20
> -=09if (!resources) {
> +=09if (info->res_type =3D=3D PCI_HOST_RES_DEFAULT) {
>  =09=09/* Use default IO/MEM/BUS resources*/
>  =09=09pci_add_resource(&host->windows, &ioport_resource);
>  =09=09pci_add_resource(&host->windows, &iomem_resource);
>  =09=09pci_add_resource(&host->windows, &busn_resource);
>  =09} else {
> -=09=09list_for_each_entry_safe(window, n, resources, list)
> -=09=09=09list_move_tail(&window->list, &host->windows);
> +=09=09if (!info->init_res || info->init_res(host, info)) {
> +=09=09=09pr_err("pci host %04x:%02x init resources fail\n",
> +=09=09=09=09=09host->domain, host->busnum);
> +=09=09=09kfree(host);
> +=09=09=09return NULL;
> +=09=09}
>  =09}
> =20
>  =09dev_set_name(&host->dev, "pci%04x:%02x", host->domain,=20
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index d472da4..42158fd 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1863,6 +1863,21 @@ void __weak pcibios_remove_bus(struct pci_bus *bus=
)
>  {
>  }
> =20
> +static int pci_default_init_res(struct pci_host_bridge *host,
> +=09=09struct pci_host_info *info)
> +{
> +=09struct pci_host_bridge_window *window, *n;
> +
> +=09if (info->res_type !=3D PCI_HOST_RES_DEFAULT)=20
> +=09=09list_for_each_entry_safe(window, n, info->resources,
> +=09=09=09=09list)
> +=09=09=09list_move_tail(&window->list, &host->windows);
> +=09else
> +=09=09info->res_type =3D PCI_HOST_RES_DEFAULT;

I'm confused about this assignment. Isn't this a nop as the else part
means info->res_type *is* PCI_HOST_RES_DEFAULT?

> +
> +=09return 0;
> +}
> +
>  struct pci_bus *__pci_create_root_bus(struct pci_host_bridge *bridge)
>  {
>  =09int error;
> @@ -1949,13 +1964,17 @@ err_out:
>  =09return NULL;
>  }
> =20
> -struct pci_bus *pci_create_root_bus(struct device *parent, u32 bus,
> +struct pci_bus *pci_create_root_bus(struct device *parent, u32 db,
>  =09=09struct pci_ops *ops, void *sysdata, struct list_head *resources)
>  {
>  =09struct pci_host_bridge *host;
> +=09struct pci_host_info info;
> +=09
> +=09info.arg=3D sysdata;
> +=09info.resources =3D resources;
> +=09info.init_res =3D pci_default_init_res;
> =20
> -=09host =3D pci_create_host_bridge(parent, bus, ops,=20
> -=09=09=09sysdata ,resources);
> +=09host =3D pci_create_host_bridge(parent, db, ops, &info);
>  =09if (!host)
>  =09=09return NULL;
> =20
> @@ -2038,8 +2057,13 @@ struct pci_bus *pci_scan_root_bus(struct device *p=
arent, u32 db,
>  =09bool found =3D false;
>  =09struct pci_host_bridge *host;
>  =09int max;
> +=09struct pci_host_info info;
> +=09
> +=09info.arg =3D sysdata;
> +=09info.resources =3D resources;
> +=09info.init_res =3D pci_default_init_res;

I have mixed feelings about this patch. While it is heading in the right di=
rection
of moving pci_host_bridge relevant information towards the right user, I do=
n't think
you picked up the right set to move. The resource list is going to be copie=
d into
internal pci_host_bridge list anyway, keeping another copy is not helpful *=
and*
you have increased the code size.

I think for now we should aim to get the *missing* data into pci_host_bridg=
e: MSI
controllers and PCI domain/segment. Then we can do more cleanup.

> =20
> -=09host =3D pci_create_host_bridge(parent, db, ops, sysdata, resources);
> +=09host =3D pci_create_host_bridge(parent, db, ops, &info);
>  =09if (!host)
>  =09=09return NULL;
> =20
> @@ -2070,6 +2094,47 @@ struct pci_bus *pci_scan_root_bus(struct device *p=
arent, u32 db,
>  }
>  EXPORT_SYMBOL(pci_scan_root_bus);
> =20
> +struct pci_host_bridge *pci_scan_host_bridge(
> +=09=09struct device *parent, u32 db, struct pci_ops *ops,
> +=09=09struct pci_host_info *info)
> +{
> +=09struct pci_host_bridge_window *window;
> +=09bool found =3D false;
> +=09struct pci_host_bridge *host;
> +=09int max;
> +
> +=09host =3D pci_create_host_bridge(parent, db, ops, info);
> +=09if (!host)
> +=09=09return NULL;
> +
> +=09list_for_each_entry(window, &host->windows, list)
> +=09=09if (window->res->flags & IORESOURCE_BUS) {
> +=09=09=09found =3D true;
> +=09=09=09break;
> +=09=09}
> +
> +=09host->bus =3D __pci_create_root_bus(host);
> +=09if (!host->bus) {
> +=09=09pci_free_host_bridge(host);
> +=09=09return NULL;
> +=09}
> +
> +=09if (!found) {
> +=09=09dev_info(&host->bus->dev,
> +=09=09 "No busn resource found for root bus, will use [bus %02x-ff]\n",
> +=09=09=09host->busnum);
> +=09=09pci_bus_insert_busn_res(host->bus, host->busnum, 255);
> +=09}
> +
> +=09max =3D pci_scan_child_bus(host->bus);
> +=09if (!found)
> +=09=09pci_bus_update_busn_res_end(host->bus, max);
> +
> +=09return host;
> +
> +}
> +EXPORT_SYMBOL(pci_scan_host_bridge);
> +
>  /**
>   * pci_rescan_bus_bridge_resize - scan a PCI bus for devices.
>   * @bridge: PCI bridge for the bus to scan
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index daa7f40..a51f5f5 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -412,6 +412,21 @@ struct pci_host_bridge {
>  =09void *release_data;
>  };
> =20
> +struct pci_host_info {
> +=09u8 res_type;
> +=09void *arg;
> +=09struct list_head *resources; /*just for build, will clean up later */
> +=09int (*init_res)(struct pci_host_bridge *host,=20
> +=09=09=09struct pci_host_info *info);
> +};
> +
> +static inline void init_pci_host_info(struct pci_host_info *info)
> +{
> +=09memset(info, 0 , sizeof(*info));
> +}

Where is this used?

> +
> +#define PCI_HOST_RES_DEFAULT=090x2
> +

Magic number?

Best regards,
Liviu

>  #define=09to_pci_host_bridge(n) container_of(n, struct pci_host_bridge, =
dev)
>  void pci_set_host_bridge_release(struct pci_host_bridge *bridge,
>  =09=09     void (*release_fn)(struct pci_host_bridge *),
> @@ -420,7 +435,7 @@ void pci_set_host_bridge_release(struct pci_host_brid=
ge *bridge,
>  int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge);
>  struct pci_host_bridge *pci_create_host_bridge(
>  =09=09struct device *parent, u32 db, struct pci_ops *ops,=20
> -=09=09void *sys, struct list_head *resources);
> +=09=09struct pci_host_info *info);
>  /*
>   * The first PCI_BRIDGE_RESOURCE_NUM PCI bus resources (those that corre=
spond
>   * to P2P or CardBus bridge windows) go in a table.  Additional ones (fo=
r
> @@ -785,6 +800,9 @@ void pci_bus_release_busn_res(struct pci_bus *b);
>  struct pci_bus *pci_scan_root_bus(struct device *parent, u32 bus,
>  =09=09=09=09=09     struct pci_ops *ops, void *sysdata,
>  =09=09=09=09=09     struct list_head *resources);
> +struct pci_host_bridge *pci_scan_host_bridge(struct device *parent,
> +=09=09u32 db, struct pci_ops *ops,
> +=09=09struct pci_host_info *info);
>  struct pci_bus *pci_add_new_bus(struct pci_bus *parent, struct pci_dev *=
dev,
>  =09=09=09=09int busnr);
>  void pcie_update_link_speed(struct pci_bus *bus, u16 link_status);
> --=20
> 1.7.1
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    =C2=AF\_(=E3=83=84)_/=C2=AF
