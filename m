Return-Path: <matt@genesi-usa.com>
Received: from mail.genesi-usa.com (mithrandir.softwarenexus.net
	[66.98.186.96])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9EFB7DDF0C
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Jun 2007 06:54:42 +1000 (EST)
Received: from 82-46-178-156.cable.ubr06.king.blueyonder.co.uk
	([82.46.178.156] helo=[192.168.2.228])
	by mail.genesi-usa.com with esmtpa (Exim 4.66 (FreeBSD))
	(envelope-from <matt@genesi-usa.com>) id 1Hyw5w-000BIR-O6
	for linuxppc-dev@ozlabs.org; Thu, 14 Jun 2007 20:39:05 +0000
Message-ID: <4671AB2B.8000008@genesi-usa.com>
Date: Thu, 14 Jun 2007 21:55:07 +0100
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: ppc-dev <linuxppc-dev@ozlabs.org>
Subject: PowerPC boot wrapper and seperate initrd images
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I am trying to get my head around this, so here goes on my take on how the
current boot loader works.

In essence the wrapper script appends a linux kernel and initrd,
compresses and throws on a little loader (chrp/of or uboot/dts or whatever)
at the front.

For Open Firmware, at boot (in of.c) it takes the values in r3 & r4
(r5 being the prom entry point) as initrd address and initrd size.

Somewhat later in the main loader (main.c:prep_initrd) it sets properties
in the /chosen node which put the initrd address and initrd size in
the device-tree for further reference (linux,initrd-size and linux,initrd-start)

I think this is a given.. it doesn't get too complicated. However what I
am looking to do is have it so that a first stage bootloader (Forth
script or binary like Yaboot) loads in the initrd into memory via the
client interface or whatever other method, then just fires up the
kernel.

This is simply because.. yaboot doesn't work here yet (Pegasos/Efika).
This is causing problems with distributions as they like to ship a
kernel and seperate initrd - and expect a boot loader like BootX or
Yaboot or Quick (pick one) to do all it's heavy lifting.

However we CAN get the data into the right place, with a tiny Forth
script, and there are some standard properties to reference it.

The linux,initrd-size and linux,initrd-start properties would
be set in the device tree by this tiny forth boot loader.

That means of.c needs to pick them up, and main.c needs not to trash
them.

What I am asking, then, if all that information is correct, is if it
would be acceptable in any terms to add this code to the boot wrapper;
in platform_init, it would get the properties out of the tree and
assign them in the loader_info structure (maybe only if the r3 and
r4 values are invalid).

Then in main.c perhaps NOT set those values if they are already in
the device tree.. but I am not sure if any manipulation of the
values is going on. I assume they're absolute, real-mode addresses
and not being weirdly relocated or as an offset to the kernel
(I didn't look to hard).

Is it an insane or stupid idea, that everyone hates and thinks
we should just fix our broken firmware, or do you think it would
come in handy? I'm considering it's a 20-line patch that wouldn't
harm anyone..

Any comments?

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations
