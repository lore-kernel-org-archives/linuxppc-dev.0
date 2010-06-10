Return-Path: <glikely@secretlab.ca>
Received: from mail-gy0-f170.google.com (mail-gy0-f170.google.com
	[209.85.160.170]) by ozlabs.org (Postfix) with ESMTP id 61158B7D5C
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jun 2010 00:26:54 +1000 (EST)
Received: by gyf2 with SMTP id 2so4678164gyf.15
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jun 2010 07:26:53 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1276152212.1962.59.camel@pasglop>
References: <20100608140917.25879.67745.stgit@angua>
	<20100608141008.25879.2050.stgit@angua>
	<1276152212.1962.59.camel@pasglop>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 10 Jun 2010 08:26:32 -0600
Message-ID: <AANLkTiltEWJQa5FL0Pjpd8JeQdo-ECBSM5EJHruIAJK0@mail.gmail.com>
Subject: Re: [PATCH 3/5] of/address: Merge all of the bus translation code
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Stephen Rothwell <sfr@canb.auug.org.au>,
	Michal Simek <monstr@monstr.eu>, microblaze-uclinux@itee.uq.edu.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 10, 2010 at 12:43 AM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Tue, 2010-06-08 at 08:10 -0600, Grant Likely wrote:
>> Microblaze and PowerPC share a large chunk of code for translating
>> OF device tree data into usable addresses. =A0There aren't many differen=
ces
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ^^^^
> Care to comment on these differences ?

Purely cosmetic IIRC, but I will go back and double check.  Things
like printk vs. pr_info and some style differences.  I looked at them
side-by-side and fixed each difference individually until they were
identical.

