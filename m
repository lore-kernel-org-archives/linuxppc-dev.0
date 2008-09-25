Return-Path: <bigeasy@www.tglx.de>
Received: from www.tglx.de (www.tglx.de [62.245.132.106])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id ACABDDDF5F
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Sep 2008 07:44:23 +1000 (EST)
Date: Thu, 25 Sep 2008 23:43:57 +0200
From: Sebastian Siewior <bigeasy@linutronix.de>
To: Milton Miller <miltonm@bga.com>
Subject: Re: [RFC] powerpc/boot: compare _start against ei.loadsize instead
	ei.memsize
Message-ID: <20080925214357.GA2929@www.tglx.de>
References: <20080923203857.GB10935@www.tglx.de>
	<200809240146.m8O1kIpZ077447@sullivan.realtime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <200809240146.m8O1kIpZ077447@sullivan.realtime.net>
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

* Milton Miller | 2008-09-23 20:46:18 [-0500]:

>On Wed Sep 24 at about 06:38:57 EST in 2008, Sebastian Siewior wrote:
>> My mylinux binary incl. bss is ~5 MiB without bss less than 4 MiB.
>> Therefore I though that I could replace ei.memsize with ei.loadsize. It
>> didn't work. I'm not sure why it did not work but I guess that the
>> memset() of bss in the initial kernel code overwrote the cuimage code
>> which is required for some reason. Maybe some device-tree callbacks.
>
>probably because the bss extended beyond the cuboot _end to include
>where your device tree was copied (just a malloc and we start
>simple_malloc at the boot _end on most platforms).

Right, the bss section went past _dtb_start, moving the device tree
helps.

Signed-off-by: Sebastian Siewior <bigeasy@linutronix.de>
---
 arch/powerpc/boot/libfdt-wrapper.c |   16 ++++++++--------
 arch/powerpc/boot/main.c           |   12 +++++++++++-
 2 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/boot/libfdt-wrapper.c b/arch/powerpc/boot/libfdt-wrapper.c
index c541fd8..1daa73f 100644
--- a/arch/powerpc/boot/libfdt-wrapper.c
+++ b/arch/powerpc/boot/libfdt-wrapper.c
@@ -165,6 +165,7 @@ static unsigned long fdt_wrapper_finalize(void)
 void fdt_init(void *blob)
 {
 	int err;
+	int bufsize;
 
 	dt_ops.finddevice = fdt_wrapper_finddevice;
 	dt_ops.getprop = fdt_wrapper_getprop;
@@ -178,16 +179,15 @@ void fdt_init(void *blob)
 
 	/* Make sure the dt blob is the right version and so forth */
 	fdt = blob;
-	err = fdt_open_into(fdt, fdt, fdt_totalsize(blob));
-	if (err == -FDT_ERR_NOSPACE) {
-		int bufsize = fdt_totalsize(fdt) + 4;
-		buf = malloc(bufsize);
-		err = fdt_open_into(fdt, buf, bufsize);
-	}
+	bufsize = fdt_totalsize(fdt) + 4;
+	buf = malloc(bufsize);
+	if(!buf)
+		fatal("malloc failed. can't relocate the device tree\n\r");
+
+	err = fdt_open_into(fdt, buf, bufsize);
 
 	if (err != 0)
 		fatal("fdt_init(): %s\n\r", fdt_strerror(err));
 
-	if (buf)
-		fdt = buf;
+	fdt = buf;
 }
diff --git a/arch/powerpc/boot/main.c b/arch/powerpc/boot/main.c
index 45a81c3..f5fcd14 100644
--- a/arch/powerpc/boot/main.c
+++ b/arch/powerpc/boot/main.c
@@ -56,9 +56,19 @@ static struct addr_range prep_kernel(void *chosen)
 	if (platform_ops.vmlinux_alloc) {
 		addr = platform_ops.vmlinux_alloc(ei.memsize);
 	} else {
+		/*
+		 * Check if the kernel image (without bss) would overwrite the
+		 * bootwrapper. The device tree has been moved in fdt_init()
+		 * to an area allocated with malloc() (somewhere past _end).
+		 */
 		if ((unsigned long)_start < ei.loadsize)
 			fatal("Insufficient memory for kernel at address 0!"
-			       " (_start=%p)\n\r", _start);
+			       " (_start=%p, uncomressed size=%08x)\n\r",
+			       _start, ei.loadsize);
+
+		if ((unsigned long)_end < ei.memsize)
+			fatal("The final kernel image would overwrite the "
+					"device tree\n\r");
 	}
 
 	/* Finally, gunzip the kernel */
-- 
1.5.6.5
