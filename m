Return-Path: <chandru@in.ibm.com>
Received: from e23smtp01.au.ibm.com (E23SMTP01.au.ibm.com [202.81.18.162])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp01.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E2C24DE24C
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jul 2008 04:45:06 +1000 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.18.234])
	by e23smtp01.au.ibm.com (8.13.1/8.13.1) with ESMTP id m67IjDKW016169
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Jul 2008 04:45:13 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m67IiHX14489330
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Jul 2008 04:44:17 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m67IiiuZ007060
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Jul 2008 04:44:44 +1000
From: Chandru <chandru@in.ibm.com>
To: kexec@lists.infradead.org, linuxppc-dev@ozlabs.org
Subject: [PATCH 3/4] kdump : add support for ibm,
	dynamic-reconfiguration-memory for kexec/kdump
Date: Tue, 8 Jul 2008 00:14:42 +0530
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200807080014.42651.chandru@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

get crash memory ranges from ibm,dynamic-reconfiguration-memory node 
of /proc/device-tree. 


Signed-off-by: Chandru Siddalingappa <chandru@in.ibm.com>
---

diff -Naurp kexec-tools-testing-orig/kexec/arch/ppc64/crashdump-ppc64.c 
kexec-tools-testing/kexec/arch/ppc64/crashdump-ppc64.c
--- kexec-tools-testing-orig/kexec/arch/ppc64/crashdump-ppc64.c	2008-07-07 
17:54:58.000000000 +0530
+++ kexec-tools-testing/kexec/arch/ppc64/crashdump-ppc64.c	2008-07-07 
20:14:02.000000000 +0530
@@ -84,6 +84,82 @@ mem_rgns_t usablemem_rgns = {0, NULL};
  */
 uint64_t saved_max_mem = 0;
 
