Return-Path: <bhelgaas@google.com>
Received: from mail-lb0-f170.google.com (mail-lb0-f170.google.com
 [209.85.217.170])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 022581007D4
 for <linuxppc-dev@ozlabs.org>; Thu, 28 Jun 2012 04:15:42 +1000 (EST)
Received: by lbgc1 with SMTP id c1so1769250lbg.15
 for <linuxppc-dev@ozlabs.org>; Wed, 27 Jun 2012 11:15:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1340808525-24996-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1340808525-24996-1-git-send-email-shangw@linux.vnet.ibm.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 27 Jun 2012 12:15:17 -0600
Message-ID: <CAErSpo4u6HKdVqaaiL5=GSWRXiVfyfJ7EsnkAwGz6KvKrqaM=w@mail.gmail.com>
Subject: Re: [PATCH V4 1/2] PCI: pcibus address to resource converting take
 bus directly
To: Gavin Shan <shangw@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-pci@vger.kernel.org, yinghai@kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 27, 2012 at 8:48 AM, Gavin Shan <shangw@linux.vnet.ibm.com> wro=
te:
> For allocating resource under bus path, we do have dev pass along,
> and we could just use bus instead. Also, we'd like to make function
> find_pci_host_bridge() global so that some platforms (e.g. PPC) can
> access the pci host bridge directly.

This patch appears to have multiple unrelated changes:

  - change "struct pci_bus *bus" to "struct pci_bus *root_bus"
  - change find_pci_host_bridge() argument from dev to bus
  - fiddle with pcibios_bus_to_resource() and pcibios_resource_to_bus()

These should be split out to make your patches easier to review.

What's the rationale for preferring the pci_bus over the pci_dev?

> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> ---
> =A0drivers/pci/host-bridge.c | =A0 34 +++++++++++++++++++++-------------
> =A0include/linux/pci.h =A0 =A0 =A0 | =A0 =A04 ++++
> =A02 files changed, 25 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/pci/host-bridge.c b/drivers/pci/host-bridge.c
> index a68dc61..4ccf477 100644
> --- a/drivers/pci/host-bridge.c
> +++ b/drivers/pci/host-bridge.c
> @@ -9,22 +9,19 @@
>
> =A0#include "pci.h"
>
> -static struct pci_bus *find_pci_root_bus(struct pci_dev *dev)
> +static struct pci_bus *find_pci_root_bus(struct pci_bus *bus)
> =A0{
> - =A0 =A0 =A0 struct pci_bus *bus;
> -
> - =A0 =A0 =A0 bus =3D dev->bus;
> =A0 =A0 =A0 =A0while (bus->parent)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bus =3D bus->parent;
>
> =A0 =A0 =A0 =A0return bus;
> =A0}
>
> -static struct pci_host_bridge *find_pci_host_bridge(struct pci_dev *dev)
> +struct pci_host_bridge *find_pci_host_bridge(struct pci_bus *bus)
> =A0{
> - =A0 =A0 =A0 struct pci_bus *bus =3D find_pci_root_bus(dev);
> + =A0 =A0 =A0 struct pci_bus *root_bus =3D find_pci_root_bus(bus);
>
> - =A0 =A0 =A0 return to_pci_host_bridge(bus->bridge);
> + =A0 =A0 =A0 return to_pci_host_bridge(root_bus->bridge);
> =A0}
>
> =A0void pci_set_host_bridge_release(struct pci_host_bridge *bridge,
> @@ -40,10 +37,11 @@ static bool resource_contains(struct resource *res1, =
struct resource *res2)
> =A0 =A0 =A0 =A0return res1->start <=3D res2->start && res1->end >=3D res2=
->end;
> =A0}
>
> -void pcibios_resource_to_bus(struct pci_dev *dev, struct pci_bus_region =
*region,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct resource =
*res)
> +void __pcibios_resource_to_bus(struct pci_bus *bus,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 struct pci_bus_region *region,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 struct resource *res)
> =A0{
> - =A0 =A0 =A0 struct pci_host_bridge *bridge =3D find_pci_host_bridge(dev=
);
> + =A0 =A0 =A0 struct pci_host_bridge *bridge =3D find_pci_host_bridge(bus=
);
> =A0 =A0 =A0 =A0struct pci_host_bridge_window *window;
> =A0 =A0 =A0 =A0resource_size_t offset =3D 0;
>
> @@ -60,6 +58,11 @@ void pcibios_resource_to_bus(struct pci_dev *dev, stru=
ct pci_bus_region *region,
> =A0 =A0 =A0 =A0region->start =3D res->start - offset;
> =A0 =A0 =A0 =A0region->end =3D res->end - offset;
> =A0}
> +void pcibios_resource_to_bus(struct pci_dev *dev, struct pci_bus_region =
*region,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct resource =
*res)
> +{
> + =A0 =A0 =A0 __pcibios_resource_to_bus(dev->bus, region, res);
> +}
> =A0EXPORT_SYMBOL(pcibios_resource_to_bus);
>
> =A0static bool region_contains(struct pci_bus_region *region1,
> @@ -68,10 +71,10 @@ static bool region_contains(struct pci_bus_region *re=
gion1,
> =A0 =A0 =A0 =A0return region1->start <=3D region2->start && region1->end =
>=3D region2->end;
> =A0}
>
> -void pcibios_bus_to_resource(struct pci_dev *dev, struct resource *res,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct pci_bus_r=
egion *region)
> +static void __pcibios_bus_to_resource(struct pci_bus *bus, struct resour=
ce *res,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 struct pci_bus_region *region)
> =A0{
> - =A0 =A0 =A0 struct pci_host_bridge *bridge =3D find_pci_host_bridge(dev=
);
> + =A0 =A0 =A0 struct pci_host_bridge *bridge =3D find_pci_host_bridge(bus=
);
> =A0 =A0 =A0 =A0struct pci_host_bridge_window *window;
> =A0 =A0 =A0 =A0resource_size_t offset =3D 0;
>
> @@ -93,4 +96,9 @@ void pcibios_bus_to_resource(struct pci_dev *dev, struc=
t resource *res,
> =A0 =A0 =A0 =A0res->start =3D region->start + offset;
> =A0 =A0 =A0 =A0res->end =3D region->end + offset;
> =A0}
> +void pcibios_bus_to_resource(struct pci_dev *dev, struct resource *res,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct pci_bus_r=
egion *region)
> +{
> + =A0 =A0 =A0 __pcibios_bus_to_resource(dev->bus, res, region);
> +}
> =A0EXPORT_SYMBOL(pcibios_bus_to_resource);
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index fefb4e1..2b559f1 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -385,6 +385,7 @@ struct pci_host_bridge {
> =A0};
>
> =A0#define =A0 =A0 =A0 =A0to_pci_host_bridge(n) container_of(n, struct pc=
i_host_bridge, dev)
> +struct pci_host_bridge *find_pci_host_bridge(struct pci_bus *bus);
> =A0void pci_set_host_bridge_release(struct pci_host_bridge *bridge,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 void (*release_fn)(struct pci_hos=
t_bridge *),
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 void *release_data);
> @@ -657,6 +658,9 @@ void pci_fixup_cardbus(struct pci_bus *);
>
> =A0/* Generic PCI functions used internally */
>
> +void __pcibios_resource_to_bus(struct pci_bus *bus,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct pci_b=
us_region *region,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct resou=
rce *res);
> =A0void pcibios_resource_to_bus(struct pci_dev *dev, struct pci_bus_regio=
n *region,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct resource *=
res);
> =A0void pcibios_bus_to_resource(struct pci_dev *dev, struct resource *res=
,
> --
> 1.7.9.5
>
