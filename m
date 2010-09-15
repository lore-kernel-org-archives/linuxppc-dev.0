Return-Path: <glikely@secretlab.ca>
Received: from mail-gw0-f51.google.com (mail-gw0-f51.google.com [74.125.83.51])
	by ozlabs.org (Postfix) with ESMTP id ED8EC10C6B9
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 16 Sep 2010 04:30:57 +1000 (EST)
Received: by gwj15 with SMTP id 15so180805gwj.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 15 Sep 2010 11:30:55 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1284573958-8397-8-git-send-email-nacc@us.ibm.com>
References: <1284573958-8397-1-git-send-email-nacc@us.ibm.com>
	<1284573958-8397-8-git-send-email-nacc@us.ibm.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 15 Sep 2010 12:30:35 -0600
Message-ID: <AANLkTin48DsHC13TtUQfRgnJKvfCVFBkkXMq6HN8mQtO@mail.gmail.com>
Subject: Re: [PATCH 07/15] ppc: pci-common cleanup
To: Nishanth Aravamudan <nacc@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Dominik Brodowski <linux@dominikbrodowski.net>,
	Milton Miller <miltonm@bga.com>, Paul Mackerras <paulus@samba.org>,
	Jesse Barnes <jbarnes@virtuousgeek.org>, linuxppc-dev@lists.ozlabs.org,
	Bjorn Helgaas <bjorn.helgaas@hp.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Sep 15, 2010 at 12:05 PM, Nishanth Aravamudan <nacc@us.ibm.com> wro=
te:
> Use set_dma_ops and remove unused oddly-named temp pointer sd.
>
> Signed-off-by: Milton Miller <miltonm@bga.com>
> Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

Acked-by: Grant Likely <grant.likely@secretlab.ca>

> ---
> =A0arch/powerpc/kernel/pci-common.c | =A0 =A04 +---
> =A01 files changed, 1 insertions(+), 3 deletions(-)
>
> diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-c=
ommon.c
> index 9021c4a..10a44e6 100644
> --- a/arch/powerpc/kernel/pci-common.c
> +++ b/arch/powerpc/kernel/pci-common.c
> @@ -1090,8 +1090,6 @@ void __devinit pcibios_setup_bus_devices(struct pci=
_bus *bus)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bus->number, bus->self ? pci_name(bus->se=
lf) : "PHB");
>
> =A0 =A0 =A0 =A0list_for_each_entry(dev, &bus->devices, bus_list) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct dev_archdata *sd =3D &dev->dev.archd=
ata;
> -
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Cardbus can call us to add new devices =
to a bus, so ignore
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * those who are already fully discovered
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
> @@ -1107,7 +1105,7 @@ void __devinit pcibios_setup_bus_devices(struct pci=
_bus *bus)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0set_dev_node(&dev->dev, pcibus_to_node(dev=
->bus));
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Hook up default DMA ops */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 sd->dma_ops =3D pci_dma_ops;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_dma_ops(&dev->dev, pci_dma_ops);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0set_dma_offset(&dev->dev, PCI_DRAM_OFFSET)=
;
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Additional platform DMA/iommu setup */
> --
> 1.7.0.4
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
