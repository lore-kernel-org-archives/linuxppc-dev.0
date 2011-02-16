Return-Path: <glikely@secretlab.ca>
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1295843342-1122-8-git-send-email-bigeasy@linutronix.de>
References: <1295843342-1122-1-git-send-email-bigeasy@linutronix.de>
	<1295843342-1122-8-git-send-email-bigeasy@linutronix.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 16 Feb 2011 14:53:47 -0700
Message-ID: <AANLkTimE=mB_yWsOeD3zw+b4cHFx591h-605tK4yWAJr@mail.gmail.com>
Subject: Re: [PATCH OF 07/14] of: move of_irq_map_pci() into generic code
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Michal Simek <monstr@monstr.eu>, microblaze-uclinux@itee.uq.edu.au,
	devicetree-discuss@lists.ozlabs.org, x86@kernel.org,
	linux-kernel@vger.kernel.org, sodaville@linutronix.de,
	Sebastian Andrzej Siewior <sebastian@breakpoint.cc>,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Jan 23, 2011 at 9:28 PM, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
> From: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
>
> There is a tiny difference between PPC32 and PPC64. Microblaze uses the
> PPC32 variant.
>
> Cc: devicetree-discuss@lists.ozlabs.org
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Signed-off-by: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>

I've got this one in my devicetree/next branch which is pulled into
linux-next.  I've not received an ack from Ben yet.  Michal, is this
okay by you?

http://git.secretlab.ca/?p=3Dlinux-2.6.git;a=3Dcommit;h=3D04bea68b2f0eeebb0=
89ecc67b618795925268b4a

g.

