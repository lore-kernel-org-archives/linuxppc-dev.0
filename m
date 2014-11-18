Return-Path: <liviu.dudau@arm.com>
Received: from service87.mimecast.com (service87.mimecast.com [91.220.42.44])
 by lists.ozlabs.org (Postfix) with ESMTP id 1F3BB1A0975
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Nov 2014 01:28:23 +1100 (AEDT)
Date: Tue, 18 Nov 2014 14:28:17 +0000
From: Liviu Dudau <Liviu.Dudau@arm.com>
To: Yijing Wang <wangyijing@huawei.com>
Subject: Re: [RFC PATCH 02/16] PCI: Use pci_scan_root_bus() instead of
 pci_scan_bus()
Message-ID: <20141118142817.GI12037@e106497-lin.cambridge.arm.com>
References: <1416219710-26088-1-git-send-email-wangyijing@huawei.com>
 <1416219710-26088-3-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
In-Reply-To: <1416219710-26088-3-git-send-email-wangyijing@huawei.com>
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

On Mon, Nov 17, 2014 at 10:21:36AM +0000, Yijing Wang wrote:
> From: Yijing Wang <wangyijing0307@gmail.com>
>=20
> Now we could use pci_scan_root_bus() instead of
> pci_scan_bus(), pass NULL resources means use the default
> io/mem.

Actually, I think this patch goes in the wrong direction. You are adding
two additional parameters that are NULL for every call you replace.
pci_scan_bus() was actually intended as a "shortcut with defaults" kind
of call so that you don't have to pass a value for parameters you don't
care about.

My suggestion would be to keep the function as is and replace the call
to pci_create_root_bus() inside with the appropriate sequence.

Best regards,
Liviu

