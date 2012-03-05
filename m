Return-Path: <bhelgaas@google.com>
Received: from mail-ee0-f51.google.com (mail-ee0-f51.google.com [74.125.83.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E0D3AB6FA3
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Mar 2012 03:14:37 +1100 (EST)
Received: by eeke50 with SMTP id e50so1361182eek.38
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Mar 2012 08:14:27 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1330918440.11728.87.camel@pasglop>
References: <20120302170638.3d172369d04335d9b921a28c@canb.auug.org.au>
 <CAErSpo6xQa4Rnv+RkkXCRjQ2HDZdBhorRv2c6pmWyXqRzhM4Vw@mail.gmail.com>
 <1330725132.11728.52.camel@pasglop> <1330918440.11728.87.camel@pasglop>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 5 Mar 2012 09:14:07 -0700
Message-ID: <CAErSpo6g8QyEhu6YRsv6-mpQoO0mymuE2Fu6v=qqS=OLV19GFA@mail.gmail.com>
Subject: Re: linux-next: boot failure for next-20120227 and later (pci tree
 related)
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org,
 ppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-kernel@vger.kernel.org,
 Jesse Barnes <jbarnes@virtuousgeek.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Mar 4, 2012 at 8:34 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Sat, 2012-03-03 at 08:52 +1100, Benjamin Herrenschmidt wrote:
>
>> Or give me a chance to dig :-) I'll have a look next week.
>
> This is indeed what bjorn suspected on irc, this patch fixes it:
>
> (Bjorn, please fold it in the original offending patch)

Thanks for checking this out.  Sparc should have the same problem, so
I'll post both updates in a bit.

Bjorn

> diff --git a/arch/powerpc/kernel/pci_of_scan.c b/arch/powerpc/kernel/pci_=
of_scan.c
> index b37d0b5..5dd63f1 100644
> --- a/arch/powerpc/kernel/pci_of_scan.c
> +++ b/arch/powerpc/kernel/pci_of_scan.c
> @@ -75,6 +75,7 @@ static void of_pci_parse_addrs(struct device_node *node=
, struct pci_dev *dev)
> =A0{
> =A0 =A0 =A0 =A0u64 base, size;
> =A0 =A0 =A0 =A0unsigned int flags;
> + =A0 =A0 =A0 struct pci_bus_region region;
> =A0 =A0 =A0 =A0struct resource *res;
> =A0 =A0 =A0 =A0const u32 *addrs;
> =A0 =A0 =A0 =A0u32 i;
> @@ -106,10 +107,12 @@ static void of_pci_parse_addrs(struct device_node *=
node, struct pci_dev *dev)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printk(KERN_ERR "PCI: bad =
cfg reg num 0x%x\n", i);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0continue;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 res->start =3D base;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 res->end =3D base + size - 1;
> +
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0res->flags =3D flags;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0res->name =3D pci_name(dev);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 region.start =3D base;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 region.end =3D base + size - 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pcibios_bus_to_resource(dev, res, &region);
> =A0 =A0 =A0 =A0}
> =A0}
>
> @@ -209,6 +212,7 @@ void __devinit of_scan_pci_bridge(struct pci_dev *dev=
)
> =A0 =A0 =A0 =A0struct pci_bus *bus;
> =A0 =A0 =A0 =A0const u32 *busrange, *ranges;
> =A0 =A0 =A0 =A0int len, i, mode;
> + =A0 =A0 =A0 struct pci_bus_region region;
> =A0 =A0 =A0 =A0struct resource *res;
> =A0 =A0 =A0 =A0unsigned int flags;
> =A0 =A0 =A0 =A0u64 size;
> @@ -270,9 +274,10 @@ void __devinit of_scan_pci_bridge(struct pci_dev *de=
v)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0res =3D bus->resource[i];
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0++i;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 res->start =3D of_read_number(&ranges[1], 2=
);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 res->end =3D res->start + size - 1;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0res->flags =3D flags;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 region.start =3D of_read_number(&ranges[1],=
 2);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 region.end =3D region.start + size - 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pcibios_bus_to_resource(dev, res, &region);
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0sprintf(bus->name, "PCI Bus %04x:%02x", pci_domain_nr(bus)=
,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bus->number);
>
>
