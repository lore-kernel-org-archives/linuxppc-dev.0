Return-Path: <l.giuliani@tiscali.it>
Received: from vsmtp2alice.tin.it (vsmtp2alice.tin.it [212.216.176.142])
	by ozlabs.org (Postfix) with ESMTP id B87672BC0F
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Oct 2004 21:32:02 +1000 (EST)
Received: from PortatileLG (131.175.54.146) by vsmtp2alice.tin.it (7.0.027)
	(authenticated as giuliani@aliceposta.it)
	id 4141A72400198019 for linuxppc-dev@ozlabs.org;
	Tue, 5 Oct 2004 13:26:28 +0200
From: "Luca Giuliani" <l.giuliani@tiscali.it>
To: <linuxppc-dev@ozlabs.org>
Date: Tue, 5 Oct 2004 13:26:15 +0200
Message-ID: <000001c4aace$245a5060$6500a8c0@PortatileLG>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: Linux on Memec Virtex II Pro V4P7 Rev. 3
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I'm a newbie of Linux on embedded devices and I tried longly to make
Linux work on the embedded PPC405 on the Memec Virtex II Prov V4P7 board
WITHOUT P160 module.
I'm using the patched 2.4.22 patched by Mind.be, freely available on
their FTP site.
The boot process always freezes after the "Uncompressing Linux...done"
i.e. after the bootloader has given the control to the uncompressed
kernel.
By making a long step-by-step debugging I found out that the problem was
due to a "Machine check" exception happining in various points (yes, not
always the same!) in memset when zeroing the BSS in early_init.
The only way to make the kernel INITIATE the boot process was to modify
the MSR mask (/include/asm-ppc/processor.h) as to disable the Machine
Check, but this is not a good idea!
The first thing that came to my mind was that there was an error in the
hardware design, but it was auto-generated with the "Base platform
builder" wizard included in EDK 6.2 and then customized only to meet the
requirements of the Mind kernel.
Has someone succeeded in booting Linux on this device WITHOUT P160
expansion card?
If so I kindly ask you to answer me privately, at least to know how you
built the hardware design, which kernel did you use and which are the
vital parameters to be set in the kernel.

Thanks in advance for your invaluable advice.

Luca