+static unsigned long long cstart, cend;
+static int memory_ranges;
+
+/*
+ * Exclude the region that lies within crashkernel
+ */
+static void exclude_crash_region(uint64_t start, uint64_t end)
+{
+	if (cstart < end && cend > start) {
+		if (start < cstart && end > cend) {
+			crash_memory_range[memory_ranges].start = start;
+			crash_memory_range[memory_ranges].end = cstart;
+			crash_memory_range[memory_ranges].type = RANGE_RAM;
+			memory_ranges++;
+			crash_memory_range[memory_ranges].start = cend;
+			crash_memory_range[memory_ranges].end = end;
+			crash_memory_range[memory_ranges].type = RANGE_RAM;
+			memory_ranges++;
+		} else if (start < cstart) {
+			crash_memory_range[memory_ranges].start = start;
+			crash_memory_range[memory_ranges].end = cstart;
+			crash_memory_range[memory_ranges].type = RANGE_RAM;
+			memory_ranges++;
+		} else if (end > cend) {
+			crash_memory_range[memory_ranges].start = cend;
+			crash_memory_range[memory_ranges].end = end;
+			crash_memory_range[memory_ranges].type = RANGE_RAM;
+			memory_ranges++;
+		}
+	} else {
+		crash_memory_range[memory_ranges].start = start;
+		crash_memory_range[memory_ranges].end  = end;
+		crash_memory_range[memory_ranges].type = RANGE_RAM;
+		memory_ranges++;
+	}
+}
+
+static int get_dyn_reconf_crash_memory_ranges()
+{
+	uint64_t start, end;
+	char fname[128], buf[32];
+	FILE *file;
+	int i, n;
+
+	strcpy(fname, "/proc/device-tree/");
+	strcat(fname, "ibm,dynamic-reconfiguration-memory/ibm,dynamic-memory");
+	if ((file = fopen(fname, "r")) == NULL) {
+		perror(fname);
+		return -1;
+	}
+
+	fseek(file, 4, SEEK_SET);
+	for (i = 0; i < num_of_lmbs; i++) {
+		if ((n = fread(buf, 1, 24, file)) < 0) {
+			perror(fname);
+			fclose(file);
+			return -1;
+		}
+		if (memory_ranges >= (max_memory_ranges + 1)) {
+			/* No space to insert another element. */
+				fprintf(stderr,
+				"Error: Number of crash memory ranges"
+				" excedeed the max limit\n");
+			return -1;
+		}
+
+		start = ((uint64_t *)buf)[0];
+		end = start + lmb_size;
+		if (start == 0 && end >= (BACKUP_SRC_END + 1))
+			start = BACKUP_SRC_END + 1;
+		exclude_crash_region(start, end);
+	}
+	fclose(file);
+	return 0;
+}
+
 /* Reads the appropriate file and retrieves the SYSTEM RAM regions for whom 
to
  * create Elf headers. Keeping it separate from get_memory_ranges() as
  * requirements are different in the case of normal kexec and crashdumps.
@@ -98,7 +174,6 @@ uint64_t saved_max_mem = 0;
 static int get_crash_memory_ranges(struct memory_range **range, int *ranges)
 {
 
-	int memory_ranges = 0;
 	char device_tree[256] = "/proc/device-tree/";
 	char fname[256];
 	char buf[MAXBYTES];
@@ -106,7 +181,7 @@ static int get_crash_memory_ranges(struc
 	FILE *file;
 	struct dirent *dentry, *mentry;
 	int i, n, crash_rng_len = 0;
-	unsigned long long start, end, cstart, cend;
+	unsigned long long start, end;
 	int page_size;
 
 	crash_max_memory_ranges = max_memory_ranges + 6;
@@ -129,7 +204,16 @@ static int get_crash_memory_ranges(struc
 		perror(device_tree);
 		goto err;
 	}
+
+	cstart = crash_base;
+	cend = crash_base + crash_size;
+
 	while ((dentry = readdir(dir)) != NULL) {
+		if (!strncmp(dentry->d_name,
+				"ibm,dynamic-reconfiguration-memory", 35)){
+			get_dyn_reconf_crash_memory_ranges();
+			continue;
+		}
 		if (strncmp(dentry->d_name, "memory@", 7) &&
 			strcmp(dentry->d_name, "memory"))
 			continue;
@@ -170,38 +254,7 @@ static int get_crash_memory_ranges(struc
 			if (start == 0 && end >= (BACKUP_SRC_END + 1))
 				start = BACKUP_SRC_END + 1;
 
-			cstart = crash_base;
-			cend = crash_base + crash_size;
-			/*
-			 * Exclude the region that lies within crashkernel
-			 */
-			if (cstart < end && cend > start) {
-				if (start < cstart && end > cend) {
-					crash_memory_range[memory_ranges].start = start;
-					crash_memory_range[memory_ranges].end = cstart;
-					crash_memory_range[memory_ranges].type = RANGE_RAM;
-					memory_ranges++;
-					crash_memory_range[memory_ranges].start = cend;
-					crash_memory_range[memory_ranges].end = end;
-					crash_memory_range[memory_ranges].type = RANGE_RAM;
-					memory_ranges++;
-				} else if (start < cstart) {
-					crash_memory_range[memory_ranges].start = start;
-					crash_memory_range[memory_ranges].end = cstart;
-					crash_memory_range[memory_ranges].type = RANGE_RAM;
-					memory_ranges++;
-				} else if (end > cend){
-					crash_memory_range[memory_ranges].start = cend;
-					crash_memory_range[memory_ranges].end = end;
-					crash_memory_range[memory_ranges].type = RANGE_RAM;
-					memory_ranges++;
-				}
-			} else {
-				crash_memory_range[memory_ranges].start = start;
-				crash_memory_range[memory_ranges].end  = end;
-				crash_memory_range[memory_ranges].type = RANGE_RAM;
-				memory_ranges++;
-			}
+			exclude_crash_region(start, end);
 			fclose(file);
 		}
 		closedir(dmem);
diff -Naurp kexec-tools-testing-orig/kexec/arch/ppc64/crashdump-ppc64.h 
kexec-tools-testing/kexec/arch/ppc64/crashdump-ppc64.h
--- kexec-tools-testing-orig/kexec/arch/ppc64/crashdump-ppc64.h	2008-07-07 
17:54:58.000000000 +0530
+++ kexec-tools-testing/kexec/arch/ppc64/crashdump-ppc64.h	2008-07-07 
20:03:45.000000000 +0530
@@ -28,4 +28,7 @@ extern uint64_t crash_size;
 extern unsigned int rtas_base;
 extern unsigned int rtas_size;
 
+uint64_t lmb_size;
+unsigned int num_of_lmbs;
+
 #endif /* CRASHDUMP_PPC64_H */
