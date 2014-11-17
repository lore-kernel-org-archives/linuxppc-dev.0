Return-Path: <lorenzo.pieralisi@arm.com>
Received: from service88.mimecast.com (service88.mimecast.com [195.130.217.12])
 by lists.ozlabs.org (Postfix) with ESMTP id 711F11A0297
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Nov 2014 23:10:00 +1100 (AEDT)
Date: Mon, 17 Nov 2014 12:08:39 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Yijing Wang <wangyijing@huawei.com>
Subject: Re: [RFC PATCH 14/16] arm/PCI: Introduce pci_get_domain_nr()
Message-ID: <20141117120839.GA22241@e102568-lin.cambridge.arm.com>
References: <1416219710-26088-1-git-send-email-wangyijing@huawei.com>
 <1416219710-26088-15-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
In-Reply-To: <1416219710-26088-15-git-send-email-wangyijing@huawei.com>
Content-Type: text/plain; charset=WINDOWS-1252
Cc: Liviu Dudau <liviu@dudau.co.uk>, Tony Luck <tony.luck@intel.com>,
 Russell King <linux@arm.linux.org.uk>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "x86@kernel.org" <x86@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "huxinwei@huawei.com" <huxinwei@huawei.com>,
 Thierry Reding <thierry.reding@gmail.com>,
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

On Mon, Nov 17, 2014 at 10:21:48AM +0000, Yijing Wang wrote:
> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
> ---
>  arch/arm/include/asm/mach/pci.h |    9 +++++++++
>  arch/arm/kernel/bios32.c        |    8 ++++++--
>  2 files changed, 15 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/arm/include/asm/mach/pci.h b/arch/arm/include/asm/mach/=
pci.h
> index f19f627..370b3bd 100644
> --- a/arch/arm/include/asm/mach/pci.h
> +++ b/arch/arm/include/asm/mach/pci.h
> @@ -90,6 +90,15 @@ extern void pci_map_io_early(unsigned long pfn);
>  static inline void pci_map_io_early(unsigned long pfn) {}
>  #endif
> =20
> +#ifdef CONFIG_PCI_DOMAINS_GENERIC
> +int pci_get_domain_nr(struct device *parent)
> +#else
> +static inline int pci_get_domain_nr(struct device *parent)
> +{
> +=09return 0;
> +}
> +#endif
> +
>  /*
>   * PCI controllers
>   */
> diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
> index d8c2b4e..3fe56f1 100644
> --- a/arch/arm/kernel/bios32.c
> +++ b/arch/arm/kernel/bios32.c
> @@ -513,7 +513,7 @@ static void pcibios_init_hw(struct device *parent, st=
ruct hw_pci *hw,
>  #ifdef CONFIG_PCI_DOMAINS_GENERIC
>  static bool dt_domain_found;
> =20
> -void pci_bus_assign_domain_nr(struct pci_bus *bus, struct device *parent=
)
> +int pci_get_domain_nr(struct device *parent)
>  {
>  =09int domain =3D of_get_pci_domain_nr(parent->of_node);
> =20
> @@ -526,8 +526,12 @@ void pci_bus_assign_domain_nr(struct pci_bus *bus, s=
truct device *parent)
>  =09} else {
>  =09=09domain =3D pci_get_new_domain_nr();
>  =09}
> +=09return domain;
> +}
> =20
> -=09bus->domain_nr =3D domain;
> +void pci_bus_assign_domain_nr(struct pci_bus *bus, struct device *parent=
)
> +{
> +=09bus->domain_nr =3D pci_get_domain_nr(parent);
>  }
>  #endif

This code is superseded by the last patches I sent to move the domain
assignment to PCI core code.

http://lists.infradead.org/pipermail/linux-arm-kernel/2014-November/301220.=
html

Lorenzo