> ---
> =A0arch/microblaze/include/asm/pci-bridge.h | =A0 12 ++++
> =A0arch/microblaze/include/asm/prom.h =A0 =A0 =A0 | =A0 15 -----
> =A0arch/microblaze/kernel/prom_parse.c =A0 =A0 =A0| =A0 77 --------------=
-------------
> =A0arch/microblaze/pci/pci-common.c =A0 =A0 =A0 =A0 | =A0 =A01 +
> =A0arch/powerpc/include/asm/pci-bridge.h =A0 =A0| =A0 10 ++++
> =A0arch/powerpc/include/asm/prom.h =A0 =A0 =A0 =A0 =A0| =A0 15 -----
> =A0arch/powerpc/kernel/pci-common.c =A0 =A0 =A0 =A0 | =A0 =A01 +
> =A0arch/powerpc/kernel/prom_parse.c =A0 =A0 =A0 =A0 | =A0 84 ------------=
------------------
> =A0drivers/of/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =
=A06 ++
> =A0drivers/of/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =
=A01 +
> =A0drivers/of/of_pci.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 8=
0 ++++++++++++++++++++++++++++
> =A0include/linux/of_pci.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 20 ++=
+++++
> =A012 files changed, 131 insertions(+), 191 deletions(-)
> =A0create mode 100644 drivers/of/of_pci.c
> =A0create mode 100644 include/linux/of_pci.h
>
> diff --git a/arch/microblaze/include/asm/pci-bridge.h b/arch/microblaze/i=
nclude/asm/pci-bridge.h
> index 0c68764..c2a40a4 100644
> --- a/arch/microblaze/include/asm/pci-bridge.h
> +++ b/arch/microblaze/include/asm/pci-bridge.h
> @@ -104,11 +104,22 @@ struct pci_controller {
> =A0 =A0 =A0 =A0int global_number; =A0 =A0 =A0/* PCI domain number */
> =A0};
>
> +#ifdef CONFIG_PCI
> =A0static inline struct pci_controller *pci_bus_to_host(const struct pci_=
bus *bus)
> =A0{
> =A0 =A0 =A0 =A0return bus->sysdata;
> =A0}
>
> +static inline struct device_node *pci_bus_to_OF_node(struct pci_bus *bus=
)
> +{
> + =A0 =A0 =A0 struct pci_controller *host;
> +
> + =A0 =A0 =A0 if (bus->self)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return pci_device_to_OF_node(bus->self);
> + =A0 =A0 =A0 host =3D pci_bus_to_host(bus);
> + =A0 =A0 =A0 return host ? host->dn : NULL;
> +}
> +
> =A0static inline int isa_vaddr_is_ioport(void __iomem *address)
> =A0{
> =A0 =A0 =A0 =A0/* No specific ISA handling on ppc32 at this stage, it
> @@ -116,6 +127,7 @@ static inline int isa_vaddr_is_ioport(void __iomem *a=
ddress)
> =A0 =A0 =A0 =A0 */
> =A0 =A0 =A0 =A0return 0;
> =A0}
> +#endif
>
> =A0/* These are used for config access before all the PCI probing
> =A0 =A0has been done. */
> diff --git a/arch/microblaze/include/asm/prom.h b/arch/microblaze/include=
/asm/prom.h
> index 2e72af0..d0890d3 100644
> --- a/arch/microblaze/include/asm/prom.h
> +++ b/arch/microblaze/include/asm/prom.h
> @@ -64,21 +64,6 @@ extern void kdump_move_device_tree(void);
> =A0/* CPU OF node matching */
> =A0struct device_node *of_get_cpu_node(int cpu, unsigned int *thread);
>
> -/**
> - * of_irq_map_pci - Resolve the interrupt for a PCI device
> - * @pdev: =A0 =A0 =A0the device whose interrupt is to be resolved
> - * @out_irq: =A0 structure of_irq filled by this function
> - *
> - * This function resolves the PCI interrupt for a given PCI device. If a
> - * device-node exists for a given pci_dev, it will use normal OF tree
> - * walking. If not, it will implement standard swizzling and walk up the
> - * PCI tree until an device-node is found, at which point it will finish
> - * resolving using the OF tree walking.
> - */
> -struct pci_dev;
> -struct of_irq;
> -extern int of_irq_map_pci(struct pci_dev *pdev, struct of_irq *out_irq);
> -
> =A0#endif /* __ASSEMBLY__ */
> =A0#endif /* __KERNEL__ */
>
> diff --git a/arch/microblaze/kernel/prom_parse.c b/arch/microblaze/kernel=
/prom_parse.c
> index 9ae24f4..47187cc 100644
> --- a/arch/microblaze/kernel/prom_parse.c
> +++ b/arch/microblaze/kernel/prom_parse.c
> @@ -2,88 +2,11 @@
>
> =A0#include <linux/kernel.h>
> =A0#include <linux/string.h>
> -#include <linux/pci_regs.h>
> =A0#include <linux/module.h>
> =A0#include <linux/ioport.h>
> =A0#include <linux/etherdevice.h>
> =A0#include <linux/of_address.h>
> =A0#include <asm/prom.h>
> -#include <asm/pci-bridge.h>
> -
> -#ifdef CONFIG_PCI
> -int of_irq_map_pci(struct pci_dev *pdev, struct of_irq *out_irq)
> -{
> - =A0 =A0 =A0 struct device_node *dn, *ppnode;
> - =A0 =A0 =A0 struct pci_dev *ppdev;
> - =A0 =A0 =A0 u32 lspec;
> - =A0 =A0 =A0 u32 laddr[3];
> - =A0 =A0 =A0 u8 pin;
> - =A0 =A0 =A0 int rc;
> -
> - =A0 =A0 =A0 /* Check if we have a device node, if yes, fallback to stan=
dard OF
> - =A0 =A0 =A0 =A0* parsing
> - =A0 =A0 =A0 =A0*/
> - =A0 =A0 =A0 dn =3D pci_device_to_OF_node(pdev);
> - =A0 =A0 =A0 if (dn)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return of_irq_map_one(dn, 0, out_irq);
> -
> - =A0 =A0 =A0 /* Ok, we don't, time to have fun. Let's start by building =
up an
> - =A0 =A0 =A0 =A0* interrupt spec. =A0we assume #interrupt-cells is 1, wh=
ich is standard
> - =A0 =A0 =A0 =A0* for PCI. If you do different, then don't use that rout=
ine.
> - =A0 =A0 =A0 =A0*/
> - =A0 =A0 =A0 rc =3D pci_read_config_byte(pdev, PCI_INTERRUPT_PIN, &pin);
> - =A0 =A0 =A0 if (rc !=3D 0)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return rc;
> - =A0 =A0 =A0 /* No pin, exit */
> - =A0 =A0 =A0 if (pin =3D=3D 0)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
> -
> - =A0 =A0 =A0 /* Now we walk up the PCI tree */
> - =A0 =A0 =A0 lspec =3D pin;
> - =A0 =A0 =A0 for (;;) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Get the pci_dev of our parent */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ppdev =3D pdev->bus->self;
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Ouch, it's a host bridge... */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ppdev =3D=3D NULL) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct pci_controller *host=
;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 host =3D pci_bus_to_host(pd=
ev->bus);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ppnode =3D host ? host->dn =
: NULL;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* No node for host bridge =
? give up */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ppnode =3D=3D NULL)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EIN=
VAL;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* We found a P2P bridge, c=
heck if it has a node */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ppnode =3D pci_device_to_OF=
_node(ppdev);
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Ok, we have found a parent with a device=
-node, hand over to
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* the OF parsing code.
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* We build a unit address from the linux=
 device to be used for
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* resolution. Note that we use the linux=
 bus number which may
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* not match your firmware bus numbering.
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Fortunately, in most cases, interrupt-=
map-mask doesn't
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* include the bus number as part of the =
matching.
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* You should still be careful about that=
 though if you intend
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* to rely on this function (you ship =A0=
a firmware that doesn't
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* create device nodes for all PCI device=
s).
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ppnode)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* We can only get here if we hit a P2P bri=
dge with no node,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* let's do standard swizzling and try ag=
ain
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 lspec =3D pci_swizzle_interrupt_pin(pdev, l=
spec);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdev =3D ppdev;
> - =A0 =A0 =A0 }
> -
> - =A0 =A0 =A0 laddr[0] =3D (pdev->bus->number << 16)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 | (pdev->devfn << 8);
> - =A0 =A0 =A0 laddr[1] =A0=3D laddr[2] =3D 0;
> - =A0 =A0 =A0 return of_irq_map_raw(ppnode, &lspec, 1, laddr, out_irq);
> -}
> -EXPORT_SYMBOL_GPL(of_irq_map_pci);
> -#endif /* CONFIG_PCI */
>
> =A0void of_parse_dma_window(struct device_node *dn, const void *dma_windo=
w_prop,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned long *busno, unsigned long *phys,=
 unsigned long *size)
