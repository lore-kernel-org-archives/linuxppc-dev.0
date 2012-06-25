Return-Path: <yhlu.kernel@gmail.com>
Received: from mail-pb0-f42.google.com (mail-pb0-f42.google.com
 [209.85.160.42]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 90BDEB6FAF
 for <linuxppc-dev@ozlabs.org>; Tue, 26 Jun 2012 03:31:01 +1000 (EST)
Received: by pbbrp12 with SMTP id rp12so5781044pbb.15
 for <linuxppc-dev@ozlabs.org>; Mon, 25 Jun 2012 10:30:59 -0700 (PDT)
MIME-Version: 1.0
Sender: yhlu.kernel@gmail.com
In-Reply-To: <1340593821-19011-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1340593821-19011-1-git-send-email-shangw@linux.vnet.ibm.com>
Date: Mon, 25 Jun 2012 10:30:59 -0700
Message-ID: <CAE9FiQUE0_niTRmvZ=ROSFKB4HKDFFLjfJC+QeQkTKLMyvxv4g@mail.gmail.com>
Subject: Re: [PATCH V3 1/2] PCI: retrieve host bridge by PCI bus
From: Yinghai Lu <yinghai@kernel.org>
To: Gavin Shan <shangw@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Jun 24, 2012 at 8:10 PM, Gavin Shan <shangw@linux.vnet.ibm.com> wro=
te:
> With current implementation, there is one function to retrieve
> the corresponding host bridge (struct pci_host_bridge) according
> to the given PCI device (struct pci_dev) and that function has
> been declared as "static". Further, we don't have the public
> function to retrieve host bridge from PCI bus yet. The function
> is useful somewhere.
>
> The additional information like minimal resource alignment for I/O
> and MMIO bars of p2p bridges will be put into the PCI host bridge.
> The patch introduces the public function pci_bus_host_bridge() to
> retrieve the corresponding PCI host bridge according to the specified
> PCI bus, then accessing the information regarding the minimal resource
> alignment for I/O and MMIO bars of p2p bridges.
>
> Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
> Reviewed-by: Ram Pai <linuxram@us.ibm.com>
> Reviewed-by: Richard Yang <weiyang@linux.vnet.ibm.com>
> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
> =A0drivers/pci/host-bridge.c | =A0 13 +++++++++++++
> =A0include/linux/pci.h =A0 =A0 =A0 | =A0 =A02 +-
> =A02 files changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/host-bridge.c b/drivers/pci/host-bridge.c
> index a68dc61..b95f0ce 100644
> --- a/drivers/pci/host-bridge.c
> +++ b/drivers/pci/host-bridge.c
> @@ -27,6 +27,19 @@ static struct pci_host_bridge *find_pci_host_bridge(st=
ruct pci_dev *dev)
> =A0 =A0 =A0 =A0return to_pci_host_bridge(bus->bridge);
> =A0}
>
> +struct pci_host_bridge *pci_bus_host_bridge(struct pci_bus *bus)
> +{
> + =A0 =A0 =A0 struct pci_bus *b =3D bus;
> +
> + =A0 =A0 =A0 /* Find the PCI root bus */
> + =A0 =A0 =A0 while (b->parent)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 b =3D b->parent;
> +
> + =A0 =A0 =A0 return to_pci_host_bridge(b->bridge);
> +}
> +
> +EXPORT_SYMBOL(pci_bus_host_bridge);

why do you need to export it?

> +
> =A0void pci_set_host_bridge_release(struct pci_host_bridge *bridge,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 void (*re=
lease_fn)(struct pci_host_bridge *),
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 void *rel=
ease_data)
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index fefb4e1..6d5bb1c 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -656,7 +656,7 @@ void pcibios_update_irq(struct pci_dev *, int irq);
> =A0void pci_fixup_cardbus(struct pci_bus *);
>
> =A0/* Generic PCI functions used internally */
> -
> +struct pci_host_bridge *pci_bus_host_bridge(struct pci_bus *bus);
> =A0void pcibios_resource_to_bus(struct pci_dev *dev, struct pci_bus_regio=
n *region,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct resource *=
res);
> =A0void pcibios_bus_to_resource(struct pci_dev *dev, struct resource *res=
,

have one patch will change parameter all to bus instead of bridge.

http://git.kernel.org/?p=3Dlinux/kernel/git/yinghai/linux-yinghai.git;a=3Dc=
ommitdiff;h=3D3dc90c8f31e5e6153e1ac9a903189d3013690e80

in that case, we can just make find_pci_host_bridge() global.

Thanks

Yinghai
