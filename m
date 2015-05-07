Return-Path: <oleks@arcturusnetworks.com>
Received: from mail.arcturusnetworks.com (mail.arcturusnetworks.com
 [66.11.68.20])
 by lists.ozlabs.org (Postfix) with ESMTP id E24CE1A058C
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 May 2015 02:38:49 +1000 (AEST)
Message-ID: <554B934C.5090406@arcturusnetworks.com>
Date: Thu, 07 May 2015 12:31:08 -0400
From: Oleksandr G Zhadan <oleks@arcturusnetworks.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 1/1] powerpc: mpc85xx: Add board support for ucp1020
References: <1430841121-1997-1-git-send-email-oleks@arcturusnetworks.com>
 <1430968950.16357.369.camel@freescale.com>
In-Reply-To: <1430968950.16357.369.camel@freescale.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Cc: Michael Durrant <mdurrant@arcturusnetworks.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Scott,

Thanks for fast response, please see inline.

On 05/06/2015 11:22 PM, Scott Wood wrote:
> On Tue, 2015-05-05 at 11:52 -0400, Oleksandr G Zhadan wrote:
>> New QorIQ p1020 based board support from Arcturus Networks Inc.
>> http://www.arcturusnetworks.com/products/ucp1020/
>>
>> Signed-off-by: Michael Durrant <mdurrant@arcturusnetworks.com>
>> Signed-off-by: Oleksandr G Zhadan <oleks@arcturusnetworks.com>
>> ---
>>   Documentation/devicetree/bindings/pci/fsl,pci.txt  |    2 +-
>>   .../devicetree/bindings/powerpc/arcturus/board.txt |  149 ++
>>   .../devicetree/bindings/powerpc/arcturus/ecm.txt   |   64 +
>>   Documentation/devicetree/bindings/usb/fsl-usb.txt  |    2 +-
>>   .../devicetree/bindings/vendor-prefixes.txt        |    1 +
>>   arch/powerpc/boot/dts/fsl/ucp1020som-post.dtsi     |  179 ++
>>   arch/powerpc/boot/dts/fsl/ucp1020som-pre.dtsi      |   70 +
>>   arch/powerpc/boot/dts/ucp1020_32b.dts              |   88 +
>>   arch/powerpc/boot/dts/ucp1020_32b.dtsi             |  174 ++
>>   arch/powerpc/configs/ucp1020_defconfig             | 2731 ++++++++++++++++++++
>>   arch/powerpc/platforms/85xx/Kconfig                |    7 +
>>   arch/powerpc/platforms/85xx/Makefile               |    1 +
>>   arch/powerpc/platforms/85xx/ucp1020_som.c          |  100 +
>>   13 files changed, 3566 insertions(+), 2 deletions(-)
>>   create mode 100644 Documentation/devicetree/bindings/powerpc/arcturus/board.txt
>>   create mode 100644 Documentation/devicetree/bindings/powerpc/arcturus/ecm.txt
>>   create mode 100644 arch/powerpc/boot/dts/fsl/ucp1020som-post.dtsi
>>   create mode 100644 arch/powerpc/boot/dts/fsl/ucp1020som-pre.dtsi
>>   create mode 100644 arch/powerpc/boot/dts/ucp1020_32b.dts
>>   create mode 100644 arch/powerpc/boot/dts/ucp1020_32b.dtsi
>>   create mode 100644 arch/powerpc/configs/ucp1020_defconfig
>>   create mode 100644 arch/powerpc/platforms/85xx/ucp1020_som.c
>>
>> diff --git a/Documentation/devicetree/bindings/pci/fsl,pci.txt b/Documentation/devicetree/bindings/pci/fsl,pci.txt
>> index d8ac4a7..298a5e6 100644
>> --- a/Documentation/devicetree/bindings/pci/fsl,pci.txt
>> +++ b/Documentation/devicetree/bindings/pci/fsl,pci.txt
>> @@ -20,7 +20,7 @@ Example:
>>   		#interrupt-cells = <1>;
>>   		#size-cells = <2>;
>>   		#address-cells = <3>;
>> -		compatible = "fsl,mpc8540-pcix", "fsl,mpc8540-pci";
>> +		compatible = "fsl,mpc8540-pcix", "fsl,mpc8540-pci", "fsl,mpc8548-pcie";
>>   		device_type = "pci";
>>   		...
>>   		...
>> diff --git a/Documentation/devicetree/bindings/powerpc/arcturus/board.txt b/Documentation/devicetree/bindings/powerpc/arcturus/board.txt
>> new file mode 100644
>> index 0000000..54e9765
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/powerpc/arcturus/board.txt
>> @@ -0,0 +1,149 @@
>> +UCP1020 module Tree Bindings
>> +----------------------------
>> +
>> +Copyright 2013-2015 Arcturus Networks, Inc.
>> +
>> +QorIQ p1020 based board
>> +http://www.arcturusnetworks.com/products/ucp1020/
>> +-------------------------------------------------
>> +
>> +Root Module
>> +
>> +Properties:
>> +- model:		"arcturus,uCP1020"
>> +- compatible:		"arcturus,uCP1020"
>> +- SN:			"1234567890-1234"
>> +
>> +/ {
>> +	model = "arcturus,uCP1020";
>> +	compatible = "arcturus,uCP1020", "fsl,P1020";
>> +	SN = "1234567890-1234";
>> +	...
>> +  }
>
> Drop the "fsl,P1020" compatible.  Top-level compatible strings describe
> the whole board.
>
> SN is a bad property name.  Call it something like "arcturus,serial#",
> and define what it actually means rather than just giving an example.
>

