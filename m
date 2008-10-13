Return-Path: <bigeasy@www.tglx.de>
Received: from www.tglx.de (www.tglx.de [62.245.132.106])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1248BDE023
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Oct 2008 20:15:58 +1100 (EST)
Date: Mon, 13 Oct 2008 11:15:26 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] powerpc/boot: compare _start against ei.loadsize instead
	ei.memsize
Message-ID: <20081013091526.GA9925@www.tglx.de>
References: <20080923203857.GB10935@www.tglx.de>
	<200809240146.m8O1kIpZ077447@sullivan.realtime.net>
	<20080925214357.GA2929@www.tglx.de>
	<1223611088.8157.144.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <1223611088.8157.144.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org, Milton Miller <miltonm@bga.com>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

If the vmlinux binary in memory is larger than 4 MiB than it collides
with the initial boot code which is linked at 4 MiB in case of cuBoot.
If the the uncompressed image size (on disk size) is less than 4 MiB
then it would fit. The difference between those two sizes is the bss
section. In cuBoot we have the dtb embedded right after the data
section so it is very likely that the reset of the bss section (in
kernel's start up code) will overwrite the dtb blob. Therefore we
reallocate the dtb. Something similar is allready done to the initrd.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/powerpc/boot/libfdt-wrapper.c |   16 ++++++++--------
 arch/powerpc/boot/main.c           |   14 ++++++++++++--
 2 files changed, 20 insertions(+), 10 deletions(-)

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
index 9e7f3dd..ae32801 100644
--- a/arch/powerpc/boot/main.c
+++ b/arch/powerpc/boot/main.c
@@ -56,9 +56,19 @@ static struct addr_range prep_kernel(void)
 	if (platform_ops.vmlinux_alloc) {
 		addr = platform_ops.vmlinux_alloc(ei.memsize);
 	} else {
-		if ((unsigned long)_start < ei.memsize)
+		/*
+		 * Check if the kernel image (without bss) would overwrite the
+		 * bootwrapper. The device tree has been moved in fdt_init()
+		 * to an area allocated with malloc() (somewhere past _end).
+		 */
+		if ((unsigned long)_start < ei.loadsize)
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
