Return-Path: <msm@freescale.com>
Received: from TX2EHSOBE006.bigfish.com (tx2ehsobe003.messaging.microsoft.com
	[65.55.88.13]) by ozlabs.org (Postfix) with ESMTP id 91C231011A1
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 21 Jul 2010 06:16:23 +1000 (EST)
From: Matthew McClintock <msm@freescale.com>
To: kexec@lists.infradead.org
Subject: [PATCH v2 2/7] Fix case where phys_addr_t != unsigned long when
	reading proc entries
Date: Tue, 20 Jul 2010 15:14:55 -0500
Message-ID: <1279656900-27458-2-git-send-email-msm@freescale.com>
In-Reply-To: <1279656900-27458-1-git-send-email-msm@freescale.com>
References: <1279656900-27458-1-git-send-email-msm@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Matthew McClintock <msm@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On some actitectures the physical memory can be 64 bits, therefore
the code that reads proc entries needs to take into account it could
read either a 32 bit or 64bit value for the physical addresses.

Signed-off-by: Matthew McClintock <msm@freescale.com>
---
 kexec/arch/ppc/kexec-elf-ppc.c |    1 -
 kexec/arch/ppc/kexec-ppc.c     |  210 ++++++++++++++++++++++++++++------------
 kexec/arch/ppc/kexec-ppc.h     |    1 +
 3 files changed, 148 insertions(+), 64 deletions(-)

diff --git a/kexec/arch/ppc/kexec-elf-ppc.c b/kexec/arch/ppc/kexec-elf-ppc.c
index d155bde..ab2d343 100644
--- a/kexec/arch/ppc/kexec-elf-ppc.c
+++ b/kexec/arch/ppc/kexec-elf-ppc.c
@@ -32,7 +32,6 @@
 
 static const int probe_debug = 0;
 
