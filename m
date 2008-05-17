Return-Path: <coreppcdevel@gmail.com>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.235])
	by ozlabs.org (Postfix) with ESMTP id 8CA64DDE0D
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 17 May 2008 23:05:45 +1000 (EST)
Received: by rv-out-0506.google.com with SMTP id f6so536165rvb.9
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 17 May 2008 06:05:43 -0700 (PDT)
Message-ID: <543e3890805170605w34292787x569d6f5ac664b72a@mail.gmail.com>
Date: Sat, 17 May 2008 18:35:42 +0530
From: "Suresh Chandra Mannava" <coreppcdevel@gmail.com>
To: LinuxPPC-Embedded <linuxppc-embedded@ozlabs.org>
Subject: 2.6.24.7 on spruce cpc700
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_9057_961471.1211029542654"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_9057_961471.1211029542654
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi all,
I am working on porting 2.6.24 on IBM SPRUCE board. There is some problem
that is not allowing serial console to come up.
I am not sure where the problem lies, it may be with 8250 serial driver or
cpc700 programmable interrupt controller driver.
CPC700 consists of 16550A type UART.
I tried with various versions and succeeded in getting serial console on
Linux-2.6.8.
My requirement is 2.6.24. I tried with various other versions starting from
2.6.16 and all seems to have same problem.

I am trying to mount the root file system on ramdisk. This ramdisk image
works with other PowerPC boards.
It looks like kernel will execute "init" and hung after reaching first
printf, which involves serial port. Here are my Linux boot messages for your
reference. I request your suggestion for finding out the problem.

I put some debug messages in 8250.c, serial_core.c and cpc700_pic.c

## Transferring control to Linux (at address 00000000) ...
id mach(): done
MMU:enter
MMU:hw init
hash:enter
hash:find piece
hash:patch
hash:done
MMU:mapin
MMU:setio
MMU:exit
setup_arch: enter
setup_arch: bootmem
arch: exit
Total memory = 128MB; using 256kB for hash table (at c0240000)
Linux version 2.6.24.7 (suresh@mannava) (gcc version 4.0.0 (DENX ELDK 4.0
4.0.0)) #20 Sat May 17 15:21:00 IST 2008
System Identification: IBM Spruce
Port by MontaVista Software, Inc. (source@mvista.com)
Zone PFN ranges:
  DMA             0 ->    32768
  Normal      32768 ->    32768
  HighMem     32768 ->    32768
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
    0:        0 ->    32768
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 32512
Kernel command line: console=ttyS0,57600 root=/dev/ram0 rw
PID hash table entries: 512 (order: 9, 2048 bytes)
 ENTER serial8250_set_termios
 8 char
 baud is 57600
 quot is 9
 EXIT serial8250_set_termios
console [ttyS0] enabled
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
Memory: 125852k available (1420k kernel code, 608k data, 104k init, 0k
highmem)
Mount-cache hash table entries: 512
net_namespace: 64 bytes
NET: Registered protocol family 16

PCI: Probing PCI hardware
devfn is 0x20  idsel is 0x4 pin is 0x1
returned IRQ is 22
devfn is 0x28  idsel is 0x5 pin is 0x1
returned IRQ is 23
devfn is 0x30  idsel is 0x6 pin is 0x1
returned IRQ is 24
devfn is 0x31  idsel is 0x6 pin is 0x1
returned IRQ is 24
devfn is 0x32  idsel is 0x6 pin is 0x1
returned IRQ is 24
devfn is 0x38  idsel is 0x7 pin is 0x1
returned IRQ is 25
PCI: Cannot allocate resource region 1 of device 0000:00:00.0
checking if image is initramfs...it isn't (no cpio magic); looks like an
initrd
Freeing initrd memory: 1541k freed
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250: ttyS0 at MMIO 0x0 (irq = 3) is a 16550A
serial8250: ttyS1 at MMIO 0x0 (irq = 4) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
RAMDISK: Compressed image found at block 0
VFS: Mounted root (ext2 filesystem).
Freeing unused kernel memory: 104k init
 ENTER uart_open(0) called
 ENTER uart_startup
 ENTER serial8250_startup
 ENTER cpc700_unmask_irq
 EXIT cpc700_unmask_irq
 ENTER cpc700_get_IRQ
 EXIT cpc700_get_IRQ 3
 ENTER __do_IRQ
 ENTER cpc700_mask_and_ack_irq
 EXIT cpc700_mask_and_ack_irq
serial8250_interrupt(3)...end.
 OUT __do_IRQ
 EXIT serial8250_startup
 EXIT uart_startup
 ENTER serial8250_set_termios
 8 char
 baud is 57600
 quot is 9
 EXIT serial8250_set_termios
 EXIT uart_open

------=_Part_9057_961471.1211029542654
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi all,<br>I am working on porting 2.6.24 on IBM SPRUCE board. There is some problem that is not allowing serial console to come up.<br>I am not sure where the problem lies, it may be with 8250 serial driver or cpc700 programmable interrupt controller driver.<br>

CPC700 consists of 16550A type UART.<br>I tried with various versions and succeeded in getting serial console on Linux-2.6.8. <br>My requirement is <a href="http://2.6.24." target="_blank">2.6.24.</a> I tried with various other versions starting from 2.6.16 and all seems to have same problem.<br>