> diff --git a/arch/microblaze/pci/pci-common.c b/arch/microblaze/pci/pci-c=
ommon.c
> index e363615..1e01a12 100644
> --- a/arch/microblaze/pci/pci-common.c
> +++ b/arch/microblaze/pci/pci-common.c
> @@ -29,6 +29,7 @@
> =A0#include <linux/slab.h>
> =A0#include <linux/of.h>
> =A0#include <linux/of_address.h>
> +#include <linux/of_pci.h>
>
> =A0#include <asm/processor.h>
> =A0#include <asm/io.h>
> diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include=
/asm/pci-bridge.h
> index 51e9e6f..edeb80f 100644
> --- a/arch/powerpc/include/asm/pci-bridge.h
> +++ b/arch/powerpc/include/asm/pci-bridge.h
> @@ -171,6 +171,16 @@ static inline struct pci_controller *pci_bus_to_host=
(const struct pci_bus *bus)
> =A0 =A0 =A0 =A0return bus->sysdata;
> =A0}
>
> +static inline struct device_node *pci_bus_to_OF_node(struct pci_bus *bus=
)
> +{
> + =A0 =A0 =A0 struct pci_controller *host;
> +
> + =A0 =A0 =A0 if (bus->self)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return pci_device_to_OF_node(bus->self);
> + =A0 =A0 =A0 host =3D pci_bus_to_host(bus);
> + =A0 =A0 =A0 return host ? host->dn : NULL;
> +}
> +
> =A0static inline int isa_vaddr_is_ioport(void __iomem *address)
> =A0{
> =A0 =A0 =A0 =A0/* No specific ISA handling on ppc32 at this stage, it
> diff --git a/arch/powerpc/include/asm/prom.h b/arch/powerpc/include/asm/p=
rom.h
> index d727575..c189aa5 100644
> --- a/arch/powerpc/include/asm/prom.h
> +++ b/arch/powerpc/include/asm/prom.h
> @@ -70,21 +70,6 @@ static inline int of_node_to_nid(struct device_node *d=
evice) { return 0; }
> =A0#endif
> =A0#define of_node_to_nid of_node_to_nid
>
> -/**
> - * of_irq_map_pci - Resolve the interrupt for a PCI device
> - * @pdev: =A0 =A0 =A0the device whose interrupt is to be resolved
> - * @out_irq: =A0 structure of_irq filled by this function
> - *
> - * This function resolves the PCI interrupt for a given PCI device. If a
> - * device-node exists for a given pci_dev, it will use normal OF tree
> - * walking. If not, it will implement standard swizzling and walk up the
> - * PCI tree until an device-node is found, at which point it will finish
> - * resolving using the OF tree walking.
> - */
> -struct pci_dev;
> -struct of_irq;
> -extern int of_irq_map_pci(struct pci_dev *pdev, struct of_irq *out_irq);
> -
> =A0extern void of_instantiate_rtc(void);
>
> =A0/* These includes are put at the bottom because they may contain thing=
s
> diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-c=
ommon.c
> index 10a44e6..eb341be 100644
> --- a/arch/powerpc/kernel/pci-common.c
> +++ b/arch/powerpc/kernel/pci-common.c
> @@ -22,6 +22,7 @@
> =A0#include <linux/init.h>
> =A0#include <linux/bootmem.h>
> =A0#include <linux/of_address.h>
> +#include <linux/of_pci.h>
> =A0#include <linux/mm.h>
> =A0#include <linux/list.h>
> =A0#include <linux/syscalls.h>
> diff --git a/arch/powerpc/kernel/prom_parse.c b/arch/powerpc/kernel/prom_=
parse.c
> index c2b7a07..47187cc 100644
> --- a/arch/powerpc/kernel/prom_parse.c
> +++ b/arch/powerpc/kernel/prom_parse.c
> @@ -2,95 +2,11 @@
>
> =A0#include <linux/kernel.h>
> =A0#include <linux/string.h>
> -#include <linux/pci_regs.h>
> =A0#include <linux/module.h>
> =A0#include <linux/ioport.h>
> =A0#include <linux/etherdevice.h>
> =A0#include <linux/of_address.h>
> =A0#include <asm/prom.h>
> -#include <asm/pci-bridge.h>
> -
> -#ifdef CONFIG_PCI
> -int of_irq_map_pci(struct pci_dev *pdev, struct of_irq *out_irq)
> -{
> - =A0 =A0 =A0 struct device_node *dn, *ppnode;
> - =A0 =A0 =A0 struct pci_dev *ppdev;
> - =A0 =A0 =A0 u32 lspec;
> - =A0 =A0 =A0 u32 laddr[3];
> - =A0 =A0 =A0 u8 pin;
> - =A0 =A0 =A0 int rc;
> -
> - =A0 =A0 =A0 /* Check if we have a device node, if yes, fallback to stan=
dard OF
> - =A0 =A0 =A0 =A0* parsing
> - =A0 =A0 =A0 =A0*/
> - =A0 =A0 =A0 dn =3D pci_device_to_OF_node(pdev);
> - =A0 =A0 =A0 if (dn) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 rc =3D of_irq_map_one(dn, 0, out_irq);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!rc)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return rc;
> - =A0 =A0 =A0 }
> -
> - =A0 =A0 =A0 /* Ok, we don't, time to have fun. Let's start by building =
up an
> - =A0 =A0 =A0 =A0* interrupt spec. =A0we assume #interrupt-cells is 1, wh=
ich is standard
> - =A0 =A0 =A0 =A0* for PCI. If you do different, then don't use that rout=
ine.
> - =A0 =A0 =A0 =A0*/
> - =A0 =A0 =A0 rc =3D pci_read_config_byte(pdev, PCI_INTERRUPT_PIN, &pin);
> - =A0 =A0 =A0 if (rc !=3D 0)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return rc;
> - =A0 =A0 =A0 /* No pin, exit */
> - =A0 =A0 =A0 if (pin =3D=3D 0)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
> -
> - =A0 =A0 =A0 /* Now we walk up the PCI tree */
> - =A0 =A0 =A0 lspec =3D pin;
> - =A0 =A0 =A0 for (;;) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Get the pci_dev of our parent */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ppdev =3D pdev->bus->self;
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Ouch, it's a host bridge... */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ppdev =3D=3D NULL) {
> -#ifdef CONFIG_PPC64
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ppnode =3D pci_bus_to_OF_no=
de(pdev->bus);
> -#else
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct pci_controller *host=
;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 host =3D pci_bus_to_host(pd=
ev->bus);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ppnode =3D host ? host->dn =
: NULL;
> -#endif
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* No node for host bridge =
? give up */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ppnode =3D=3D NULL)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EIN=
VAL;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* We found a P2P bridge, c=
heck if it has a node */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ppnode =3D pci_device_to_OF=
_node(ppdev);
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Ok, we have found a parent with a device=
-node, hand over to
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* the OF parsing code.
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* We build a unit address from the linux=
 device to be used for
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* resolution. Note that we use the linux=
 bus number which may
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* not match your firmware bus numbering.
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Fortunately, in most cases, interrupt-=
map-mask doesn't include
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* the bus number as part of the matching=
.
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* You should still be careful about that=
 though if you intend
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* to rely on this function (you ship =A0=
a firmware that doesn't
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* create device nodes for all PCI device=
s).
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ppnode)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* We can only get here if we hit a P2P bri=
dge with no node,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* let's do standard swizzling and try ag=
ain
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 lspec =3D pci_swizzle_interrupt_pin(pdev, l=
spec);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdev =3D ppdev;
> - =A0 =A0 =A0 }
> -
> - =A0 =A0 =A0 laddr[0] =3D (pdev->bus->number << 16)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 | (pdev->devfn << 8);
> - =A0 =A0 =A0 laddr[1] =A0=3D laddr[2] =3D 0;
> - =A0 =A0 =A0 return of_irq_map_raw(ppnode, &lspec, 1, laddr, out_irq);
> -}
> -EXPORT_SYMBOL_GPL(of_irq_map_pci);
> -#endif /* CONFIG_PCI */
>
> =A0void of_parse_dma_window(struct device_node *dn, const void *dma_windo=
w_prop,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned long *busno, unsigned long *phys,=
 unsigned long *size)
> diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
> index 3c6e100..c71cff1 100644
> --- a/drivers/of/Kconfig
> +++ b/drivers/of/Kconfig
> @@ -69,4 +69,10 @@ config OF_MDIO
> =A0 =A0 =A0 =A0help
> =A0 =A0 =A0 =A0 =A0OpenFirmware MDIO bus (Ethernet PHY) accessors
>
> +config OF_PCI
> + =A0 =A0 =A0 def_tristate PCI
> + =A0 =A0 =A0 depends on PCI && !SPARC
> + =A0 =A0 =A0 help
> + =A0 =A0 =A0 =A0 OpenFirmware PCI bus accessors
> +
> =A0endmenu # OF
> diff --git a/drivers/of/Makefile b/drivers/of/Makefile
> index 3ab21a0..f7861ed 100644
> --- a/drivers/of/Makefile
> +++ b/drivers/of/Makefile
> @@ -9,3 +9,4 @@ obj-$(CONFIG_OF_I2C) =A0 =A0+=3D of_i2c.o
> =A0obj-$(CONFIG_OF_NET) =A0 +=3D of_net.o
> =A0obj-$(CONFIG_OF_SPI) =A0 +=3D of_spi.o
> =A0obj-$(CONFIG_OF_MDIO) =A0+=3D of_mdio.o
> +obj-$(CONFIG_OF_PCI) =A0 +=3D of_pci.o
> diff --git a/drivers/of/of_pci.c b/drivers/of/of_pci.c
> new file mode 100644
> index 0000000..dd862d2
> --- /dev/null
> +++ b/drivers/of/of_pci.c
> @@ -0,0 +1,80 @@
> +#include <linux/kernel.h>
> +#include <linux/of_pci.h>
> +#include <asm/prom.h>
> +
> +int of_irq_map_pci(struct pci_dev *pdev, struct of_irq *out_irq)
> +{
> + =A0 =A0 =A0 struct device_node *dn, *ppnode;
> + =A0 =A0 =A0 struct pci_dev *ppdev;
> + =A0 =A0 =A0 u32 lspec;
> + =A0 =A0 =A0 __be32 lspec_be;
> + =A0 =A0 =A0 __be32 laddr[3];
> + =A0 =A0 =A0 u8 pin;
> + =A0 =A0 =A0 int rc;
> +
> + =A0 =A0 =A0 /* Check if we have a device node, if yes, fallback to stan=
dard OF
> + =A0 =A0 =A0 =A0* parsing
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 dn =3D pci_device_to_OF_node(pdev);
> + =A0 =A0 =A0 if (dn) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rc =3D of_irq_map_one(dn, 0, out_irq);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!rc)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return rc;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* Ok, we don't, time to have fun. Let's start by building =
up an
> + =A0 =A0 =A0 =A0* interrupt spec. =A0we assume #interrupt-cells is 1, wh=
ich is standard
> + =A0 =A0 =A0 =A0* for PCI. If you do different, then don't use that rout=
ine.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 rc =3D pci_read_config_byte(pdev, PCI_INTERRUPT_PIN, &pin);
> + =A0 =A0 =A0 if (rc !=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return rc;
> + =A0 =A0 =A0 /* No pin, exit */
> + =A0 =A0 =A0 if (pin =3D=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
> +
> + =A0 =A0 =A0 /* Now we walk up the PCI tree */
> + =A0 =A0 =A0 lspec =3D pin;
> + =A0 =A0 =A0 for (;;) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Get the pci_dev of our parent */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ppdev =3D pdev->bus->self;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Ouch, it's a host bridge... */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ppdev =3D=3D NULL) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ppnode =3D pci_bus_to_OF_no=
de(pdev->bus);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* No node for host bridge =
? give up */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ppnode =3D=3D NULL)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EIN=
VAL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* We found a P2P bridge, c=
heck if it has a node */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ppnode =3D pci_device_to_OF=
_node(ppdev);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Ok, we have found a parent with a device=
-node, hand over to
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* the OF parsing code.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* We build a unit address from the linux=
 device to be used for
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* resolution. Note that we use the linux=
 bus number which may
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* not match your firmware bus numbering.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Fortunately, in most cases, interrupt-=
map-mask doesn't
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* include the bus number as part of the =
matching.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* You should still be careful about that=
 though if you intend
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* to rely on this function (you ship =A0=
a firmware that doesn't
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* create device nodes for all PCI device=
s).
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ppnode)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* We can only get here if we hit a P2P bri=
dge with no node,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* let's do standard swizzling and try ag=
ain
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 lspec =3D pci_swizzle_interrupt_pin(pdev, l=
spec);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdev =3D ppdev;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 lspec_be =3D cpu_to_be32(lspec);
> + =A0 =A0 =A0 laddr[0] =3D cpu_to_be32((pdev->bus->number << 16) | (pdev-=
>devfn << 8));
> + =A0 =A0 =A0 laddr[1] =A0=3D laddr[2] =3D cpu_to_be32(0);
> + =A0 =A0 =A0 return of_irq_map_raw(ppnode, &lspec_be, 1, laddr, out_irq)=
;
> +}
> +EXPORT_SYMBOL_GPL(of_irq_map_pci);
> diff --git a/include/linux/of_pci.h b/include/linux/of_pci.h
> new file mode 100644
> index 0000000..9b0ba67
> --- /dev/null
> +++ b/include/linux/of_pci.h
> @@ -0,0 +1,20 @@
> +#ifndef __OF_PCI_H
> +#define __OF_PCI_H
> +
> +#include <linux/pci.h>
> +
> +/**
> + * of_irq_map_pci - Resolve the interrupt for a PCI device
> + * @pdev: =A0 =A0 =A0 the device whose interrupt is to be resolved
> + * @out_irq: =A0 =A0structure of_irq filled by this function
> + *
> + * This function resolves the PCI interrupt for a given PCI device. If a
> + * device-node exists for a given pci_dev, it will use normal OF tree
> + * walking. If not, it will implement standard swizzling and walk up the
> + * PCI tree until an device-node is found, at which point it will finish
> + * resolving using the OF tree walking.
> + */
> +struct pci_dev;
> +struct of_irq;
> +int of_irq_map_pci(struct pci_dev *pdev, struct of_irq *out_irq);
> +#endif
> --
> 1.7.3.2
>
> _______________________________________________
> devicetree-discuss mailing list
> devicetree-discuss@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/devicetree-discuss
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
