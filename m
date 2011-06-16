Return-Path: <suzuki@in.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp05.in.ibm.com",
	Issuer "GeoTrust SSL CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id DE1B4B6FB4
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 16 Jun 2011 21:26:39 +1000 (EST)
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
	by e28smtp05.in.ibm.com (8.14.4/8.13.1) with ESMTP id p5GBQOte002687
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jun 2011 16:56:24 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p5GBQLkV3354632
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jun 2011 16:56:22 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
	by d28av01.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p5GBQKPp027167
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jun 2011 16:56:21 +0530
From: "Suzuki K. Poulose" <suzuki@in.ibm.com>
Subject: [PATCH v2] kexec-tools: powerpc: Use the #address-cells information
	to parsememory/reg
To: Simon Horman<horms@verge.net.au>
Date: Thu, 16 Jun 2011 16:56:20 +0530
Message-ID: <20110616112445.12515.72987.stgit@suzukikp.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linux ppc dev <linuxppc-dev@lists.ozlabs.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	David Laight <David.Laight@ACULAB.COM>,
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>,
	"Suzuki K. Poulose" <suzuki@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


The problem was with the mail client. Also, mistyped the "To" field in the previous
one. Resending.

ChangeLog from V1:
	* Changed the interface for read_memory_region_limits to use 'int fd'
	* Use sizeof(variable) for read(, instead of sizeof(type).

---
The format of memory/reg is based on the #address-cells,#size-cells. Currently,
the kexec-tools doesn't use the above values in parsing the memory/reg values.
Hence the kexec cannot handle cases where #address-cells, #size-cells are
different, (for e.g, PPC440X ).

This patch introduces a read_memory_region_limits(), which parses the
memory/reg contents based on the values of #address-cells and #size-cells.

Signed-off-by: Suzuki K. Poulose <suzuki@in.ibm.com>
---

 kexec/arch/ppc/crashdump-powerpc.c |   33 ++------
 kexec/arch/ppc/fs2dt.c             |   14 ---
 kexec/arch/ppc/kexec-ppc.c         |  158 ++++++++++++++++++++++++++----------
 kexec/arch/ppc/kexec-ppc.h         |    6 +
 4 files changed, 129 insertions(+), 82 deletions(-)

diff --git a/kexec/arch/ppc/crashdump-powerpc.c b/kexec/arch/ppc/crashdump-powerpc.c
index 1dd6485..77a01e1 100644
--- a/kexec/arch/ppc/crashdump-powerpc.c
+++ b/kexec/arch/ppc/crashdump-powerpc.c
@@ -81,7 +81,7 @@ static int get_crash_memory_ranges(struct memory_range **range, int *ranges)
 	char fname[256];
 	char buf[MAXBYTES];
 	DIR *dir, *dmem;
-	FILE *file;
+	int fd;
 	struct dirent *dentry, *mentry;
 	int i, n, crash_rng_len = 0;
 	unsigned long long start, end, cstart, cend;
@@ -123,17 +123,16 @@ static int get_crash_memory_ranges(struct memory_range **range, int *ranges)
 			if (strcmp(mentry->d_name, "reg"))
 				continue;
 			strcat(fname, "/reg");
-			file = fopen(fname, "r");
-			if (!file) {
+			fd = open(fname, O_RDONLY);
+			if (fd < 0) {
 				perror(fname);
 				closedir(dmem);
 				closedir(dir);
 				goto err;
 			}
-			n = fread(buf, 1, MAXBYTES, file);
-			if (n < 0) {
-				perror(fname);
-				fclose(file);
+			n = read_memory_region_limits(fd, &start, &end);
+			if (n != 0) {
+				close(fd);
 				closedir(dmem);
 				closedir(dir);
 				goto err;
@@ -146,24 +145,6 @@ static int get_crash_memory_ranges(struct memory_range **range, int *ranges)
 				goto err;
 			}
 
-			/*
-			 * FIXME: This code fails on platforms that
-			 * have more than one memory range specified
-			 * in the device-tree's /memory/reg property.
-			 * or where the #address-cells and #size-cells
-			 * are not identical.
-			 *
-			 * We should interpret the /memory/reg property
-			 * based on the values of the #address-cells and
-			 * #size-cells properites.
-			 */
-			if (n == (sizeof(unsigned long) * 2)) {
-				start = ((unsigned long *)buf)[0];
-				end = start + ((unsigned long *)buf)[1];
-			} else {
-				start = ((unsigned long long *)buf)[0];
-				end = start + ((unsigned long long *)buf)[1];
-			}
 			if (start == 0 && end >= (BACKUP_SRC_END + 1))
 				start = BACKUP_SRC_END + 1;
 
@@ -212,7 +193,7 @@ static int get_crash_memory_ranges(struct memory_range **range, int *ranges)
 					= RANGE_RAM;
 				memory_ranges++;
 			}
-			fclose(file);
+			close(fd);
 		}
 		closedir(dmem);
 	}
