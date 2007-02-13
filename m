Return-Path: <dgibson@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH 13/16] Add initrd properties to device tree from zImage
In-Reply-To: <20070213060904.GA6214@localhost.localdomain>
Message-Id: <20070213061025.C63CBDDD0C@ozlabs.org>
Date: Tue, 13 Feb 2007 17:10:25 +1100 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Current kernels expect the address of an initrd to be passed via
properties in the /chosen node of the device tree.  However, so far
the zImage wrapper code does not add these properties to the device
tree and will only pass initrd information to the kernel via the older
OF method.

This patch fixes that deficiency.

Signed-off-by: David Gibson <dwg@au1.ibm.com>
---

 arch/powerpc/boot/main.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

Index: working-2.6/arch/powerpc/boot/main.c
===================================================================
--- working-2.6.orig/arch/powerpc/boot/main.c	2007-02-09 15:17:15.000000000 +1100
+++ working-2.6/arch/powerpc/boot/main.c	2007-02-09 15:25:03.000000000 +1100
@@ -172,6 +172,7 @@ static int is_elf32(void *hdr)
 static void prep_kernel(unsigned long a1, unsigned long a2)
 {
 	int len;
+	void *devp;
 
 	vmlinuz.addr = (unsigned long)_vmlinux_start;
 	vmlinuz.size = (unsigned long)(_vmlinux_end - _vmlinux_start);
@@ -236,6 +237,18 @@ static void prep_kernel(unsigned long a1
 		       initrd.addr, initrd.size);
 	}
 
+	/* Tell the kernel initrd address via device tree */
+	if (initrd.size && (devp = finddevice("/chosen"))) {
+		u32 initrd_start = initrd.addr;
+		u32 initrd_end = initrd.addr + initrd.size;
+
+		setprop(devp, "linux,initrd-start", &initrd_start,
+			sizeof(initrd_start));
+		setprop(devp, "linux,initrd-end", &initrd_end,
+			sizeof(initrd_end));
+	}
+
+
 	/* Eventually gunzip the kernel */
 	if (*(unsigned short *)vmlinuz.addr == 0x1f8b) {
 		printf("gunzipping (0x%lx <- 0x%lx:0x%0lx)...",
