Reply-To: <jwalden@digitalatlantic.com>
From: "Jerry Walden" <jwalden@digitalatlantic.com>
To: "Linux PPC embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: default console settings for printk?
Date: Sun, 23 Mar 2003 17:05:20 -0500
Message-ID: <EGEGIJHKDKJGAJMGIDPNGEPJCJAA.jwalden@digitalatlantic.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <EGEGIJHKDKJGAJMGIDPNGEPGCJAA.jwalden@digitalatlantic.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello:

I'm still trying a variety of things to attempt to
bring Linux up on my custom 405GPr board.

I am using u-boot as my loader.

I first start u-boot from a BDI-2000.
Then I halt the board
Next I load the vmlinux.PPCBoot file, and the initrd file.
I then set a breakpoint on panic.
Next I tell the BDI to let the u-boot monitor to continue to run.
Lastly I issue the bootm command (i.e. bootm 0xllllllll 0xiiiiiiii)


Two things happen that I need some help on:
Before I hit the panic breakpoint many "garbage" characters appear in the
minicom
window that is connected to the target serial port.  u-boot behaves just
fine, and
all I/O works fine at 9600 baud - however it looks like the printk function
is putting
characters out to the serial port, however it seems that it is not putting
them out
at 9600 N81 - is there a default initializtion for the console?  It there a
way
to tell the kernel to setup the serial console for printk in a certain way.

Below is my log_buf contents after the panic breakpoint is hit.  You can see
the command
line I am passing - does this look correct?

 BDI>md 0xc00a2d88 10000
<4>Linux version 2.4.18_mvl30-walnut (root@hhl)(gcc version 3.2.1
20020930(MontaVista)) #8
 Sun Mar 23 13:02:27 EST 2003.
<6>IBM Sycamore (IBM405GPr) Platform.
<4>On node 0 totalpages: 16384.
<4>zone(0): 16384 pages..
<4>zone(1): 0 pages..
<4>zone(2): 0 pages..
<4>Kernel command line: root=/dev/ram console=ttyS0,9600.
<4>Calibrating delay loop... 266.24 BogoMIPS.
<6>Memory: 63744k available (512k kernel code, 212k data, 32k init, 0k
highmem).
<4>Dentry-cache hash table entries: 8192 (order:4, 65536 bytes).
<4>Inode-cache hash table entries: 4096 (order:3, 32768 bytes).
<4>Mount-cache hash table entries: 1024 (order:1, 8192 bytes).
<4>Buffer-cache hash table entries: 4096 (order:2, 16384 bytes).
<4>Page-cache hash table entries: 16384 (order:4, 65536 bytes).
<4>POSIX conformance testing by UNIFIX.
<6>Linux NET4.0 for Linux 2.4.
<6>Based upon Swansea University Computer Society NET3.039.
<4>OCP uart ver1.2 init complete.
<4>Starting kswapd.
<4>Disabling the Out Of Memory Killer.
<6>Serial driver version 5.05c (2001-07-08) with no serial options enabled.
<6>ttyS00 at 0xef600300 (irq = 0)is a 16550A.
<6>ttyS01 at 0xef600400 (irq = 1) is a 16550A.
<4>block: 128 slots per queue, batch=32.
<4>RAMDISK driver initialized:  16 RAM disks of 4096K size 1024 blocksize.
<6>Tracer: Initialization complete .

Thanks


Jerry Walden


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
