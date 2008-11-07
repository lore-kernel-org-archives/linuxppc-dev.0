Return-Path: <isaac.gomez.morales@gmail.com>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.169])
	by ozlabs.org (Postfix) with ESMTP id 4149BDDE19
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  7 Nov 2008 22:57:41 +1100 (EST)
Received: by wf-out-1314.google.com with SMTP id 24so1185887wfg.15
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 07 Nov 2008 03:57:39 -0800 (PST)
Message-ID: <38a5a2d10811070357x684dcdefg1a43e0891f12ce29@mail.gmail.com>
Date: Fri, 7 Nov 2008 13:57:38 +0200
From: "Isaac Gomez Morales" <isaac.gomez.morales@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: MPC8572: Graphic Card problem
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_41204_17685447.1226059058979"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_41204_17685447.1226059058979
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

I have MPC8572DS Board with

> uname -a
Linux mpc8572ds 2.6.23 #3 SMP

and u-boot 1.3.0.

I have an ATI Radeon 3650 graphics card in the PCIe Slot1 as you can see in
the following charts

> lspci -v
...
0001:03:00.0 Non-VGA unclassified device: Freescale Semiconductor Inc
MPC8572E (rev 10)
        !!! Invalid class 0000 for header type 01
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=04, subordinate=04, sec-latency=0
        I/O behind bridge: 00000000-00000fff
        Memory behind bridge: a0000000-bfffffff
        Capabilities: [44] Power Management version 2
        Capabilities: [4c] Express Root Port (Slot-) IRQ 0
        Capabilities: [100] Advanced Error Reporting

0001:04:00.0 VGA compatible controller: ATI Technologies Inc Mobility Radeon
HD 3600 Series (prog-if 00 [VGA controller])
        Subsystem: ATI Technologies Inc Unknown device 0b42
        Flags: bus master, fast devsel, latency 0, IRQ 18
        Memory at a0000000 (64-bit, prefetchable) [size=256M]
        Memory at b0000000 (64-bit, non-prefetchable) [size=64K]
        I/O ports at 1000 [size=256]
        Capabilities: [50] Power Management version 3
        Capabilities: [58] Express Legacy Endpoint IRQ 0
        Capabilities: [a0] Message Signalled Interrupts: Mask- 64bit+
Queue=0/0 Enable-
        Capabilities: [100] Unknown (11)

The first problem is that the kernel does not seem to know that there is a
kind of pci bridge.

Doing..

> dmesg
...
Found 0001:03:00.0 [1957/0040] 000b20 01
PCI: Calling quirk c045aa60 for 0001:03:00.0
PCI: 0001:03:00.0: class b20 doesn't match header type 01. Ignoring class.
...
PCI: Fixups for bus 0001:03
PCI: Scanning behind PCI bridge 0001:03:00.0, config 010100, pass 0
PCI: Scanning behind PCI bridge 0001:03:00.0, config 000000, pass 1
...
PCI: Cannot allocate resource region 0 of device 0001:04:00.0
  got res [a0000000:afffffff] bus [a0000000:afffffff] flags 120c for BAR 0
of 0001:04:00.0
...
vga16fb: initializing
vga16fb: mapped to 0x000a0000
fb0: VGA16 VGA frame buffer device
...

The system cannot allocate de region 0, i believe that is an IO region.

Trying to read de framebuffer

> cat /dev/fb0

