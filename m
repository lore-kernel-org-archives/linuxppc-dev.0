Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: horms@verge.net.au
MIME-Version: 1.0
Subject: [PATCH] kexec ppc64: cleanup get_devtree_details
Date: Tue, 01 May 2007 13:47:14 +1000
Message-ID: <10869.1177991234@neuling.org>
Cc: linuxppc-dev@ozlabs.org, kexec@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Cleanup error paths in get_devtree_details.  Also convert fstat from a
pointer to avoid malloc.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
It's error paths, so if I screwed something up, I won't have picked it
up with the simple testing I did. 

 kexec/arch/ppc64/kexec-ppc64.c |  136 ++++++++++++-----------------------------
 1 file changed, 40 insertions(+), 96 deletions(-)

Index: kexec-tools-testing/kexec/arch/ppc64/kexec-ppc64.c
===================================================================
--- kexec-tools-testing.orig/kexec/arch/ppc64/kexec-ppc64.c
+++ kexec-tools-testing/kexec/arch/ppc64/kexec-ppc64.c
@@ -265,7 +265,7 @@ static int get_devtree_details(unsigned 
 	DIR *dir, *cdir;
 	FILE *file;
 	struct dirent *dentry;
-	struct stat *fstat = malloc(sizeof(struct stat));
+	struct stat fstat;
 	int n, i = 0;
 
 	if ((dir = opendir(device_tree)) == NULL) {
@@ -283,24 +283,18 @@ static int get_devtree_details(unsigned 
 		strcat(fname, dentry->d_name);
 		if ((cdir = opendir(fname)) == NULL) {
 			perror(fname);
-			closedir(dir);
-			return -1;
+			goto error_opendir;
 		}
 
 		if (strncmp(dentry->d_name, "chosen", 6) == 0) {
 			strcat(fname, "/linux,kernel-end");
 			if ((file = fopen(fname, "r")) == NULL) {
 				perror(fname);
-				closedir(cdir);
-				closedir(dir);
-				return -1;
+				goto error_opencdir;
 			}
 			if (fread(&kernel_end, sizeof(unsigned long), 1, file) != 1) {
 				perror(fname);
-				fclose(file);
-				closedir(cdir);
-				closedir(dir);
-				return -1;
+				goto error_openfile;
 			}
 			fclose(file);
 
@@ -316,17 +310,12 @@ static int get_devtree_details(unsigned 
 				strcat(fname, "/linux,crashkernel-base");
 				if ((file = fopen(fname, "r")) == NULL) {
 					perror(fname);
-					closedir(cdir);
-					closedir(dir);
-					return -1;
+					goto error_opencdir;
 				}
 				if (fread(&crash_base, sizeof(unsigned long), 1,
 						file) != 1) {
 					perror(fname);
-					fclose(file);
-					closedir(cdir);
-					closedir(dir);
-					return -1;
+					goto error_openfile;
 				}
 				fclose(file);
 
@@ -336,17 +325,12 @@ static int get_devtree_details(unsigned 
 				strcat(fname, "/linux,crashkernel-size");
 				if ((file = fopen(fname, "r")) == NULL) {
 					perror(fname);
-					closedir(cdir);
-					closedir(dir);
-					return -1;
+					goto error_opencdir;
 				}
 				if (fread(&crash_size, sizeof(unsigned long), 1,
 						file) != 1) {
 					perror(fname);
-					fclose(file);
-					closedir(cdir);
-					closedir(dir);
-					return -1;
+					goto error_openfile;
 				}
 
 				if (crash_base > mem_min)
@@ -370,15 +354,11 @@ static int get_devtree_details(unsigned 
 					continue;
                                 }
 				perror(fname);
-				closedir(dir);
-				return -1;
+				goto error_opendir;
 			}
 			if (fread(&htab_base, sizeof(unsigned long), 1, file) != 1) {
 				perror(fname);
-				fclose(file);
-				closedir(cdir);
-				closedir(dir);
-				return -1;
+				goto error_openfile;
 			}
 			memset(fname, 0, sizeof(fname));
 			strcpy(fname, device_tree);
@@ -386,16 +366,11 @@ static int get_devtree_details(unsigned 
 			strcat(fname, "/linux,htab-size");
 			if ((file = fopen(fname, "r")) == NULL) {
 				perror(fname);
-				closedir(cdir);
-				closedir(dir);
-				return -1;
+				goto error_opencdir;
 			}
 			if (fread(&htab_size, sizeof(unsigned long), 1, file) != 1) {
 				perror(fname);
-				fclose(file);
-				closedir(cdir);
-				closedir(dir);
-				return -1;
+				goto error_openfile;
 			}
 			/* Add htab address to exclude_range - NON-LPAR only */
 			exclude_range[i].start = htab_base;
@@ -410,24 +385,16 @@ static int get_devtree_details(unsigned 
 				strcat(fname, "/linux,initrd-start");
 				if ((file = fopen(fname, "r")) == NULL) {
 					perror(fname);
-					closedir(cdir);
-					closedir(dir);
-					return -1;
+					goto error_opencdir;
 				}
 				/* check for 4 and 8 byte initrd offset sizes */
-				if (stat(fname, fstat) != 0) {
+				if (stat(fname, &fstat) != 0) {
 					perror(fname);
-					fclose(file);
-					closedir(cdir);
-					closedir(dir);
-					return -1;
+					goto error_openfile;
 				}
- 				if (fread(&initrd_start, fstat->st_size, 1, file) != 1) {
+ 				if (fread(&initrd_start, fstat.st_size, 1, file) != 1) {
 					perror(fname);
-					fclose(file);
-					closedir(cdir);
-					closedir(dir);
-					return -1;
+					goto error_openfile;
 				}
 				fclose(file);
 
@@ -437,24 +404,16 @@ static int get_devtree_details(unsigned 
 				strcat(fname, "/linux,initrd-end");
 				if ((file = fopen(fname, "r")) == NULL) {
 					perror(fname);
-					closedir(cdir);
-					closedir(dir);
-					return -1;
+					goto error_opencdir;
 				}
 				/* check for 4 and 8 byte initrd offset sizes */
-				if (stat(fname, fstat) != 0) {
+				if (stat(fname, &fstat) != 0) {
 					perror(fname);
-					fclose(file);
-					closedir(cdir);
-					closedir(dir);
-					return -1;
+					goto error_openfile;
 				}
- 				if (fread(&initrd_end, fstat->st_size, 1, file) != 1) {
+ 				if (fread(&initrd_end, fstat.st_size, 1, file) != 1) {
 					perror(fname);
-					fclose(file);
-					closedir(cdir);
-					closedir(dir);
-					return -1;
+					goto error_openfile;
 				}
 				fclose(file);
 
@@ -469,16 +428,11 @@ static int get_devtree_details(unsigned 
 			strcat(fname, "/linux,rtas-base");
 			if ((file = fopen(fname, "r")) == NULL) {
 				perror(fname);
-				closedir(cdir);
-				closedir(dir);
-				return -1;
+				goto error_opencdir;
 			}
 			if (fread(&rtas_base, sizeof(unsigned int), 1, file) != 1) {
 				perror(fname);
-				fclose(file);
-				closedir(cdir);
-				closedir(dir);
-				return -1;
+				goto error_openfile;
 			}
 			memset(fname, 0, sizeof(fname));
 			strcpy(fname, device_tree);
@@ -486,16 +440,11 @@ static int get_devtree_details(unsigned 
 			strcat(fname, "/rtas-size");
 			if ((file = fopen(fname, "r")) == NULL) {
 				perror(fname);
-				closedir(cdir);
-				closedir(dir);
-				return -1;
+				goto error_opencdir;
 			}
 			if (fread(&rtas_size, sizeof(unsigned int), 1, file) != 1) {
 				perror(fname);
-				fclose(file);
-				closedir(cdir);
-				closedir(dir);
-				return -1;
+				goto error_openfile;
 			}
 			closedir(cdir);
 			/* Add rtas to exclude_range */
@@ -510,16 +459,11 @@ static int get_devtree_details(unsigned 
 			strcat(fname, "/reg");
 			if ((file = fopen(fname, "r")) == NULL) {
 				perror(fname);
-				closedir(cdir);
-				closedir(dir);
-				return -1;
+				goto error_opencdir;
 			}
 			if ((n = fread(buf, 1, MAXBYTES, file)) < 0) {
 				perror(fname);
-				fclose(file);
-				closedir(cdir);
-				closedir(dir);
-				return -1;
+				goto error_openfile;
 			}
 			rmo_base = ((unsigned long long *)buf)[0];
 			rmo_top = rmo_base + ((unsigned long long *)buf)[1];
@@ -540,14 +484,11 @@ static int get_devtree_details(unsigned 
 					continue;
 				}
 				perror(fname);
-				closedir(dir);
-				return -1;
+				goto error_opendir;
 			}
 			if (fread(&tce_base, sizeof(unsigned long), 1, file) != 1) {
 				perror(fname);
-				fclose(file);
-				closedir(cdir);
-				closedir(dir);
+				goto error_openfile;
 				return -1;
 			}
 			memset(fname, 0, sizeof(fname));
@@ -556,16 +497,11 @@ static int get_devtree_details(unsigned 
 			strcat(fname, "/linux,tce-size");
 			if ((file = fopen(fname, "r")) == NULL) {
 				perror(fname);
-				closedir(cdir);
-				closedir(dir);
-				return -1;
+				goto error_opencdir;
 			}
 			if (fread(&tce_size, sizeof(unsigned int), 1, file) != 1) {
 				perror(fname);
-				fclose(file);
-				closedir(cdir);
-				closedir(dir);
-				return -1;
+				goto error_openfile;
 			}
 			/* Add tce to exclude_range - NON-LPAR only */
 			exclude_range[i].start = tce_base;
@@ -590,6 +526,14 @@ static int get_devtree_details(unsigned 
 			exclude_range[k].end);
 #endif
 	return 0;
+
+error_openfile:
+	fclose(file);
+error_opencdir:
+	closedir(cdir);
+error_opendir:
+	closedir(dir);
+	return -1;
 }
 
 /* Setup a sorted list of memory ranges. */
