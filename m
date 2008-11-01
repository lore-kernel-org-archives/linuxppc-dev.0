Return-Path: <bigeasy@www.tglx.de>
Received: from www.tglx.de (www.tglx.de [62.245.132.106])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8B896DDD0C
	for <linuxppc-dev@ozlabs.org>; Sun,  2 Nov 2008 07:02:42 +1100 (EST)
Date: Sat, 1 Nov 2008 21:00:56 +0100
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH] powerpc/boot: allocate more memory for dtb
Message-ID: <20081101200056.GA23385@www.tglx.de>
References: <20080923203857.GB10935@www.tglx.de>
	<200809240146.m8O1kIpZ077447@sullivan.realtime.net>
	<20080925214357.GA2929@www.tglx.de>
	<1223611088.8157.144.camel@pasglop>
	<20081013091526.GA9925@www.tglx.de>
	<20081014015753.GD20620@yookeroo.seuss>
	<20081014020004.GE20620@yookeroo.seuss>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <20081014020004.GE20620@yookeroo.seuss>
Cc: Milton Miller <miltonm@bga.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

* David Gibson | 2008-10-14 13:00:04 [+1100]:

>Oh, one other thing.  Since we are now unconditionally copying the dtb
>into a malloc()ed buffer, possibly it would be sensible to add a
>little padding to the buffer at that point, so that further device
>tree manipulations won't need to reallocate it.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
Haven't notice earlier that the other patch went mainline.
EXPAND_GRANULARITY is 1KiB and it is used in expand_buf() if the buffer
has to be increased. I hope that is okay.

All other platforms except prpmc2800 are passing the dtb to fdt_init().
prpmc2800 is reallocating the dtb to a malloced area. I thing I can
remove that part since fdt_init() is doing this anyway.

 arch/powerpc/boot/libfdt-wrapper.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/boot/libfdt-wrapper.c b/arch/powerpc/boot/libfdt-wrapper.c
index 1daa73f..0085930 100644
--- a/arch/powerpc/boot/libfdt-wrapper.c
+++ b/arch/powerpc/boot/libfdt-wrapper.c
@@ -179,7 +179,7 @@ void fdt_init(void *blob)
 
 	/* Make sure the dt blob is the right version and so forth */
 	fdt = blob;
-	bufsize = fdt_totalsize(fdt) + 4;
+	bufsize = fdt_totalsize(fdt) + EXPAND_GRANULARITY;
 	buf = malloc(bufsize);
 	if(!buf)
 		fatal("malloc failed. can't relocate the device tree\n\r");
-- 
1.5.6.5
