Return-Path: <lorenzo.pieralisi@arm.com>
Received: from service88.mimecast.com (service88.mimecast.com [195.130.217.12])
 by lists.ozlabs.org (Postfix) with ESMTP id D290A1A0031
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Oct 2014 04:28:23 +1100 (AEDT)
Date: Mon, 20 Oct 2014 18:21:58 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Yijing Wang <wangyijing@huawei.com>
Subject: Re: [PATCH v3 04/27] arm/MSI: Save MSI chip in pci_sys_data
Message-ID: <20141020172158.GA8017@e102568-lin.cambridge.arm.com>
References: <1413342435-7876-1-git-send-email-wangyijing@huawei.com>
 <1413342435-7876-5-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
In-Reply-To: <1413342435-7876-5-git-send-email-wangyijing@huawei.com>
Content-Type: text/plain; charset=WINDOWS-1252
Cc: "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
 "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "Bharat.Bhushan@freescale.com" <Bharat.Bhushan@freescale.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
 Russell King <linux@arm.linux.org.uk>, Joerg Roedel <joro@8bytes.org>,
 "x86@kernel.org" <x86@kernel.org>, Sebastian Ott <sebott@linux.vnet.ibm.com>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 "arnab.basu@freescale.com" <arnab.basu@freescale.com>,
 Liviu Dudau <liviu@dudau.co.uk>, Arnd Bergmann <arnd@arndb.de>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Chris Metcalf <cmetcalf@tilera.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 "huxinwei@huawei.com" <huxinwei@huawei.com>, Tony Luck <tony.luck@intel.com>,
 Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Ralf Baechle <ralf@linux-mips.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 David Vrabel <david.vrabel@citrix.com>, Wuyun <wuyun.wu@huawei.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "David S. Miller" <davem@davemloft.net>, Lucas Stach <l.stach@pengutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Oct 15, 2014 at 04:06:52AM +0100, Yijing Wang wrote:
> Saving msi chip in pci_sys_data can make pci bus and
> devices don't need to know msi chip detail, it also
> make pci enumeration code be decoupled from msi chip.
> In fact, all pci devices under the same pci hostbridge
> share same msi chip. So msi chip should be seen as one
> of resources or attributes to be initialized in pci host
> bridge driver. Currently, pci hostbridge drivers create
> pci_host_bridge in pci_create_root_bus(), and pass arch
> specific pci sysdata to core pci scan functions. So pci
> arch sysdata is good place to save msi chip.
>=20
> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
> ---
>  arch/arm/include/asm/mach/pci.h |    6 ++++++
>  arch/arm/include/asm/pci.h      |    9 +++++++++
>  arch/arm/kernel/bios32.c        |    3 +++
>  drivers/pci/msi.c               |    6 ++++++
>  include/linux/pci.h             |    9 +++++++++
>  5 files changed, 33 insertions(+), 0 deletions(-)
>=20
> diff --git a/arch/arm/include/asm/mach/pci.h b/arch/arm/include/asm/mach/=
pci.h
> index 7fc4278..59b0d87 100644
> --- a/arch/arm/include/asm/mach/pci.h
> +++ b/arch/arm/include/asm/mach/pci.h
> @@ -22,6 +22,9 @@ struct hw_pci {
>  #ifdef CONFIG_PCI_DOMAINS
>  =09int=09=09domain;
>  #endif
> +#ifdef CONFIG_PCI_MSI
> +=09struct msi_chip *msi_chip;
> +#endif
>  =09struct pci_ops=09*ops;
>  =09int=09=09nr_controllers;
>  =09void=09=09**private_data;
> @@ -47,6 +50,9 @@ struct pci_sys_data {
>  #ifdef CONFIG_PCI_DOMAINS
>  =09int=09=09domain;
>  #endif
> +#ifdef CONFIG_PCI_MSI
> +=09struct msi_chip *msi_chip;
> +#endif

This struct is defined for ARM only. We are trying to remove dependency on =
it
so that we can have a single driver for ARM32 and ARM64 systems without
pcibios dependency. Why can't we add this msi chip data to the host
bridge struct instead ? I understand it is all a matter of how to pass
the pointer to pci_scan_root_bus(), where the bridge is created.
We could initialize the msi chip on the bridge through the bus pointer
returned by the pci_scan_root_bus() function.

Thanks,
Lorenzo

>  =09struct list_head node;
>  =09int=09=09busnr;=09=09/* primary bus number=09=09=09*/
>  =09u64=09=09mem_offset;=09/* bus->cpu memory mapping offset=09*/
> diff --git a/arch/arm/include/asm/pci.h b/arch/arm/include/asm/pci.h
> index 7e95d85..b562c09 100644
> --- a/arch/arm/include/asm/pci.h
> +++ b/arch/arm/include/asm/pci.h
> @@ -31,6 +31,15 @@ static inline int pci_proc_domain(struct pci_bus *bus)
>  }
>  #endif /* CONFIG_PCI_DOMAINS */
> =20
> +#ifdef CONFIG_PCI_MSI
> +static inline struct msi_chip *pci_msi_chip(struct pci_bus *bus)
> +{
> +=09struct pci_sys_data *root =3D bus->sysdata;
> +
> +=09return root->msi_chip;
> +}
> +#endif
> +
>  /*
>   * The PCI address space does equal the physical memory address space.
>   * The networking and block device layers use this boolean for bounce
> diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
> index 17a26c1..a19038d 100644
> --- a/arch/arm/kernel/bios32.c
> +++ b/arch/arm/kernel/bios32.c
> @@ -471,6 +471,9 @@ static void pcibios_init_hw(struct device *parent, st=
ruct hw_pci *hw,
>  #ifdef CONFIG_PCI_DOMAINS
>  =09=09sys->domain  =3D hw->domain;
>  #endif
> +#ifdef CONFIG_PCI_MSI
> +=09=09sys->msi_chip =3D hw->msi_chip;
> +#endif
>  =09=09sys->busnr   =3D busnr;
>  =09=09sys->swizzle =3D hw->swizzle;
>  =09=09sys->map_irq =3D hw->map_irq;
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index 22e413c..f11108c 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -35,6 +35,9 @@ int __weak arch_setup_msi_irq(struct pci_dev *dev, stru=
ct msi_desc *desc)
>  =09struct msi_chip *chip =3D dev->bus->msi;
>  =09int err;
> =20
> +=09if (!chip)
> +=09=09chip =3D pci_msi_chip(dev->bus);
> +
>  =09if (!chip || !chip->setup_irq)
>  =09=09return -EINVAL;
> =20
> @@ -50,6 +53,9 @@ void __weak arch_teardown_msi_irq(unsigned int irq)
>  =09struct msi_desc *entry =3D irq_get_msi_desc(irq);
>  =09struct msi_chip *chip =3D entry->dev->bus->msi;
> =20
> +=09if (!chip)
> +=09=09chip =3D pci_msi_chip(entry->dev->bus);
> +
>  =09if (!chip || !chip->teardown_irq)
>  =09=09return;
> =20
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 9cd2721..7a48b40 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1433,6 +1433,15 @@ static inline int pci_get_new_domain_nr(void) { re=
turn -ENOSYS; }
> =20
>  #include <asm/pci.h>
> =20
> +/* Just avoid compile error, will be clean up later */
> +#ifdef CONFIG_PCI_MSI
> +
> +#ifndef pci_msi_chip
> +#define pci_msi_chip(bus)=09NULL
> +#endif
> +
> +#endif
> +
>  /* these helpers provide future and backwards compatibility
>   * for accessing popular PCI BAR info */
>  #define pci_resource_start(dev, bar)=09((dev)->resource[(bar)].start)
> --=20
> 1.7.1
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>=20