OK, will fix.

>> +-------------------------------------------------
>> +
>> +P1020 SPI controller
>> +
>> +Properties:
>> +- compatible:		"spansion,s25fl008k", "winbond,w25q80bl"
>> +
>> +Example:
>> +	spi@7000 {
>> +		flash@0 {
>> +			#address-cells = <1>;
>> +			#size-cells = <1>;
>> +			compatible = "spansion,s25fl008k", "winbond,w25q80bl";
>> +			reg = <0>;
>> +			spi-max-frequency = <40000000>; /* input clock */
>> +			...
>> +		};
>
> This isn't describing the controller, but rather a SPI chip attached to
> the controller.  This also doesn't seem like the right place for random
> SPI chips.
>
> If all you're specifying is the compatible, maybe create a
> spi/trivial-devices.txt similar to i2c/trivial-devices.txt?  Or
> something specific to SPI flash chips to describe the partition
> specification, though I generally recommend against describing
> partitions in the device tree -- especially if this is a developer board
> rather than something fixed-purpose where the partitioning is not going
> to change based on user requirements.
>
>

Mostly in all Documentation/devicetree/bindings/ I tried to satisfy 
checkpatch script as simple as possible. And for me as well it looks 
reasonable to create spi/trivial-devices.txt file and I will.

>> +-------------------------------------------------
>> +
>> +Chipselect/Local Bus
>> +
>> +Properties:
>> +- #address-cells:	<2>.
>> +- #size-cells:		<1>.
>> +- compatible:		"fsl,p1020-elbc", "fsl,elbc", "simple-bus","fsl,p1020-immr"
>> +- interrupts:		interrupts to report localbus events.
>> +
>> +Example:
>> +
>> +&lbc {
>> +	#address-cells = <2>;
>> +	#size-cells = <1>;
>> +	compatible = "fsl,p1020-elbc", "fsl,elbc", "simple-bus";
>> +	interrupts = <19 2 0 0>;
>> +};
>
> There's already a binding for elbc -- and the elbc node certainly should
> not claim compatibility with "fsl,p1020-immr".
>
>

to satisfy checkpatch script.

>> +-------------------------------------------------
>> +
>> +Freescale L2 Cache Controller
>> +
>> +L2 cache is present in Freescale's QorIQ and QorIQ Qonverge platforms.
>> +The cache bindings explained below are ePAPR compliant
>> +
>> +Properties:
>> +
>> +- compatible	: Should include "fsl,chip-l2-cache-controller" and "cache"
>> +		  where chip is the processor (bsc9132, npc8572 etc.)
>> +- reg		: Address and size of L2 cache controller registers
>> +- cache-size	: Size of the entire L2 cache
>> +- interrupts	: Error interrupt of L2 controller
>> +- cache-line-size : Size of L2 cache lines
>> +
>> +Example:
>> +
>> +	L2: l2-cache-controller@20000 {
>> +		compatible = "fsl,p1020-l2-cache-controller", "cache";
>> +		reg = <0x20000 0x1000>;
>> +		cache-line-size = <32>; // 32 bytes
>> +		cache-size = <0x40000>; // L2,256K
>> +		interrupts = <16 2 1 0>;
>> +	};
>
> This is copied and pasted from the existing binding.  Ignore
> checkpatch's inability to understand that "fsl,chip-l2-cache-controller"
> includes "fsl,p1020-l2-cache-controller".
>
> Likewise for the other bindings.  If you're going to have a binding
> document for your board, it should only talk about things that are
> specific to your board.
>

to satisfy checkpatch script.


>> diff --git a/Documentation/devicetree/bindings/usb/fsl-usb.txt b/Documentation/devicetree/bindings/usb/fsl-usb.txt
>> index 4779c02..a2663ad 100644
>> --- a/Documentation/devicetree/bindings/usb/fsl-usb.txt
>> +++ b/Documentation/devicetree/bindings/usb/fsl-usb.txt
>> @@ -57,7 +57,7 @@ Example multi port host USB controller device node :
>>
>>   Example dual role USB controller device node :
>>   	usb@23000 {
>> -		compatible = "fsl-usb2-dr";
>> +		compatible = "fsl-usb2-dr", "fsl-usb2-dr-v1.6";
>>   		reg = <23000 1000>;
>>   		#address-cells = <1>;
>>   		#size-cells = <0>;
>
> More specific compatibles come first.
>

OK.

>> diff --git a/arch/powerpc/boot/dts/fsl/ucp1020som-post.dtsi b/arch/powerpc/boot/dts/fsl/ucp1020som-post.dtsi
>> new file mode 100644
>> index 0000000..930a6e3
>> --- /dev/null
>> +++ b/arch/powerpc/boot/dts/fsl/ucp1020som-post.dtsi
>
> Why can't you use p1020si-post.dtsi?  The "si" means "silicon" -- it's
> meant to be included by all p1020 boards.
>

Yes, silicon is the same, but p1020 boards using all 3 etsec ethernet 
controllers. Our board using only 2: etsec1 and etsec3. And to avoid 
using eth0,eth2, and to use eth0,eth1 we make this extra ucp1020som-*.

>> diff --git a/arch/powerpc/boot/dts/ucp1020_32b.dts b/arch/powerpc/boot/dts/ucp1020_32b.dts
>> new file mode 100644
>> index 0000000..4a8358c
>> --- /dev/null
>> +++ b/arch/powerpc/boot/dts/ucp1020_32b.dts
>> @@ -0,0 +1,88 @@
>> +/*
>> + * uCP1020 Tree Source (32-bit address map)
>
> Do you plan on supporting both 32 and 36 bits?  If not, leave off the
> "_32b".
>

Good point - will rename.

>> diff --git a/arch/powerpc/configs/ucp1020_defconfig b/arch/powerpc/configs/ucp1020_defconfig
>> new file mode 100644
>> index 0000000..62f99aa
>> --- /dev/null
>> +++ b/arch/powerpc/configs/ucp1020_defconfig
>
> Please explain why your board needs its own defconfig.
>

Because, it's our own board and it has some specific to board 
definitions like CONFIG_DEFAULT_HOSTNAME and some specific to product 
definitions.

If I can do it in some other way could you please give me some example 
if it's possible.


> Plus, all defconfigs need to be run through savedefconfig to trim
> everything that doesn't change a default.
>

Sorry, forgot. Will do.

>> diff --git a/arch/powerpc/platforms/85xx/ucp1020_som.c b/arch/powerpc/platforms/85xx/ucp1020_som.c
>> new file mode 100644
>> index 0000000..aa98d31
>> --- /dev/null
>> +++ b/arch/powerpc/platforms/85xx/ucp1020_som.c
>> @@ -0,0 +1,100 @@
>> +/*
>> + * Arcturus Networks Inc. uCP1020 system on module Setup
>> + *
>> + * Copyright 2014-2015 Arcturus Networks Inc.
>> + *
>> + * by Oleksandr G Zhadan & Michael Durrant (www.ArcturusNetworks.com)
>> + *
>> + * This program is free software; you can redistribute  it and/or modify it
>> + * under  the terms of  the GNU General  Public License as published by the
>> + * Free Software Foundation;  either version 2 of the  License, or (at your
>> + * option) any later version.
>> + */
>> +
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
>> +#include <asm/fsl_guts.h>
>> +
>> +#include <sysdev/fsl_soc.h>
>> +#include <sysdev/fsl_pci.h>
>> +#include "smp.h"
>> +
>> +#include "mpc85xx.h"
>
> You don't need all of these headers.
>
>> +
>> +void __init ucp1020_som_pic_init(void)
>> +{
>> +	struct mpic *mpic;
>> +	unsigned long root = of_get_flat_dt_root();
>> +
>> +	if (of_flat_dt_is_compatible(root, "fsl,MPC85XXRDB-CAMP")) {
>> +		mpic = mpic_alloc(NULL, 0, MPIC_NO_RESET |
>> +				  MPIC_BIG_ENDIAN |
>> +				  MPIC_SINGLE_DEST_CPU, 0, 256, " OpenPIC  ");
>> +	} else {
>> +		mpic = mpic_alloc(NULL, 0,
>> +				  MPIC_BIG_ENDIAN |
>> +				  MPIC_SINGLE_DEST_CPU, 0, 256, " OpenPIC  ");
>> +	}
>
> Why do you have fsl,MPC85XXRDB-CAMP in here?
>

ups, didn't notice(cut and paste) will fix.


Probably will delay with patches fixes until May 21 - I'll be out of office.


Oleks

> -Scott
>
>
>


-- 
Oleksandr Zhadan
Arcturus Networks
T 416 621-0125 x235
F 416 621-0190
