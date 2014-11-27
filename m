Return-Path: <alessio.bogani@elettra.eu>
Received: from spamalot.elettra.eu (spamalot.elettra.trieste.it
 [140.105.206.208])
 (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A01641A09BB
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Nov 2014 01:28:49 +1100 (AEDT)
Received: from spamalot.elettra.eu (localhost.localdomain [127.0.0.1])
 by localhost (Email Security Appliance) with SMTP id 02F1F440E16_477351DB
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Nov 2014 14:28:45 +0000 (GMT)
Received: from mail-wi0-f181.google.com (mail-wi0-f181.google.com
 [209.85.212.181]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (verified OK))
 by spamalot.elettra.eu (Sophos Email Appliance) with ESMTPSA id
 6D93143E096_477351CF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Nov 2014 14:28:44 +0000 (GMT)
Received: by mail-wi0-f181.google.com with SMTP id r20so8533600wiv.8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Nov 2014 06:28:43 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1417040495.15957.176.camel@freescale.com>
References: <1417011468-13485-1-git-send-email-alessio.bogani@elettra.eu>
 <1417040495.15957.176.camel@freescale.com>
Date: Thu, 27 Nov 2014 15:28:42 +0100
Message-ID: <CAPk1OjGGnF6jxxXOOqK4dB9-g2=CyT7DsS8U+KgW3-g2PooXdQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1 1/1] powerpc/85xx: Add support for Emerson/Artesyn
 MVME2500.
From: Alessio Igor Bogani <alessio.bogani@elettra.eu>
To: Scott Wood <scottwood@freescale.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Scott,

