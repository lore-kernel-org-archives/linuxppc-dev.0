Return-Path: <B38951@freescale.com>
Received: from VA3EHSOBE007.bigfish.com (va3ehsobe006.messaging.microsoft.com
 [216.32.180.16]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id A7270B6F67
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Dec 2011 13:21:16 +1100 (EST)
From: Jia Hongtao-B38951 <B38951@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [powerpc] boot up problem
Date: Fri, 2 Dec 2011 02:21:03 +0000
Message-ID: <412C8208B4A0464FA894C5F0C278CD5DFDC478@039-SN1MPN1-005.039d.mgd.msft.net>
References: <1320040492-6407-1-git-send-email-B38951@freescale.com>
 <1320040492-6407-2-git-send-email-B38951@freescale.com>
 <412C8208B4A0464FA894C5F0C278CD5DFD4DB8@039-SN1MPN1-005.039d.mgd.msft.net>
 <3E825AD9-1CD5-4D6D-8161-E6B4F1D32457@kernel.crashing.org>
 <3F607A5180246847A760FD34122A1E052DBCD1@039-SN1MPN1-003.039d.mgd.msft.net>
 <412C8208B4A0464FA894C5F0C278CD5DFD6BAB@039-SN1MPN1-005.039d.mgd.msft.net>
 <3EC6F9E0-C847-4DA8-AD8C-313976982A10@kernel.crashing.org>
In-Reply-To: <3EC6F9E0-C847-4DA8-AD8C-313976982A10@kernel.crashing.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Li Yang-R58472 <r58472@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi

I just found that the 'next' branch you mentioned have problem to boot up.
I test it in p1022ds and p1010rdb boards and the result are both the same.
Note that for p1022ds I use "make p1022ds.dtb" to make the dtb file(36bit) =
with 36bit-uboot.
And for p1010rdb I use all 32bit image.
The problem list below:

scsi0 : sata_fsl
ata1: SATA max UDMA/133 irq 74
fsl-sata fffe19000.sata: Sata FSL Platform/CSB Driver init
scsi1 : sata_fsl
ata2: SATA max UDMA/133 irq 41
Fixed MDIO Bus: probed
Unable to handle kernel paging request for data at address 0x00000000
Faulting instruction address: 0xc0451630
Oops: Kernel access of bad area, sig: 11 [#1]
SMP NR_CPUS=3D2 P1022 DS
Modules linked in:
NIP: c0451630 LR: c0451618 CTR: 00000007
REGS: ef03fce0 TRAP: 0300   Not tainted  (3.2.0-rc3-00099-g883381d)
MSR: 00029000 <EE,ME,CE>  CR: 24042022  XER: 00000000
DEAR: 00000000, ESR: 00800000
TASK =3D ef040000[1] 'swapper' THREAD: ef03e000 CPU: 0
GPR00: ef03fd98 ef03fd90 ef040000 ef1ab22c 00000000 00000002 ffeb0000 0000f=
ffe
GPR08: b0541215 00000000 00000000 00000000 24042028 23c406c2 00000000 00000=
000
GPR16: c0000a00 00000014 3fffffff 03ff9000 00000015 7ff3a760 f1044030 fffff=
ff4
GPR24: c053e128 ef1ab230 c056a3a8 ef03e000 ef040000 ef1ab22c 00000000 ef1ab=
228
NIP [c0451630] __mutex_lock_slowpath+0xb4/0x190
LR [c0451618] __mutex_lock_slowpath+0x9c/0x190
Call Trace:
[ef03fdd0] [c0451758] mutex_lock+0x4c/0x50
[ef03fde0] [c02b5124] mdiobus_read+0x38/0x74
[ef03fe00] [c02b41f4] get_phy_id+0x24/0x80
[ef03fe20] [c02b9de4] fsl_pq_mdio_probe+0x3b4/0x580
[ef03feb0] [c0266120] platform_drv_probe+0x20/0x30
[ef03fec0] [c0264bbc] driver_probe_device+0xa4/0x1d4
[ef03fee0] [c0264da8] __driver_attach+0xbc/0xc0
[ef03ff00] [c0263ac0] bus_for_each_dev+0x60/0x9c
[ef03ff30] [c02647f4] driver_attach+0x24/0x34
[ef03ff40] [c0264444] bus_add_driver+0x1ac/0x274
[ef03ff70] [c02651b0] driver_register+0x88/0x154
[ef03ff90] [c0266450] platform_driver_register+0x68/0x78
[ef03ffa0] [c05d93b8] fsl_pq_mdio_init+0x18/0x28
[ef03ffb0] [c0001eb8] do_one_initcall+0x34/0x1a8
[ef03ffe0] [c05bb82c] kernel_init+0xa0/0x13c
[ef03fff0] [c000d878] kernel_thread+0x4c/0x68
Instruction dump:
801c0020 2f800063 419dffe8 3bbf0004 7fa3eb78 48001aad 813f000c 38010008
3b3f0008 901f000c 93210008 9121000c
 3800ffff 93810010 7c0004ac
---[ end trace 1643a9a9c5097f8f ]---
Kernel panic - not syncing: Attempted to kill init!
Call Trace:
[ef03fbc0] [c0008044] show_stack+0x44/0x154 (unreliable)
[ef03fc00] [c04532c8] panic+0xa4/0x1d8
[ef03fc50] [c0049a00] do_exit+0x5dc/0x684
[ef03fca0] [c000a6f0] die+0xdc/0x1b4
[ef03fcc0] [c00128d0] bad_page_fault+0xb4/0xfc
[ef03fcd0] [c000ebe4] handle_page_fault+0x7c/0x80
--- Exception: 300 at __mutex_lock_slowpath+0xb4/0x190
    LR =3D __mutex_lock_slowpath+0x9c/0x190
[ef03fd90] [00000000]   (null) (unreliable)
[ef03fdd0] [c0451758] mutex_lock+0x4c/0x50
[ef03fde0] [c02b5124] mdiobus_read+0x38/0x74
[ef03fe00] [c02b41f4] get_phy_id+0x24/0x80
[ef03fe20] [c02b9de4] fsl_pq_mdio_probe+0x3b4/0x580
[ef03feb0] [c0266120] platform_drv_probe+0x20/0x30
[ef03fec0] [c0264bbc] driver_probe_device+0xa4/0x1d4
[ef03fee0] [c0264da8] __driver_attach+0xbc/0xc0
[ef03ff00] [c0263ac0] bus_for_each_dev+0x60/0x9c
[ef03ff30] [c02647f4] driver_attach+0x24/0x34
[ef03ff40] [c0264444] bus_add_driver+0x1ac/0x274
[ef03ff70] [c02651b0] driver_register+0x88/0x154
[ef03ff90] [c0266450] platform_driver_register+0x68/0x78
[ef03ffa0] [c05d93b8] fsl_pq_mdio_init+0x18/0x28
[ef03ffb0] [c0001eb8] do_one_initcall+0x34/0x1a8
[ef03ffe0] [c05bb82c] kernel_init+0xa0/0x13c
[ef03fff0] [c000d878] kernel_thread+0x4c/0x68
Rebooting in 180 seconds..

Do you or anyone else have any idea about this?
Thanks.


-----Original Message-----
From: Kumar Gala [mailto:galak@kernel.crashing.org]=20
Sent: Thursday, November 24, 2011 3:10 PM
To: Jia Hongtao-B38951
Cc: Li Yang-R58472
Subject: Re: [PATCH 1/2] Unify pci/pcie initialization code

When you do this please do it against my latest upstream 'next' branch on:

http://git.kernel.org/?p=3Dlinux/kernel/git/galak/powerpc.git
git://git.kernel.org/pub/scm/linux/kernel/git/galak/powerpc.git

- k

On Nov 24, 2011, at 12:27 AM, Jia Hongtao-B38951 wrote:

> Ok, I got it.
>=20
> - Hongtao
>=20
> -----Original Message-----
> From: Li Yang-R58472
> Sent: Thursday, November 24, 2011 2:06 PM
> To: Jia Hongtao-B38951; Kumar Gala
> Subject: RE: [PATCH 1/2] Unify pci/pcie initialization code
>=20
> Hongtao,
>=20
> Please update all the boards currently using fsl_add_bridge().
>=20
> - Leo
>=20
>> -----Original Message-----
>> From: Kumar Gala [mailto:galak@kernel.crashing.org]
>> Sent: Thursday, November 24, 2011 12:51 PM
>> To: Jia Hongtao-B38951
>> Cc: linuxppc-dev@lists.ozlabs.org; Gala Kumar-B11780; Li Yang-R58472
>> Subject: Re: [PATCH 1/2] Unify pci/pcie initialization code
>>=20
>>=20
>> On Nov 22, 2011, at 12:20 AM, Jia Hongtao-B38951 wrote:
>>=20
>>> Hi Kumar,
>>> We want more comments on this series of patches ([1/2] & [2/2]) to=20
>>> speed
>> up the pushing-to-kernel progress.
>>> Thanks.
>>=20
>> I think the code is fine, but you need to update it for all the=20
>> boards include the 86xx ones.
>>=20
>> - k
>>=20
>>>=20
>>> -----Original Message-----
>>> From: Jia Hongtao-B38951
>>> Sent: Monday, October 31, 2011 1:55 PM
>>> To: linuxppc-dev@lists.ozlabs.org
>>> Cc: Li Yang-R58472; Gala Kumar-B11780; Jia Hongtao-B38951
>>> Subject: [PATCH 1/2] Unify pci/pcie initialization code
>>>=20
>>> In previous version pci/pcie initialization is in platform code=20
>>> which
>> Initialize PCI bridge base on EP/RC or host/agent settings.
>>> We unified pci/pcie initialization as common APIs named=20
>>> fsl_pci_setup
>> which can be called by platform code.
>>>=20
>>> Signed-off-by: Jia Hongtao <B38951@freescale.com>
>>> Signed-off-by: Li Yang <leoli@freescale.com>
>>> ---
>>> arch/powerpc/platforms/85xx/mpc85xx_ds.c |   30 ++-----------------
>>> arch/powerpc/sysdev/fsl_pci.c            |   48
>> ++++++++++++++++++++++++++++++
>>> arch/powerpc/sysdev/fsl_pci.h            |    5 +++
>>> 3 files changed, 56 insertions(+), 27 deletions(-)
>>>=20
>>> diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ds.c
>> b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
>>> index 10e7db0..7188c0b 100644
>>> --- a/arch/powerpc/platforms/85xx/mpc85xx_ds.c
>>> +++ b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
>>> @@ -157,33 +157,12 @@ extern void __init mpc85xx_smp_init(void);=20
>>> #endif
>> static void __init mpc85xx_ds_setup_arch(void)  { -#ifdef CONFIG_PCI
>>> -	struct device_node *np;
>>> -	struct pci_controller *hose;
>>> -#endif
>>> -	dma_addr_t max =3D 0xffffffff;
>>> -
>>> 	if (ppc_md.progress)
>>> 		ppc_md.progress("mpc85xx_ds_setup_arch()", 0);
>>>=20
>>> -#ifdef CONFIG_PCI
>>> -	for_each_node_by_type(np, "pci") {
>>> -		if (of_device_is_compatible(np, "fsl,mpc8540-pci") ||
>>> -		    of_device_is_compatible(np, "fsl,mpc8548-pcie") ||
>>> -		    of_device_is_compatible(np, "fsl,p2020-pcie")) {
>>> -			struct resource rsrc;
>>> -			of_address_to_resource(np, 0, &rsrc);
>>> -			if ((rsrc.start & 0xfffff) =3D=3D primary_phb_addr)
>>> -				fsl_add_bridge(np, 1);
>>> -			else
>>> -				fsl_add_bridge(np, 0);
>>> -
>>> -			hose =3D pci_find_hose_for_OF_device(np);
>>> -			max =3D min(max, hose->dma_window_base_cur +
>>> -					hose->dma_window_size);
>>> -		}
>>> -	}
>>> +	fsl_pci_setup(primary_phb_addr);
>>>=20
>>> +#ifdef CONFIG_PCI
>>> 	ppc_md.pci_exclude_device =3D mpc85xx_exclude_device;  #endif
>>>=20
>>> @@ -192,11 +171,8 @@ static void __init mpc85xx_ds_setup_arch(void)
>> #endif
>>>=20
>>> #ifdef CONFIG_SWIOTLB
>>> -	if (memblock_end_of_DRAM() > max) {
>>> +	if (memblock_end_of_DRAM() > 0xffffffff)
>>> 		ppc_swiotlb_enable =3D 1;
>>> -		set_pci_dma_ops(&swiotlb_dma_ops);
>>> -		ppc_md.pci_dma_dev_setup =3D pci_dma_dev_setup_swiotlb;
>>> -	}
>>> #endif
>>>=20
>>> 	printk("MPC85xx DS board from Freescale Semiconductor\n"); diff --
>> git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c=20
>> index 80b8b7a..4d4536f 100644
>>> --- a/arch/powerpc/sysdev/fsl_pci.c
>>> +++ b/arch/powerpc/sysdev/fsl_pci.c
>>> @@ -402,6 +402,54 @@ int __init fsl_add_bridge(struct device_node=20
>>> *dev,
>> int is_primary)  }  #endif /* CONFIG_FSL_SOC_BOOKE || CONFIG_PPC_86xx=20
>> */
>>>=20
>>> +static struct of_device_id pci_ids[] =3D {
>>> +	{ .compatible =3D "fsl,mpc8540-pci", },
>>> +	{ .compatible =3D "fsl,mpc8548-pcie", },
>>> +	{},
>>> +};
>>> +
>>> +/**
>>> + * fsl_pci_setup - Initialization for PCI
>>> + * @primary_phb_addr: primary bus address
>>> + *
>>> + * Add bridge if pci controller is a host  */ void=20
>>> +fsl_pci_setup(int
>>> +primary_phb_addr) {
>>> +	struct device_node *np;
>>> +	struct pci_controller *hose;
>>> +	dma_addr_t min_dma_addr =3D 0xffffffff;
>>> +
>>> +	for_each_node_by_type(np, "pci") {
>>> +		if (of_match_node(pci_ids, np)) {
>>> +			struct resource rsrc;
>>> +			of_address_to_resource(np, 0, &rsrc);
>>> +			if ((rsrc.start & 0xfffff) =3D=3D primary_phb_addr)
>>> +				fsl_add_bridge(np, 1);
>>> +			else
>>> +				fsl_add_bridge(np, 0);
>>> +
>>> +			hose =3D pci_find_hose_for_OF_device(np);
>>> +			min_dma_addr =3D min(min_dma_addr,
>>> +					hose->dma_window_base_cur
>>> +					+ hose->dma_window_size);
>>> +
>>> +		}
>>> +	}
>>> +
>>> +#ifdef CONFIG_SWIOTLB
>>> +	/*
>>> +	 * if we couldn't map all of DRAM via the dma windows we need
>> SWIOTLB
>>> +	 * to handle buffers located outside of dma capable memory region
>>> +	 */
>>> +	if (memblock_end_of_DRAM() > min_dma_addr) {
>>> +		ppc_swiotlb_enable =3D 1;
>>> +		set_pci_dma_ops(&swiotlb_dma_ops);
>>> +		ppc_md.pci_dma_dev_setup =3D pci_dma_dev_setup_swiotlb;
>>> +	}
>>> +#endif
>>> +}
>>> +
>>> DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_FREESCALE, PCI_ANY_ID,
>> quirk_fsl_pcie_header);
>>>=20
>>> #if defined(CONFIG_PPC_83xx) || defined(CONFIG_PPC_MPC512x) diff=20
>>> --git
>> a/arch/powerpc/sysdev/fsl_pci.h b/arch/powerpc/sysdev/fsl_pci.h index
>> a39ed5c..775ea21 100644
>>> --- a/arch/powerpc/sysdev/fsl_pci.h
>>> +++ b/arch/powerpc/sysdev/fsl_pci.h
>>> @@ -89,6 +89,11 @@ struct ccsr_pci { };
>>>=20
>>> extern int fsl_add_bridge(struct device_node *dev, int is_primary);
>>> +#ifndef CONFIG_PCI
>>> +#define fsl_pci_setup(p)
>>> +#else
>>> +extern void fsl_pci_setup(int primary_phb_addr); #endif
>>> extern void fsl_pcibios_fixup_bus(struct pci_bus *bus);  extern int
>> mpc83xx_add_bridge(struct device_node *dev);
>>> u64 fsl_pci_immrbar_base(struct pci_controller *hose);
>>> --
>>> 1.7.5.1
>>>=20
>>>=20
>>> _______________________________________________
>>> Linuxppc-dev mailing list
>>> Linuxppc-dev@lists.ozlabs.org
>>> https://lists.ozlabs.org/listinfo/linuxppc-dev
>>=20
>=20
