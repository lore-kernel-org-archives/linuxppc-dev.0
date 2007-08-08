Return-Path: <wolfgang.reissnegger@xilinx.com>
Received: from outbound8-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id BB256DDEBA
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  9 Aug 2007 01:36:33 +1000 (EST)
Date: Wed, 08 Aug 2007 08:36:26 -0700
From: Wolfgang Reissnegger <wolfgang.reissnegger@xilinx.com>
MIME-Version: 1.0
To: Anton Kowalski <antonkowalski@gmail.com>
Subject: Re: no output to serial console from /init process on ml405
References: <e835b80a0708080428q59378732x52ee40f9702f5692@mail.gmail.com>
In-Reply-To: <e835b80a0708080428q59378732x52ee40f9702f5692@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Message-Id: <20070808153630.AF2D91A88050@mail200-sin.bigfish.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Anton,

it looks as if your init executable is not doing the right thing and for
some reason terminates. Maybe your inittab configuration is wrong? Maybe
the init executable has been compiled with the wrong options?

You can try to copy another executable (e.g. sh, getty) into /init and
see if you get any output. If you see anything doing that then most
likely there's something wrong with your init executable.

Wolfgang

Anton Kowalski wrote:
> Hi All:
> 
> I'm trying to bring up linux 2.6.21.1 on an ml405 board. The kernel
> boots fine but the init process does not produce any output. The /init
> program resides in an initramfs file system and I believe the /dev
> device files have been set up correctly. Here's an excerpt from my
> initramfs specification:
> 
>     dir /dev 755 0 0
>     nod /dev/console 644 0 0 c 5 1
>     nod /dev/ttyS0 644 0 0 c 4 64
> 
> (I am able to open these files from the init program. I tested this by
> sleeping for a specified time on success.)
> 
> Also, printk continues to function after /init terminates and before
> the kernel panics.
> 
> Here are the last few lines of the console output:
> 
> [    0.507478] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports,
> IRQ sharing disabled
> [    0.513862] serial8250.0: ttyS0 at MMIO 0x80201003 (irq = 3) is a 16550A
> [    2.927509] RAMDISK driver initialized: 1 RAM disks of 8192K size
> 1024 blocksize
> [    3.018391] tun: Universal TUN/TAP device driver, 1.6
> [    3.079115] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
> [    3.154919] mice: PS/2 mouse device common for all mice
> [    3.218021] TCP cubic registered
> [    3.257034] NET: Registered protocol family 1
> [    3.309405] NET: Registered protocol family 17
> [    3.363462] Freeing unused kernel memory: 300k init
> [   23.488277] Kernel panic - not syncing: Attempted to kill init!
> [   23.559517] Rebooting in 180 seconds..<NULL>
> 
> I'm using the plb uart and the 8250.c driver. (The obp uartlite driver
> didn't work so I switched.) The kernel and the init program were
> compiled with eldk.
> 
> Any insights into resolving this problem are greatly appreciated.
> 
> 
> Anton
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
