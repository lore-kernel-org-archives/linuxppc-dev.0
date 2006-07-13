Return-Path: <M9402134@mail.ntust.edu.tw>
Received: from mail.ntust.edu.tw (mail.ntust.edu.tw [140.118.31.60])
	by ozlabs.org (Postfix) with SMTP id ECB3967B5F
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 13 Jul 2006 13:40:19 +1000 (EST)
Message-ID: <000a01c6a62e$0f89bfb0$457b768c@Heclus>
From: "Kenny" <M9402134@mail.ntust.edu.tw>
To: <linuxppc-embedded@ozlabs.org>
Subject: Problem in PCI resource allocation with MPC8245
Date: Thu, 13 Jul 2006 11:40:18 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

I have a Freescale MPC8245 machine running Montavista Linux (kernel 2.4.20).
There are two devices connected to the PCI bus:
a USB host controller (VIA VT6212L) and a single-chip network switch
(Broadcom BCM5650).

Now BCM5650 is working but VT6212L is not.
I tried to modify the PCI code but met some problems.

Here are the PCI information and boot message:

Bus 0, device  0, devfn  0 (id 1057-0006, headertype 0x00)
        region 0: mask 0x00000008, now at 0x00000000
        region 0: type mem, size 0 (0MB)
        region 1: mask 0xfffff000, now at 0x00000000
        region 1: type mem, size 4096 (4KB)
        region 2: mask 0x00000008, now at 0x00000000
        region 2: type mem, size 0 (0MB)
Bus 0, device 16, devfn  0 (id 14e4-5650, headertype 0x00)  <-- BCM5650
        region 0: mask 0xffff0004, now at 0xbfff0000
        region 0: type mem, size 65536 (64KB)
        region 1: mask 0x000000ff, now at 0x00000000
        region 1: type I/O, size 65284 (65284B)
Bus 0, device 17, devfn  0 (id 1106-3038, headertype 0x00)  <-- VT6212L
(UHCI 1)
        region 4: mask 0xffffffe1, now at 0x00bfffe0
        region 4: type I/O, size 32 (32B)
Bus 0, device 17, devfn  1 (id 1106-3038, headertype 0x00)  <-- VT6212L
(UHCI 2)
        region 4: mask 0xffffffe1, now at 0x00bfffc0
        region 4: type I/O, size 32 (32B)
Bus 0, device 17, devfn  2 (id 1106-3104, headertype 0x00) <-- VT6212L
(EHCI)
        region 0: mask 0xffffff00, now at 0xbffeff00
        region 0: type mem, size 256 (256B)
--
PCI: Probing PCI hardware
PCI:00:00.0 Resource 0 [00000000-ffffffff] is unassigned
PCI:00:00.0 Resource 1 [00000000-00000fff] is unassigned
PCI:00:00.0 Resource 2 [00000000-ffffffff] is unassigned
PCI: bridge rsrc 0..bfffff (100), parent c0179de4
PCI: bridge rsrc 80000000..fcffffff (200), parent c0179e00
PCI:00:10.0: Resource 0: bfff0000-bfffffff (f=204)     <-- BCM5650
PCI:00:11.0: Resource 4: 00bfffe0-00bfffff (f=101)    <-- VT6212L (UHCI 1)
PCI:00:11.1: Resource 4: 00bfffc0-00bfffdf (f=101)   <-- VT6212L (UHCI 2)
PCI:00:11.2: Resource 0: bffeff00-bffeffff (f=200)     <-- VT6212L (EHCI)
--

It seems no problem with the allocated resource regions for VT6212L, but I
got "Timeout" message printed by USB driver.
So, I modify the function "mpc10x_bridge_set_resources" in
"arch/ppc/kernel/mpc10x_common.c":

 case MPC10X_MEM_MAP_B:
                        pci_init_resource(&hose->io_resource,
                                        0x00000000,
                                        0xffff,                       /*
original value: 0x00bfffff, */
                                        IORESOURCE_IO,
                                        "PCI host bridge");
--
and the defination of MPC10X_MAPB_PCI_IO_END in "include/asm/mpc10x.h":

