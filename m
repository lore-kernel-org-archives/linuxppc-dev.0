Return-Path: <tallam.sreen@gmail.com>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.239])
	by ozlabs.org (Postfix) with ESMTP id 0F9A5DDF17
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 10 Apr 2008 12:07:03 +1000 (EST)
Received: by wx-out-0506.google.com with SMTP id h27so2795835wxd.15
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 09 Apr 2008 19:07:02 -0700 (PDT)
Message-ID: <5b1d25eb0804091907n7b1d6faewf66b5d664e40c115@mail.gmail.com>
Date: Wed, 9 Apr 2008 19:07:01 -0700
From: "Sreen Tallam" <tallam.sreen@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: Kernel Panic - not syncing: Attempted to kill init!
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi All,

Has anyone seen this error?
I am running a 2.6.18 kernel on a PPC 405GP using a AMCC Walnut board.

I added some printf's within the kernel to debug more information, and
it pointed to

init/main.c
under init() routine
in run_init_process(execute_command);
where execute_command = /sbin/tallam_init


=> tftp 0x800000 /tftpboot/tallam/kernel_5_2
ENET Speed is 100 Mbps - FULL duplex connection
Filename '/tftpboot/tallam/kernel_5_2'.
Load address: 0x800000
Loading: #################################################################
         #################################################################
         #################################################################
         #######################################
done
Bytes transferred = 1196495 (1241cf hex)
=> bootm 0x800000
## Booting image at 00800000 ...
   Image Name:   Linux-2.6.18_pro500
   Created:      2008-04-09  23:13:11 UTC
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    1196431 Bytes =  1.1 MB
   Load Address: 00400000
   Entry Point:  0040053c
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
## Current stack ends at 0x03FAD548 => set upper limit to 0x00800000
## cmdline at 0x007FFC00 ... 0x007FFD14
gd address  = 0x03FADF18
bd address  = 0x03FADF48
memstart    = 0x00000000
memsize     = 0x04000000
flashstart  = 0xFF000000
flashsize   = 0x01000000
flashoffset = 0x00000000
sramstart   = 0x00000000
sramsize    = 0x00000000
bootflags   = 0x0000A000
procfreq    =    100 MHz
plb_busfreq =    100 MHz
pci_busfreq =     50 MHz
ethaddr     = 00:xx:xx:04:4F:70
IP addr     = 172.xx.xxx.177
baudrate    =   9600 bps
No initrd
## Transferring control to Linux (at address 0040053c) ...
Memory <- <0x0 0x4000000> (64MB)
CPU clock-frequency <- 0x5f5e0ff (100MHz)
CPU timebase-frequency <- 0x5f5e0ff (100MHz)
/plb: clock-frequency <- 5f5e0ff (100MHz)
/plb/opb: clock-frequency <- 2faf07f (50MHz)
/plb/ebc: clock-frequency <- 2faf07f (50MHz)
/plb/opb/serial@ef600300: clock-frequency <- a98ac7 (11MHz)
/plb/opb/serial@ef600400: clock-frequency <- a98ac7 (11MHz)
ENET0: local-mac-address <- 00:xx:xx:04:4f:70

zImage starting: loaded at 0x00400000 (sp: 0x03fad3e8)
Allocating 0x299958 bytes for kernel ...
gunzipping (0x00000000 <- 0x0040d000:0x006a871c)...done 0x2740c0 bytes

Linux/PowerPC load:
mtdparts=phys_mapped_flash:64k@0k(envb),960k@64k(spare-log
s),6m@1m(jffs2b),768k@7m(kernelb),256k@7936k(u-bootb),64k@8m(envp),960k@8256k(
    logs),6m@9m(jffs2p),768k@15m(kernelp),256k@16128k(u-bootp)
console=ttyS1,9600      rootfstype=jffs2 root=/dev/mtdblock7 ro
init=/sbin/tallam_init
Finalizing device tree... flat tree at 0x6b5420
id mach(): done
MMU:enter
MMU:hw init
MMU:mapin
MMU:setio
MMU:exit
Linux version 2.6.18_pro500 (gcc version 4.2.     0 ) #1 PREEMPT Wed
Apr 9 16:02:34      PDT 2008
Found legacy serial port 0 for /plb/opb/serial@ef600300
  mem=ef600300, taddr=ef600300, irq=0, clk=11111111, speed=9600