On 26 November 2014 at 23:21, Scott Wood <scottwood@freescale.com> wrote:
> On Wed, 2014-11-26 at 15:17 +0100, Alessio Igor Bogani wrote:
>> +     board_soc: soc: soc@ffe00000 {
>
> There's no need for two labels on the same node.

I'll remove board_soc label.

[...]
>> +                     eeprom-vpd@54 {
>> +                             compatible = "atmel,24c64";
>> +                             reg = <0x54>;
>> +                     };
>
> eeprom-vpd?
>
> Node name isn't the right place to put the intended usage of the
> contents of the EEPROM.

I'll rename  eeprom-vpd to eeprom.

[...]
>> +                     spd@50 {
>> +                             compatible = "atmel,24c02";
>> +                             reg = <0x50>;
>> +                     };
>
> Likewise, I suspect this is also an eeprom.

I'll rename spd to eeprom.

[...]
>> +                             partition@u-boot {
>> +                                     label = "u-boot";
>> +                                     reg = <0x00000000 0x000A0000>;
>> +                                     read-only;
>> +                             };
>> +                             partition@dtb {
>> +                                     label = "dtb";
>> +                                     reg = <0x000A0000 0x00020000>;
>> +                             };
>
> Unfortunately you seem to have copied a bad example here...  After the @
> should be a number that matches reg.
>
> Better yet, don't put partition information in the dts at all -- it's
> not hardware description.  Use the mtdparts command line.

I'll remove partition scheme.

>> +     lbc: localbus@ffe05000 {
>> +             reg = <0 0xffe05000 0 0x1000>;
>> +
>
> It's not possible to program the LBC with a window of only 0x1000 bytes.

All similar boards seem to have the same value there. AFAIK 0x1000 is
a offset so it stands for 4KB.

>> +
>> +             serial2: serial@1,0 {
>> +                     #cell-index = <2>;
>> +                     device_type = "serial";
>> +                     compatible = "ns16550";
>> +                     reg = <0x1 0x0 0x100>;
>> +                     clock-frequency = <1843200>;
>> +                     interrupts = <11 2 0 0>;
>> +             };
>
> Why do you need cell-index, what connection do these values have to
> actual hardware (e.g. values written to a register, rather than numbers
> in a manual), and why did the name change to #cell-index?

I have used fsl/pq3-duart-0.dtsi as template and #cell-index are used there.

I'll remove #cell-index. The name should be already correct.

>> +                     interrupts = <9 1 0 0 >;
>
> Whitespace

I'll remove it.

>> +/include/ "mvme2500.dtsi"
>
> Are you going to have more than one .dts using this .dtsi?  If not, why
> separate this part?

The pq3-gpio-0.dtsi defines an gpio controller in this way:

gpio-controller@f000 {
     reg = <0xf000 0x100>;
     [...]

But MVME2500 board requires a slightly different definition:

     reg = <0xfc00 0x100>;

Override gpio-controller reg definition included by
fsl/p2020si-post.dtsi (which includes the above mentioned
fsl/pq3-gpio-0.dtsi) using mvme2500.dtsi is the only solution I have
found so far.

Can you suggest me a better approach, please?

>> diff --git a/arch/powerpc/boot/dts/mvme2500.dtsi b/arch/powerpc/boot/dts/mvme2500.dtsi
>> new file mode 100644
>> index 0000000..6966f13
>> --- /dev/null
>> +++ b/arch/powerpc/boot/dts/mvme2500.dtsi
> [snip]
>> +/include/ "fsl/pq3-mpic-message-B.dtsi"
>> +};
>
> Why is this being included from a board file rather than from the SoC
> file?

My fault. I'll move that include into mvme2500.dts.

>> diff --git a/arch/powerpc/configs/85xx/mvme2500_defconfig b/arch/powerpc/configs/85xx/mvme2500_defconfig
>> new file mode 100644
>> index 0000000..06fe629
>> --- /dev/null
>> +++ b/arch/powerpc/configs/85xx/mvme2500_defconfig
>
> Why does this board need its own defconfig?
>
> If it's just for the address space stuff, maybe it could be a more
> general mpc85xx_2g_1g_1g_defconfig.  xes_mpc85xx_defconfig uses the same
> layout (though it's SMP).  Maybe other boards could share it in the
> future, or users of existing boards might prefer it...

Sorry for ignorance but what are *_defconfigs supposed to provide?
A barely bootable system (in that case I can pick the config of a
similar board) or a system with all drivers for devices exposed by its
device tree?

> Better still would be if we could have address map tweaks be kconfig
> fragments that get mixed in by the user, with merge_config.sh.

Personally I would prefer see something more simple like this:

%_defconfig: scripts/kconfig/conf
   # Grab the platform generic config file (for a SoC family)
   $(Q)$< --defconfig=arch/$(SRCARCH)/configs/mpc$(shell dirname
$@)_defconfig Kconfig
   # So merge board specific configuration options
   $(Q)$(CONFIG_SHELL) $(srctree)/scripts/kconfig/merge_config.sh -m
-O $(objtree) $(objtree)/.config arch/$(SRCARCH)/configs/$@
   # Expand config
   $(Q)yes "" | $(MAKE) -f $(srctree)/Makefile oldconfig

>> +CONFIG_MATH_EMULATION=y
>> +CONFIG_MATH_EMULATION_HW_UNIMPLEMENTED=y
>
> CONFIG_MATH_EMULATION_HW_UNIMPLEMENTED is not appropriate for e500v2
> which does not implement any part of the classic PPC FPU.  You want
> either full emulation or no emulation at all.

I'll change configuration for use full emulation.

>> +CONFIG_ADVANCED_OPTIONS=y
>> +CONFIG_LOWMEM_SIZE_BOOL=y
>> +CONFIG_LOWMEM_SIZE=0x40000000
>> +CONFIG_PAGE_OFFSET_BOOL=y
>> +CONFIG_PAGE_OFFSET=0x80000000
>> +CONFIG_KERNEL_START_BOOL=y
>> +CONFIG_TASK_SIZE_BOOL=y
>> +CONFIG_TASK_SIZE=0x80000000
>
> I gues the point here is to avoid using highmem just for the last 256
> MiB?

Yes. Can you suggest me a better solution, please?

>> +CONFIG_STAGING=y
>
> What do you need from staging?

CONFIG_VME_USER. It is a staging driver although it isn't appear in
staging menu.

>> diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
>> index f22635a..b92674a 100644
>> --- a/arch/powerpc/platforms/85xx/Kconfig
>> +++ b/arch/powerpc/platforms/85xx/Kconfig
>> @@ -241,6 +241,14 @@ config SGY_CTS1000
>>       help
>>         Enable this to support functionality in Servergy's CTS-1000 systems.
>>
>> +config MVME2500
>> +     bool "Artesyn MVME2500"
>> +     select DEFAULT_UIMAGE
>> +     select SWIOTLB
>
> Why do you need SWIOTLB with only 1 GiB RAM?

I'll remove SWIOTLB usages.

>> +#include <linux/stddef.h>
>> +#include <linux/kernel.h>
>> +#include <linux/pci.h>
>> +#include <linux/kdev_t.h>
>> +#include <linux/delay.h>
>> +#include <linux/seq_file.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/of_platform.h>
>> +
>> +#include <asm/time.h>
>> +#include <asm/machdep.h>
>> +#include <asm/pci-bridge.h>
>> +#include <mm/mmu_decl.h>
>> +#include <asm/prom.h>
>> +#include <asm/udbg.h>
>> +#include <asm/mpic.h>
>> +#include <asm/swiotlb.h>
>> +#include <asm/nvram.h>
>> +
>> +#include <sysdev/fsl_soc.h>
>> +#include <sysdev/fsl_pci.h>
>> +
>> +#include "mpc85xx.h"
>
> I don't think you need all of these.

Il'' avoid include useless headers.

>
>> +#if defined(CONFIG_MMIO_NVRAM)
>> +     mmio_nvram_init();
>> +#endif
>
> You select it in kconfig, so why do you need the ifdef?
>
>> +     printk(KERN_INFO "MVME2500 board from Artesyn\n");
>
> pr_info()

I''l change the code for using pr_info() instead of printk().

>> +     return of_flat_dt_is_compatible(root, "Artesyn,MVME2500");
>
> The compatible in the dts uses "artesyn", not "Artesyn".  Don't rely on
> the fact that Linux (on some arches) uses case-insensitive comparisons
> to deal with broken old firmware.  Nothing in ePAPR says that compatible
> should be case-insensitive.

I'll rename Artesyn to artesyn.

Thank you very much.

Ciao,
Alessio