-unsigned long long initrd_base, initrd_size;
 unsigned char reuse_initrd;
 const char *ramdisk;
 int create_flatten_tree(struct kexec_info *, unsigned char **, unsigned long *,
diff --git a/kexec/arch/ppc/kexec-ppc.c b/kexec/arch/ppc/kexec-ppc.c
index c073f56..d7afad6 100644
--- a/kexec/arch/ppc/kexec-ppc.c
+++ b/kexec/arch/ppc/kexec-ppc.c
@@ -28,6 +28,8 @@
 
 uint64_t rmo_top;
 unsigned long long crash_base, crash_size;
+unsigned long long initrd_base, initrd_size;
+unsigned long long devicetree_base, devicetree_size;
 unsigned int rtas_base, rtas_size;
 int max_memory_ranges;
 
@@ -320,9 +322,7 @@ static int get_devtree_details(unsigned long kexec_flags)
 	DIR *dir, *cdir;
 	FILE *file;
 	struct dirent *dentry;
-	struct stat fstat;
 	int n, i = 0;
-	unsigned long tmp_long;
 
 	if ((dir = opendir(device_tree)) == NULL) {
 		perror(device_tree);
@@ -352,12 +352,18 @@ static int get_devtree_details(unsigned long kexec_flags)
 					perror(fname);
 					goto error_opencdir;
 				}
-				if (fread(&tmp_long, sizeof(unsigned long), 1, file)
-						!= 1) {
+				if ((n = fread(buf, 1, MAXBYTES, file)) < 0) {
 					perror(fname);
 					goto error_openfile;
 				}
-				kernel_end = tmp_long;
+				if (n == 4) {
+					kernel_end = ((uint32_t *)buf)[0];
+				} else if (n == 8) {
+					kernel_end = ((uint64_t *)buf)[0];
+				} else {
+					fprintf(stderr, "%s node has invalid size: %d\n", fname, n);
+					goto error_openfile;
+				}
 				fclose(file);
 
 				/* Add kernel memory to exclude_range */
@@ -375,12 +381,18 @@ static int get_devtree_details(unsigned long kexec_flags)
 					perror(fname);
 					goto error_opencdir;
 				}
-				if (fread(&tmp_long, sizeof(unsigned long), 1,
-						file) != 1) {
+				if ((n = fread(buf, 1, MAXBYTES, file)) < 0) {
 					perror(fname);
 					goto error_openfile;
 				}
-				crash_base = tmp_long;
+				if (n == 4) {
+					crash_base = ((uint32_t *)buf)[0];
+				} else if (n == 8) {
+					crash_base = ((uint64_t *)buf)[0];
+				} else {
+					fprintf(stderr, "%s node has invalid size: %d\n", fname, n);
+					goto error_openfile;
+				}
 				fclose(file);
 
 				memset(fname, 0, sizeof(fname));
@@ -392,12 +404,19 @@ static int get_devtree_details(unsigned long kexec_flags)
 					perror(fname);
 					goto error_opencdir;
 				}
-				if (fread(&tmp_long, sizeof(unsigned long), 1,
-						file) != 1) {
+				if ((n = fread(buf, 1, MAXBYTES, file)) < 0) {
 					perror(fname);
 					goto error_openfile;
 				}
-				crash_size = tmp_long;
+				if (n == 4) {
+					crash_size = ((uint32_t *)buf)[0];
+				} else if (n == 8) {
+					crash_size = ((uint64_t *)buf)[0];
+				} else {
+					fprintf(stderr, "%s node has invalid size: %d\n", fname, n);
+					goto error_openfile;
+				}
+				fclose(file);
 
 				if (crash_base > mem_min)
 					mem_min = crash_base;
@@ -408,6 +427,123 @@ static int get_devtree_details(unsigned long kexec_flags)
 				reserve(KDUMP_BACKUP_LIMIT,
 						crash_base-KDUMP_BACKUP_LIMIT);
 			}
+			/* reserve the initrd_start and end locations. */
+			memset(fname, 0, sizeof(fname));
+			strcpy(fname, device_tree);
+			strcat(fname, dentry->d_name);
+			strcat(fname, "/linux,initrd-start");
+			file = fopen(fname, "r");
+			if (!file) {
+				errno = 0;
+				initrd_start = 0;
+			} else {
+				if ((n = fread(buf, 1, MAXBYTES, file)) < 0) {
+					perror(fname);
+					goto error_openfile;
+				}
+				if (n == 4) {
+					initrd_start = ((uint32_t *)buf)[0];
+				} else if (n == 8) {
+					initrd_start = ((uint64_t *)buf)[0];
+				} else {
+					fprintf(stderr, "%s node has invalid size: %d\n", fname, n);
+					goto error_openfile;
+				}
+				fclose(file);
+			}
+
+			memset(fname, 0, sizeof(fname));
+			strcpy(fname, device_tree);
+			strcat(fname, dentry->d_name);
+			strcat(fname, "/linux,initrd-end");
+			file = fopen(fname, "r");
+			if (!file) {
+				errno = 0;
+				initrd_end = 0;
+			} else {
+				if ((n = fread(buf, 1, MAXBYTES, file)) < 0) {
+					perror(fname);
+					goto error_openfile;
+				}
+				if (n == 4) {
+					initrd_end = ((uint32_t *)buf)[0];
+				} else if (n == 8) {
+					initrd_end = ((uint64_t *)buf)[0];
+				} else {
+					fprintf(stderr, "%s node has invalid size: %d\n", fname, n);
+					goto error_openfile;
+				}
+				fclose(file);
+			}
+
+			if ((initrd_end - initrd_start) != 0 )
+			{
+				initrd_base = initrd_start;
+				initrd_size = initrd_end - initrd_start + 1;
+			}
+
+			if (reuse_initrd) {
+				/* Add initrd address to exclude_range */
+				exclude_range[i].start = initrd_start;
+				exclude_range[i].end = initrd_end;
+				i++;
+				if (i >= max_memory_ranges)
+					realloc_memory_ranges();
+			}
+
+			memset(fname, 0, sizeof(fname));
+			strcpy(fname, device_tree);
+			strcat(fname, dentry->d_name);
+			strcat(fname, "/linux,devicetree-start");
+			file = fopen(fname, "r");
+			if (!file) {
+				errno = 0;
+				devicetree_base = 0;
+			} else {
+				if ((n = fread(buf, 1, MAXBYTES, file)) < 0) {
+					perror(fname);
+					goto error_openfile;
+				}
+				if (n == 4) {
+					devicetree_base = ((uint32_t *)buf)[0];
+				} else if (n == 8) {
+					devicetree_base = ((uint64_t *)buf)[0];
+				} else {
+					fprintf(stderr, "%s node has invalid size: %d\n", fname, n);
+					goto error_openfile;
+				}
+				fclose(file);
+			}
+
+			memset(fname, 0, sizeof(fname));
+			strcpy(fname, device_tree);
+			strcat(fname, dentry->d_name);
+			strcat(fname, "/linux,devicetree-end");
+			file = fopen(fname, "r");
+			if (!file) {
+				errno = 0;
+				devicetree_size = 0;
+			} else {
+				if ((n = fread(buf, 1, MAXBYTES, file)) < 0) {
+					perror(fname);
+					goto error_openfile;
+				}
+				if (n == 4) {
+					devicetree_size = ((uint32_t *)buf)[0];
+				} else if (n == 8) {
+					devicetree_size = ((uint64_t *)buf)[0];
+				} else {
+					fprintf(stderr, "%s node has invalid size: %d\n", fname, n);
+					goto error_openfile;
+				}
+				fclose(file);
+			}
+
+			/* Fixup device tree size */
+			if (devicetree_size != 0)
+				devicetree_size -= devicetree_base;
+
+			/* HTAB */
 			memset(fname, 0, sizeof(fname));
 			strcpy(fname, device_tree);
 			strcat(fname, dentry->d_name);
@@ -449,59 +585,7 @@ static int get_devtree_details(unsigned long kexec_flags)
 			if (i >= max_memory_ranges)
 				realloc_memory_ranges();
 
-			/* reserve the initrd_start and end locations. */
-			if (reuse_initrd) {
-				memset(fname, 0, sizeof(fname));
-				strcpy(fname, device_tree);
-				strcat(fname, dentry->d_name);
-				strcat(fname, "/linux,initrd-start");
-				file = fopen(fname, "r");
-				if (!file) {
-					perror(fname);
-					goto error_opencdir;
-				}
-				/* check for 4 and 8 byte initrd offset sizes */
-				if (stat(fname, &fstat) != 0) {
-					perror(fname);
-					goto error_openfile;
-				}
-				if (fread(&initrd_start, fstat.st_size, 1, file)
-						!= 1) {
-					perror(fname);
-					goto error_openfile;
-				}
-				fclose(file);
-
-				memset(fname, 0, sizeof(fname));
-				strcpy(fname, device_tree);
-				strcat(fname, dentry->d_name);
-				strcat(fname, "/linux,initrd-end");
-				file = fopen(fname, "r");
-				if (!file) {
-					perror(fname);
-					goto error_opencdir;
-				}
-				/* check for 4 and 8 byte initrd offset sizes */
-				if (stat(fname, &fstat) != 0) {
-					perror(fname);
-					goto error_openfile;
-				}
-				if (fread(&initrd_end, fstat.st_size, 1, file)
-						!= 1) {
-					perror(fname);
-					goto error_openfile;
-				}
-				fclose(file);
-
-				/* Add initrd address to exclude_range */
-				exclude_range[i].start = initrd_start;
-				exclude_range[i].end = initrd_end;
-				i++;
-				if (i >= max_memory_ranges)
-					realloc_memory_ranges();
-			}
 		} /* chosen */
-
 		if (strncmp(dentry->d_name, "rtas", 4) == 0) {
 			strcat(fname, "/linux,rtas-base");
 			if ((file = fopen(fname, "r")) == NULL) {
diff --git a/kexec/arch/ppc/kexec-ppc.h b/kexec/arch/ppc/kexec-ppc.h
index fc0471f..aefdc6f 100644
--- a/kexec/arch/ppc/kexec-ppc.h
+++ b/kexec/arch/ppc/kexec-ppc.h
@@ -65,6 +65,7 @@ typedef struct mem_rgns {
 extern mem_rgns_t usablemem_rgns;
 extern int max_memory_ranges;
 extern unsigned long long initrd_base, initrd_size;
+extern unsigned long long devicetree_base, devicetree_size;
 extern unsigned char reuse_initrd;
 #define COMMAND_LINE_SIZE	512 /* from kernel */
 /*fs2dt*/
-- 
1.6.0.6
