Return-Path: <sprasad@bivio.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: kernel_thread pid - stuck (after VFS: Mounted root (ext2 filesystem).)
Date: Wed, 5 Dec 2007 16:00:21 -0800
Message-ID: <D83235F0F3C86D4D889D8B9A0DA8C6D7011A75A4@corpexc01.corp.networkrobots.com>
From: "Siva Prasad" <sprasad@bivio.net>
To: <linuxppc-dev@ozlabs.org>,
	<linuxppc-embedded@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

I am trying to bring up 8641 based on 2.6.19 kernel.

My system hangs after printing the message "VFS: Mounted root (ext2
filesystem)." I tried to follow down the path to identify where it is
hanging, and ended up at the following...

init/do_mounts_initrd.c: handle_initrd() function
.
.
.
        pid =3D kernel_thread(do_linuxrc, "/linuxrc", SIGCHLD);
        if (pid > 0) {
                while (pid !=3D (sivaval =3D sys_wait4(-1, NULL, 0, =
NULL)))
                      yield();
        }
.
.
.

It never comes out of this while loop and stuck for ever. Pid value
returned by kernel_thread is 193. I am not sure why that should be equal
to sys_wait4()'s return value, in order to proceed further. As you can
imagine, it repeatedly goes and executes sys_wait4, only to go and
execute again as the condition stays true (pid is not the same as return
value of sys_wait4).

Can some one throw some ideas, as to what might be the problem, and a
possible resolution to this.

Boot Log below
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Using MPC86xx HPCN machine description
Total memory =3D 1024MB; using 2048kB for hash table (at cfe00000)
Linux version 2.6.19 (sprasad@cider.bivio.net) (gcc version 4.1.1
20060525 (Red Hat 4.1.1-1)) #183 SMP Wed Dec 5 15:51:59 PST 2007
Found initrd at 0xc6000000:0xc62f912a
Found legacy serial port 0 for /soc8641@ff700000/serial@4500
  mem=3Dff704500, taddr=3Dff704500, irq=3D1a, clk=3D598500000, speed=3D0
Found MPC86xx PCIE host bridge at 0x00000000ff708000. Firmware bus
number: 0->254
Found MPC86xx PCIE host bridge at 0x00000000ff709000. Firmware bus
number: 0->255
MPC86xx HPCN board from Freescale Semiconductor
Zone PFN ranges:
  DMA             0 ->   196608
  Normal     196608 ->   196608
  HighMem    196608 ->   262144
early_node_map[1] active PFN ranges
    0:        0 ->   262144
Built 1 zonelists.  Total pages: 260096
Kernel command line: console=3DttyS0,115200 root=3D/dev/sda8
mpic: Setting up MPIC " MPIC     " version 1.2 at ff740000, max 2 CPUs
mpic: ISU size: 16, shift: 4, mask: f
mpic: Initializing for 80 sources
PID hash table entries: 4096 (order: 12, 16384 bytes)
generic_calibrate_decr: 7 ppc_tb_freq =3D 150000000.
generic_calibrate_decr: 7 ppc_proc_freq =3D 1649267441.
time_init: decrementer frequency =3D 150.000000 MHz
time_init: processor frequency   =3D 1649.267441 MHz
Console: colour dummy device 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1030352k/1048576k available (2740k kernel code, 279760k
reserved, 232k data, 129k bss, 156k init)
Mount-cache hash table entries: 512
mpic: requesting IPIs ...=20
Processor 1 is stuck.
Brought up 1 CPUs
checking if image is initramfs...it isn't (no cpio magic); looks like an
initrd
Freeing initrd memory: 3044k freed
NET: Registered protocol family 16
PCI: Probing PCI hardware
PCI: 0000:00:00.0: class b20 doesn't match header type 01. Ignoring
class.
PCI: Cannot allocate resource region 1 of PCI bridge 1
PCI: Cannot allocate resource region 2 of PCI bridge 1
PCI: Cannot allocate resource region 1 of device 0000:01:00.0
PCI: Cannot allocate resource region 3 of device 0000:01:00.0
PCI: Failed to allocate mem resource #1:4000@0 for 0000:01:00.0
PCI: Failed to allocate mem resource #3:10000@0 for 0000:01:00.0
bus mdio_bus: add driver Generic PHY
Generic PHY: Registered new driver
SCSI subsystem initialized
bus i2c: add driver i2c_adapter
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
highmem bounce pool size: 64 pages
io scheduler noop registered
io scheduler deadline registered (default)
io scheduler cfq registered
bus pci: add driver pcieport-driver
Serial: 8250/16550 driver $Revision: 1.90 $ 1 ports, IRQ sharing enabled
bus platform: add driver serial8250
serial8250.0: ttyS0 at MMIO 0xff704500 (irq =3D 26) is a 16550A
bus pci: add driver serial
RAMDISK driver initialized: 16 RAM disks of 131072K size 1024 blocksize
loop: loaded (max 8 devices)
bus mdio_bus: add driver Vitesse VSC8244
Vitesse VSC8244: Registered new driver
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=3Dxx
bus pci: add driver ALI15x3_IDE
bus ide: add driver ide-disk
bus ide: add driver ide-cdrom
bus scsi: add driver sd
bus pci: add driver ahci
bus platform: add driver fsl-i2c
bus i2c: add driver eeprom
TCP cubic registered
Initializing XFRM netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 10
IPv6 over IPv4 tunneling driver
NET: Registered protocol family 17
RAMDISK: Compressed image found at block 0
VFS: Mounted root (ext2 filesystem).
<<<<<< hangs here >>>>>>