diff --git a/kexec/arch/ppc/fs2dt.c b/kexec/arch/ppc/fs2dt.c
index 238a3f2..733515a 100644
--- a/kexec/arch/ppc/fs2dt.c
+++ b/kexec/arch/ppc/fs2dt.c
@@ -137,21 +137,11 @@ static void add_usable_mem_property(int fd, int len)
 	if (strncmp(bname, "/memory@", 8) && strcmp(bname, "/memory"))
 		return;
 
-	if (len < 2 * sizeof(unsigned long))
-		die("unrecoverable error: not enough data for mem property\n");
-	len = 2 * sizeof(unsigned long);
-
 	if (lseek(fd, 0, SEEK_SET) < 0)
 		die("unrecoverable error: error seeking in \"%s\": %s\n",
 		    pathname, strerror(errno));
-	if (read(fd, buf, len) != len)
-		die("unrecoverable error: error reading \"%s\": %s\n",
-		    pathname, strerror(errno));
-
-	if (~0ULL - buf[0] < buf[1])
-		die("unrecoverable error: mem property overflow\n");
-	base = buf[0];
-	end = base + buf[1];
+	if (read_memory_region_limits(fd, &base, &end) != 0)
+		die("unrecoverable error: error parsing memory/reg limits\n");
 
 	for (range = 0; range < usablemem_rgns.size; range++) {
 		loc_base = usablemem_rgns.ranges[range].start;
diff --git a/kexec/arch/ppc/kexec-ppc.c b/kexec/arch/ppc/kexec-ppc.c
index db00b96..4e3569f 100644
--- a/kexec/arch/ppc/kexec-ppc.c
+++ b/kexec/arch/ppc/kexec-ppc.c
@@ -16,6 +16,7 @@
 #include <dirent.h>
 #include <stdlib.h>
 #include <sys/stat.h>
+#include <fcntl.h>
 #include <unistd.h>
 
 #include "../../kexec.h"
@@ -26,6 +27,7 @@
 
 #include "config.h"
 
+unsigned long dt_address_cells = 0, dt_size_cells = 0;
 uint64_t rmo_top;
 unsigned long long crash_base = 0, crash_size = 0;
 unsigned long long initrd_base = 0, initrd_size = 0;
@@ -34,6 +36,98 @@ unsigned int rtas_base, rtas_size;
 int max_memory_ranges;
 const char *ramdisk;
 
+/*
+ * Reads the #address-cells and #size-cells on this platform.
+ * This is used to parse the memory/reg info from the device-tree
+ */
+int init_memory_region_info()
+{
+	size_t res = 0;
+	int fd;
+	char *file;
+
+	file = "/proc/device-tree/#address-cells";
+	fd = open(file, O_RDONLY);
+	if (fd < 0) {
+		fprintf(stderr, "Unable to open %s\n", file);
+		return -1;
+	}
+
+	res = read(fd, &dt_address_cells, sizeof(dt_address_cells));
+	if (res != sizeof(dt_address_cells)) {
+		fprintf(stderr, "Error reading %s\n", file);
+		return -1;
+	}
+	close(fd);
+
+	file = "/proc/device-tree/#size-cells";
+	fd = open(file, O_RDONLY);
+	if (fd < 0) {
+		fprintf(stderr, "Unable to open %s\n", file);
+		return -1;
+	}
+
+	res = read(fd, &dt_size_cells, sizeof(dt_size_cells));
+	if (res != sizeof(dt_size_cells)) {
+		fprintf(stderr, "Error reading %s\n", file);
+		return -1;
+	}
+	close(fd);
+
+	/* Convert the sizes into bytes */
+	dt_size_cells *= sizeof(unsigned long);
+	dt_address_cells *= sizeof(unsigned long);
+
+	return 0;
+}
+
+#define MAXBYTES 128
+/*
+ * Reads the memory region info from the device-tree node pointed
+ * by @fd and fills the *start, *end with the boundaries of the region
+ */
+int read_memory_region_limits(int fd, unsigned long long *start,
+				unsigned long long *end)
+{
+	char buf[MAXBYTES];
+	unsigned long *p;
+	unsigned long nbytes = dt_address_cells + dt_size_cells;
+
+	if (lseek(fd, 0, SEEK_SET) == -1) {
+		fprintf(stderr, "Error in file seek\n");
+		return -1;
+	}
+	if (read(fd, buf, nbytes) != nbytes) {
+		fprintf(stderr, "Error reading the memory region info\n");
+		return -1;
+	}
+
+	p = (unsigned long*)buf;
+	if (dt_address_cells == sizeof(unsigned long)) {
+		*start = p[0];
+		p++;
+	} else if (dt_address_cells == sizeof(unsigned long long)) {
+		*start = ((unsigned long long *)p)[0];
+		p = (unsigned long long *)p + 1;
+	} else {
+		fprintf(stderr, "Unsupported value for #address-cells : %ld\n",
+					dt_address_cells);
+		return -1;
+	}
+
+	if (dt_size_cells == sizeof(unsigned long))
+		*end = *start + p[0];
+	else if (dt_size_cells == sizeof(unsigned long long))
+		*end = *start + ((unsigned long long *)p)[0];
+	else {
+		fprintf(stderr, "Unsupported value for #size-cells : %ld\n",
+					dt_size_cells);
+		return -1;
+	}
+
+	return 0;
+}
+
 void arch_reuse_initrd(void)
 {
 	reuse_initrd = 1;
@@ -182,9 +276,6 @@ static int sort_base_ranges(void)
 	return 0;
 }
 
-
-#define MAXBYTES 128
-
 static int realloc_memory_ranges(void)
 {
 	size_t memory_range_len;
@@ -228,9 +319,8 @@ static int get_base_ranges(void)
 	char fname[256];
 	char buf[MAXBYTES];
 	DIR *dir, *dmem;
-	FILE *file;
 	struct dirent *dentry, *mentry;
-	int n;
+	int n, fd;
 
 	if ((dir = opendir(device_tree)) == NULL) {
 		perror(device_tree);
@@ -248,54 +338,39 @@ static int get_base_ranges(void)
 			return -1;
 		}
 		while ((mentry = readdir(dmem)) != NULL) {
+			unsigned long long start, end;
+
 			if (strcmp(mentry->d_name, "reg"))
 				continue;
 			strcat(fname, "/reg");
-			if ((file = fopen(fname, "r")) == NULL) {
+			if ((fd = open(fname, O_RDONLY)) < 0) {
 				perror(fname);
 				closedir(dmem);
 				closedir(dir);
 				return -1;
 			}
-			if ((n = fread(buf, 1, MAXBYTES, file)) < 0) {
-				perror(fname);
-				fclose(file);
+			if (read_memory_region_limits(fd, &start, &end) != 0) {
+				close(fd);
 				closedir(dmem);
 				closedir(dir);
 				return -1;
 			}
 			if (local_memory_ranges >= max_memory_ranges) {
 				if (realloc_memory_ranges() < 0){
-					fclose(file);
+					close(fd);
 					break;
 				}
 			}
 
-			if (n == sizeof(uint32_t) * 2) {
-				base_memory_range[local_memory_ranges].start =
-					((uint32_t *)buf)[0];
-				base_memory_range[local_memory_ranges].end  =
-					base_memory_range[local_memory_ranges].start +
-					((uint32_t *)buf)[1];
-			}
-			else if (n == sizeof(uint64_t) * 2) {
-				base_memory_range[local_memory_ranges].start =
-                                        ((uint64_t *)buf)[0];
-                                base_memory_range[local_memory_ranges].end  =
-                                        base_memory_range[local_memory_ranges].start +
-                                        ((uint64_t *)buf)[1];
-			}
-			else {
-				fprintf(stderr, "Mem node has invalid size: %d\n", n);
-				return -1;
-			}
+			base_memory_range[local_memory_ranges].start = start;
+			base_memory_range[local_memory_ranges].end  = end;
 			base_memory_range[local_memory_ranges].type = RANGE_RAM;
 			local_memory_ranges++;
 			dbgprintf("%016llx-%016llx : %x\n",
 					base_memory_range[local_memory_ranges-1].start,
 					base_memory_range[local_memory_ranges-1].end,
 					base_memory_range[local_memory_ranges-1].type);
-			fclose(file);
+			close(fd);
 		}
 		closedir(dmem);
 	}
@@ -572,29 +647,19 @@ static int get_devtree_details(unsigned long kexec_flags)
 
 		if (!strncmp(dentry->d_name, "memory@", 7) ||
 				!strcmp(dentry->d_name, "memory")) {
+			int fd;
 			strcat(fname, "/reg");
-			if ((file = fopen(fname, "r")) == NULL) {
+			if ((fd = open(fname, O_RDONLY)) < 0) {
 				perror(fname);
 				goto error_opencdir;
 			}
-			if ((n = fread(buf, 1, MAXBYTES, file)) < 0) {
-				perror(fname);
-				goto error_openfile;
-			}
-			if (n == sizeof(uint64_t)) {
-				rmo_base = ((uint32_t *)buf)[0];
-				rmo_top = rmo_base + ((uint32_t *)buf)[1];
-			} else if (n == 16) {
-				rmo_base = ((uint64_t *)buf)[0];
-				rmo_top = rmo_base + ((uint64_t *)buf)[1];
-			} else {
-				fprintf(stderr, "Mem node has invalid size: %d\n", n);
+			if (read_memory_region_limits(fd, &rmo_base, &rmo_top) != 0)
 				goto error_openfile;
-			}
+
 			if (rmo_top > 0x30000000UL)
 				rmo_top = 0x30000000UL;
 
-			fclose(file);
+			close(fd);
 			closedir(cdir);
 		} /* memory */
 
@@ -778,6 +843,11 @@ int get_memory_ranges_dt(struct memory_range **range, int *ranges,
 int get_memory_ranges(struct memory_range **range, int *ranges,
 					unsigned long kexec_flags)
 {
+	int res = 0;
+
+	res = init_memory_region_info();
+	if (res != 0)
+		return res;
 #ifdef WITH_GAMECUBE
 	return get_memory_ranges_gc(range, ranges, kexec_flags);
 #else
diff --git a/kexec/arch/ppc/kexec-ppc.h b/kexec/arch/ppc/kexec-ppc.h
index 7f96be8..68728c6 100644
--- a/kexec/arch/ppc/kexec-ppc.h
+++ b/kexec/arch/ppc/kexec-ppc.h
@@ -69,6 +69,12 @@ extern unsigned long long initrd_base, initrd_size;
 extern unsigned long long ramdisk_base, ramdisk_size;
 extern unsigned char reuse_initrd;
 extern const char *ramdisk;
+
+/* Method to parse the memory/reg nodes in device-tree */
+extern unsigned long dt_address_cells, dt_size_cells;
+extern int init_memory_region_info(void);
+extern int read_memory_region_limits(int fd, unsigned long long *start,
+					unsigned long long *end);
 #define COMMAND_LINE_SIZE	512 /* from kernel */
 /*fs2dt*/
 void reserve(unsigned long long where, unsigned long long length);
