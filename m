Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Fastboot mailing list <fastboot@lists.osdl.org>
MIME-Version: 1.0
Subject: [PATCH] kexec-tools ppc64: add --reuseinitrd option
Date: Wed, 18 Apr 2007 17:26:07 +1000
Message-ID: <12001.1176881167@neuling.org>
Cc: linuxppc-dev@ozlabs.org, horms@verge.net.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add a --reuseinitrd option so that initrds saved using the
retain_initrd kernel option can be reused on the kexec boot.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
Horms: applies on top of my recent cleanup patch

 kexec/arch/ppc64/fs2dt.c           |   23 +++++++++++++++++------
 kexec/arch/ppc64/kexec-elf-ppc64.c |    6 ++++++
 kexec/arch/ppc64/kexec-ppc64.c     |    1 +
 kexec/arch/ppc64/kexec-ppc64.h     |    1 +
 4 files changed, 25 insertions(+), 6 deletions(-)

Index: kexec-tools-testing/kexec/arch/ppc64/fs2dt.c
===================================================================
--- kexec-tools-testing.orig/kexec/arch/ppc64/fs2dt.c
+++ kexec-tools-testing/kexec/arch/ppc64/fs2dt.c
@@ -68,9 +68,9 @@ void reserve(unsigned long long where, u
 /* look for properties we need to reserve memory space for */
 static void checkprop(char *name, unsigned *data)
 {
-	static unsigned long long base, size;
+	static unsigned long long base, size, end;
 
-	if ((data == NULL) && (base || size))
+	if ((data == NULL) && (base || size || end))
 		die("unrecoverable error: no property data");
 	else if (!strcmp(name, "linux,rtas-base"))
 		base = *data;
@@ -79,11 +79,21 @@ static void checkprop(char *name, unsign
 	else if (!strcmp(name, "rtas-size") ||
 			!strcmp(name, "linux,tce-size"))
 		size = *data;
+	else if (reuse_initrd && !strcmp(name, "linux,initrd-start"))
+		base = *(unsigned long long *) data;
+	else if (reuse_initrd && !strcmp(name, "linux,initrd-end"))
+		end = *(unsigned long long *) data;
 
+	if (size && end)
+		die("unrecoverable error: size and end set at same time\n");
 	if (base && size) {
 		reserve(base, size);
 		base = size = 0;
 	}
+	if (base && end) {
+		reserve(base, end-base);
+		base = end = 0;
+	}
 }
 
 /*
@@ -213,10 +223,11 @@ static void putprops(char *fn, struct di
 				continue;
 
 		/* This property will be created/modified later in putnode()
-		 * So ignore it.
+		 * So ignore it, unless we are reusing the initrd.
 		 */
-		if (!strcmp(dp->d_name, "linux,initrd-start") ||
-			!strcmp(dp->d_name, "linux,initrd-end"))
+		if ((!strcmp(dp->d_name, "linux,initrd-start") ||
+		     !strcmp(dp->d_name, "linux,initrd-end")) &&
+		    !reuse_initrd)
 				continue;
 
 		if (! S_ISREG(statbuf.st_mode))
@@ -343,7 +354,7 @@ static void putnode(void)
 	putprops(dn, namelist, numlist);
 
 	/* Add initrd entries to the second kernel */
-	if (initrd_base && !strcmp(basename,"/chosen/")) {
+	if (initrd_base && !strcmp(basename,"/chosen/") && !reuse_initrd) {
 		int len = 8;
 		unsigned long long initrd_end;
 		*dt++ = 3;
Index: kexec-tools-testing/kexec/arch/ppc64/kexec-elf-ppc64.c
===================================================================
--- kexec-tools-testing.orig/kexec/arch/ppc64/kexec-elf-ppc64.c
+++ kexec-tools-testing/kexec/arch/ppc64/kexec-elf-ppc64.c
@@ -43,6 +43,7 @@
 #define BOOTLOADER_VERSION VERSION
 
 unsigned long initrd_base, initrd_size;
+unsigned char reuse_initrd = 0;
 
 int create_flatten_tree(struct kexec_info *, unsigned char **, unsigned long *,
 			char *);
@@ -95,6 +96,7 @@ int elf_ppc64_load(int argc, char **argv
 #define OPT_RAMDISK     (OPT_ARCH_MAX+1)
 #define OPT_DEVICETREEBLOB     (OPT_ARCH_MAX+2)
 #define OPT_ARGS_IGNORE		(OPT_ARCH_MAX+3)
+#define OPT_REUSE_INITRD	(OPT_ARCH_MAX+4)
 
 	static const struct option options[] = {
 		KEXEC_ARCH_OPTIONS
@@ -104,6 +106,7 @@ int elf_ppc64_load(int argc, char **argv
 		{ "initrd",             1, NULL, OPT_RAMDISK },
 		{ "devicetreeblob",     1, NULL, OPT_DEVICETREEBLOB },
 		{ "args-linux",		0, NULL, OPT_ARGS_IGNORE },
+		{ "reuseinitrd",	0, NULL, OPT_REUSE_INITRD },
 		{ 0,                    0, NULL, 0 },
 	};
 
@@ -139,6 +142,9 @@ int elf_ppc64_load(int argc, char **argv
 			break;
 		case OPT_ARGS_IGNORE:
 			break;
+		case OPT_REUSE_INITRD:
+			reuse_initrd = 1;
+			break;
 		}
 	}
 
Index: kexec-tools-testing/kexec/arch/ppc64/kexec-ppc64.c
===================================================================
--- kexec-tools-testing.orig/kexec/arch/ppc64/kexec-ppc64.c
+++ kexec-tools-testing/kexec/arch/ppc64/kexec-ppc64.c
@@ -635,6 +635,7 @@ void arch_usage(void)
 	fprintf(stderr, "     --ramdisk=<filename> Initial RAM disk.\n");
 	fprintf(stderr, "     --initrd=<filename> same as --ramdisk.\n");
 	fprintf(stderr, "     --devicetreeblob=<filename> Specify device tree blob file.\n");
+	fprintf(stderr, "     --reuseinitrd Reuse the current initrd in memory.\n");
 	fprintf(stderr, "     --elf64-core-headers Prepare core headers in ELF64 format\n");
 }
 
Index: kexec-tools-testing/kexec/arch/ppc64/kexec-ppc64.h
===================================================================
--- kexec-tools-testing.orig/kexec/arch/ppc64/kexec-ppc64.h
+++ kexec-tools-testing/kexec/arch/ppc64/kexec-ppc64.h
@@ -16,6 +16,7 @@ void reserve(unsigned long long where, u
 
 extern unsigned long initrd_base, initrd_size;
 extern int max_memory_ranges;
+extern unsigned char reuse_initrd;
 
 /* boot block version 2 as defined by the linux kernel */
 struct bootblock {