>=20
> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
> ---
>  arch/alpha/include/asm/pci.h      |    2 +-
>  arch/alpha/kernel/sys_nautilus.c  |    2 +-
>  arch/cris/include/asm/pci.h       |    2 +-
>  arch/ia64/include/asm/pci.h       |    2 +-
>  arch/m68k/coldfire/pci.c          |    2 +-
>  arch/mips/include/asm/pci.h       |    2 +-
>  arch/mn10300/include/asm/pci.h    |    2 +-
>  arch/sh/include/asm/pci.h         |    2 +-
>  arch/sparc/include/asm/pci_32.h   |    2 +-
>  arch/sparc/include/asm/pci_64.h   |    2 +-
>  arch/sparc/kernel/pcic.c          |    3 ++-
>  arch/unicore32/kernel/pci.c       |    2 +-
>  arch/x86/include/asm/pci.h        |    2 +-
>  arch/x86/pci/amd_bus.c            |    2 +-
>  arch/xtensa/include/asm/pci.h     |    2 +-
>  drivers/parisc/dino.c             |    4 ++--
>  drivers/pci/hotplug/ibmphp_core.c |    2 +-
>  17 files changed, 19 insertions(+), 18 deletions(-)
>=20
> diff --git a/arch/alpha/include/asm/pci.h b/arch/alpha/include/asm/pci.h
> index f7f680f..157925a 100644
> --- a/arch/alpha/include/asm/pci.h
> +++ b/arch/alpha/include/asm/pci.h
> @@ -49,7 +49,7 @@ struct pci_controller {
>  =09void *sysdata;
>  };
> =20
> -/* Override the logic in pci_scan_bus for skipping already-configured
> +/* Override the logic in pci_scan_root_bus for skipping already-configur=
ed
>     bus numbers.  */
> =20
>  #define pcibios_assign_all_busses()=091
> diff --git a/arch/alpha/kernel/sys_nautilus.c b/arch/alpha/kernel/sys_nau=
tilus.c
> index 837c0fa..1047ab3 100644
> --- a/arch/alpha/kernel/sys_nautilus.c
> +++ b/arch/alpha/kernel/sys_nautilus.c
> @@ -206,7 +206,7 @@ nautilus_init_pci(void)
>  =09unsigned long memtop =3D max_low_pfn << PAGE_SHIFT;
> =20
>  =09/* Scan our single hose.  */
> -=09bus =3D pci_scan_bus(0, alpha_mv.pci_ops, hose);
> +=09bus =3D pci_scan_root_bus(NULL, 0, alpha_mv.pci_ops, hose, NULL);
>  =09hose->bus =3D bus;
>  =09pcibios_claim_one_bus(bus);
> =20
> diff --git a/arch/cris/include/asm/pci.h b/arch/cris/include/asm/pci.h
> index cc2399c..96b33a6 100644
> --- a/arch/cris/include/asm/pci.h
> +++ b/arch/cris/include/asm/pci.h
> @@ -5,7 +5,7 @@
>  #ifdef __KERNEL__
>  #include <linux/mm.h>=09=09/* for struct page */
> =20
> -/* Can be used to override the logic in pci_scan_bus for skipping
> +/* Can be used to override the logic in pci_scan_root_bus for skipping
>     already-configured bus numbers - to be used for buggy BIOSes
>     or architectures with incomplete PCI setup by the loader */
> =20
> diff --git a/arch/ia64/include/asm/pci.h b/arch/ia64/include/asm/pci.h
> index 52af5ed..64b34d6 100644
> --- a/arch/ia64/include/asm/pci.h
> +++ b/arch/ia64/include/asm/pci.h
> @@ -20,7 +20,7 @@ struct pci_vector_struct {
>  };
> =20
>  /*
> - * Can be used to override the logic in pci_scan_bus for skipping alread=
y-configured bus
> + * Can be used to override the logic in pci_scan_root_bus for skipping a=
lready-configured bus
>   * numbers - to be used for buggy BIOSes or architectures with incomplet=
e PCI setup by the
>   * loader.
>   */
> diff --git a/arch/m68k/coldfire/pci.c b/arch/m68k/coldfire/pci.c
> index df96792..4d242fb 100644
> --- a/arch/m68k/coldfire/pci.c
> +++ b/arch/m68k/coldfire/pci.c
> @@ -312,7 +312,7 @@ static int __init mcf_pci_init(void)
>  =09set_current_state(TASK_UNINTERRUPTIBLE);
>  =09schedule_timeout(msecs_to_jiffies(200));
> =20
> -=09rootbus =3D pci_scan_bus(0, &mcf_pci_ops, NULL);
> +=09rootbus =3D pci_scan_root_bus(NULL, 0, &mcf_pci_ops, NULL, NULL);
>  =09rootbus->resource[0] =3D &mcf_pci_io;
>  =09rootbus->resource[1] =3D &mcf_pci_mem;
> =20
> diff --git a/arch/mips/include/asm/pci.h b/arch/mips/include/asm/pci.h
> index 974b0e3..212030a 100644
> --- a/arch/mips/include/asm/pci.h
> +++ b/arch/mips/include/asm/pci.h
> @@ -60,7 +60,7 @@ extern void register_pci_controller(struct pci_controll=
er *hose);
>  extern int pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin);
> =20
> =20
> -/* Can be used to override the logic in pci_scan_bus for skipping
> +/* Can be used to override the logic in pci_scan_root_bus for skipping
>     already-configured bus numbers - to be used for buggy BIOSes
>     or architectures with incomplete PCI setup by the loader */
> =20
> diff --git a/arch/mn10300/include/asm/pci.h b/arch/mn10300/include/asm/pc=
i.h
> index 5f70af2..6305f14 100644
> --- a/arch/mn10300/include/asm/pci.h
> +++ b/arch/mn10300/include/asm/pci.h
> @@ -33,7 +33,7 @@ do {=09=09=09=09=09=09=09\
>  #define __pcidebug(FMT, BUS, DEVFN, WHERE, ...)=09do {} while (0)
>  #endif
> =20
> -/* Can be used to override the logic in pci_scan_bus for skipping
> +/* Can be used to override the logic in pci_scan_root_bus for skipping
>   * already-configured bus numbers - to be used for buggy BIOSes or
>   * architectures with incomplete PCI setup by the loader */
> =20
> diff --git a/arch/sh/include/asm/pci.h b/arch/sh/include/asm/pci.h
> index 5b45115..69bcb78 100644
> --- a/arch/sh/include/asm/pci.h
> +++ b/arch/sh/include/asm/pci.h
> @@ -3,7 +3,7 @@
> =20
>  #ifdef __KERNEL__
> =20
> -/* Can be used to override the logic in pci_scan_bus for skipping
> +/* Can be used to override the logic in pci_scan_root_bus for skipping
>     already-configured bus numbers - to be used for buggy BIOSes
>     or architectures with incomplete PCI setup by the loader */
> =20
> diff --git a/arch/sparc/include/asm/pci_32.h b/arch/sparc/include/asm/pci=
_32.h
> index 53e9b49..4ef6064 100644
> --- a/arch/sparc/include/asm/pci_32.h
> +++ b/arch/sparc/include/asm/pci_32.h
> @@ -5,7 +5,7 @@
> =20
>  #include <linux/dma-mapping.h>
> =20
> -/* Can be used to override the logic in pci_scan_bus for skipping
> +/* Can be used to override the logic in pci_scan_root_bus for skipping
>   * already-configured bus numbers - to be used for buggy BIOSes
>   * or architectures with incomplete PCI setup by the loader.
>   */
> diff --git a/arch/sparc/include/asm/pci_64.h b/arch/sparc/include/asm/pci=
_64.h
> index bd00a62..6e017f9 100644
> --- a/arch/sparc/include/asm/pci_64.h
> +++ b/arch/sparc/include/asm/pci_64.h
> @@ -5,7 +5,7 @@
> =20
>  #include <linux/dma-mapping.h>
> =20
> -/* Can be used to override the logic in pci_scan_bus for skipping
> +/* Can be used to override the logic in pci_scan_root_bus for skipping
>   * already-configured bus numbers - to be used for buggy BIOSes
>   * or architectures with incomplete PCI setup by the loader.
>   */
> diff --git a/arch/sparc/kernel/pcic.c b/arch/sparc/kernel/pcic.c
> index 6cc78c2..64aafac 100644
> --- a/arch/sparc/kernel/pcic.c
> +++ b/arch/sparc/kernel/pcic.c
> @@ -390,7 +390,8 @@ static void __init pcic_pbm_scan_bus(struct linux_pci=
c *pcic)
>  {
>  =09struct linux_pbm_info *pbm =3D &pcic->pbm;
> =20
> -=09pbm->pci_bus =3D pci_scan_bus(pbm->pci_first_busno, &pcic_ops, pbm);
> +=09pbm->pci_bus =3D pci_scan_root_bus(NULL, pbm->pci_first_busno,=20
> +=09=09=09&pcic_ops, pbm, NULL);
>  #if 0 /* deadwood transplanted from sparc64 */
>  =09pci_fill_in_pbm_cookies(pbm->pci_bus, pbm, pbm->prom_node);
>  =09pci_record_assignments(pbm, pbm->pci_bus);
> diff --git a/arch/unicore32/kernel/pci.c b/arch/unicore32/kernel/pci.c
> index 374a055..be0f261 100644
> --- a/arch/unicore32/kernel/pci.c
> +++ b/arch/unicore32/kernel/pci.c
> @@ -258,7 +258,7 @@ static int __init pci_common_init(void)
> =20
>  =09pci_puv3_preinit();
> =20
> -=09puv3_bus =3D pci_scan_bus(0, &pci_puv3_ops, NULL);
> +=09puv3_bus =3D pci_scan_root_bus(NULL, 0, &pci_puv3_ops, NULL, NULL);
> =20
>  =09if (!puv3_bus)
>  =09=09panic("PCI: unable to scan bus!");
> diff --git a/arch/x86/include/asm/pci.h b/arch/x86/include/asm/pci.h
> index 0892ea0..0540ff7 100644
> --- a/arch/x86/include/asm/pci.h
> +++ b/arch/x86/include/asm/pci.h
> @@ -41,7 +41,7 @@ static inline int pci_proc_domain(struct pci_bus *bus)
>  }
>  #endif
> =20
> -/* Can be used to override the logic in pci_scan_bus for skipping
> +/* Can be used to override the logic in pci_scan_root_bus for skipping
>     already-configured bus numbers - to be used for buggy BIOSes
>     or architectures with incomplete PCI setup by the loader */
> =20
> diff --git a/arch/x86/pci/amd_bus.c b/arch/x86/pci/amd_bus.c
> index c20d2cc..baf6209 100644
> --- a/arch/x86/pci/amd_bus.c
> +++ b/arch/x86/pci/amd_bus.c
> @@ -52,7 +52,7 @@ static struct pci_root_info __init *find_pci_root_info(=
int node, int link)
> =20
>  /**
>   * early_root_info_init()
> - * called before pcibios_scan_root and pci_scan_bus
> + * called before pcibios_scan_root and pci_scan_root_bus
>   * fills the mp_bus_to_cpumask array based according
>   * to the LDT Bus Number Registers found in the northbridge.
>   */
> diff --git a/arch/xtensa/include/asm/pci.h b/arch/xtensa/include/asm/pci.=
h
> index 5d52dc4..377fae9 100644
> --- a/arch/xtensa/include/asm/pci.h
> +++ b/arch/xtensa/include/asm/pci.h
> @@ -13,7 +13,7 @@
> =20
>  #ifdef __KERNEL__
> =20
> -/* Can be used to override the logic in pci_scan_bus for skipping
> +/* Can be used to override the logic in pci_scan_root_bus for skipping
>   * already-configured bus numbers - to be used for buggy BIOSes
>   * or architectures with incomplete PCI setup by the loader
>   */
> diff --git a/drivers/parisc/dino.c b/drivers/parisc/dino.c
> index a0580af..67c31bd 100644
> --- a/drivers/parisc/dino.c
> +++ b/drivers/parisc/dino.c
> @@ -74,7 +74,7 @@
>  ** assigned a PCI bus number based on "when" it's discovered.
>  **
>  ** The "secondary" bus number is set to this before calling
> -** pci_scan_bus(). If any PPB's are present, the scan will
> +** pci_scan_root_bus(). If any PPB's are present, the scan will
>  ** discover them and update the "secondary" and "subordinate"
>  ** fields in Dino's pci_bus structure.
>  **
> @@ -787,7 +787,7 @@ static int __init dino_common_init(struct parisc_devi=
ce *dev,
> =20
>  =09pcibios_register_hba(&dino_dev->hba);
> =20
> -=09pci_bios =3D &dino_bios_ops;   /* used by pci_scan_bus() */
> +=09pci_bios =3D &dino_bios_ops;  =20
>  =09pci_port =3D &dino_port_ops;
> =20
>  =09/*
> diff --git a/drivers/pci/hotplug/ibmphp_core.c b/drivers/pci/hotplug/ibmp=
hp_core.c
> index 3efaf4c..b486432 100644
> --- a/drivers/pci/hotplug/ibmphp_core.c
> +++ b/drivers/pci/hotplug/ibmphp_core.c
> @@ -767,7 +767,7 @@ static u8 bus_structure_fixup(u8 busno)
>  =09=09=09=09=09(l !=3D 0x0000) && (l !=3D 0xffff)) {
>  =09=09=09debug("%s - Inside bus_structure_fixup()\n",
>  =09=09=09=09=09=09=09__func__);
> -=09=09=09pci_scan_bus(busno, ibmphp_pci_bus->ops, NULL);
> +=09=09=09pci_scan_root_bus(NULL, busno, ibmphp_pci_bus->ops, NULL, NULL)=
;
>  =09=09=09break;
>  =09=09}
>  =09}
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