>> between the two, so merge the codebase wholesale rather than trying to
>> work out the independent bits.
>
> Well, I don't see ifdef's in the resulting code (but I'm a bit blind),
> so what did you do with the differences ?
>
> This is complex and fragile code, so any change to it must be very
> carefully scrutinized.
>
> Cheers,
> Ben.
>
>> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
>> CC: Michal Simek <monstr@monstr.eu>
>> CC: Wolfram Sang <w.sang@pengutronix.de>
>> CC: Stephen Rothwell <sfr@canb.auug.org.au>
>> CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> CC: microblaze-uclinux@itee.uq.edu.au
>> CC: linuxppc-dev@ozlabs.org
>> ---
>> =A0arch/microblaze/include/asm/prom.h =A0| =A0 =A04
>> =A0arch/microblaze/kernel/prom_parse.c | =A0489 ------------------------=
---------
>> =A0arch/powerpc/include/asm/prom.h =A0 =A0 | =A0 =A04
>> =A0arch/powerpc/kernel/prom_parse.c =A0 =A0| =A0515 --------------------=
---------------
>> =A0drivers/of/address.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0517 ++++++++=
+++++++++++++++++++++++++++
>> =A0include/linux/of_address.h =A0 =A0 =A0 =A0 =A0| =A0 =A04
>> =A06 files changed, 515 insertions(+), 1018 deletions(-)
>>
>> diff --git a/arch/microblaze/include/asm/prom.h b/arch/microblaze/includ=
e/asm/prom.h
>> index 644fa32..35cb3de 100644
>> --- a/arch/microblaze/include/asm/prom.h
>> +++ b/arch/microblaze/include/asm/prom.h
>> @@ -52,10 +52,6 @@ extern void pci_create_OF_bus_map(void);
>> =A0 * OF address retreival & translation
>> =A0 */
>>
>> -/* Translate an OF address block into a CPU physical address
>> - */
>> -extern u64 of_translate_address(struct device_node *np, const u32 *addr=
);
>> -
>> =A0/* Extract an address from a device, returns the region size and
>> =A0 * the address space flags too. The PCI version uses a BAR number
>> =A0 * instead of an absolute index
>> diff --git a/arch/microblaze/kernel/prom_parse.c b/arch/microblaze/kerne=
l/prom_parse.c
>> index 7cb5a98..1d610e6 100644
>> --- a/arch/microblaze/kernel/prom_parse.c
>> +++ b/arch/microblaze/kernel/prom_parse.c
>> @@ -10,213 +10,7 @@
>> =A0#include <asm/prom.h>
>> =A0#include <asm/pci-bridge.h>
>>
>> -#define PRu64 =A0 =A0 =A0 =A0"%llx"
>> -
>> -/* Max address size we deal with */
>> -#define OF_MAX_ADDR_CELLS =A0 =A04
>> -#define OF_CHECK_COUNTS(na, ns) =A0 =A0 =A0((na) > 0 && (na) <=3D OF_MA=
X_ADDR_CELLS && \
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (ns) > 0)
>> -
>> -static struct of_bus *of_match_bus(struct device_node *np);
>> -
>> -/* Debug utility */
>> -#ifdef DEBUG
>> -static void of_dump_addr(const char *s, const u32 *addr, int na)
>> -{
>> - =A0 =A0 printk(KERN_INFO "%s", s);
>> - =A0 =A0 while (na--)
>> - =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_INFO " %08x", *(addr++));
>> - =A0 =A0 printk(KERN_INFO "\n");
>> -}
>> -#else
>> -static void of_dump_addr(const char *s, const u32 *addr, int na) { }
>> -#endif
>> -
>> -/* Callbacks for bus specific translators */
>> -struct of_bus {
>> - =A0 =A0 const char =A0 =A0 =A0*name;
>> - =A0 =A0 const char =A0 =A0 =A0*addresses;
>> - =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 (*match)(struct device_node *paren=
t);
>> - =A0 =A0 void =A0 =A0 =A0 =A0 =A0 =A0(*count_cells)(struct device_node =
*child,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 int *addrc, int *sizec);
>> - =A0 =A0 u64 =A0 =A0 =A0 =A0 =A0 =A0 (*map)(u32 *addr, const u32 *range=
,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int na, int ns=
, int pna);
>> - =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 (*translate)(u32 *addr, u64 offset=
, int na);
>> - =A0 =A0 unsigned int =A0 =A0(*get_flags)(const u32 *addr);
>> -};
>> -
>> -/*
>> - * Default translator (generic bus)
>> - */
>> -
>> -static void of_bus_default_count_cells(struct device_node *dev,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 int *addrc, int *sizec)
>> -{
>> - =A0 =A0 if (addrc)
>> - =A0 =A0 =A0 =A0 =A0 =A0 *addrc =3D of_n_addr_cells(dev);
>> - =A0 =A0 if (sizec)
>> - =A0 =A0 =A0 =A0 =A0 =A0 *sizec =3D of_n_size_cells(dev);
>> -}
>> -
>> -static u64 of_bus_default_map(u32 *addr, const u32 *range,
>> - =A0 =A0 =A0 =A0 =A0 =A0 int na, int ns, int pna)
>> -{
>> - =A0 =A0 u64 cp, s, da;
>> -
>> - =A0 =A0 cp =3D of_read_number(range, na);
>> - =A0 =A0 s =A0=3D of_read_number(range + na + pna, ns);
>> - =A0 =A0 da =3D of_read_number(addr, na);
>> -
>> - =A0 =A0 pr_debug("OF: default map, cp=3D"PRu64", s=3D"PRu64", da=3D"PR=
u64"\n",
>> - =A0 =A0 =A0 =A0 =A0 =A0 cp, s, da);
>> -
>> - =A0 =A0 if (da < cp || da >=3D (cp + s))
>> - =A0 =A0 =A0 =A0 =A0 =A0 return OF_BAD_ADDR;
>> - =A0 =A0 return da - cp;
>> -}
>> -
>> -static int of_bus_default_translate(u32 *addr, u64 offset, int na)
>> -{
>> - =A0 =A0 u64 a =3D of_read_number(addr, na);
>> - =A0 =A0 memset(addr, 0, na * 4);
>> - =A0 =A0 a +=3D offset;
>> - =A0 =A0 if (na > 1)
>> - =A0 =A0 =A0 =A0 =A0 =A0 addr[na - 2] =3D a >> 32;
>> - =A0 =A0 addr[na - 1] =3D a & 0xffffffffu;
>> -
>> - =A0 =A0 return 0;
>> -}
>> -
>> -static unsigned int of_bus_default_get_flags(const u32 *addr)
>> -{
>> - =A0 =A0 return IORESOURCE_MEM;
>> -}
>> -
>> =A0#ifdef CONFIG_PCI
>> -/*
>> - * PCI bus specific translator
>> - */
>> -
>> -static int of_bus_pci_match(struct device_node *np)
>> -{
>> - =A0 =A0 /* "vci" is for the /chaos bridge on 1st-gen PCI powermacs */
>> - =A0 =A0 return !strcmp(np->type, "pci") || !strcmp(np->type, "vci");
>> -}
>> -
>> -static void of_bus_pci_count_cells(struct device_node *np,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int *addrc, in=
t *sizec)
>> -{
>> - =A0 =A0 if (addrc)
>> - =A0 =A0 =A0 =A0 =A0 =A0 *addrc =3D 3;
>> - =A0 =A0 if (sizec)
>> - =A0 =A0 =A0 =A0 =A0 =A0 *sizec =3D 2;
>> -}
>> -
>> -static u64 of_bus_pci_map(u32 *addr, const u32 *range, int na, int ns, =
int pna)
>> -{
>> - =A0 =A0 u64 cp, s, da;
>> -
>> - =A0 =A0 /* Check address type match */
>> - =A0 =A0 if ((addr[0] ^ range[0]) & 0x03000000)
>> - =A0 =A0 =A0 =A0 =A0 =A0 return OF_BAD_ADDR;
>> -
>> - =A0 =A0 /* Read address values, skipping high cell */
>> - =A0 =A0 cp =3D of_read_number(range + 1, na - 1);
>> - =A0 =A0 s =A0=3D of_read_number(range + na + pna, ns);
>> - =A0 =A0 da =3D of_read_number(addr + 1, na - 1);
>> -
>> - =A0 =A0 pr_debug("OF: PCI map, cp=3D"PRu64", s=3D"PRu64", da=3D"PRu64"=
\n", cp, s, da);
>> -
>> - =A0 =A0 if (da < cp || da >=3D (cp + s))
>> - =A0 =A0 =A0 =A0 =A0 =A0 return OF_BAD_ADDR;
>> - =A0 =A0 return da - cp;
>> -}
>> -
>> -static int of_bus_pci_translate(u32 *addr, u64 offset, int na)
>> -{
>> - =A0 =A0 return of_bus_default_translate(addr + 1, offset, na - 1);
>> -}
>> -
>> -static unsigned int of_bus_pci_get_flags(const u32 *addr)
>> -{
>> - =A0 =A0 unsigned int flags =3D 0;
>> - =A0 =A0 u32 w =3D addr[0];
>> -
>> - =A0 =A0 switch ((w >> 24) & 0x03) {
>> - =A0 =A0 case 0x01:
>> - =A0 =A0 =A0 =A0 =A0 =A0 flags |=3D IORESOURCE_IO;
>> - =A0 =A0 =A0 =A0 =A0 =A0 break;
>> - =A0 =A0 case 0x02: /* 32 bits */
>> - =A0 =A0 case 0x03: /* 64 bits */
>> - =A0 =A0 =A0 =A0 =A0 =A0 flags |=3D IORESOURCE_MEM;
>> - =A0 =A0 =A0 =A0 =A0 =A0 break;
>> - =A0 =A0 }
>> - =A0 =A0 if (w & 0x40000000)
>> - =A0 =A0 =A0 =A0 =A0 =A0 flags |=3D IORESOURCE_PREFETCH;
>> - =A0 =A0 return flags;
>> -}
>> -
>> -const u32 *of_get_pci_address(struct device_node *dev, int bar_no, u64 =
*size,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int *flags)
>> -{
>> - =A0 =A0 const u32 *prop;
>> - =A0 =A0 unsigned int psize;
>> - =A0 =A0 struct device_node *parent;
>> - =A0 =A0 struct of_bus *bus;
>> - =A0 =A0 int onesize, i, na, ns;
>> -
>> - =A0 =A0 /* Get parent & match bus type */
>> - =A0 =A0 parent =3D of_get_parent(dev);
>> - =A0 =A0 if (parent =3D=3D NULL)
>> - =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
>> - =A0 =A0 bus =3D of_match_bus(parent);
>> - =A0 =A0 if (strcmp(bus->name, "pci")) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 of_node_put(parent);
>> - =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
>> - =A0 =A0 }
>> - =A0 =A0 bus->count_cells(dev, &na, &ns);
>> - =A0 =A0 of_node_put(parent);
>> - =A0 =A0 if (!OF_CHECK_COUNTS(na, ns))
>> - =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
>> -
>> - =A0 =A0 /* Get "reg" or "assigned-addresses" property */
>> - =A0 =A0 prop =3D of_get_property(dev, bus->addresses, &psize);
>> - =A0 =A0 if (prop =3D=3D NULL)
>> - =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
>> - =A0 =A0 psize /=3D 4;
>> -
>> - =A0 =A0 onesize =3D na + ns;
>> - =A0 =A0 for (i =3D 0; psize >=3D onesize; psize -=3D onesize, prop +=
=3D onesize, i++)
>> - =A0 =A0 =A0 =A0 =A0 =A0 if ((prop[0] & 0xff) =3D=3D ((bar_no * 4) + PC=
I_BASE_ADDRESS_0)) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (size)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *size =3D of_r=
ead_number(prop + na, ns);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (flags)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *flags =3D bus=
->get_flags(prop);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return prop;
>> - =A0 =A0 =A0 =A0 =A0 =A0 }
>> - =A0 =A0 return NULL;
>> -}
>> -EXPORT_SYMBOL(of_get_pci_address);
>> -
>> -int of_pci_address_to_resource(struct device_node *dev, int bar,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct resourc=
e *r)
>> -{
>> - =A0 =A0 const u32 =A0 =A0 =A0 *addrp;
>> - =A0 =A0 u64 =A0 =A0 =A0 =A0 =A0 =A0 size;
>> - =A0 =A0 unsigned int =A0 =A0flags;
>> -
>> - =A0 =A0 addrp =3D of_get_pci_address(dev, bar, &size, &flags);
>> - =A0 =A0 if (addrp =3D=3D NULL)
>> - =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> - =A0 =A0 return __of_address_to_resource(dev, addrp, size, flags, r);
>> -}
>> -EXPORT_SYMBOL_GPL(of_pci_address_to_resource);
>> -
>> -static u8 of_irq_pci_swizzle(u8 slot, u8 pin)
>> -{
>> - =A0 =A0 return (((pin - 1) + slot) % 4) + 1;
>> -}
>> -
>> =A0int of_irq_map_pci(struct pci_dev *pdev, struct of_irq *out_irq)
>> =A0{
>> =A0 =A0 =A0 struct device_node *dn, *ppnode;
>> @@ -291,289 +85,6 @@ int of_irq_map_pci(struct pci_dev *pdev, struct of_=
irq *out_irq)
>> =A0EXPORT_SYMBOL_GPL(of_irq_map_pci);
>> =A0#endif /* CONFIG_PCI */
>>
>> -/*
>> - * ISA bus specific translator
>> - */
>> -
>> -static int of_bus_isa_match(struct device_node *np)
>> -{
>> - =A0 =A0 return !strcmp(np->name, "isa");
>> -}
>> -
>> -static void of_bus_isa_count_cells(struct device_node *child,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int *addrc, in=
t *sizec)
>> -{
>> - =A0 =A0 if (addrc)
>> - =A0 =A0 =A0 =A0 =A0 =A0 *addrc =3D 2;
>> - =A0 =A0 if (sizec)
>> - =A0 =A0 =A0 =A0 =A0 =A0 *sizec =3D 1;
>> -}
>> -
>> -static u64 of_bus_isa_map(u32 *addr, const u32 *range, int na, int ns, =
int pna)
>> -{
>> - =A0 =A0 u64 cp, s, da;
>> -
>> - =A0 =A0 /* Check address type match */
>> - =A0 =A0 if ((addr[0] ^ range[0]) & 0x00000001)
>> - =A0 =A0 =A0 =A0 =A0 =A0 return OF_BAD_ADDR;
>> -
>> - =A0 =A0 /* Read address values, skipping high cell */
>> - =A0 =A0 cp =3D of_read_number(range + 1, na - 1);
>> - =A0 =A0 s =A0=3D of_read_number(range + na + pna, ns);
>> - =A0 =A0 da =3D of_read_number(addr + 1, na - 1);
>> -
>> - =A0 =A0 pr_debug("OF: ISA map, cp=3D"PRu64", s=3D"PRu64", da=3D"PRu64"=
\n", cp, s, da);
>> -
>> - =A0 =A0 if (da < cp || da >=3D (cp + s))
>> - =A0 =A0 =A0 =A0 =A0 =A0 return OF_BAD_ADDR;
>> - =A0 =A0 return da - cp;
>> -}
>> -
>> -static int of_bus_isa_translate(u32 *addr, u64 offset, int na)
>> -{
>> - =A0 =A0 return of_bus_default_translate(addr + 1, offset, na - 1);
>> -}
>> -
>> -static unsigned int of_bus_isa_get_flags(const u32 *addr)
>> -{
>> - =A0 =A0 unsigned int flags =3D 0;
>> - =A0 =A0 u32 w =3D addr[0];
>> -
>> - =A0 =A0 if (w & 1)
>> - =A0 =A0 =A0 =A0 =A0 =A0 flags |=3D IORESOURCE_IO;
>> - =A0 =A0 else
>> - =A0 =A0 =A0 =A0 =A0 =A0 flags |=3D IORESOURCE_MEM;
>> - =A0 =A0 return flags;
>> -}
>> -
>> -/*
>> - * Array of bus specific translators
>> - */
>> -
>> -static struct of_bus of_busses[] =3D {
>> -#ifdef CONFIG_PCI
>> - =A0 =A0 /* PCI */
>> - =A0 =A0 {
>> - =A0 =A0 =A0 =A0 =A0 =A0 .name =3D "pci",
>> - =A0 =A0 =A0 =A0 =A0 =A0 .addresses =3D "assigned-addresses",
>> - =A0 =A0 =A0 =A0 =A0 =A0 .match =3D of_bus_pci_match,
>> - =A0 =A0 =A0 =A0 =A0 =A0 .count_cells =3D of_bus_pci_count_cells,
>> - =A0 =A0 =A0 =A0 =A0 =A0 .map =3D of_bus_pci_map,
>> - =A0 =A0 =A0 =A0 =A0 =A0 .translate =3D of_bus_pci_translate,
>> - =A0 =A0 =A0 =A0 =A0 =A0 .get_flags =3D of_bus_pci_get_flags,
>> - =A0 =A0 },
>> -#endif /* CONFIG_PCI */
>> - =A0 =A0 /* ISA */
>> - =A0 =A0 {
>> - =A0 =A0 =A0 =A0 =A0 =A0 .name =3D "isa",
>> - =A0 =A0 =A0 =A0 =A0 =A0 .addresses =3D "reg",
>> - =A0 =A0 =A0 =A0 =A0 =A0 .match =3D of_bus_isa_match,
>> - =A0 =A0 =A0 =A0 =A0 =A0 .count_cells =3D of_bus_isa_count_cells,
>> - =A0 =A0 =A0 =A0 =A0 =A0 .map =3D of_bus_isa_map,
>> - =A0 =A0 =A0 =A0 =A0 =A0 .translate =3D of_bus_isa_translate,
>> - =A0 =A0 =A0 =A0 =A0 =A0 .get_flags =3D of_bus_isa_get_flags,
>> - =A0 =A0 },
>> - =A0 =A0 /* Default */
>> - =A0 =A0 {
>> - =A0 =A0 =A0 =A0 =A0 =A0 .name =3D "default",
>> - =A0 =A0 =A0 =A0 =A0 =A0 .addresses =3D "reg",
>> - =A0 =A0 =A0 =A0 =A0 =A0 .match =3D NULL,
>> - =A0 =A0 =A0 =A0 =A0 =A0 .count_cells =3D of_bus_default_count_cells,
>> - =A0 =A0 =A0 =A0 =A0 =A0 .map =3D of_bus_default_map,
>> - =A0 =A0 =A0 =A0 =A0 =A0 .translate =3D of_bus_default_translate,
>> - =A0 =A0 =A0 =A0 =A0 =A0 .get_flags =3D of_bus_default_get_flags,
>> - =A0 =A0 },
>> -};
>> -
>> -static struct of_bus *of_match_bus(struct device_node *np)
>> -{
>> - =A0 =A0 int i;
>> -
>> - =A0 =A0 for (i =3D 0; i < ARRAY_SIZE(of_busses); i++)
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (!of_busses[i].match || of_busses[i].match(=
np))
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return &of_busses[i];
>> - =A0 =A0 BUG();
>> - =A0 =A0 return NULL;
>> -}
>> -
>> -static int of_translate_one(struct device_node *parent, struct of_bus *=
bus,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct of_bus *pbus, u32 *addr=
,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int na, int ns, int pna)
>> -{
>> - =A0 =A0 const u32 *ranges;
>> - =A0 =A0 unsigned int rlen;
>> - =A0 =A0 int rone;
>> - =A0 =A0 u64 offset =3D OF_BAD_ADDR;
>> -
>> - =A0 =A0 /* Normally, an absence of a "ranges" property means we are
>> - =A0 =A0 =A0* crossing a non-translatable boundary, and thus the addres=
ses
>> - =A0 =A0 =A0* below the current not cannot be converted to CPU physical=
 ones.
>> - =A0 =A0 =A0* Unfortunately, while this is very clear in the spec, it's=
 not
>> - =A0 =A0 =A0* what Apple understood, and they do have things like /uni-=
n or
>> - =A0 =A0 =A0* /ht nodes with no "ranges" property and a lot of perfectl=
y
>> - =A0 =A0 =A0* useable mapped devices below them. Thus we treat the abse=
nce of
>> - =A0 =A0 =A0* "ranges" as equivalent to an empty "ranges" property whic=
h means
>> - =A0 =A0 =A0* a 1:1 translation at that level. It's up to the caller no=
t to try
>> - =A0 =A0 =A0* to translate addresses that aren't supposed to be transla=
ted in
>> - =A0 =A0 =A0* the first place. --BenH.
>> - =A0 =A0 =A0*/
>> - =A0 =A0 ranges =3D of_get_property(parent, "ranges", (int *) &rlen);
>> - =A0 =A0 if (ranges =3D=3D NULL || rlen =3D=3D 0) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 offset =3D of_read_number(addr, na);
>> - =A0 =A0 =A0 =A0 =A0 =A0 memset(addr, 0, pna * 4);
>> - =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("OF: no ranges, 1:1 translation\n");
>> - =A0 =A0 =A0 =A0 =A0 =A0 goto finish;
>> - =A0 =A0 }
>> -
>> - =A0 =A0 pr_debug("OF: walking ranges...\n");
>> -
>> - =A0 =A0 /* Now walk through the ranges */
>> - =A0 =A0 rlen /=3D 4;
>> - =A0 =A0 rone =3D na + pna + ns;
>> - =A0 =A0 for (; rlen >=3D rone; rlen -=3D rone, ranges +=3D rone) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 offset =3D bus->map(addr, ranges, na, ns, pna)=
;
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (offset !=3D OF_BAD_ADDR)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> - =A0 =A0 }
>> - =A0 =A0 if (offset =3D=3D OF_BAD_ADDR) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("OF: not found !\n");
>> - =A0 =A0 =A0 =A0 =A0 =A0 return 1;
>> - =A0 =A0 }
>> - =A0 =A0 memcpy(addr, ranges + na, 4 * pna);
>> -
>> - finish:
>> - =A0 =A0 of_dump_addr("OF: parent translation for:", addr, pna);
>> - =A0 =A0 pr_debug("OF: with offset: "PRu64"\n", offset);
>> -
>> - =A0 =A0 /* Translate it into parent bus space */
>> - =A0 =A0 return pbus->translate(addr, offset, pna);
>> -}
>> -
>> -/*
>> - * Translate an address from the device-tree into a CPU physical addres=
s,
>> - * this walks up the tree and applies the various bus mappings on the
>> - * way.
>> - *
>> - * Note: We consider that crossing any level with #size-cells =3D=3D 0 =
to mean
>> - * that translation is impossible (that is we are not dealing with a va=
lue
>> - * that can be mapped to a cpu physical address). This is not really sp=
ecified
>> - * that way, but this is traditionally the way IBM at least do things
>> - */
>> -u64 of_translate_address(struct device_node *dev, const u32 *in_addr)
>> -{
>> - =A0 =A0 struct device_node *parent =3D NULL;
>> - =A0 =A0 struct of_bus *bus, *pbus;
>> - =A0 =A0 u32 addr[OF_MAX_ADDR_CELLS];
>> - =A0 =A0 int na, ns, pna, pns;
>> - =A0 =A0 u64 result =3D OF_BAD_ADDR;
>> -
>> - =A0 =A0 pr_debug("OF: ** translation for device %s **\n", dev->full_na=
me);
>> -
>> - =A0 =A0 /* Increase refcount at current level */
>> - =A0 =A0 of_node_get(dev);
>> -
>> - =A0 =A0 /* Get parent & match bus type */
>> - =A0 =A0 parent =3D of_get_parent(dev);
>> - =A0 =A0 if (parent =3D=3D NULL)
>> - =A0 =A0 =A0 =A0 =A0 =A0 goto bail;
>> - =A0 =A0 bus =3D of_match_bus(parent);
>> -
>> - =A0 =A0 /* Cound address cells & copy address locally */
>> - =A0 =A0 bus->count_cells(dev, &na, &ns);
>> - =A0 =A0 if (!OF_CHECK_COUNTS(na, ns)) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "prom_parse: Bad cell count fo=
r %s\n",
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev->full_name);
>> - =A0 =A0 =A0 =A0 =A0 =A0 goto bail;
>> - =A0 =A0 }
>> - =A0 =A0 memcpy(addr, in_addr, na * 4);
>> -
>> - =A0 =A0 pr_debug("OF: bus is %s (na=3D%d, ns=3D%d) on %s\n",
>> - =A0 =A0 =A0 =A0 =A0 =A0 bus->name, na, ns, parent->full_name);
>> - =A0 =A0 of_dump_addr("OF: translating address:", addr, na);
>> -
>> - =A0 =A0 /* Translate */
>> - =A0 =A0 for (;;) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 /* Switch to parent bus */
>> - =A0 =A0 =A0 =A0 =A0 =A0 of_node_put(dev);
>> - =A0 =A0 =A0 =A0 =A0 =A0 dev =3D parent;
>> - =A0 =A0 =A0 =A0 =A0 =A0 parent =3D of_get_parent(dev);
>> -
>> - =A0 =A0 =A0 =A0 =A0 =A0 /* If root, we have finished */
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (parent =3D=3D NULL) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("OF: reached root nod=
e\n");
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 result =3D of_read_number(addr=
, na);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> - =A0 =A0 =A0 =A0 =A0 =A0 }
>> -
>> - =A0 =A0 =A0 =A0 =A0 =A0 /* Get new parent bus and counts */
>> - =A0 =A0 =A0 =A0 =A0 =A0 pbus =3D of_match_bus(parent);
>> - =A0 =A0 =A0 =A0 =A0 =A0 pbus->count_cells(dev, &pna, &pns);
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (!OF_CHECK_COUNTS(pna, pns)) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "prom_parse: B=
ad cell count for %s\n",
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev->full_name=
);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> - =A0 =A0 =A0 =A0 =A0 =A0 }
>> -
>> - =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("OF: parent bus is %s (na=3D%d, ns=3D=
%d) on %s\n",
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pbus->name, pna, pns, parent->=
full_name);
>> -
>> - =A0 =A0 =A0 =A0 =A0 =A0 /* Apply bus translation */
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (of_translate_one(dev, bus, pbus, addr, na,=
 ns, pna))
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> -
>> - =A0 =A0 =A0 =A0 =A0 =A0 /* Complete the move up one level */
>> - =A0 =A0 =A0 =A0 =A0 =A0 na =3D pna;
>> - =A0 =A0 =A0 =A0 =A0 =A0 ns =3D pns;
>> - =A0 =A0 =A0 =A0 =A0 =A0 bus =3D pbus;
>> -
>> - =A0 =A0 =A0 =A0 =A0 =A0 of_dump_addr("OF: one level translation:", add=
r, na);
>> - =A0 =A0 }
>> - bail:
>> - =A0 =A0 of_node_put(parent);
>> - =A0 =A0 of_node_put(dev);
>> -
>> - =A0 =A0 return result;
>> -}
>> -EXPORT_SYMBOL(of_translate_address);
>> -
>> -const u32 *of_get_address(struct device_node *dev, int index, u64 *size=
,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int *flags)
>> -{
>> - =A0 =A0 const u32 *prop;
>> - =A0 =A0 unsigned int psize;
>> - =A0 =A0 struct device_node *parent;
>> - =A0 =A0 struct of_bus *bus;
>> - =A0 =A0 int onesize, i, na, ns;
>> -
>> - =A0 =A0 /* Get parent & match bus type */
>> - =A0 =A0 parent =3D of_get_parent(dev);
>> - =A0 =A0 if (parent =3D=3D NULL)
>> - =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
>> - =A0 =A0 bus =3D of_match_bus(parent);
>> - =A0 =A0 bus->count_cells(dev, &na, &ns);
>> - =A0 =A0 of_node_put(parent);
>> - =A0 =A0 if (!OF_CHECK_COUNTS(na, ns))
>> - =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
>> -
>> - =A0 =A0 /* Get "reg" or "assigned-addresses" property */
>> - =A0 =A0 prop =3D of_get_property(dev, bus->addresses, (int *) &psize);
>> - =A0 =A0 if (prop =3D=3D NULL)
>> - =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
>> - =A0 =A0 psize /=3D 4;
>> -
>> - =A0 =A0 onesize =3D na + ns;
>> - =A0 =A0 for (i =3D 0; psize >=3D onesize; psize -=3D onesize, prop +=
=3D onesize, i++)
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (i =3D=3D index) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (size)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *size =3D of_r=
ead_number(prop + na, ns);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (flags)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *flags =3D bus=
->get_flags(prop);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return prop;
>> - =A0 =A0 =A0 =A0 =A0 =A0 }
>> - =A0 =A0 return NULL;
>> -}
>> -EXPORT_SYMBOL(of_get_address);
>> -
>> =A0void of_parse_dma_window(struct device_node *dn, const void *dma_wind=
ow_prop,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned long *busno, unsigned long *phys, u=
nsigned long *size)
>> =A0{
>> diff --git a/arch/powerpc/include/asm/prom.h b/arch/powerpc/include/asm/=
prom.h
>> index e1c1bdd..8e1d0fe 100644
>> --- a/arch/powerpc/include/asm/prom.h
>> +++ b/arch/powerpc/include/asm/prom.h
>> @@ -45,10 +45,6 @@ extern void pci_create_OF_bus_map(void);
>> =A0 * OF address retreival & translation
>> =A0 */
>>
>> -/* Translate an OF address block into a CPU physical address
>> - */
>> -extern u64 of_translate_address(struct device_node *np, const u32 *addr=
);
>> -
>> =A0/* Translate a DMA address from device space to CPU space */
>> =A0extern u64 of_translate_dma_address(struct device_node *dev,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cons=
t u32 *in_addr);
>> diff --git a/arch/powerpc/kernel/prom_parse.c b/arch/powerpc/kernel/prom=
_parse.c
>> index a2ef129..64f2606 100644
>> --- a/arch/powerpc/kernel/prom_parse.c
>> +++ b/arch/powerpc/kernel/prom_parse.c
>> @@ -10,225 +10,7 @@
>> =A0#include <asm/prom.h>
>> =A0#include <asm/pci-bridge.h>
>>
>> -#ifdef DEBUG
>> -#define DBG(fmt...) do { printk(fmt); } while(0)
>> -#else
>> -#define DBG(fmt...) do { } while(0)
>> -#endif
>> -
>> -#ifdef CONFIG_PPC64
>> -#define PRu64 =A0 =A0 =A0 =A0"%lx"
>> -#else
>> -#define PRu64 =A0 =A0 =A0 =A0"%llx"
>> -#endif
>> -
>> -/* Max address size we deal with */
>> -#define OF_MAX_ADDR_CELLS =A0 =A04
>> -#define OF_CHECK_COUNTS(na, ns) =A0 =A0 =A0((na) > 0 && (na) <=3D OF_MA=
X_ADDR_CELLS && \
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (ns) > 0)
>> -
>> -static struct of_bus *of_match_bus(struct device_node *np);
>> -
>> -/* Debug utility */
>> -#ifdef DEBUG
>> -static void of_dump_addr(const char *s, const u32 *addr, int na)
>> -{
>> - =A0 =A0 printk("%s", s);
>> - =A0 =A0 while(na--)
>> - =A0 =A0 =A0 =A0 =A0 =A0 printk(" %08x", *(addr++));
>> - =A0 =A0 printk("\n");
>> -}
>> -#else
>> -static void of_dump_addr(const char *s, const u32 *addr, int na) { }
>> -#endif
>> -
>> -
>> -/* Callbacks for bus specific translators */
>> -struct of_bus {
>> - =A0 =A0 const char =A0 =A0 =A0*name;
>> - =A0 =A0 const char =A0 =A0 =A0*addresses;
>> - =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 (*match)(struct device_node *paren=
t);
>> - =A0 =A0 void =A0 =A0 =A0 =A0 =A0 =A0(*count_cells)(struct device_node =
*child,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0int *addrc, int *sizec);
>> - =A0 =A0 u64 =A0 =A0 =A0 =A0 =A0 =A0 (*map)(u32 *addr, const u32 *range=
,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int na, int ns=
, int pna);
>> - =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 (*translate)(u32 *addr, u64 offset=
, int na);
>> - =A0 =A0 unsigned int =A0 =A0(*get_flags)(const u32 *addr);
>> -};
>> -
>> -
>> -/*
>> - * Default translator (generic bus)
>> - */
>> -
>> -static void of_bus_default_count_cells(struct device_node *dev,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0int *addrc, int *sizec)
>> -{
>> - =A0 =A0 if (addrc)
>> - =A0 =A0 =A0 =A0 =A0 =A0 *addrc =3D of_n_addr_cells(dev);
>> - =A0 =A0 if (sizec)
>> - =A0 =A0 =A0 =A0 =A0 =A0 *sizec =3D of_n_size_cells(dev);
>> -}
>> -
>> -static u64 of_bus_default_map(u32 *addr, const u32 *range,
>> - =A0 =A0 =A0 =A0 =A0 =A0 int na, int ns, int pna)
>> -{
>> - =A0 =A0 u64 cp, s, da;
>> -
>> - =A0 =A0 cp =3D of_read_number(range, na);
>> - =A0 =A0 s =A0=3D of_read_number(range + na + pna, ns);
>> - =A0 =A0 da =3D of_read_number(addr, na);
>> -
>> - =A0 =A0 DBG("OF: default map, cp=3D"PRu64", s=3D"PRu64", da=3D"PRu64"\=
n",
>> - =A0 =A0 =A0 =A0 cp, s, da);
>> -
>> - =A0 =A0 if (da < cp || da >=3D (cp + s))
>> - =A0 =A0 =A0 =A0 =A0 =A0 return OF_BAD_ADDR;
>> - =A0 =A0 return da - cp;
>> -}
>> -
>> -static int of_bus_default_translate(u32 *addr, u64 offset, int na)
>> -{
>> - =A0 =A0 u64 a =3D of_read_number(addr, na);
>> - =A0 =A0 memset(addr, 0, na * 4);
>> - =A0 =A0 a +=3D offset;
>> - =A0 =A0 if (na > 1)
>> - =A0 =A0 =A0 =A0 =A0 =A0 addr[na - 2] =3D a >> 32;
>> - =A0 =A0 addr[na - 1] =3D a & 0xffffffffu;
>> -
>> - =A0 =A0 return 0;
>> -}
>> -
>> -static unsigned int of_bus_default_get_flags(const u32 *addr)
>> -{
>> - =A0 =A0 return IORESOURCE_MEM;
>> -}
>> -
>> -
>> =A0#ifdef CONFIG_PCI
>> -/*
>> - * PCI bus specific translator
>> - */
>> -
>> -static int of_bus_pci_match(struct device_node *np)
>> -{
>> - =A0 =A0 /* "vci" is for the /chaos bridge on 1st-gen PCI powermacs */
>> - =A0 =A0 return !strcmp(np->type, "pci") || !strcmp(np->type, "vci");
>> -}
>> -
>> -static void of_bus_pci_count_cells(struct device_node *np,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int *ad=
drc, int *sizec)
>> -{
>> - =A0 =A0 if (addrc)
>> - =A0 =A0 =A0 =A0 =A0 =A0 *addrc =3D 3;
>> - =A0 =A0 if (sizec)
>> - =A0 =A0 =A0 =A0 =A0 =A0 *sizec =3D 2;
>> -}
>> -
>> -static unsigned int of_bus_pci_get_flags(const u32 *addr)
>> -{
>> - =A0 =A0 unsigned int flags =3D 0;
>> - =A0 =A0 u32 w =3D addr[0];
>> -
>> - =A0 =A0 switch((w >> 24) & 0x03) {
>> - =A0 =A0 case 0x01:
>> - =A0 =A0 =A0 =A0 =A0 =A0 flags |=3D IORESOURCE_IO;
>> - =A0 =A0 =A0 =A0 =A0 =A0 break;
>> - =A0 =A0 case 0x02: /* 32 bits */
>> - =A0 =A0 case 0x03: /* 64 bits */
>> - =A0 =A0 =A0 =A0 =A0 =A0 flags |=3D IORESOURCE_MEM;
>> - =A0 =A0 =A0 =A0 =A0 =A0 break;
>> - =A0 =A0 }
>> - =A0 =A0 if (w & 0x40000000)
>> - =A0 =A0 =A0 =A0 =A0 =A0 flags |=3D IORESOURCE_PREFETCH;
>> - =A0 =A0 return flags;
>> -}
>> -
>> -static u64 of_bus_pci_map(u32 *addr, const u32 *range, int na, int ns, =
int pna)
>> -{
>> - =A0 =A0 u64 cp, s, da;
>> - =A0 =A0 unsigned int af, rf;
>> -
>> - =A0 =A0 af =3D of_bus_pci_get_flags(addr);
>> - =A0 =A0 rf =3D of_bus_pci_get_flags(range);
>> -
>> - =A0 =A0 /* Check address type match */
>> - =A0 =A0 if ((af ^ rf) & (IORESOURCE_MEM | IORESOURCE_IO))
>> - =A0 =A0 =A0 =A0 =A0 =A0 return OF_BAD_ADDR;
>> -
>> - =A0 =A0 /* Read address values, skipping high cell */
>> - =A0 =A0 cp =3D of_read_number(range + 1, na - 1);
>> - =A0 =A0 s =A0=3D of_read_number(range + na + pna, ns);
>> - =A0 =A0 da =3D of_read_number(addr + 1, na - 1);
>> -
>> - =A0 =A0 DBG("OF: PCI map, cp=3D"PRu64", s=3D"PRu64", da=3D"PRu64"\n", =
cp, s, da);
>> -
>> - =A0 =A0 if (da < cp || da >=3D (cp + s))
>> - =A0 =A0 =A0 =A0 =A0 =A0 return OF_BAD_ADDR;
>> - =A0 =A0 return da - cp;
>> -}
>> -
>> -static int of_bus_pci_translate(u32 *addr, u64 offset, int na)
>> -{
>> - =A0 =A0 return of_bus_default_translate(addr + 1, offset, na - 1);
>> -}
>> -
>> -const u32 *of_get_pci_address(struct device_node *dev, int bar_no, u64 =
*size,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int *flags)
>> -{
>> - =A0 =A0 const u32 *prop;
>> - =A0 =A0 unsigned int psize;
>> - =A0 =A0 struct device_node *parent;
>> - =A0 =A0 struct of_bus *bus;
>> - =A0 =A0 int onesize, i, na, ns;
>> -
>> - =A0 =A0 /* Get parent & match bus type */
>> - =A0 =A0 parent =3D of_get_parent(dev);
>> - =A0 =A0 if (parent =3D=3D NULL)
>> - =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
>> - =A0 =A0 bus =3D of_match_bus(parent);
>> - =A0 =A0 if (strcmp(bus->name, "pci")) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 of_node_put(parent);
>> - =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
>> - =A0 =A0 }
>> - =A0 =A0 bus->count_cells(dev, &na, &ns);
>> - =A0 =A0 of_node_put(parent);
>> - =A0 =A0 if (!OF_CHECK_COUNTS(na, ns))
>> - =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
>> -
>> - =A0 =A0 /* Get "reg" or "assigned-addresses" property */
>> - =A0 =A0 prop =3D of_get_property(dev, bus->addresses, &psize);
>> - =A0 =A0 if (prop =3D=3D NULL)
>> - =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
>> - =A0 =A0 psize /=3D 4;
>> -
>> - =A0 =A0 onesize =3D na + ns;
>> - =A0 =A0 for (i =3D 0; psize >=3D onesize; psize -=3D onesize, prop +=
=3D onesize, i++)
>> - =A0 =A0 =A0 =A0 =A0 =A0 if ((prop[0] & 0xff) =3D=3D ((bar_no * 4) + PC=
I_BASE_ADDRESS_0)) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (size)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *size =3D of_r=
ead_number(prop + na, ns);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (flags)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *flags =3D bus=
->get_flags(prop);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return prop;
>> - =A0 =A0 =A0 =A0 =A0 =A0 }
>> - =A0 =A0 return NULL;
>> -}
>> -EXPORT_SYMBOL(of_get_pci_address);
>> -
>> -int of_pci_address_to_resource(struct device_node *dev, int bar,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct resource=
 *r)
