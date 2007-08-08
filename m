Return-Path: <antonkowalski@gmail.com>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.233])
	by ozlabs.org (Postfix) with ESMTP id E144FDDE9A
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  8 Aug 2007 21:28:18 +1000 (EST)
Received: by nz-out-0506.google.com with SMTP id l1so26461nzf
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 08 Aug 2007 04:28:17 -0700 (PDT)
Message-ID: <e835b80a0708080428q59378732x52ee40f9702f5692@mail.gmail.com>
Date: Wed, 8 Aug 2007 07:28:16 -0400
From: "Anton Kowalski" <antonkowalski@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: no output to serial console from /init process on ml405
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi All:

I'm trying to bring up linux 2.6.21.1 on an ml405 board. The kernel
boots fine but the init process does not produce any output. The /init
program resides in an initramfs file system and I believe the /dev
device files have been set up correctly. Here's an excerpt from my
initramfs specification:

    dir /dev 755 0 0
    nod /dev/console 644 0 0 c 5 1
    nod /dev/ttyS0 644 0 0 c 4 64

(I am able to open these files from the init program. I tested this by
sleeping for a specified time on success.)

Also, printk continues to function after /init terminates and before
the kernel panics.

Here are the last few lines of the console output:

[    0.507478] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports,
IRQ sharing disabled
[    0.513862] serial8250.0: ttyS0 at MMIO 0x80201003 (irq = 3) is a 16550A
[    2.927509] RAMDISK driver initialized: 1 RAM disks of 8192K size
1024 blocksize
[    3.018391] tun: Universal TUN/TAP device driver, 1.6
[    3.079115] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
[    3.154919] mice: PS/2 mouse device common for all mice
[    3.218021] TCP cubic registered
[    3.257034] NET: Registered protocol family 1
[    3.309405] NET: Registered protocol family 17
[    3.363462] Freeing unused kernel memory: 300k init
[   23.488277] Kernel panic - not syncing: Attempted to kill init!
[   23.559517] Rebooting in 180 seconds..<NULL>

I'm using the plb uart and the 8250.c driver. (The obp uartlite driver
didn't work so I switched.) The kernel and the init program were
compiled with eldk.

Any insights into resolving this problem are greatly appreciated.


Anton