<br>I am trying to mount the root file system on ramdisk. This ramdisk image works with other PowerPC boards. <br>It looks like kernel will execute &quot;init&quot; and hung after reaching first printf, which involves serial port. Here are my Linux boot messages for your reference. I request your suggestion for finding out the problem.<br>

<br>I put some debug messages in 8250.c, serial_core.c and cpc700_pic.c<br><br>## Transferring control to Linux (at address 00000000) ...<br>id mach(): done<br>MMU:enter<br>MMU:hw init<br>hash:enter<br>hash:find piece<br>

hash:patch<br>hash:done<br>MMU:mapin<br>MMU:setio<br>MMU:exit<br>setup_arch: enter<br>setup_arch: bootmem<br>arch: exit<br>Total memory = 128MB; using 256kB for hash table (at c0240000)<br>Linux version <a href="http://2.6.24.7" target="_blank">2.6.24.7</a> (suresh@mannava) (gcc version 4.0.0 (DENX ELDK 4.0 4.0.0)) #20 Sat May 17 15:21:00 IST 2008<br>

System Identification: IBM Spruce<br>Port by MontaVista Software, Inc. (<a href="mailto:source@mvista.com" target="_blank">source@mvista.com</a>)<br>Zone PFN ranges:<br>&nbsp; DMA&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 -&gt;&nbsp;&nbsp;&nbsp; 32768<br>&nbsp; Normal&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 32768 -&gt;&nbsp;&nbsp;&nbsp; 32768<br>

&nbsp; HighMem&nbsp;&nbsp;&nbsp;&nbsp; 32768 -&gt;&nbsp;&nbsp;&nbsp; 32768<br>Movable zone start PFN for each node<br>early_node_map[1] active PFN ranges<br>&nbsp;&nbsp;&nbsp; 0:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 -&gt;&nbsp;&nbsp;&nbsp; 32768<br>Built 1 zonelists in Zone order, mobility grouping on.&nbsp; Total pages: 32512<br>

Kernel command line: console=ttyS0,57600 root=/dev/ram0 rw<br>PID hash table entries: 512 (order: 9, 2048 bytes)<br>&nbsp;ENTER serial8250_set_termios<br>&nbsp;8 char<br>&nbsp;baud is 57600<br>&nbsp;quot is 9<br>&nbsp;EXIT serial8250_set_termios<br>

console [ttyS0] enabled<br>Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)<br>Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)<br>Memory: 125852k available (1420k kernel code, 608k data, 104k init, 0k highmem)<br>

Mount-cache hash table entries: 512<br>net_namespace: 64 bytes<br>NET: Registered protocol family 16<br><br>PCI: Probing PCI hardware<br>devfn is 0x20&nbsp; idsel is 0x4 pin is 0x1<br>returned IRQ is 22<br>devfn is 0x28&nbsp; idsel is 0x5 pin is 0x1<br>

returned IRQ is 23<br>devfn is 0x30&nbsp; idsel is 0x6 pin is 0x1<br>returned IRQ is 24<br>devfn is 0x31&nbsp; idsel is 0x6 pin is 0x1<br>returned IRQ is 24<br>devfn is 0x32&nbsp; idsel is 0x6 pin is 0x1<br>returned IRQ is 24<br>devfn is 0x38&nbsp; idsel is 0x7 pin is 0x1<br>

returned IRQ is 25<br>PCI: Cannot allocate resource region 1 of device 0000:00:00.0<br>checking if image is initramfs...it isn&#39;t (no cpio magic); looks like an initrd<br>Freeing initrd memory: 1541k freed<br>io scheduler noop registered<br>

io scheduler anticipatory registered<br>io scheduler deadline registered<br>io scheduler cfq registered (default)<br>Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled<br>serial8250: ttyS0 at MMIO 0x0 (irq = 3) is a 16550A<br>

serial8250: ttyS1 at MMIO 0x0 (irq = 4) is a 16550A<br>RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize<br>RAMDISK: Compressed image found at block 0<br>VFS: Mounted root (ext2 filesystem).<br>Freeing unused kernel memory: 104k init<br>

&nbsp;ENTER uart_open(0) called<br>&nbsp;ENTER uart_startup<br>&nbsp;ENTER serial8250_startup<br>&nbsp;ENTER cpc700_unmask_irq<br>&nbsp;EXIT cpc700_unmask_irq<br>&nbsp;ENTER cpc700_get_IRQ<br>&nbsp;EXIT cpc700_get_IRQ 3<br>&nbsp;ENTER __do_IRQ<br>&nbsp;ENTER cpc700_mask_and_ack_irq<br>

&nbsp;EXIT cpc700_mask_and_ack_irq<br>serial8250_interrupt(3)...end.<br>&nbsp;OUT __do_IRQ<br>&nbsp;EXIT serial8250_startup<br>&nbsp;EXIT uart_startup<br>&nbsp;ENTER serial8250_set_termios<br>&nbsp;8 char<br>&nbsp;baud is 57600<br>&nbsp;quot is 9<br>&nbsp;EXIT serial8250_set_termios<br>

&nbsp;EXIT uart_open<br>

------=_Part_9057_961471.1211029542654--