Found legacy serial port 1 for /plb/opb/serial@e600400
  mem=ef600400, taddr=ef600400, irq=0, clk=11111111, spHz
time_init: processor frequency   = 99.999999 MHz
Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
Memory: 62228k/65536k available (2372k kernel code, 3248k reserved,
92k data,      146k bss, 156k init)
Calibrating delay loop... 198.65 BogoMIPS (lpj=397312)
Mount-cache hash table entries: 512
NET: Registered protocol family 16
/plb/opb/gpio@ef600700: device found
PCI: Probing PCI hardware
NET: Registered protocol family 2
IP route cache hash table entries: 512 (order: -1, 2048 bytes)
TCP established hash table entries: 2048 (order: 1, 8192 bytes)
TCP bind hash table entries: 1024 (order: 0, 4096 bytes)
TCP: Hash tables configured (established 2048 bind 1024)
TCP reno registered
JFFS2 version 2.2. (NAND) (C) 2001-2006 Red Hat, Inc.
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
/plb/opb/gpio@ef600700 character device (0) ready
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
serial8250.0: ttyS0 at MMIO map 0xef600300 mem 0xc5000300 (irq = 16)
is a 1655     0A
serial8250.0: ttyS1 at MMIO map 0xef600400 mem 0xc5002400 (irq = 17)
is a 1655     0A
console handover: boot [udbg0] -> real [ttyS1]
ef600300.serial: ttyS0 at MMIO map 0xef600300 mem 0xc5062300 (irq =
16) is a 1     6550A
ef600400.serial: ttyS1 at MMIO map 0xef600400 mem 0xc5064400 (irq =
17) is a 1     6550A
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
loop: loaded (max 8 devices)
PPC 4xx OCP EMAC driver, version 3.54
MAL v1 /plb/mcmal, 1 TX channels, 1 RX channels
eth0: EMAC-0 /plb/opb/ethernet@ef600800, MAC 00:a0:xx:xx:4f:70
eth0: found Generic MII PHY (0x01)
i2c /dev entries driver
IBM IIC driver v2.1
ff000000.flash: Found 1 x16 devices at 0x0 in 16-bit bank
 Amd/Fujitsu Extended Query Table at 0x0040
ff000000.flash: CFI does not contain boot bank location. Assuming top.
number of CFI chips: 1
cfi_cmdset_0002: Disabling erase-suspend-program due to code brokenness.
RedBoot partition parsing not available
Creating 10 MTD partitions on "ff000000.flash":
0x00000000-0x00010000 : "envb"
0x00010000-0x00100000 : "spare-logs"
0x00100000-0x00700000 : "jffs2b"
0x00700000-0x007c0000 : "kernelb"
0x007c0000-0x00800000 : "u-bootb"
0x00800000-0x00810000 : "envp"
0x00810000-0x00900000 : "logs"
0x00900000-0x00f00000 : "jffs2p"
0x00f00000-0x00fc0000 : "kernelp"
0x00fc0000-0x01000000 : "u-bootp"
ip_conntrack version 2.4 (512 buckets, 4096 max) - 172 bytes per conntrack
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
Time: timebase clocksource has been installed.
eth0: link is up, 100 FDX
IP-Config: Incomplete network configuration information.
VFS: Mounted root (jffs2 filesystem) readonly.
Freeing unused kernel memory: 156k init
Warning: unable to open an initial console.
init/main.c -- 819
init/main.c -- 821
init/main.c -- 844
init/main.c -- 704 -- /sbin/tallam_init<0>Kernel panic - not syncing:
Attempted to kill init!
Call Trace:
[C3FE7E60] [C0006D98]  (unreliable)
[C3FE7EA0] [C001F150]
[C3FE7EF0] [C0023630]
[C3FE7F30] [C0023734]
[C3FE7F40] [C000DBC0]
 <0>Rebooting in 180 seconds..

Any help will be appreciated.

Thanks,
Sreen