>> -{
>> - =A0 =A0 const u32 =A0 =A0 =A0 *addrp;
>> - =A0 =A0 u64 =A0 =A0 =A0 =A0 =A0 =A0 size;
>> - =A0 =A0 unsigned int =A0 =A0flags;
>> -
>> - =A0 =A0 addrp =3D of_get_pci_address(dev, bar, &size, &flags);
>> - =A0 =A0 if (addrp =3D=3D NULL)
>> - =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> - =A0 =A0 return __of_address_to_resource(dev, addrp, size, flags, r);
>> -}
>> -EXPORT_SYMBOL_GPL(of_pci_address_to_resource);
>> -
>> =A0int of_irq_map_pci(struct pci_dev *pdev, struct of_irq *out_irq)
>> =A0{
>> =A0 =A0 =A0 struct device_node *dn, *ppnode;
>> @@ -310,303 +92,6 @@ int of_irq_map_pci(struct pci_dev *pdev, struct of_=
irq *out_irq)
>> =A0EXPORT_SYMBOL_GPL(of_irq_map_pci);
>> =A0#endif /* CONFIG_PCI */
>>
>> -/*
>> - * ISA bus specific translator
>> - */
>> -
>> -static int of_bus_isa_match(struct device_node *np)
>> -{
>> - =A0 =A0 return !strcmp(np->name, "isa");
>> -}
>> -
>> -static void of_bus_isa_count_cells(struct device_node *child,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int *ad=
drc, int *sizec)
>> -{
>> - =A0 =A0 if (addrc)
>> - =A0 =A0 =A0 =A0 =A0 =A0 *addrc =3D 2;
>> - =A0 =A0 if (sizec)
>> - =A0 =A0 =A0 =A0 =A0 =A0 *sizec =3D 1;
>> -}
>> -
>> -static u64 of_bus_isa_map(u32 *addr, const u32 *range, int na, int ns, =
int pna)
>> -{
>> - =A0 =A0 u64 cp, s, da;
>> -
>> - =A0 =A0 /* Check address type match */
>> - =A0 =A0 if ((addr[0] ^ range[0]) & 0x00000001)
>> - =A0 =A0 =A0 =A0 =A0 =A0 return OF_BAD_ADDR;
>> -
>> - =A0 =A0 /* Read address values, skipping high cell */
>> - =A0 =A0 cp =3D of_read_number(range + 1, na - 1);
>> - =A0 =A0 s =A0=3D of_read_number(range + na + pna, ns);
>> - =A0 =A0 da =3D of_read_number(addr + 1, na - 1);
>> -
>> - =A0 =A0 DBG("OF: ISA map, cp=3D"PRu64", s=3D"PRu64", da=3D"PRu64"\n", =
cp, s, da);
>> -
>> - =A0 =A0 if (da < cp || da >=3D (cp + s))
>> - =A0 =A0 =A0 =A0 =A0 =A0 return OF_BAD_ADDR;
>> - =A0 =A0 return da - cp;
>> -}
>> -
>> -static int of_bus_isa_translate(u32 *addr, u64 offset, int na)
>> -{
>> - =A0 =A0 return of_bus_default_translate(addr + 1, offset, na - 1);
>> -}
>> -
>> -static unsigned int of_bus_isa_get_flags(const u32 *addr)
>> -{
>> - =A0 =A0 unsigned int flags =3D 0;
>> - =A0 =A0 u32 w =3D addr[0];
>> -
>> - =A0 =A0 if (w & 1)
>> - =A0 =A0 =A0 =A0 =A0 =A0 flags |=3D IORESOURCE_IO;
>> - =A0 =A0 else
>> - =A0 =A0 =A0 =A0 =A0 =A0 flags |=3D IORESOURCE_MEM;
>> - =A0 =A0 return flags;
>> -}
>> -
>> -
>> -/*
>> - * Array of bus specific translators
>> - */
>> -
>> -static struct of_bus of_busses[] =3D {
>> -#ifdef CONFIG_PCI
>> - =A0 =A0 /* PCI */
>> - =A0 =A0 {
>> - =A0 =A0 =A0 =A0 =A0 =A0 .name =3D "pci",
>> - =A0 =A0 =A0 =A0 =A0 =A0 .addresses =3D "assigned-addresses",
>> - =A0 =A0 =A0 =A0 =A0 =A0 .match =3D of_bus_pci_match,
>> - =A0 =A0 =A0 =A0 =A0 =A0 .count_cells =3D of_bus_pci_count_cells,
>> - =A0 =A0 =A0 =A0 =A0 =A0 .map =3D of_bus_pci_map,
>> - =A0 =A0 =A0 =A0 =A0 =A0 .translate =3D of_bus_pci_translate,
>> - =A0 =A0 =A0 =A0 =A0 =A0 .get_flags =3D of_bus_pci_get_flags,
>> - =A0 =A0 },
>> -#endif /* CONFIG_PCI */
>> - =A0 =A0 /* ISA */
>> - =A0 =A0 {
>> - =A0 =A0 =A0 =A0 =A0 =A0 .name =3D "isa",
>> - =A0 =A0 =A0 =A0 =A0 =A0 .addresses =3D "reg",
>> - =A0 =A0 =A0 =A0 =A0 =A0 .match =3D of_bus_isa_match,
>> - =A0 =A0 =A0 =A0 =A0 =A0 .count_cells =3D of_bus_isa_count_cells,
>> - =A0 =A0 =A0 =A0 =A0 =A0 .map =3D of_bus_isa_map,
>> - =A0 =A0 =A0 =A0 =A0 =A0 .translate =3D of_bus_isa_translate,
>> - =A0 =A0 =A0 =A0 =A0 =A0 .get_flags =3D of_bus_isa_get_flags,
>> - =A0 =A0 },
>> - =A0 =A0 /* Default */
>> - =A0 =A0 {
>> - =A0 =A0 =A0 =A0 =A0 =A0 .name =3D "default",
>> - =A0 =A0 =A0 =A0 =A0 =A0 .addresses =3D "reg",
>> - =A0 =A0 =A0 =A0 =A0 =A0 .match =3D NULL,
>> - =A0 =A0 =A0 =A0 =A0 =A0 .count_cells =3D of_bus_default_count_cells,
>> - =A0 =A0 =A0 =A0 =A0 =A0 .map =3D of_bus_default_map,
>> - =A0 =A0 =A0 =A0 =A0 =A0 .translate =3D of_bus_default_translate,
>> - =A0 =A0 =A0 =A0 =A0 =A0 .get_flags =3D of_bus_default_get_flags,
>> - =A0 =A0 },
>> -};
>> -
>> -static struct of_bus *of_match_bus(struct device_node *np)
>> -{
>> - =A0 =A0 int i;
>> -
>> - =A0 =A0 for (i =3D 0; i < ARRAY_SIZE(of_busses); i ++)
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (!of_busses[i].match || of_busses[i].match(=
np))
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return &of_busses[i];
>> - =A0 =A0 BUG();
>> - =A0 =A0 return NULL;
>> -}
>> -
>> -static int of_translate_one(struct device_node *parent, struct of_bus *=
bus,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct of_bus *pbus, u=
32 *addr,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int na, int ns, int pn=
a, const char *rprop)
>> -{
>> - =A0 =A0 const u32 *ranges;
>> - =A0 =A0 unsigned int rlen;
>> - =A0 =A0 int rone;
>> - =A0 =A0 u64 offset =3D OF_BAD_ADDR;
>> -
>> - =A0 =A0 /* Normally, an absence of a "ranges" property means we are
>> - =A0 =A0 =A0* crossing a non-translatable boundary, and thus the addres=
ses
>> - =A0 =A0 =A0* below the current not cannot be converted to CPU physical=
 ones.
>> - =A0 =A0 =A0* Unfortunately, while this is very clear in the spec, it's=
 not
>> - =A0 =A0 =A0* what Apple understood, and they do have things like /uni-=
n or
>> - =A0 =A0 =A0* /ht nodes with no "ranges" property and a lot of perfectl=
y
>> - =A0 =A0 =A0* useable mapped devices below them. Thus we treat the abse=
nce of
>> - =A0 =A0 =A0* "ranges" as equivalent to an empty "ranges" property whic=
h means
>> - =A0 =A0 =A0* a 1:1 translation at that level. It's up to the caller no=
t to try
>> - =A0 =A0 =A0* to translate addresses that aren't supposed to be transla=
ted in
>> - =A0 =A0 =A0* the first place. --BenH.
>> - =A0 =A0 =A0*/
>> - =A0 =A0 ranges =3D of_get_property(parent, rprop, &rlen);
>> - =A0 =A0 if (ranges =3D=3D NULL || rlen =3D=3D 0) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 offset =3D of_read_number(addr, na);
>> - =A0 =A0 =A0 =A0 =A0 =A0 memset(addr, 0, pna * 4);
>> - =A0 =A0 =A0 =A0 =A0 =A0 DBG("OF: no ranges, 1:1 translation\n");
>> - =A0 =A0 =A0 =A0 =A0 =A0 goto finish;
>> - =A0 =A0 }
>> -
>> - =A0 =A0 DBG("OF: walking ranges...\n");
>> -
>> - =A0 =A0 /* Now walk through the ranges */
>> - =A0 =A0 rlen /=3D 4;
>> - =A0 =A0 rone =3D na + pna + ns;
>> - =A0 =A0 for (; rlen >=3D rone; rlen -=3D rone, ranges +=3D rone) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 offset =3D bus->map(addr, ranges, na, ns, pna)=
;
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (offset !=3D OF_BAD_ADDR)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> - =A0 =A0 }
>> - =A0 =A0 if (offset =3D=3D OF_BAD_ADDR) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 DBG("OF: not found !\n");
>> - =A0 =A0 =A0 =A0 =A0 =A0 return 1;
>> - =A0 =A0 }
>> - =A0 =A0 memcpy(addr, ranges + na, 4 * pna);
>> -
>> - finish:
>> - =A0 =A0 of_dump_addr("OF: parent translation for:", addr, pna);
>> - =A0 =A0 DBG("OF: with offset: "PRu64"\n", offset);
>> -
>> - =A0 =A0 /* Translate it into parent bus space */
>> - =A0 =A0 return pbus->translate(addr, offset, pna);
>> -}
>> -
>> -
>> -/*
>> - * Translate an address from the device-tree into a CPU physical addres=
s,
>> - * this walks up the tree and applies the various bus mappings on the
>> - * way.
>> - *
>> - * Note: We consider that crossing any level with #size-cells =3D=3D 0 =
to mean
>> - * that translation is impossible (that is we are not dealing with a va=
lue
>> - * that can be mapped to a cpu physical address). This is not really sp=
ecified
>> - * that way, but this is traditionally the way IBM at least do things
>> - */
>> -u64 __of_translate_address(struct device_node *dev, const u32 *in_addr,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0const char *rprop)
>> -{
>> - =A0 =A0 struct device_node *parent =3D NULL;
>> - =A0 =A0 struct of_bus *bus, *pbus;
>> - =A0 =A0 u32 addr[OF_MAX_ADDR_CELLS];
>> - =A0 =A0 int na, ns, pna, pns;
>> - =A0 =A0 u64 result =3D OF_BAD_ADDR;
>> -
>> - =A0 =A0 DBG("OF: ** translation for device %s **\n", dev->full_name);
>> -
>> - =A0 =A0 /* Increase refcount at current level */
>> - =A0 =A0 of_node_get(dev);
>> -
>> - =A0 =A0 /* Get parent & match bus type */
>> - =A0 =A0 parent =3D of_get_parent(dev);
>> - =A0 =A0 if (parent =3D=3D NULL)
>> - =A0 =A0 =A0 =A0 =A0 =A0 goto bail;
>> - =A0 =A0 bus =3D of_match_bus(parent);
>> -
>> - =A0 =A0 /* Cound address cells & copy address locally */
>> - =A0 =A0 bus->count_cells(dev, &na, &ns);
>> - =A0 =A0 if (!OF_CHECK_COUNTS(na, ns)) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "prom_parse: Bad cell count fo=
r %s\n",
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev->full_name);
>> - =A0 =A0 =A0 =A0 =A0 =A0 goto bail;
>> - =A0 =A0 }
>> - =A0 =A0 memcpy(addr, in_addr, na * 4);
>> -
>> - =A0 =A0 DBG("OF: bus is %s (na=3D%d, ns=3D%d) on %s\n",
>> - =A0 =A0 =A0 =A0 bus->name, na, ns, parent->full_name);
>> - =A0 =A0 of_dump_addr("OF: translating address:", addr, na);
>> -
>> - =A0 =A0 /* Translate */
>> - =A0 =A0 for (;;) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 /* Switch to parent bus */
>> - =A0 =A0 =A0 =A0 =A0 =A0 of_node_put(dev);
>> - =A0 =A0 =A0 =A0 =A0 =A0 dev =3D parent;
>> - =A0 =A0 =A0 =A0 =A0 =A0 parent =3D of_get_parent(dev);
>> -
>> - =A0 =A0 =A0 =A0 =A0 =A0 /* If root, we have finished */
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (parent =3D=3D NULL) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DBG("OF: reached root node\n")=
;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 result =3D of_read_number(addr=
, na);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> - =A0 =A0 =A0 =A0 =A0 =A0 }
>> -
>> - =A0 =A0 =A0 =A0 =A0 =A0 /* Get new parent bus and counts */
>> - =A0 =A0 =A0 =A0 =A0 =A0 pbus =3D of_match_bus(parent);
>> - =A0 =A0 =A0 =A0 =A0 =A0 pbus->count_cells(dev, &pna, &pns);
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (!OF_CHECK_COUNTS(pna, pns)) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "prom_parse: B=
ad cell count for %s\n",
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev->full_name)=
;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> - =A0 =A0 =A0 =A0 =A0 =A0 }
>> -
>> - =A0 =A0 =A0 =A0 =A0 =A0 DBG("OF: parent bus is %s (na=3D%d, ns=3D%d) o=
n %s\n",
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pbus->name, pna, pns, parent->full_nam=
e);
>> -
>> - =A0 =A0 =A0 =A0 =A0 =A0 /* Apply bus translation */
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (of_translate_one(dev, bus, pbus, addr, na,=
 ns, pna, rprop))
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> -
>> - =A0 =A0 =A0 =A0 =A0 =A0 /* Complete the move up one level */
>> - =A0 =A0 =A0 =A0 =A0 =A0 na =3D pna;
>> - =A0 =A0 =A0 =A0 =A0 =A0 ns =3D pns;
>> - =A0 =A0 =A0 =A0 =A0 =A0 bus =3D pbus;
>> -
>> - =A0 =A0 =A0 =A0 =A0 =A0 of_dump_addr("OF: one level translation:", add=
r, na);
>> - =A0 =A0 }
>> - bail:
>> - =A0 =A0 of_node_put(parent);
>> - =A0 =A0 of_node_put(dev);
>> -
>> - =A0 =A0 return result;
>> -}
>> -
>> -u64 of_translate_address(struct device_node *dev, const u32 *in_addr)
>> -{
>> - =A0 =A0 return __of_translate_address(dev, in_addr, "ranges");
>> -}
>> -EXPORT_SYMBOL(of_translate_address);
>> -
>> -u64 of_translate_dma_address(struct device_node *dev, const u32 *in_add=
r)
>> -{
>> - =A0 =A0 return __of_translate_address(dev, in_addr, "dma-ranges");
>> -}
>> -EXPORT_SYMBOL(of_translate_dma_address);
>> -
>> -const u32 *of_get_address(struct device_node *dev, int index, u64 *size=
,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int *flags)
>> -{
>> - =A0 =A0 const u32 *prop;
>> - =A0 =A0 unsigned int psize;
>> - =A0 =A0 struct device_node *parent;
>> - =A0 =A0 struct of_bus *bus;
>> - =A0 =A0 int onesize, i, na, ns;
>> -
>> - =A0 =A0 /* Get parent & match bus type */
>> - =A0 =A0 parent =3D of_get_parent(dev);
>> - =A0 =A0 if (parent =3D=3D NULL)
>> - =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
>> - =A0 =A0 bus =3D of_match_bus(parent);
>> - =A0 =A0 bus->count_cells(dev, &na, &ns);
>> - =A0 =A0 of_node_put(parent);
>> - =A0 =A0 if (!OF_CHECK_COUNTS(na, ns))
>> - =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
>> -
>> - =A0 =A0 /* Get "reg" or "assigned-addresses" property */
>> - =A0 =A0 prop =3D of_get_property(dev, bus->addresses, &psize);
>> - =A0 =A0 if (prop =3D=3D NULL)
>> - =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
>> - =A0 =A0 psize /=3D 4;
>> -
>> - =A0 =A0 onesize =3D na + ns;
>> - =A0 =A0 for (i =3D 0; psize >=3D onesize; psize -=3D onesize, prop +=
=3D onesize, i++)
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (i =3D=3D index) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (size)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *size =3D of_r=
ead_number(prop + na, ns);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (flags)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *flags =3D bus=
->get_flags(prop);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return prop;
>> - =A0 =A0 =A0 =A0 =A0 =A0 }
>> - =A0 =A0 return NULL;
>> -}
>> -EXPORT_SYMBOL(of_get_address);
>> -
>> =A0void of_parse_dma_window(struct device_node *dn, const void *dma_wind=
ow_prop,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned long *busno, unsigned long *phys, u=
nsigned long *size)
>> =A0{
>> diff --git a/drivers/of/address.c b/drivers/of/address.c
>> index c381955..2a905d5 100644
>> --- a/drivers/of/address.c
>> +++ b/drivers/of/address.c
>> @@ -1,11 +1,522 @@
>>
>> =A0#include <linux/io.h>
>> =A0#include <linux/ioport.h>
>> +#include <linux/module.h>
>> =A0#include <linux/of_address.h>
>> +#include <linux/pci_regs.h>
>> +#include <linux/string.h>
>>
>> -int __of_address_to_resource(struct device_node *dev, const u32 *addrp,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0u64 size, unsigned =
int flags,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct resource *r)
>> +/* Max address size we deal with */
>> +#define OF_MAX_ADDR_CELLS =A0 =A04
>> +#define OF_CHECK_COUNTS(na, ns) =A0 =A0 =A0((na) > 0 && (na) <=3D OF_MA=
X_ADDR_CELLS && \
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (ns) > 0)
>> +
>> +static struct of_bus *of_match_bus(struct device_node *np);
>> +static int __of_address_to_resource(struct device_node *dev, const u32 =
*addrp,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 u64 si=
ze, unsigned int flags,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct=
 resource *r);
