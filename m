Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D5C70DDE9E
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Aug 2007 22:09:21 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1INSXv-0005li-4A
	for linuxppc-dev@ozlabs.org; Tue, 21 Aug 2007 05:09:19 -0700
Message-ID: <12253307.post@talk.nabble.com>
Date: Tue, 21 Aug 2007 05:09:19 -0700 (PDT)
From: sivaji <rameshmrm@gmail.com>
To: linuxppc-dev@ozlabs.org
Subject: Regarding PCIExpress Problem in MPC8641D
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hai,

Currently I am involved in the testing of a MPC8641D based board designed by
us. We have planned to test the PCI Express interface through a back to back
interface, host being mpc8641d and target is mpc8548.

When trying a target DMA transaction we are not able to access the host
memory using pci Express bus. We are facingDMA Transfer Error. Without DMA
we are able to access the host memory from the target and target memory from
the host.


The processor rev number is 2.0. The external irq[0-3] are pulled down and
the polarity is active low and it is level sensitive.

Memory base address : 0x80000000 size:512MB
I/O base address    : 0xe2000000 size:16MB.
Kernel Version	    : 2.6.21

PCI Express device node in the device tree:

pci@8000 {
                        compatible = "fsl,mpc86xx-pciex";
                        device_type = "pci";
                        #interrupt-cells = <1>;
                        #size-cells = <2>;
                        #address-cells = <3>;
                        reg = <8000 1000>;
                        bus-range = <0 fe>;
                        ranges = <02000000 0 80000000 80000000 0 20000000
                                  01000000 0 00000000 e2000000 0 01000000>;
                        clock-frequency = <1fca055>;
                        interrupt-parent = <40000>;
                        interrupts = <18 2>;
                        interrupt-map-mask = <f800 0 0 7>;
                        interrupt-map = <
                                /* IDSEL 0x0 (PEX) */
                                0000 0 0 1 40000 30 2
                                0000 0 0 2 40000 31 2
                                0000 0 0 3 40000 32 2
                                0000 0 0 4 40000 33 2 >;
               };

lspci result:


00:00.0 Class 0b20: 1957:7011 (rev 20)
        !!! Invalid class 0b20 for header type 01
        Flags: bus master, fast devsel, latency 0
        Memory at 80400000 (32-bit, non-prefetchable) [size=1M]
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 00000000-00000fff
        Memory behind bridge: 9ff00000-9fffffff
        Prefetchable memory behind bridge: 000000009fe00000-000000009fe00000
        Capabilities: [44] Power Management version 2
        Capabilities: [4c] #10 [0041]
00: 57 19 11 70 06 01 10 00 20 00 20 0b 00 00 01 00
10: 00 00 40 80 00 00 00 00 00 01 01 00 00 00 00 20
20: f0 9f f0 9f e1 9f e1 9f 00 00 00 00 00 00 00 00
30: 00 00 00 00 44 00 00 00 00 00 00 00 00 00 00 00

01:00.0 Class 0b20: 1957:0012 (rev 20) (prog-if 01)
        Flags: bus master, fast devsel, latency 0, IRQ 48
        Memory at 80000000 (32-bit, non-prefetchable) [size=1M]
        Memory at 80100000 (32-bit, non-prefetchable) [size=1M]
        Memory at 80200000 (64-bit, non-prefetchable) [size=1M]
        Memory at 80300000 (64-bit, non-prefetchable) [size=1M]
        Capabilities: [44] Power Management version 2
        Capabilities: [4c] #10 [0001]
        Capabilities: [70] Message Signalled Interrupts: 64bit+ Queue=0/4
Enable-
00: 57 19 12 00 06 00 10 00 20 01 20 0b 08 00 00 00
10: 00 00 00 80 00 00 10 80 04 00 20 80 00 00 00 00
20: 04 00 30 80 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 44 00 00 00 00 00 00 00 00 01 00 00

Host config space result(the value was taken in the kernel):

Vendor ID = 0x1957
Device ID = 0x7011
Command Register = 0x106
Status Register = 0x10
Revision ID = 0x20
Base class  = 0x0
Sub Class   = 0x20
Programming Interface = 0xb
Cache line register = 0x0
Latency Timer   = 0x0
Header type = 0x1
BAR Address Register 0 = 0x80400000
Primary Bus Number Register = 0x0
Secondary Bus Number Register = 0x1
Subordinate Bus Number Register = 0x1
PCI Express I/O Base Register :0x0
PCI Express I/O Limit Register = 0x0
PCI Express Secondary Status Register = 0x2000
PCI Express Memory Base Register = 0x9ff0
PCI Express Memory I/O Limit Register = 0x9ff0
PCI Express Prefetchable Memory Base Register = 0x9fe1
PCI Express Prefetchable Memory Limit Register = 0x9fe1
PCI Express Prefetchable Base Upper 32 BitsRegister = 0x0
PCI Express Prefetchable Limite Upper 32 BitsRegister = 0x0
PCI Express I/O Base upper 16 BitsRegister = 0x0
PCI Express I/O Limit upper 16 BitsRegister = 0x0
PCI Express Capabilites pointer Register = 0x44
PCI Express Interrupt Line Register = 0x0
PCI Express Interrupt Pin Register = 0x0
PCI Express Bridge Control Register = 0x0 


Please advice me.




-- 
View this message in context: http://www.nabble.com/Regarding-PCIExpress-Problem-in-MPC8641D-tf4304754.html#a12253307
Sent from the linuxppc-dev mailing list archive at Nabble.com.
