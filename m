Return-Path: <thirumalai.p@datapatterns.co.in>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 3A01FB6F34
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 12 Aug 2009 21:56:06 +1000 (EST)
Received: from ns0.datapatterns.co.in (ns0.datapatterns.co.in [121.242.18.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4AC73DDD01
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Aug 2009 21:56:05 +1000 (EST)
Message-ID: <0BB5A1799E0D45988C9DE08406084EAF@itd210>
From: "Thirumalai" <thirumalai.p@datapatterns.co.in>
To: <paulus@samba.org>
Subject: Fw: Regarding Device tree PCI binding on Linux-2.6.30 kernels
Date: Wed, 12 Aug 2009 17:15:03 +0530
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1";
	reply-type=response
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> Hi,
>    Is there any changes on PCI Device tree binding has happened? Because i 
> am trying to port linux 2.6.30 to my MPC7448 based custom board. The 
> target is getting hanged at ethernet initialization. Also i have seen on 
> the debug message of kernel that the PCI MEM/IO resources are not getting 
> assigned. So when searched the reason for not assigning the PCI MEM/IO 
> spaces.  I have seen the implemetation of 
> /linux/arch/powerpc/kernel/pci-common.c/ pci_process_bridge_OF_ranges() is 
> some what different from the old kernels. The CPU address is taken using 
> of_translate_address() function which is in prom_parse.c. This step is not 
> included on the previous implementations. This particular implementation 
> causing me problem of not finding PCI MEM/IO spaces. I have taken the dts 
> file of arch/powerpc/boot/dts/MPC7448hpc2.dts as my base dts file and 
> started to port for my hardware.
>    Kindly let me know any changes that i need to know.
> My dts file,
>
> / {
>        model = "dpvme0447";
>        compatible = "mpc74xx";
>        #address-cells = <1>;
>        #size-cells = <1>;
>
>        aliases {
>                ethernet0 = &enet0;
>                ethernet1 = &enet1;
>
>                serial0 = &serial0;
>                serial1 = &serial1;
>
>        };
>
>        cpus {
>                #address-cells = <1>;
>                #size-cells =<0>;
>
>                PowerPC,7448@0 {
>                        device_type = "cpu";
>                        reg = <0>;
>                        d-cache-line-size = <0x20>;     // 32 bytes
>                        i-cache-line-size = <0x20>;     // 32 bytes
>                        d-cache-size = <0x8000>;                // L1, 32K 
> bytes
>                        i-cache-size = <0x8000>;                // L1, 32K 
> bytes
>                        timebase-frequency = <0>;       // 33 MHz, from 
> uboot
>                        clock-frequency = <0>;          // From U-Boot
>                        bus-frequency = <0>;            // From U-Boot
>                        32-bit;
>                };
>        };
>
>        memory {
>                device_type = "memory";
>                reg = <0x00000000 0x20000000    // DDR2   512M at 0
>                       >;
>        };
>
>     tsi108@50000000 {
>                #address-cells = <1>;
>                #size-cells = <1>;
>                device_type = "tsi-bridge";
>                ranges = <0x00000000 0x50000000 0x00010000>;
>                reg = <0x50000000 0x00010000>;
>                assigned-addresses = <0>;
>                bus-frequency = <0>;
>
>                i2c@7000 {
>                        interrupt-parent = <&mpic>;
>                        interrupts = <0xE 0>;
>                        reg = <0x7000 0x400>;
>                        device_type = "i2c";
>                        compatible  = "tsi108-i2c";
>                };
>
>                MDIO: mdio@6000 {
>                        device_type = "mdio";
>                        compatible = "tsi108-mdio";
>                        reg = <0x6000 0x50>;
>                        #address-cells = <1>;
>                        #size-cells = <0>;
>
>                        phy8: ethernet-phy@6000 {
>                                interrupt-parent = <&mpic>;
>                                interrupts = <2 1>;
>                                reg = <8>;
>                                device_type = "ethernet-phy";
>                        };
>
>                        phy9: ethernet-phy@6400 {
>                                interrupt-parent = <&mpic>;
>                                interrupts = <2 1>;
>                                reg = <9>;
>                                device_type = "ethernet-phy"; enet0: 
> ethernet@6200 {
>                        linux,network-index = <0>;
>                        #size-cells = <0>;
>                        device_type = "network";
>                        compatible = "tsi108-ethernet";
>                        reg = <0x6000 0x200>;
>                        address = [ 00 06 D2 00 00 01 ];
>                        interrupts = <0x10 2>;
>                        interrupt-parent = <&mpic>;
>                        mdio-handle = <&MDIO>;
>                        phy-handle = <&phy8>;
>                };
>
>                enet1: ethernet@6600 {
>                        linux,network-index = <1>;
>                        #address-cells = <1>;
>                        #size-cells = <0>;
>                        device_type = "network";
>                        compatible = "tsi108-ethernet";
>                        reg = <0x6400 0x200>;
>                        address = [ 00 06 D2 00 00 02 ];
>                        interrupts = <0x11 2>;
>                        interrupt-parent = <&mpic>;
>                        mdio-handle = <&MDIO>;
>                        phy-handle = <&phy9>;
>                };
>
>                serial0: serial@7808 {
>                        device_type = "serial";
>                        compatible = "ns16550";
>                        reg = <0x7808 0x200>;
>                        clock-frequency = <0x3f6b5a00>;
>                        interrupts = <0xc 0>;
>                        interrupt-parent = <&mpic>;
>                };
>
>                serial1: serial@7c08 {
>                        device_type = "serial";
>                        compatible = "ns16550";
>                        reg = <0x7c08 0x200>;
>                        clock-frequency = <0x3f6b5a00>;
>                        interrupts = <0xd 0>;
>                        interrupt-parent = <&mpic>;
>                };
> mpic: pic@7400 {
>                        clock-frequency = <0>;
>                        interrupt-controller;
>                        #address-cells = <0>;
>                        #interrupt-cells = <2>;
>                        reg = <0x7400 0x400>;
>                        built-in;
>                        compatible = "chrp,open-pic";
>                        device_type = "open-pic";
>                        big-endian;
>                };
>                pci@1000 {
>                        device_type = "pci";
>                        compatible = "tsi108-pci";
>                        #interrupt-cells = <1>;
>                        #size-cells = <2>;
>                        #address-cells = <3>;
>                        reg = <0x1000 0x1000>;
>                        big-endian;
>                        bus-range = <0x0 0xff>;
>                        /* RANGE_TYPE UNKNOWN PCI_ADD PROC_ADDR UNKNOWN 
> SIZE
>                         02000000 - PCIMEM
>                         42000000 - PCI-MEM-PREFETCH
>                         01000000 - PCIIO
>                        */
>                        ranges = <0x02000000 0x0 0xe0000000 0xe0000000 0x0 
> 0x10000000
>                                  0x42000000 0x0 0x80000000 0x80000000 0x0 
> 0x40000000
>                                  0x01000000 0x0 0x00000000 0xf0000000 0x0 
> 0x00010000>;
>                        clock-frequency = <0x7f28154>;
>                        interrupt-parent = <&mpic>;
>                        interrupts = <0x17 2>;
>                        interrupt-map-mask = <0xf800 0 0 7>;
>                        interrupt-map = <
>
>                                /* IDSEL 0x11 */
>                                0x0800 0x0 0x0 0x1 &RT0 0x24 0x0
>                                0x0800 0x0 0x0 0x2 &RT0 0x25 0x0
>                                0x0800 0x0 0x0 0x3 &RT0 0x26 0x0
>                                0x0800 0x0 0x0 0x4 &RT0 0x27 0x0
>
>                                /* IDSEL 0x12 */
>                                0x1000 0x0 0x0 0x1 &RT0 0x25 0x0
>                                0x1000 0x0 0x0 0x2 &RT0 0x26 0x0
>                                0x1000 0x0 0x0 0x3 &RT0 0x27 0x0
>                                0x1000 0x0 0x0 0x4 &RT0 0x24 0x0
>
>                                /* IDSEL 0x13 */
>                                0x1800 0x0 0x0 0x1 &RT0 0x26 0x0
>                                0x1800 0x0 0x0 0x2 &RT0 0x27 0x0
>                                0x1800 0x0 0x0 0x3 &RT0 0x26 0x0
>                                0x1800 0x0 0x0 0x4 &RT0 0x26 0x0
>
>                                /* IDSEL 0x14 */
>                                0x2000 0x0 0x0 0x1 &RT0 0x27 0x0
>                                0x2000 0x0 0x0 0x2 &RT0 0x24 0x0
>                                0x2000 0x0 0x0 0x3 &RT0 0x25 0x0
>                                0x2000 0x0 0x0 0x4 &RT0 0x26 0x0
>                                >;
>
>                        RT0: router@1180 {
>                                clock-frequency = <0>;
>                                interrupt-controller;
>                                device_type = "pic-router";
>                                #address-cells = <0>;
>                                #interrupt-cells = <2>;
>                                built-in;
>                                big-endian;
>                                interrupts = <0x17 2>;
>                                interrupt-parent = <&mpic>;
>                        };
>                };
>        };
> };
>
> Regards,
> T.
>                        };
>
>                };
>

Panic Message that i got

------------[ cut here ]------------
Kernel BUG at c0190764 [verbose debug info unavailable]
Oops: Exception in kernel mode, sig: 5 [#1]
DPVME0447
NIP: c0190764 LR: c0190764 CTR: c014ea54
REGS: df82bd80 TRAP: 0700   Not tainted  (2.6.30)
MSR: 00029032 <EE,ME,CE,IR,DR>  CR: 24000022  XER: 20000000
TASK = df82c000[1] 'swapper' THREAD: df82a000
GPR00: c0190764 df82be30 df82c000 0000001a 00001509 ffffffff c014e9a4 
00000034
GPR08: c02f4af0 c02e9bb8 00001509 c02cf8f4 24000022 00000000 00000002 
00000000
GPR16: c02c0000 00000000 00000000 00000000 00000000 0ffaa41c c0300000 
00000004
GPR24: 00000000 00000000 c02f0000 c02f0000 df821030 00000000 df821000 
df821300
NIP [c0190764] tsi108_open+0x68/0x9c
LR [c0190764] tsi108_open+0x68/0x9c
Call Trace:
[df82be30] [c0190764] tsi108_open+0x68/0x9c (unreliable)
[df82be50] [c01b157c] dev_open+0xac/0x11c
[df82be70] [c01b147c] dev_change_flags+0x160/0x1b4
[df82be90] [c02bd8f4] ip_auto_config+0x18c/0xe5c
[df82bf50] [c0003c8c] do_one_initcall+0x34/0x1a8
[df82bfd0] [c02a2848] kernel_init+0x9c/0x100
[df82bff0] [c0012024] kernel_thread+0x4c/0x68
Instruction dump:
7c7d1b79 40820034 80bf003c 3c60c029 7fc6f378 38632ad8 90be0028 809f0040
4be90669 3c60c029 38632b08 4be9065d <0fe00000> 48000000 80bf003c 3c60c029
---[ end trace a900fd7f842065b9 ]---
Kernel panic - not syncing: Attempted to kill init!
Rebooting in 180 seconds..

Regards,
T. 


**************** CAUTION - Disclaimer *****************This email may contain confidential and privileged material for the
sole use of the intended recipient(s). Any review, use, retention, distribution or disclosure by others is strictly prohibited. If you are not the intended recipient (or authorized to receive for the recipient), please contact the sender by reply email and delete all copies of this message. Also, email is susceptible to data corruption, interception, tampering, unauthorized amendment and viruses. We only send and receive emails on the basis that we are not liable for any such corruption, interception, tampering, amendment or viruses or any consequence thereof. 
*********** End of Disclaimer ***********DataPatterns ITS Group**********
