Return-Path: <kumar.gala@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 19E30DDE2E
	for <linuxppc-dev@ozlabs.org>; Sat,  1 Dec 2007 01:57:39 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	lAUEvXFp026247
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Nov 2007 07:57:33 -0700 (MST)
Message-Id: <6FF36777-D91C-4B80-968B-CAEF11BC98ED@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
To: Li Li <r64360@freescale.com>
In-Reply-To: <1196415470.2371.28.camel@Guyver>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [PATCH] Add MPC837xEMDS PCIE RC mode support
Date: Fri, 30 Nov 2007 08:57:33 -0600
References: <1196394334.29683.5.camel@Guyver>
	<4544168D-5E95-44E8-9128-6F343283EC82@freescale.com>
	<1196412491.31962.9.camel@Guyver>
	<7DF684FC-A53A-4F4D-903F-D50F1E0A486A@freescale.com>
	<1196415470.2371.28.camel@Guyver>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Li Tony <Tony.Li@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Nov 30, 2007, at 3:37 AM, Li Li wrote:

> On Fri, 2007-11-30 at 17:05 +0800, Gala Kumar wrote:
>>>>> +
>>>>> +     pci2@e0009000 {
>>>>
>>>> I agree w/Olof.  This should be pcie@e0009000
>>>>>
>>>>> +             interrupt-map-mask = <f800 0 0 7>;
>>>>> +             msi-available-ranges = <43 4 51 52 56 57 58 59>;
>>>>> +             interrupt-map = <
>>>>> +                     0000 0 0 1 &ipic 1 8
>>>>> +                     0000 0 0 2 &ipic 1 8
>>>>> +                     0000 0 0 3 &ipic 1 8
>>>>> +                     0000 0 0 4 &ipic 1 8
>>>>> +             >;
>>>>> +             interrupt-parent = < &ipic >;
>>>>> +             interrupts = <1 8>;
>>>>> +             bus-range = <0 0>;
>>>>> +             ranges = <02000000 0 A8000000 A8000000 0 10000000
>>>>> +                       01000000 0 00000000 B8000000 0 00800000>;
>>>>> +             clock-frequency = <0>;
>>>>> +             #interrupt-cells = <1>;
>>>>> +             #size-cells = <2>;
>>>>> +             #address-cells = <3>;
>>>>> +             reg = <e0009000 00001000
>>>>> +                    a0000000 08000000>;
>>>>
>>>> Shouldn't the reg size for the cfg space be 256M?
>>>
>>> 256M is a little too big for kernel.
>>
>> what do you mean too big?  Aren't you losing access to some
>> bus/dev/fn
>> than?
>
> If do it standard, a 256M config space, at least 256M mem space and  
> 16M
> io space are needed for each PCIE controller.
> To allocate PCIE window, the window size only can be 512M or 1G.
> If we choose 1G space, two PCIE controller needs 2G space.
> We do not have 2G free physical space now. Usually, we use upper 128M
> configure space. So, we have to cut down the config space.

We'll cutting config space is problematic in that its a bug since you  
might not be able to talk to a given device.

Is it possible to make the outbound window for cfg space 4k and change  
the region of config space its looking at?

>>>>> diff --git a/arch/powerpc/platforms/83xx/Kconfig b/arch/powerpc/
>>>>> platforms/83xx/Kconfig
>>>>> index 0c61e7a..00154c5 100644
>>>>> --- a/arch/powerpc/platforms/83xx/Kconfig
>>>>> +++ b/arch/powerpc/platforms/83xx/Kconfig
>>>>> @@ -87,3 +87,10 @@ config PPC_MPC837x
>>>>>     select PPC_INDIRECT_PCI
>>>>>     select FSL_SERDES
>>>>>     default y if MPC837x_MDS
>>>>> +
>>>>> +config PPC_MPC83XX_PCIE
>>>>> +     bool "MPC837X PCI Express support"
>>>>> +     depends on PCIEPORTBUS && PPC_MPC837x
>>>>> +     default n
>>>>> +     help
>>>>> +       Enables MPC837x PCI express RC mode
>>>>
>>>> This should be a hidden config that is just selected by
>> PPC_MPC837x
>>>> instead of a choice.  Also drop the depends on.
>>>>
>>>
>>> In the dts file, the PCIE is default enabled. So, we should provide
>>> another way to disable the PCIE.
>>> Modify and recompile the dts is a little unkind to user.
>>
>> Why do you something beyond CONFIG_PCI.  if you don't want PCIe but
>> do
>> want PCI the extra code for PCIe isn't going to kill you.
>>
>
> Here is a little complex. The MPC837xE board needs a carrier board to
> extend PCIE slot. If user does not populate carrier board onto  
> MPC837xE
> board and do PCIE scan, the system will halt.
> I just want to provide a easy way to disable the PCIe other than  
> modify
> and recompile the dts.

So I have to recompile the kernel for this case, that seems even more  
painful to the user.  Can we not detect if this board isn't there and  
not hang?

>>>>> diff --git a/arch/powerpc/platforms/83xx/mpc83xx.h
>> b/arch/powerpc/
>>>>> platforms/83xx/mpc83xx.h
>>>>> index b778cb4..2078da7 100644
>>>>> --- a/arch/powerpc/platforms/83xx/mpc83xx.h
>>>>> +++ b/arch/powerpc/platforms/83xx/mpc83xx.h
>>>>> @@ -43,12 +43,18 @@
>>>>> #define PORTSCX_PTS_UTMI           0x00000000
>>>>> #define PORTSCX_PTS_ULPI           0x80000000
>>>>>
>>>>> +/* PCIE Registers */
>>>>> +#define PEX_LTSSM_STAT               0x404
>>>>> +#define PEX_LTSSM_STAT_L0    0x16
>>>>> +#define PEX_GCLK_RATIO               0x440
>>>>> +
>>>>
>>>> just move these into the .c file.
>
> ok.
>
>>>>
>>>>>
>>>>> /*
>>>>> * Declaration for the various functions exported by the
>>>>> * mpc83xx_* files. Mostly for use by mpc83xx_setup
>>>>> */
>>>>> -
>>>>> -extern int mpc83xx_add_bridge(struct device_node *dev);
>>>>> +#define PPC_83XX_PCI 0x1
>>>>> +#define PPC_83XX_PCIE        0x2
>>>>> +extern int mpc83xx_add_bridge(struct device_node *dev, int
>> flags);
>>>>> extern void mpc83xx_restart(char *cmd);
>>>>> extern long mpc83xx_time_init(void);
>>>>> extern int mpc834x_usb_cfg(void);
>>>>> diff --git a/arch/powerpc/platforms/83xx/pci.c b/arch/powerpc/
>>>>> platforms/83xx/pci.c
>>>>> index 80425d7..0b52b2e 100644
>>>>> --- a/arch/powerpc/platforms/83xx/pci.c
>>>>> +++ b/arch/powerpc/platforms/83xx/pci.c
>>>>> @@ -25,6 +25,8 @@
>>>>> #include <asm/prom.h>
>>>>> #include <sysdev/fsl_soc.h>
>>>>>
>>>>> +#include "mpc83xx.h"
>>>>> +
>>>>> #undef DEBUG
>>>>>
>>>>> #ifdef DEBUG
>>>>> @@ -33,13 +35,157 @@
>>>>> #define DBG(x...)
>>>>> #endif
>>>>>
>>>>> -int __init mpc83xx_add_bridge(struct device_node *dev)
>>>>> +#if defined(CONFIG_PPC_MPC83XX_PCIE)
>>>>> +
>>>>> +/* PCIE config space Read/Write routines */
>>>>
>>>> should really be called something like mpc83xx_pciex_read_config
>>>>>
>>>>> +static int direct_read_config_pcie(struct pci_bus *bus,
>>>>> +                     uint devfn, int offset, int len, u32 *val)
>>>>> +{
>>>>> +     struct pci_controller *hose = bus->sysdata;
>>>>> +     void __iomem *cfg_addr;
>>>>> +     u32 bus_no;
>>>>> +
>>>>> +     if (hose->indirect_type & PPC_INDIRECT_TYPE_NO_PCIE_LINK)
>>>>> +             return PCIBIOS_DEVICE_NOT_FOUND;
>>>>> +
>>>>> +     if (ppc_md.pci_exclude_device)
>>>>> +             if (ppc_md.pci_exclude_device(hose, bus->number,
>>>> devfn))
>>>>> +                     return PCIBIOS_DEVICE_NOT_FOUND;
>>>>> +
>>>>> +     switch (len) {
>>>>> +     case 2:
>>>>> +             if (offset & 1)
>>>>> +                     return -EINVAL;
>>>>> +             break;
>>>>> +     case 4:
>>>>> +     if (offset & 3)
>>>>> +             return -EINVAL;
>>>>> +             break;
>>>>> +     }
>>>>
>>>> fix formatting.
>>>>
>>>>>
>>>>> +
>>>>> +     pr_debug("_read_cfg_pcie: bus=%d devfn=%x off=%x len=%x\n",
>>>>> +             bus->number, devfn, offset, len);
>>>>> +
>>>>> +     if (bus->number == hose->first_busno) {
>>>>> +             if (devfn & 0xf8)
>>>>> +                     return PCIBIOS_DEVICE_NOT_FOUND;
>>>>
>>>> what is the 0xf8 all about?
>>>>
>>>
>>> The pcie only have one link, so the dev number only can be 0, as
>> well
>>> the function number can be 0 ~ 7.
>>
>> I don't follow what the number of links has to do with dev number.
>
> The PCIE only have one link that mean one PCIE bus only can have one
> device populate on it. The dev number of this device must be 0. If the
> device number is not 0, we consider it is a error.

we should add a comment about that.

>>>>> +     addr = mbase + (cfg_addr & ~PAGE_MASK);
>>>>> +     hose->cfg_addr = addr;
>>>>> +     hose->ops = &direct_pcie_ops;
>>>>
>>>> what's the point of this function, why not just fold it into
>>>> mpc83xx_setup_pcie
>>>>
>>>>>
>>>>> +}
>>>>> +
>>>>> +static void __init mpc83xx_setup_pcie(struct pci_controller
>> *hose,
>>>>> +                     struct resource *reg, struct resource
>>>> *cfg_space)
>>>>> +{
>>>>> +     void __iomem *hose_cfg_base;
>>>>> +     u32 val;
>>>>> +
>>>>> +     hose_cfg_base = ioremap(reg->start, reg->end - reg->start +
>>>> 1);
>>>>> +
>>>>> +     val = in_le32(hose_cfg_base + PEX_LTSSM_STAT);
>>>>> +     if (val < PEX_LTSSM_STAT_L0)
>>>>> +             hose->indirect_type |=
>>>> PPC_INDIRECT_TYPE_NO_PCIE_LINK;
>>>>> +
>>>>> +     setup_direct_pcie(hose, cfg_space->start,
>>>>> +                     cfg_space->end - cfg_space->start + 1);
>>>>> +}
>>>>> +#endif /* CONFIG_PPC_MPC83XX_PCIE */
>>>>> +
>>>>
>>>> We should do the same think fsl_pci does for primary, its passed
>>>> into
>>>> _add_bridge.  Also, can we not do what fsl_pci does and use PCI
>>>> capabilities to determine we are a PCIe controller (and drop
>> passing
>>>> it in via flags).
>>>>
>>>
>>> The mpc837x PCIE controller is a little different from mpc85xx.
>>> It can not be access via PCI configure read/write. It only can be
>>> accessed via memory-mapped read/write from core.
>>
>> You don't have access to your own config space?
>>
>
> I can access it but can not via standard pci configure routine.
> So, we use different way to access PCI and PCIE. If we want access PCI
> capabilities, we must know it is PCI controller or PCIE controller
> first.

Duh, your right..  we should than expand flags to also have a  
PPC_83XX_PCI_IS_PRIMARY and let that get set by the caller.

- k
