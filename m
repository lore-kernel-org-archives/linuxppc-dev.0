Return-Path: <MBenedict@twacs.com>
Received: from outbound8-dub-R.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id ADEA5DDED0
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  9 Aug 2007 02:26:05 +1000 (EST)
Received: from outbound8-dub.bigfish.com (localhost.localdomain [127.0.0.1])
	by outbound8-dub-R.bigfish.com (Postfix) with ESMTP id C739817293E3
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  8 Aug 2007 16:26:03 +0000 (UTC)
Received: from mail71-dub-R.bigfish.com (unknown [10.5.252.3])
	by outbound8-dub.bigfish.com (Postfix) with ESMTP id B2D781230050
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  8 Aug 2007 16:26:03 +0000 (UTC)
Received: from mail71-dub (localhost.localdomain [127.0.0.1])
	by mail71-dub-R.bigfish.com (Postfix) with ESMTP id 511F83D034D
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  8 Aug 2007 16:25:52 +0000 (UTC)
Received: from mail.twacs.com (unknown [68.89.149.4])
	by mail71-dub.bigfish.com (Postfix) with ESMTP id AD101153006D
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  8 Aug 2007 16:25:51 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: no output to serial console from /init process on ml405
Date: Wed, 8 Aug 2007 11:25:37 -0500
Message-ID: <CF7E46FCFF66AD478BB72724345289EC2797CE@twx-exch01.twacs.local>
In-Reply-To: <e835b80a0708080428q59378732x52ee40f9702f5692@mail.gmail.com>
References: <e835b80a0708080428q59378732x52ee40f9702f5692@mail.gmail.com>
From: "Benedict, Michael" <MBenedict@twacs.com>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Just a guess, but do you have stdout and friends defined as recommended
in the Compulsory links section of Documentation/devices.txt?
	-Michael

> -----Original Message-----
> From:=20
> linuxppc-embedded-bounces+mbenedict=3Dtwacs.com@ozlabs.org=20
> [mailto:linuxppc-embedded-bounces+mbenedict=3Dtwacs.com@ozlabs.o
rg] On Behalf Of Anton Kowalski
> Sent: Wednesday, August 08, 2007 6:28 AM
> To: linuxppc-embedded@ozlabs.org
> Subject: no output to serial console from /init process on ml405
>=20
> Hi All:
>=20
> I'm trying to bring up linux 2.6.21.1 on an ml405 board. The kernel
> boots fine but the init process does not produce any output. The /init
> program resides in an initramfs file system and I believe the /dev
> device files have been set up correctly. Here's an excerpt from my
> initramfs specification:
>=20
>     dir /dev 755 0 0
>     nod /dev/console 644 0 0 c 5 1
>     nod /dev/ttyS0 644 0 0 c 4 64
>=20
> (I am able to open these files from the init program. I tested this by
> sleeping for a specified time on success.)
>=20
> Also, printk continues to function after /init terminates and before
> the kernel panics.
>=20
> Here are the last few lines of the console output:
>=20
> [    0.507478] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports,
> IRQ sharing disabled
> [    0.513862] serial8250.0: ttyS0 at MMIO 0x80201003 (irq =3D=20
> 3) is a 16550A
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
>=20
> I'm using the plb uart and the 8250.c driver. (The obp uartlite driver
> didn't work so I switched.) The kernel and the init program were
> compiled with eldk.
>=20
> Any insights into resolving this problem are greatly appreciated.
>=20
>=20
> Anton
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>=20
>=20
