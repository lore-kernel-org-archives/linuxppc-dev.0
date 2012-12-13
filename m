Return-Path: <andrew.murray@arm.com>
Received: from service87.mimecast.com (service87.mimecast.com [91.220.42.44])
 by ozlabs.org (Postfix) with ESMTP id BD24D2C0091
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Dec 2012 20:48:55 +1100 (EST)
Date: Thu, 13 Dec 2012 09:45:43 +0000
From: Andrew Murray <andrew.murray@arm.com>
To: Thierry Reding <thierry.reding@avionic-design.de>
Subject: Re: [PATCH] pci: Provide support for parsing PCI DT ranges property
Message-ID: <20121213094543.GA23446@arm.com>
References: <20121212163749.GA17371@arm.com>
 <20121213091333.GA14828@avionic-0098.adnet.avionic-design.de>
MIME-Version: 1.0
In-Reply-To: <20121213091333.GA14828@avionic-0098.adnet.avionic-design.de>
Content-Type: text/plain; charset=WINDOWS-1252
Cc: Michal Simek <monstr@monstr.eu>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 devicetree-discuss <devicetree-discuss@lists.ozlabs.org>,
 Liviu Dudau <Liviu.Dudau@arm.com>,
 "rob.herring@calxeda.com" <rob.herring@calxeda.com>,
 Rob Herring <robherring2@gmail.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Dec 13, 2012 at 09:13:33AM +0000, Thierry Reding wrote:
> Hi Andrew,
>=20
> I don't like iterator interfaces too much, but I can live with that.
> Other than that the patch looks good to me and I'll try to work it into
> my Tegra PCIe patch series.
>=20
> Just two minor comments below.
>=20
> > diff --git a/drivers/of/address.c b/drivers/of/address.c
> [...]
> > @@ -421,7 +472,7 @@ u64 __of_translate_address(struct device_node *dev,=
 const __be32 *in_addr,
> >  =09=09goto bail;
> >  =09bus =3D of_match_bus(parent);
> > =20
> > -=09/* Cound address cells & copy address locally */
> > +=09/* Count address cells & copy address locally */
> >  =09bus->count_cells(dev, &na, &ns);
> >  =09if (!OF_CHECK_COUNTS(na, ns)) {
> >  =09=09printk(KERN_ERR "prom_parse: Bad cell count for %s\n",
>=20
> This is really minor, but it should still go into a separate patch.
>=20
> > diff --git a/include/linux/of_address.h b/include/linux/of_address.h
> > index 01b925a..4582b20 100644
> > --- a/include/linux/of_address.h
> > +++ b/include/linux/of_address.h
> > @@ -26,6 +26,8 @@ static inline unsigned long pci_address_to_pio(phys_a=
ddr_t addr) { return -1; }
> >  #define pci_address_to_pio pci_address_to_pio
> >  #endif
> > =20
> > +const __be32 *of_pci_process_ranges(struct device_node *node,
> > +=09=09=09=09    struct resource *res, const __be32 *from);
> >  #else /* CONFIG_OF_ADDRESS */
> >  static inline int of_address_to_resource(struct device_node *dev, int =
index,
> >  =09=09=09=09=09 struct resource *r)
> > @@ -48,6 +50,11 @@ static inline const u32 *of_get_address(struct devic=
e_node *dev, int index,
> >  {
> >  =09return NULL;
> >  }
> > +const __be32 *of_pci_process_ranges(struct device_node *node,
>=20
> There should be a blank line to separate the above two lines.
>=20

Thanks for the feedback.

I will send another patch for the typo and leave this patch with you for
working into your existing series.

Andrew Murray