__ioremap(): phys addr 0xa0000 is RAM lr c018e838
Unable to handle kernel paging request for data at address 0x000a0000
Faulting instruction address: 0xc0191538
Oops: Kernel access of bad area, sig: 11 [#1]
SMP NR_CPUS=2 MPC8572 DS
NIP: c0191538 LR: c01914d4 CTR: 00000400
REGS: e0415e10 TRAP: 0300   Not tainted  (2.6.23)
MSR: 00029000 <EE,ME>  CR: 40002242  XER: 00000000
DEAR: 000a0000, ESR: 00000000
TASK = efe64530[1085] 'cat' THREAD: e0414000 CPU: 1
GPR00: 00000400 e0415ec0 efe64530 fffffff4 c07635dc 00000000 efffa530
00000000
GPR08: 00000001 e0433000 00000000 000a0000 20002222 1001c648 0ffea000
10090000
GPR16: 10010000 00000002 fffff000 00001000 00000000 00000000 100bbb28
100bec08
GPR24: 00000000 e0433000 00001000 000a0000 00001000 efd8d400 10016000
e0415f20
NIP [c0191538] fb_read+0x148/0x260
LR [c01914d4] fb_read+0xe4/0x260
Call Trace:
[e0415ec0] [c01914d4] fb_read+0xe4/0x260 (unreliable)
[e0415ef0] [c008bf24] vfs_read+0xc4/0x168
[e0415f10] [c008c50c] sys_read+0x4c/0x90
[e0415f40] [c000ffb8] ret_from_syscall+0x0/0x3c
Instruction dump:
7f7be214 3b000000 2b9a1000 39201000 7f9a4f1e 7f2bcb78 7f801671 7c0903a6
41820034 7f6bdb78 7f29cb78 39400000 <800b0000> 394a0001 396b0004 90090000
Segmentation fault

> cat /proc/ioports

00000000-0000ffff : /pcie@ffe08000
  00000000-0000ffff : PCI Bus #01
    00000020-00000021 : 8259 (master)
    000000a0-000000a1 : 8259 (slave)
    000004d0-000004d1 : 8259 edge control
    00001000-00001fff : PCI Bus #02
      00001000-000010ff : 0000:02:1d.0
      00001200-00001207 : 0000:02:1f.0
        00001200-00001207 : libata
      00001208-0000120b : 0000:02:1f.0
        00001208-0000120b : libata
      00001210-00001217 : 0000:02:1f.0
        00001210-00001217 : libata
      00001218-0000121b : 0000:02:1f.0
        00001218-0000121b : libata
      00001220-0000122f : 0000:02:1f.0
        00001220-0000122f : libata
      00001230-00001237 : 0000:02:1f.1
      00001238-0000123b : 0000:02:1f.1
      00001240-00001247 : 0000:02:1f.1
      00001248-0000124b : 0000:02:1f.1
      00001250-0000125f : 0000:02:1f.1
fffdc000-fffebfff : /pcie@ffe0a000
fffee000-ffffdfff : /pcie@ffe09000
  fffee000-ffffdfff : PCI Bus #04
    fffef000-fffef0ff : 0001:04:00.0

I cant see anything, i have tried differents the lastest version of u-boot
(u-boot-2008) and linux kernel (2.6.27.4) but it dont solve this problem.

All comments will be good.

Thanks in advance and sorry for my english.

Isaac.

------=_Part_41204_17685447.1226059058979
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,<br><br>I have MPC8572DS Board with<br><br>&gt; uname -a<br>Linux mpc8572ds 2.6.23 #3 SMP<br><br>and u-boot <a href="http://1.3.0.">1.3.0.</a><br><br>I have an ATI Radeon 3650 graphics card in the PCIe Slot1 as you can see in the following charts<br>
<br>&gt; lspci -v<br>...<br>0001:03:00.0 Non-VGA unclassified device: Freescale Semiconductor Inc MPC8572E (rev 10)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !!! Invalid class 0000 for header type 01<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Flags: bus master, fast devsel, latency 0<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Bus: primary=00, secondary=04, subordinate=04, sec-latency=0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I/O behind bridge: 00000000-00000fff<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Memory behind bridge: a0000000-bfffffff<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Capabilities: [44] Power Management version 2<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Capabilities: [4c] Express Root Port (Slot-) IRQ 0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Capabilities: [100] Advanced Error Reporting<br><br>0001:04:00.0 VGA compatible controller: ATI Technologies Inc Mobility Radeon HD 3600 Series (prog-if 00 [VGA controller])<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Subsystem: ATI Technologies Inc Unknown device 0b42<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Flags: bus master, fast devsel, latency 0, IRQ 18<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Memory at a0000000 (64-bit, prefetchable) [size=256M]<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Memory at b0000000 (64-bit, non-prefetchable) [size=64K]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I/O ports at 1000 [size=256]<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Capabilities: [50] Power Management version 3<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Capabilities: [58] Express Legacy Endpoint IRQ 0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Capabilities: [a0] Message Signalled Interrupts: Mask- 64bit+ Queue=0/0 Enable-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Capabilities: [100] Unknown (11)<br><br>The first problem is that the kernel does not seem to know that there is a kind of pci bridge.<br><br>Doing..<br><br>&gt; dmesg<br>...<br>Found 0001:03:00.0 [1957/0040] 000b20 01<br>
PCI: Calling quirk c045aa60 for 0001:03:00.0<br>PCI: 0001:03:00.0: class b20 doesn&#39;t match header type 01. Ignoring class.<br>...<br>PCI: Fixups for bus 0001:03&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>PCI: Scanning behind PCI bridge 0001:03:00.0, config 010100, pass 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
PCI: Scanning behind PCI bridge 0001:03:00.0, config 000000, pass 1&nbsp;&nbsp;&nbsp; <br>...<br>PCI: Cannot allocate resource region 0 of device 0001:04:00.0<br>&nbsp; got res [a0000000:afffffff] bus [a0000000:afffffff] flags 120c for BAR 0 of 0001:04:00.0<br>
...<br>vga16fb: initializing<br>vga16fb: mapped to 0x000a0000<br>fb0: VGA16 VGA frame buffer device<br>...<br><br>The system cannot allocate de region 0, i believe that is an IO region.<br><br>Trying to read de framebuffer<br>
<br>&gt; cat /dev/fb0<br><br>__ioremap(): phys addr 0xa0000 is RAM lr c018e838<br>Unable to handle kernel paging request for data at address 0x000a0000<br>Faulting instruction address: 0xc0191538<br>Oops: Kernel access of bad area, sig: 11 [#1]<br>
SMP NR_CPUS=2 MPC8572 DS<br>NIP: c0191538 LR: c01914d4 CTR: 00000400<br>REGS: e0415e10 TRAP: 0300&nbsp;&nbsp; Not tainted&nbsp; (2.6.23)<br>MSR: 00029000 &lt;EE,ME&gt;&nbsp; CR: 40002242&nbsp; XER: 00000000<br>DEAR: 000a0000, ESR: 00000000<br>TASK = efe64530[1085] &#39;cat&#39; THREAD: e0414000 CPU: 1<br>
GPR00: 00000400 e0415ec0 efe64530 fffffff4 c07635dc 00000000 efffa530 00000000 <br>GPR08: 00000001 e0433000 00000000 000a0000 20002222 1001c648 0ffea000 10090000 <br>GPR16: 10010000 00000002 fffff000 00001000 00000000 00000000 100bbb28 100bec08 <br>
GPR24: 00000000 e0433000 00001000 000a0000 00001000 efd8d400 10016000 e0415f20 <br>NIP [c0191538] fb_read+0x148/0x260<br>LR [c01914d4] fb_read+0xe4/0x260<br>Call Trace:<br>[e0415ec0] [c01914d4] fb_read+0xe4/0x260 (unreliable)<br>
[e0415ef0] [c008bf24] vfs_read+0xc4/0x168<br>[e0415f10] [c008c50c] sys_read+0x4c/0x90<br>[e0415f40] [c000ffb8] ret_from_syscall+0x0/0x3c<br>Instruction dump:<br>7f7be214 3b000000 2b9a1000 39201000 7f9a4f1e 7f2bcb78 7f801671 7c0903a6 <br>
41820034 7f6bdb78 7f29cb78 39400000 &lt;800b0000&gt; 394a0001 396b0004 90090000 <br>Segmentation fault<br><br>&gt; cat /proc/ioports<br><br>00000000-0000ffff : /pcie@ffe08000<br>&nbsp; 00000000-0000ffff : PCI Bus #01<br>&nbsp;&nbsp;&nbsp; 00000020-00000021 : 8259 (master)<br>
&nbsp;&nbsp;&nbsp; 000000a0-000000a1 : 8259 (slave)<br>&nbsp;&nbsp;&nbsp; 000004d0-000004d1 : 8259 edge control<br>&nbsp;&nbsp;&nbsp; 00001000-00001fff : PCI Bus #02<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00001000-000010ff : 0000:02:1d.0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00001200-00001207 : 0000:02:1f.0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00001200-00001207 : libata<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00001208-0000120b : 0000:02:1f.0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00001208-0000120b : libata<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00001210-00001217 : 0000:02:1f.0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00001210-00001217 : libata<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00001218-0000121b : 0000:02:1f.0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00001218-0000121b : libata<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00001220-0000122f : 0000:02:1f.0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00001220-0000122f : libata<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00001230-00001237 : 0000:02:1f.1<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00001238-0000123b : 0000:02:1f.1<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00001240-00001247 : 0000:02:1f.1<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00001248-0000124b : 0000:02:1f.1<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00001250-0000125f : 0000:02:1f.1<br>fffdc000-fffebfff : /pcie@ffe0a000<br>fffee000-ffffdfff : /pcie@ffe09000<br>&nbsp; fffee000-ffffdfff : PCI Bus #04<br>&nbsp;&nbsp;&nbsp; fffef000-fffef0ff : 0001:04:00.0<br><br>I cant see anything, i have tried differents the lastest version of u-boot (u-boot-2008) and linux kernel (<a href="http://2.6.27.4">2.6.27.4</a>) but it dont solve this problem.<br>
<br>All comments will be good.<br><br>Thanks in advance and sorry for my english.<br><br>Isaac.<br>

------=_Part_41204_17685447.1226059058979--