>> +
>> +/* Debug utility */
>> +#ifdef DEBUG
>> +static void of_dump_addr(const char *s, const u32 *addr, int na)
>> +{
>> + =A0 =A0 printk(KERN_DEBUG "%s", s);
>> + =A0 =A0 while (na--)
>> + =A0 =A0 =A0 =A0 =A0 =A0 printk(" %08x", *(addr++));
>> + =A0 =A0 printk("\n");
>> +}
>> +#else
>> +static void of_dump_addr(const char *s, const u32 *addr, int na) { }
>> +#endif
>> +
>> +/* Callbacks for bus specific translators */
>> +struct of_bus {
>> + =A0 =A0 const char =A0 =A0 =A0*name;
>> + =A0 =A0 const char =A0 =A0 =A0*addresses;
>> + =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 (*match)(struct device_node *paren=
t);
>> + =A0 =A0 void =A0 =A0 =A0 =A0 =A0 =A0(*count_cells)(struct device_node =
*child,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0int *addrc, int *sizec);
>> + =A0 =A0 u64 =A0 =A0 =A0 =A0 =A0 =A0 (*map)(u32 *addr, const u32 *range=
,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int na, int ns=
, int pna);
>> + =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 (*translate)(u32 *addr, u64 offset=
, int na);
>> + =A0 =A0 unsigned int =A0 =A0(*get_flags)(const u32 *addr);
>> +};
>> +
>> +/*
>> + * Default translator (generic bus)
>> + */
>> +
>> +static void of_bus_default_count_cells(struct device_node *dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0int *addrc, int *sizec)
>> +{
>> + =A0 =A0 if (addrc)
>> + =A0 =A0 =A0 =A0 =A0 =A0 *addrc =3D of_n_addr_cells(dev);
>> + =A0 =A0 if (sizec)
>> + =A0 =A0 =A0 =A0 =A0 =A0 *sizec =3D of_n_size_cells(dev);
>> +}
>> +
>> +static u64 of_bus_default_map(u32 *addr, const u32 *range,
>> + =A0 =A0 =A0 =A0 =A0 =A0 int na, int ns, int pna)
>> +{
>> + =A0 =A0 u64 cp, s, da;
>> +
>> + =A0 =A0 cp =3D of_read_number(range, na);
>> + =A0 =A0 s =A0=3D of_read_number(range + na + pna, ns);
>> + =A0 =A0 da =3D of_read_number(addr, na);
>> +
>> + =A0 =A0 pr_debug("OF: default map, cp=3D%llx, s=3D%llx, da=3D%llx\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0(unsigned long long)cp, (unsigned long long=
)s,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0(unsigned long long)da);
>> +
>> + =A0 =A0 if (da < cp || da >=3D (cp + s))
>> + =A0 =A0 =A0 =A0 =A0 =A0 return OF_BAD_ADDR;
>> + =A0 =A0 return da - cp;
>> +}
>> +
>> +static int of_bus_default_translate(u32 *addr, u64 offset, int na)
>> +{
>> + =A0 =A0 u64 a =3D of_read_number(addr, na);
>> + =A0 =A0 memset(addr, 0, na * 4);
>> + =A0 =A0 a +=3D offset;
>> + =A0 =A0 if (na > 1)
>> + =A0 =A0 =A0 =A0 =A0 =A0 addr[na - 2] =3D a >> 32;
>> + =A0 =A0 addr[na - 1] =3D a & 0xffffffffu;
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static unsigned int of_bus_default_get_flags(const u32 *addr)
>> +{
>> + =A0 =A0 return IORESOURCE_MEM;
>> +}
>> +
>> +#ifdef CONFIG_PCI
>> +/*
>> + * PCI bus specific translator
>> + */
>> +
>> +static int of_bus_pci_match(struct device_node *np)
>> +{
>> + =A0 =A0 /* "vci" is for the /chaos bridge on 1st-gen PCI powermacs */
>> + =A0 =A0 return !strcmp(np->type, "pci") || !strcmp(np->type, "vci");
>> +}
>> +
>> +static void of_bus_pci_count_cells(struct device_node *np,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int *ad=
drc, int *sizec)
>> +{
>> + =A0 =A0 if (addrc)
>> + =A0 =A0 =A0 =A0 =A0 =A0 *addrc =3D 3;
>> + =A0 =A0 if (sizec)
>> + =A0 =A0 =A0 =A0 =A0 =A0 *sizec =3D 2;
>> +}
>> +
>> +static unsigned int of_bus_pci_get_flags(const u32 *addr)
>> +{
>> + =A0 =A0 unsigned int flags =3D 0;
>> + =A0 =A0 u32 w =3D addr[0];
>> +
>> + =A0 =A0 switch((w >> 24) & 0x03) {
>> + =A0 =A0 case 0x01:
>> + =A0 =A0 =A0 =A0 =A0 =A0 flags |=3D IORESOURCE_IO;
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 case 0x02: /* 32 bits */
>> + =A0 =A0 case 0x03: /* 64 bits */
>> + =A0 =A0 =A0 =A0 =A0 =A0 flags |=3D IORESOURCE_MEM;
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 }
>> + =A0 =A0 if (w & 0x40000000)
>> + =A0 =A0 =A0 =A0 =A0 =A0 flags |=3D IORESOURCE_PREFETCH;
>> + =A0 =A0 return flags;
>> +}
>> +
>> +static u64 of_bus_pci_map(u32 *addr, const u32 *range, int na, int ns, =
int pna)
>> +{
>> + =A0 =A0 u64 cp, s, da;
>> + =A0 =A0 unsigned int af, rf;
>> +
>> + =A0 =A0 af =3D of_bus_pci_get_flags(addr);
>> + =A0 =A0 rf =3D of_bus_pci_get_flags(range);
>> +
>> + =A0 =A0 /* Check address type match */
>> + =A0 =A0 if ((af ^ rf) & (IORESOURCE_MEM | IORESOURCE_IO))
>> + =A0 =A0 =A0 =A0 =A0 =A0 return OF_BAD_ADDR;
>> +
>> + =A0 =A0 /* Read address values, skipping high cell */
>> + =A0 =A0 cp =3D of_read_number(range + 1, na - 1);
>> + =A0 =A0 s =A0=3D of_read_number(range + na + pna, ns);
>> + =A0 =A0 da =3D of_read_number(addr + 1, na - 1);
>> +
>> + =A0 =A0 pr_debug("OF: PCI map, cp=3D%llx, s=3D%llx, da=3D%llx\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0(unsigned long long)cp, (unsigned long long=
)s,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0(unsigned long long)da);
>> +
>> + =A0 =A0 if (da < cp || da >=3D (cp + s))
>> + =A0 =A0 =A0 =A0 =A0 =A0 return OF_BAD_ADDR;
>> + =A0 =A0 return da - cp;
>> +}
>> +
>> +static int of_bus_pci_translate(u32 *addr, u64 offset, int na)
>> +{
>> + =A0 =A0 return of_bus_default_translate(addr + 1, offset, na - 1);
>> +}
>> +
>> +const u32 *of_get_pci_address(struct device_node *dev, int bar_no, u64 =
*size,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int *flags)
>> +{
>> + =A0 =A0 const u32 *prop;
>> + =A0 =A0 unsigned int psize;
>> + =A0 =A0 struct device_node *parent;
>> + =A0 =A0 struct of_bus *bus;
>> + =A0 =A0 int onesize, i, na, ns;
>> +
>> + =A0 =A0 /* Get parent & match bus type */
>> + =A0 =A0 parent =3D of_get_parent(dev);
>> + =A0 =A0 if (parent =3D=3D NULL)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
>> + =A0 =A0 bus =3D of_match_bus(parent);
>> + =A0 =A0 if (strcmp(bus->name, "pci")) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 of_node_put(parent);
>> + =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
>> + =A0 =A0 }
>> + =A0 =A0 bus->count_cells(dev, &na, &ns);
>> + =A0 =A0 of_node_put(parent);
>> + =A0 =A0 if (!OF_CHECK_COUNTS(na, ns))
>> + =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
>> +
>> + =A0 =A0 /* Get "reg" or "assigned-addresses" property */
>> + =A0 =A0 prop =3D of_get_property(dev, bus->addresses, &psize);
>> + =A0 =A0 if (prop =3D=3D NULL)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
>> + =A0 =A0 psize /=3D 4;
>> +
>> + =A0 =A0 onesize =3D na + ns;
>> + =A0 =A0 for (i =3D 0; psize >=3D onesize; psize -=3D onesize, prop +=
=3D onesize, i++)
>> + =A0 =A0 =A0 =A0 =A0 =A0 if ((prop[0] & 0xff) =3D=3D ((bar_no * 4) + PC=
I_BASE_ADDRESS_0)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (size)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *size =3D of_r=
ead_number(prop + na, ns);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (flags)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *flags =3D bus=
->get_flags(prop);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return prop;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 return NULL;
>> +}
>> +EXPORT_SYMBOL(of_get_pci_address);
>> +
>> +int of_pci_address_to_resource(struct device_node *dev, int bar,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct resource=
 *r)
