Date: Sat, 28 Jul 2001 16:54:19 -0700 (PDT)
From: James F Dougherty <jfd@GigabitNetworks.COM>
Message-Id: <200107282354.QAA00412@krakatoa.gigabitnetworks.com>
To: linuxppc-embedded@lists.linuxppc.org,
	ppcboot-users@lists.sourceforge.net
Subject: ISA SIO Problems
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I am trying to use the serial.c driver with HHL-2.4 and modified it
by adding the following entry to rs_table[] :


static struct serial_state rs_table[RS_TABLE_SIZE] = {

#ifdef CONFIG_MOUSSE
  { 0, 9600, 0xffe08080, 4, ASYNC_BOOT_AUTOCONF|ASYNC_NO_FLOW|ASYNC_SKIP_TEST,0,
	  PORT_8250, /* chip */
	  0, /*line*/
	  0, /*rev*/
	  1, /*tx fifo sz*/
	  0, /* custom div */
	  1, /* count */
	  (u8*)0xffe08080, /* IO base */
	  0, /* shift */
          0, /* close delay */
          0, /* closing_wait */
          (struct async_icount*)NULL, /* async icount struct */
          (struct termios*)NULL,
          (struct termios*)NULL,
          SERIAL_IO_MEM,
          (struct async_struct*)NULL
	} /* ttyS0 */
#else
     STD_SERIAL_PORT_DFNS
#endif
};


The serial port is an NS16552, however, if I use any value other than
PORT_8250, it doesn't seem to work and auto-detects an 8250.

The problem is that when I finally do boot up and mount the root filesystem,
the console no longer works, and when I try to exit from my tip console
session, the serial port on my sun box gets wedged.

My serial port does not have H/W flow control, is there some other
options I need to configure (tty terminal ios flags?) in order to
get my serial port to work without HW flow control?

I'm at a loss, as the network was much easier to bringup then the
serial port :-)




## Booting image at 00100000 ...
   Image Name:   vmlinux.bin.gz
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    674936 Bytes = 659 kB = 0 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
Total memory = 64MB; using 0kB for hash table (at 00000000)
Linux version 2.4.2_hhl20 (jfd@atlantis) (gcc version 2.95.2 19991024 (release))
#332 Sat Jul 28 16:31:52 PDT 2001
cpu0: MPC8240/KAHLUA : MOUSSE Platform : 64MB RAM: MPLD Rev.  1
Sandpoint port (C) 2000, 2001 MontaVista Software, Inc. (source@mvista.com)
On node 0 totalpages: 16384
zone(0): 16384 pages.
zone(1): 0 pages.
zone(2): 0 pages.
time_init: decrementer frequency = 16.666030 MHz
time_init: MPC8240 PCI Bus frequency = 33.332060 MHz
Calibrating delay loop... 133.12 BogoMIPS
Memory: 62612k available (1212k kernel code, 456k data, 80k init, 0k highmem)
Dentry-cache hash table entries: 8192 (order: 4, 65536 bytes)
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 4096 (order: 3, 32768 bytes)
POSIX conformance testing by UNIFIX
PCI: Probing PCI hardware
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd v1.8
pty: 256 Unix98 ptys configured
block: queued sectors max/low 41538kB/13846kB, 128 slots per queue
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
loop: loaded (max 8 devices)
Serial driver version 5.02 (2000-08-09) with SHARE_IRQ enabled
?%ZttyS00 at 0xffe08080 (irq = 4) is a 8250
Linux Tulip driver version 0.9.13a (January 20, 2001)
eth0: Digital DS21143 Tulip rev 65 at 0xbfff80, EEPROM not present,
00:00:00:00:01:0D, IRQ 1.
eth0:  MII transceiver #0 config 3000 status 7829 advertising 01e1.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 4096 bind 4096)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (nfs filesystem).
Freeing unused kernel memory: 80k init 4k openfirmware

eth0: Setting full-duplex based on MII#0 link partner capability of 45e1.

~
[EOT]

<=== Hang

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
