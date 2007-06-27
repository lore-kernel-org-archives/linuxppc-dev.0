Return-Path: <dgibson@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>,
	<linuxppc-dev@ozlabs.org>
From: David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH 2/3] Make more OF-related bootwrapper functions available to
	non-OF platforms
In-Reply-To: <20070627065335.GD11191@localhost.localdomain>
Message-Id: <20070627065458.60C5ADDF2B@ozlabs.org>
Date: Wed, 27 Jun 2007 16:54:58 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Commit 2e6016133755eb3cc44e8efab92573d23ed75888 split up
arch/powerpc/boot/of.c so that some OF functions can be used on
platforms that don't want to use the overall OF platform boot code.
This is useful on things like PReP which can have an OF implementation
which is useful for debugging output, but inadequate for booting.

However, that commit didn't export quite enough things to make a
usable OF console on a non-OF system.  In particular, the device tree
manipulation performed to initialize the OF console code must
explicitly use the OF device tree, rather than the flattened device
tree, even if the system is otherwise booting using a flattened device
tree.  This patch makes it so.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---

 arch/powerpc/boot/of.c        |   30 ------------------------------
 arch/powerpc/boot/of.h        |    6 ++++++
 arch/powerpc/boot/ofconsole.c |    8 ++++----
 arch/powerpc/boot/oflib.c     |   40 +++++++++++++++++++++++++++++++++++-----
 4 files changed, 45 insertions(+), 39 deletions(-)

Index: working-2.6/arch/powerpc/boot/of.c
===================================================================
--- working-2.6.orig/arch/powerpc/boot/of.c	2007-06-15 13:24:11.000000000 +1000
+++ working-2.6/arch/powerpc/boot/of.c	2007-06-21 13:21:46.000000000 +1000
@@ -63,36 +63,6 @@ static void of_image_hdr(const void *hdr
 	}
 }
 
-static void *of_vmlinux_alloc(unsigned long size)
-{
-	void *p = malloc(size);
-
-	if (!p)
-		fatal("Can't allocate memory for kernel image!\n\r");
-
-	return p;
-}
-
-/*
- * OF device tree routines
- */
-static void *of_finddevice(const char *name)
-{
-	return (phandle) of_call_prom("finddevice", 1, 1, name);
-}
-
-static int of_getprop(const void *phandle, const char *name, void *buf,
-		const int buflen)
-{
-	return of_call_prom("getprop", 4, 1, phandle, name, buf, buflen);
-}
-
-static int of_setprop(const void *phandle, const char *name, const void *buf,
-		const int buflen)
-{
-	return of_call_prom("setprop", 4, 1, phandle, name, buf, buflen);
-}
-
 void platform_init(unsigned long a1, unsigned long a2, void *promptr)
 {
 	platform_ops.image_hdr = of_image_hdr;
Index: working-2.6/arch/powerpc/boot/of.h
===================================================================
--- working-2.6.orig/arch/powerpc/boot/of.h	2007-06-15 13:24:11.000000000 +1000
+++ working-2.6/arch/powerpc/boot/of.h	2007-06-21 13:22:14.000000000 +1000
@@ -7,7 +7,13 @@ typedef void *ihandle;
 void of_init(void *promptr);
 int of_call_prom(const char *service, int nargs, int nret, ...);
 void *of_claim(unsigned long virt, unsigned long size, unsigned long align);
+void *of_vmlinux_alloc(unsigned long size);
 void of_exit(void);
+void *of_finddevice(const char *name);
+int of_getprop(const void *phandle, const char *name, void *buf,
+	       const int buflen);
+int of_setprop(const void *phandle, const char *name, const void *buf,
+	       const int buflen);
 
 /* Console functions */
 void of_console_init(void);
Index: working-2.6/arch/powerpc/boot/oflib.c
===================================================================
--- working-2.6.orig/arch/powerpc/boot/oflib.c	2007-06-15 13:24:11.000000000 +1000
+++ working-2.6/arch/powerpc/boot/oflib.c	2007-06-21 13:21:58.000000000 +1000
@@ -110,25 +110,25 @@ static int check_of_version(void)
 	phandle oprom, chosen;
 	char version[64];
 
-	oprom = finddevice("/openprom");
+	oprom = of_finddevice("/openprom");
 	if (oprom == (phandle) -1)
 		return 0;
-	if (getprop(oprom, "model", version, sizeof(version)) <= 0)
+	if (of_getprop(oprom, "model", version, sizeof(version)) <= 0)
 		return 0;
 	version[sizeof(version)-1] = 0;
 	printf("OF version = '%s'\r\n", version);
 	if (!string_match(version, "Open Firmware, 1.")
 	    && !string_match(version, "FirmWorks,3."))
 		return 0;
-	chosen = finddevice("/chosen");
+	chosen = of_finddevice("/chosen");
 	if (chosen == (phandle) -1) {
-		chosen = finddevice("/chosen@0");
+		chosen = of_finddevice("/chosen@0");
 		if (chosen == (phandle) -1) {
 			printf("no chosen\n");
 			return 0;
 		}
 	}
-	if (getprop(chosen, "mmu", &chosen_mmu, sizeof(chosen_mmu)) <= 0) {
+	if (of_getprop(chosen, "mmu", &chosen_mmu, sizeof(chosen_mmu)) <= 0) {
 		printf("no mmu\n");
 		return 0;
 	}
@@ -166,7 +166,37 @@ void *of_claim(unsigned long virt, unsig
 	return (void *) virt;
 }
 
+void *of_vmlinux_alloc(unsigned long size)
+{
+	void *p = malloc(size);
+
+	if (!p)
+		fatal("Can't allocate memory for kernel image!\n\r");
+
+	return p;
+}
+
 void of_exit(void)
 {
 	of_call_prom("exit", 0, 0);
 }
+
+/*
+ * OF device tree routines
+ */
+void *of_finddevice(const char *name)
+{
+	return (phandle) of_call_prom("finddevice", 1, 1, name);
+}
+
+int of_getprop(const void *phandle, const char *name, void *buf,
+	       const int buflen)
+{
+	return of_call_prom("getprop", 4, 1, phandle, name, buf, buflen);
+}
+
+int of_setprop(const void *phandle, const char *name, const void *buf,
+	       const int buflen)
+{
+	return of_call_prom("setprop", 4, 1, phandle, name, buf, buflen);
+}
Index: working-2.6/arch/powerpc/boot/ofconsole.c
===================================================================
--- working-2.6.orig/arch/powerpc/boot/ofconsole.c	2007-06-15 13:24:11.000000000 +1000
+++ working-2.6/arch/powerpc/boot/ofconsole.c	2007-06-21 10:30:18.000000000 +1000
@@ -24,10 +24,10 @@ static int of_console_open(void)
 {
 	void *devp;
 
-	if (((devp = finddevice("/chosen")) != NULL)
-			&& (getprop(devp, "stdout", &of_stdout_handle,
-				sizeof(of_stdout_handle))
-				== sizeof(of_stdout_handle)))
+	if (((devp = of_finddevice("/chosen")) != NULL)
+	    && (of_getprop(devp, "stdout", &of_stdout_handle,
+			   sizeof(of_stdout_handle))
+		== sizeof(of_stdout_handle)))
 		return 0;
 
 	return -1;