>> +{
>> + =A0 =A0 const u32 =A0 =A0 =A0 *addrp;
>> + =A0 =A0 u64 =A0 =A0 =A0 =A0 =A0 =A0 size;
>> + =A0 =A0 unsigned int =A0 =A0flags;
>> +
>> + =A0 =A0 addrp =3D of_get_pci_address(dev, bar, &size, &flags);
>> + =A0 =A0 if (addrp =3D=3D NULL)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> + =A0 =A0 return __of_address_to_resource(dev, addrp, size, flags, r);
>> +}
>> +EXPORT_SYMBOL_GPL(of_pci_address_to_resource);
>> +#endif /* CONFIG_PCI */
>> +
>> +/*
>> + * ISA bus specific translator
>> + */
>> +
>> +static int of_bus_isa_match(struct device_node *np)
>> +{
>> + =A0 =A0 return !strcmp(np->name, "isa");
>> +}
>> +
>> +static void of_bus_isa_count_cells(struct device_node *child,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int *ad=
drc, int *sizec)
>> +{
>> + =A0 =A0 if (addrc)
>> + =A0 =A0 =A0 =A0 =A0 =A0 *addrc =3D 2;
>> + =A0 =A0 if (sizec)
>> + =A0 =A0 =A0 =A0 =A0 =A0 *sizec =3D 1;
>> +}
>> +
>> +static u64 of_bus_isa_map(u32 *addr, const u32 *range, int na, int ns, =
int pna)
>> +{
>> + =A0 =A0 u64 cp, s, da;
>> +
>> + =A0 =A0 /* Check address type match */
>> + =A0 =A0 if ((addr[0] ^ range[0]) & 0x00000001)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return OF_BAD_ADDR;
>> +
>> + =A0 =A0 /* Read address values, skipping high cell */
>> + =A0 =A0 cp =3D of_read_number(range + 1, na - 1);
>> + =A0 =A0 s =A0=3D of_read_number(range + na + pna, ns);
>> + =A0 =A0 da =3D of_read_number(addr + 1, na - 1);
>> +
>> + =A0 =A0 pr_debug("OF: ISA map, cp=3D%llx, s=3D%llx, da=3D%llx\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0(unsigned long long)cp, (unsigned long long=
)s,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0(unsigned long long)da);
>> +
>> + =A0 =A0 if (da < cp || da >=3D (cp + s))
>> + =A0 =A0 =A0 =A0 =A0 =A0 return OF_BAD_ADDR;
>> + =A0 =A0 return da - cp;
>> +}
>> +
>> +static int of_bus_isa_translate(u32 *addr, u64 offset, int na)
>> +{
>> + =A0 =A0 return of_bus_default_translate(addr + 1, offset, na - 1);
>> +}
>> +
>> +static unsigned int of_bus_isa_get_flags(const u32 *addr)
>> +{
>> + =A0 =A0 unsigned int flags =3D 0;
>> + =A0 =A0 u32 w =3D addr[0];
>> +
>> + =A0 =A0 if (w & 1)
>> + =A0 =A0 =A0 =A0 =A0 =A0 flags |=3D IORESOURCE_IO;
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 flags |=3D IORESOURCE_MEM;
>> + =A0 =A0 return flags;
>> +}
>> +
>> +/*
>> + * Array of bus specific translators
>> + */
>> +
>> +static struct of_bus of_busses[] =3D {
>> +#ifdef CONFIG_PCI
>> + =A0 =A0 /* PCI */
>> + =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .name =3D "pci",
>> + =A0 =A0 =A0 =A0 =A0 =A0 .addresses =3D "assigned-addresses",
>> + =A0 =A0 =A0 =A0 =A0 =A0 .match =3D of_bus_pci_match,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .count_cells =3D of_bus_pci_count_cells,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .map =3D of_bus_pci_map,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .translate =3D of_bus_pci_translate,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .get_flags =3D of_bus_pci_get_flags,
>> + =A0 =A0 },
>> +#endif /* CONFIG_PCI */
>> + =A0 =A0 /* ISA */
>> + =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .name =3D "isa",
>> + =A0 =A0 =A0 =A0 =A0 =A0 .addresses =3D "reg",
>> + =A0 =A0 =A0 =A0 =A0 =A0 .match =3D of_bus_isa_match,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .count_cells =3D of_bus_isa_count_cells,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .map =3D of_bus_isa_map,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .translate =3D of_bus_isa_translate,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .get_flags =3D of_bus_isa_get_flags,
>> + =A0 =A0 },
>> + =A0 =A0 /* Default */
>> + =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .name =3D "default",
>> + =A0 =A0 =A0 =A0 =A0 =A0 .addresses =3D "reg",
>> + =A0 =A0 =A0 =A0 =A0 =A0 .match =3D NULL,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .count_cells =3D of_bus_default_count_cells,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .map =3D of_bus_default_map,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .translate =3D of_bus_default_translate,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .get_flags =3D of_bus_default_get_flags,
>> + =A0 =A0 },
>> +};
>> +
>> +static struct of_bus *of_match_bus(struct device_node *np)
>> +{
>> + =A0 =A0 int i;
>> +
>> + =A0 =A0 for (i =3D 0; i < ARRAY_SIZE(of_busses); i++)
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!of_busses[i].match || of_busses[i].match(=
np))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return &of_busses[i];
>> + =A0 =A0 BUG();
>> + =A0 =A0 return NULL;
>> +}
>> +
>> +static int of_translate_one(struct device_node *parent, struct of_bus *=
bus,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct of_bus *pbus, u=
32 *addr,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int na, int ns, int pn=
a, const char *rprop)
>> +{
>> + =A0 =A0 const u32 *ranges;
>> + =A0 =A0 unsigned int rlen;
>> + =A0 =A0 int rone;
>> + =A0 =A0 u64 offset =3D OF_BAD_ADDR;
>> +
>> + =A0 =A0 /* Normally, an absence of a "ranges" property means we are
>> + =A0 =A0 =A0* crossing a non-translatable boundary, and thus the addres=
ses
>> + =A0 =A0 =A0* below the current not cannot be converted to CPU physical=
 ones.
>> + =A0 =A0 =A0* Unfortunately, while this is very clear in the spec, it's=
 not
>> + =A0 =A0 =A0* what Apple understood, and they do have things like /uni-=
n or
>> + =A0 =A0 =A0* /ht nodes with no "ranges" property and a lot of perfectl=
y
>> + =A0 =A0 =A0* useable mapped devices below them. Thus we treat the abse=
nce of
>> + =A0 =A0 =A0* "ranges" as equivalent to an empty "ranges" property whic=
h means
>> + =A0 =A0 =A0* a 1:1 translation at that level. It's up to the caller no=
t to try
>> + =A0 =A0 =A0* to translate addresses that aren't supposed to be transla=
ted in
>> + =A0 =A0 =A0* the first place. --BenH.
>> + =A0 =A0 =A0*/
>> + =A0 =A0 ranges =3D of_get_property(parent, rprop, &rlen);
>> + =A0 =A0 if (ranges =3D=3D NULL || rlen =3D=3D 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 offset =3D of_read_number(addr, na);
>> + =A0 =A0 =A0 =A0 =A0 =A0 memset(addr, 0, pna * 4);
>> + =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("OF: no ranges, 1:1 translation\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto finish;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 pr_debug("OF: walking ranges...\n");
>> +
>> + =A0 =A0 /* Now walk through the ranges */
>> + =A0 =A0 rlen /=3D 4;
>> + =A0 =A0 rone =3D na + pna + ns;
>> + =A0 =A0 for (; rlen >=3D rone; rlen -=3D rone, ranges +=3D rone) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 offset =3D bus->map(addr, ranges, na, ns, pna)=
;
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (offset !=3D OF_BAD_ADDR)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 }
>> + =A0 =A0 if (offset =3D=3D OF_BAD_ADDR) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("OF: not found !\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return 1;
>> + =A0 =A0 }
>> + =A0 =A0 memcpy(addr, ranges + na, 4 * pna);
>> +
>> + finish:
>> + =A0 =A0 of_dump_addr("OF: parent translation for:", addr, pna);
>> + =A0 =A0 pr_debug("OF: with offset: %llx\n", (unsigned long long)offset=
);
>> +
>> + =A0 =A0 /* Translate it into parent bus space */
>> + =A0 =A0 return pbus->translate(addr, offset, pna);
>> +}
>> +
>> +/*
>> + * Translate an address from the device-tree into a CPU physical addres=
s,
>> + * this walks up the tree and applies the various bus mappings on the
>> + * way.
>> + *
>> + * Note: We consider that crossing any level with #size-cells =3D=3D 0 =
to mean
>> + * that translation is impossible (that is we are not dealing with a va=
lue
>> + * that can be mapped to a cpu physical address). This is not really sp=
ecified
>> + * that way, but this is traditionally the way IBM at least do things
>> + */
>> +u64 __of_translate_address(struct device_node *dev, const u32 *in_addr,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0const char *rprop)
>> +{
>> + =A0 =A0 struct device_node *parent =3D NULL;
>> + =A0 =A0 struct of_bus *bus, *pbus;
>> + =A0 =A0 u32 addr[OF_MAX_ADDR_CELLS];
>> + =A0 =A0 int na, ns, pna, pns;
>> + =A0 =A0 u64 result =3D OF_BAD_ADDR;
>> +
>> + =A0 =A0 pr_debug("OF: ** translation for device %s **\n", dev->full_na=
me);
>> +
>> + =A0 =A0 /* Increase refcount at current level */
>> + =A0 =A0 of_node_get(dev);
>> +
>> + =A0 =A0 /* Get parent & match bus type */
>> + =A0 =A0 parent =3D of_get_parent(dev);
>> + =A0 =A0 if (parent =3D=3D NULL)
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto bail;
>> + =A0 =A0 bus =3D of_match_bus(parent);
>> +
>> + =A0 =A0 /* Cound address cells & copy address locally */
>> + =A0 =A0 bus->count_cells(dev, &na, &ns);
>> + =A0 =A0 if (!OF_CHECK_COUNTS(na, ns)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "prom_parse: Bad cell count fo=
r %s\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev->full_name);
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto bail;
>> + =A0 =A0 }
>> + =A0 =A0 memcpy(addr, in_addr, na * 4);
>> +
>> + =A0 =A0 pr_debug("OF: bus is %s (na=3D%d, ns=3D%d) on %s\n",
>> + =A0 =A0 =A0 =A0 bus->name, na, ns, parent->full_name);
>> + =A0 =A0 of_dump_addr("OF: translating address:", addr, na);
>> +
>> + =A0 =A0 /* Translate */
>> + =A0 =A0 for (;;) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* Switch to parent bus */
>> + =A0 =A0 =A0 =A0 =A0 =A0 of_node_put(dev);
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev =3D parent;
>> + =A0 =A0 =A0 =A0 =A0 =A0 parent =3D of_get_parent(dev);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* If root, we have finished */
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (parent =3D=3D NULL) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("OF: reached root nod=
e\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 result =3D of_read_number(addr=
, na);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* Get new parent bus and counts */
>> + =A0 =A0 =A0 =A0 =A0 =A0 pbus =3D of_match_bus(parent);
>> + =A0 =A0 =A0 =A0 =A0 =A0 pbus->count_cells(dev, &pna, &pns);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!OF_CHECK_COUNTS(pna, pns)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "prom_parse: B=
ad cell count for %s\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev->full_name)=
;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("OF: parent bus is %s (na=3D%d, ns=3D=
%d) on %s\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pbus->name, pna, pns, parent->full_nam=
e);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* Apply bus translation */
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (of_translate_one(dev, bus, pbus, addr, na,=
 ns, pna, rprop))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* Complete the move up one level */
