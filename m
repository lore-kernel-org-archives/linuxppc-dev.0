Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: kexec@lists.infradead.org
MIME-Version: 1.0
Subject: [PATCH 2/2] kexec ppc64: Add arch specific --reuseinitrd hooks
In-reply-to: <13112.1177317015@neuling.org>
References: <13112.1177317015@neuling.org>
Date: Mon, 23 Apr 2007 18:30:40 +1000
Message-ID: <13481.1177317040@neuling.org>
Cc: linuxppc-dev@ozlabs.org, horms@verge.net.au,
	Fastboot mailing list <fastboot@lists.osdl.org>, miltonm@bga.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Adds ppc64 specific hooks for the --reuseinitrd option.
--
 kexec/arch/ppc64/fs2dt.c           |   30 ++++++++++++++++++++++--------
 kexec/arch/ppc64/kexec-elf-ppc64.c |   13 ++++++++++++-
 kexec/arch/ppc64/kexec-ppc64.h     |    1 +
 3 files changed, 35 insertions(+), 9 deletions(-)

Index: kexec-tools-testing/kexec/arch/ppc64/fs2dt.c
===================================================================
--- kexec-tools-testing.orig/kexec/arch/ppc64/fs2dt.c
+++ kexec-tools-testing/kexec/arch/ppc64/fs2dt.c
@@ -66,11 +66,11 @@ void reserve(unsigned long long where, u
 }
 
 /* look for properties we need to reserve memory space for */
-static void checkprop(char *name, unsigned *data)
+static void checkprop(char *name, unsigned *data, int len)
 {
-	static unsigned long long base, size;
+	static unsigned long long base, size, end;
 
-	if ((data == NULL) && (base || size))
+	if ((data == NULL) && (base || size || end))
 		die("unrecoverable error: no property data");
 	else if (!strcmp(name, "linux,rtas-base"))
 		base = *data;
@@ -79,11 +79,24 @@ static void checkprop(char *name, unsign
 	else if (!strcmp(name, "rtas-size") ||
 			!strcmp(name, "linux,tce-size"))
 		size = *data;
+	else if (reuse_initrd && !strcmp(name, "linux,initrd-start"))
+		if (len == 8)
+			base = *(unsigned long long *) data;
+		else
+			base = *data;
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
@@ -213,10 +226,11 @@ static void putprops(char *fn, struct di
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
@@ -241,7 +255,7 @@ static void putprops(char *fn, struct di
 			die("unrecoverable error: could not read \"%s\": %s\n",
 			    pathname, strerror(errno));
 
-		checkprop(fn, dt);
+		checkprop(fn, dt, len);
 
 		/* Get the cmdline from the device-tree and modify it */
 		if (!strcmp(dp->d_name, "bootargs")) {
@@ -282,7 +296,7 @@ static void putprops(char *fn, struct di
 	}
 
 	fn[0] = '\0';
-	checkprop(pathname, NULL);
+	checkprop(pathname, NULL, 0);
 }
 
 /*
Index: kexec-tools-testing/kexec/arch/ppc64/kexec-elf-ppc64.c
===================================================================
--- kexec-tools-testing.orig/kexec/arch/ppc64/kexec-elf-ppc64.c
+++ kexec-tools-testing/kexec/arch/ppc64/kexec-elf-ppc64.c
@@ -43,6 +43,8 @@
 #define BOOTLOADER_VERSION VERSION
 
 unsigned long initrd_base, initrd_size;
+unsigned char reuse_initrd = 0;
+const char *ramdisk;
 
 int create_flatten_tree(struct kexec_info *, unsigned char **, unsigned long *,
 			char *);
@@ -69,12 +71,17 @@ int elf_ppc64_probe(const char *buf, off
 	return result;
 }
 
+void arch_reuse_initrd(void)
+{
+	reuse_initrd = 1;
+}
+
 int elf_ppc64_load(int argc, char **argv, const char *buf, off_t len,
 			struct kexec_info *info)
 {
 	struct mem_ehdr ehdr;
 	char *cmdline, *modified_cmdline;
-	const char *ramdisk, *devicetreeblob;
+	const char *devicetreeblob;
 	int cmdline_len, modified_cmdline_len;
 	unsigned long long max_addr, hole_addr;
 	unsigned char *seg_buf = NULL;
@@ -148,6 +155,10 @@ int elf_ppc64_load(int argc, char **argv
 	else
 		fprintf(stdout, "Warning: append= option is not passed. Using the first kernel root partition\n");
 
+	if (ramdisk && reuse_initrd)
+		die("Can't specify --ramdisk or --initrd with "
+		    "--reuseinitrd\n");
+
 	setup_memory_ranges(info->kexec_flags);
 
 	/* Need to append some command line parameters internally in case of
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