#define MPC10X_MAPB_PCI_IO_END         (0x00010000 - 1)    /* original
value: (0x00c00000 - 1) */
--
After modification, the USB 1.x driver (UHCI) is working, and EHCI is still
not working.
BUT I don't know why the UHCI works if I  do the above modification?

The PCI information after modification is shown below:

Bus  0, device  17, function  0:
    Class 0c03: PCI device 1106:3038 (rev 97).
      IRQ 1.
      Master Capable.  Latency=128.
      I/O at 0xffe0 [0xffff].                          <-- I/O change to
0xffe0
  Bus  0, device  17, function  1:
    Class 0c03: PCI device 1106:3038 (rev 97).
      IRQ 1.
      Master Capable.  Latency=128.
      I/O at 0xffc0 [0xffdf].                        <-- I/O change to
0xffc0
  Bus  0, device  17, function  2:
    Class 0c03: PCI device 1106:3104 (rev 99).
      IRQ 1.
      Master Capable.  Latency=128.
      Non-prefetchable 32 bit memory at 0xbffeff00 [0xbffeffff].
--

I do the modification for the PCI memory configuration similar to the
modification for PCI I/O configuration:

[arch/ppc/kernel/mpc10x_common.c]
case MPC10X_MEM_MAP_B:
 ... snipped
                        pci_init_resource (&hose->mem_resources[0],
                                        0x00000000,              /*
original value: 0x80000000, */
                                        0x000fffff,                 /*
original value: 0xfcffffff, */
                                        IORESOURCE_MEM,
                                        "PCI host bridge");
--
[include/asm/mpc10x.h]
#define MPC10X_MAPB_ISA_MEM_BASE        0x00000000 /* original value:
0x80000000 */
... snipped
#define MPC10X_MAPB_PCI_MEM_START       0x00000000      /* original value:
0x80000000 */
#define MPC10X_MAPB_PCI_MEM_END        (0x00100000 - 1) /* original value:
(0xC0000000 - 1) */
--
Surprisingly, after this modification, the USB2.0 driver (EHCI) can work.
BUT, the BCM5650 driver failed...

Here are the PCI information and boot message:

  Bus  0, device  16, function  0:
    Class 0280: PCI device 14e4:5650 (rev 17).
      Master Capable.  Latency=128.
      Non-prefetchable 64 bit memory at 0xf0000 [0xfffff].  <-- BCM5650 PCI
memory address change to 0xf0000
  Bus  0, device  17, function  0:
    Class 0c03: PCI device 1106:3038 (rev 97).
      IRQ 1.
      Master Capable.  Latency=128.
      I/O at 0xffe0 [0xffff].
  Bus  0, device  17, function  1:
    Class 0c03: PCI device 1106:3038 (rev 97).
      IRQ 1.
      Master Capable.  Latency=128.
      I/O at 0xffc0 [0xffdf].
  Bus  0, device  17, function  2:
    Class 0c03: PCI device 1106:3104 (rev 99).
      IRQ 1.
      Master Capable.  Latency=128.
      Non-prefetchable 32 bit memory at 0xeff00 [0xeffff]. <-- EHCI PCI
memory address change to 0xeff00
--
PCI: bridge rsrc 0..ffff (100), parent c016fde4
PCI: bridge rsrc 0..fffff (200), parent c016fe00
PCI:00:10.0: Resource 0: 000f0000-000fffff (f=204)
PCI:00:11.0: Resource 4: 0000ffe0-0000ffff (f=101)
PCI:00:11.1: Resource 4: 0000ffc0-0000ffdf (f=101)
PCI:00:11.2: Resource 0: 000eff00-000effff (f=200)
--
And the failure message during inserting BCM5650 driver into kernel is:

__ioremap(): phys addr f0000 is RAM lr c0011db0
Oops: kernel access of bad area, sig: 11
NIP: C4881164 XER: 20000000 LR: C4887EDC SP: C3729C90 REGS: c3729be0 TRAP:
0300
   Not tainted
MSR: 00001032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: 00000148, DSISR: 22000000
TASK = c3728000[109] 'insmod' Last syscall: 128
... snipped
--

I have really no idea about this problem because I'm pretty new to PowerPC
and PCI architecture :'(
(So I think my modification may not reasonable)
Can anyone help me solve this problem ?
Any pointers and help would be greatly appreciated.

Thank you!
Kenny