>> + =A0 =A0 =A0 =A0 =A0 =A0 na =3D pna;
>> + =A0 =A0 =A0 =A0 =A0 =A0 ns =3D pns;
>> + =A0 =A0 =A0 =A0 =A0 =A0 bus =3D pbus;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 of_dump_addr("OF: one level translation:", add=
r, na);
>> + =A0 =A0 }
>> + bail:
>> + =A0 =A0 of_node_put(parent);
>> + =A0 =A0 of_node_put(dev);
>> +
>> + =A0 =A0 return result;
>> +}
>> +
>> +u64 of_translate_address(struct device_node *dev, const u32 *in_addr)
>> +{
>> + =A0 =A0 return __of_translate_address(dev, in_addr, "ranges");
>> +}
>> +EXPORT_SYMBOL(of_translate_address);
>> +
>> +u64 of_translate_dma_address(struct device_node *dev, const u32 *in_add=
r)
>> +{
>> + =A0 =A0 return __of_translate_address(dev, in_addr, "dma-ranges");
>> +}
>> +EXPORT_SYMBOL(of_translate_dma_address);
>> +
>> +const u32 *of_get_address(struct device_node *dev, int index, u64 *size=
,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int *flags)
>> +{
>> + =A0 =A0 const u32 *prop;
>> + =A0 =A0 unsigned int psize;
>> + =A0 =A0 struct device_node *parent;
>> + =A0 =A0 struct of_bus *bus;
>> + =A0 =A0 int onesize, i, na, ns;
>> +
>> + =A0 =A0 /* Get parent & match bus type */
>> + =A0 =A0 parent =3D of_get_parent(dev);
>> + =A0 =A0 if (parent =3D=3D NULL)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
>> + =A0 =A0 bus =3D of_match_bus(parent);
>> + =A0 =A0 bus->count_cells(dev, &na, &ns);
>> + =A0 =A0 of_node_put(parent);
>> + =A0 =A0 if (!OF_CHECK_COUNTS(na, ns))
>> + =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
>> +
>> + =A0 =A0 /* Get "reg" or "assigned-addresses" property */
>> + =A0 =A0 prop =3D of_get_property(dev, bus->addresses, &psize);
>> + =A0 =A0 if (prop =3D=3D NULL)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
>> + =A0 =A0 psize /=3D 4;
>> +
>> + =A0 =A0 onesize =3D na + ns;
>> + =A0 =A0 for (i =3D 0; psize >=3D onesize; psize -=3D onesize, prop +=
=3D onesize, i++)
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (i =3D=3D index) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (size)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *size =3D of_r=
ead_number(prop + na, ns);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (flags)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *flags =3D bus=
->get_flags(prop);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return prop;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 return NULL;
>> +}
>> +EXPORT_SYMBOL(of_get_address);
>> +
>> +static int __of_address_to_resource(struct device_node *dev, const u32 =
*addrp,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 u64 si=
ze, unsigned int flags,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct=
 resource *r)
>> =A0{
>> =A0 =A0 =A0 u64 taddr;
>>
>> diff --git a/include/linux/of_address.h b/include/linux/of_address.h
>> index 474b794..cc567df 100644
>> --- a/include/linux/of_address.h
>> +++ b/include/linux/of_address.h
>> @@ -3,9 +3,7 @@
>> =A0#include <linux/ioport.h>
>> =A0#include <linux/of.h>
>>
>> -extern int __of_address_to_resource(struct device_node *dev, const u32 =
*addrp,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 u64 si=
ze, unsigned int flags,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct=
 resource *r);
>> +extern u64 of_translate_address(struct device_node *np, const u32 *addr=
);
>> =A0extern int of_address_to_resource(struct device_node *dev, int index,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct r=
esource *r);
>> =A0extern void __iomem *of_iomap(struct device_node *device, int index);
>
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
