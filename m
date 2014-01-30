Return-Path: <ldufour@linux.vnet.ibm.com>
Received: from e06smtp18.uk.ibm.com (e06smtp18.uk.ibm.com [195.75.94.114])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 6D3DB2C00BF
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jan 2014 02:06:32 +1100 (EST)
Received: from /spool/local
 by e06smtp18.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ldufour@linux.vnet.ibm.com>;
 Thu, 30 Jan 2014 15:06:27 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 8A7DF17D8059
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jan 2014 15:06:46 +0000 (GMT)
Received: from d06av03.portsmouth.uk.ibm.com (d06av03.portsmouth.uk.ibm.com
 [9.149.37.213])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s0UF6EXL42401992
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jan 2014 15:06:14 GMT
Received: from d06av03.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av03.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s0UF6Ojg005820
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jan 2014 08:06:25 -0700
Subject: [PATCH v2] kexec/ppc64 fix device tree endianess issues for memory
 attributes
To: Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Date: Thu, 30 Jan 2014 16:06:22 +0100
Message-ID: <20140130150622.11156.39497.stgit@nimbus>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linuxppc-dev@lists.ozlabs.org, Anton Blanchard <anton@samba.org>,
 Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

All the attributes exposed in the device tree are in Big Endian format.

This patch add the byte swap operation for some entries which were not yet
processed, including those fixed by the following kernel's patch :

https://lists.ozlabs.org/pipermail/linuxppc-dev/2014-January/114720.html

To work on PPC64 Little Endian mode, kexec now requires that the kernel's
patch mentioned above is applied on the kexecing kernel.

Tested on ppc64 LPAR (kexec/dump) and ppc64le in a Qemu/KVM guest (kexec)

Changes from v1 :
 * add processing of the following entries :
   - ibm,dynamic-reconfiguration-memory
   - chosen/linux,kernel-end
   - chosen/linux,crashkernel-base & size
   - chosen/linux,memory-limit
   - chosen/linux,htab-base & size
   - linux,tce-base & size
   - memory@/reg
Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
---
 kexec/arch/ppc64/crashdump-ppc64.c |    9 ++++---
 kexec/arch/ppc64/kexec-ppc64.c     |   44 +++++++++++++++++++++++++++---------
 kexec/fs2dt.c                      |   19 ++++++++--------
 3 files changed, 48 insertions(+), 24 deletions(-)

diff --git a/kexec/arch/ppc64/crashdump-ppc64.c b/kexec/arch/ppc64/crashdump-ppc64.c
index e31dd6d..c0d575d 100644
--- a/kexec/arch/ppc64/crashdump-ppc64.c
+++ b/kexec/arch/ppc64/crashdump-ppc64.c
@@ -146,12 +146,12 @@ static int get_dyn_reconf_crash_memory_ranges(void)
 			return -1;
 		}
 
-		start = ((uint64_t *)buf)[DRCONF_ADDR];
+		start = be64_to_cpu(((uint64_t *)buf)[DRCONF_ADDR]);
 		end = start + lmb_size;
 		if (start == 0 && end >= (BACKUP_SRC_END + 1))
 			start = BACKUP_SRC_END + 1;
 
-		flags = (*((uint32_t *)&buf[DRCONF_FLAGS]));
+		flags = be32_to_cpu((*((uint32_t *)&buf[DRCONF_FLAGS])));
 		/* skip this block if the reserved bit is set in flags (0x80)
 		   or if the block is not assigned to this partition (0x8) */
 		if ((flags & 0x80) || !(flags & 0x8))
@@ -252,8 +252,9 @@ static int get_crash_memory_ranges(struct memory_range **range, int *ranges)
 				goto err;
 			}
 
-			start = ((unsigned long long *)buf)[0];
-			end = start + ((unsigned long long *)buf)[1];
+			start = be64_to_cpu(((unsigned long long *)buf)[0]);
+			end = start +
+				be64_to_cpu(((unsigned long long *)buf)[1]);
 			if (start == 0 && end >= (BACKUP_SRC_END + 1))
 				start = BACKUP_SRC_END + 1;
 
diff --git a/kexec/arch/ppc64/kexec-ppc64.c b/kexec/arch/ppc64/kexec-ppc64.c
index af9112b..49b291d 100644
--- a/kexec/arch/ppc64/kexec-ppc64.c
+++ b/kexec/arch/ppc64/kexec-ppc64.c
@@ -167,7 +167,7 @@ static int get_dyn_reconf_base_ranges(void)
 	 * lmb_size, num_of_lmbs(global variables) are
 	 * initialized once here.
 	 */
-	lmb_size = ((uint64_t *)buf)[0];
+	lmb_size = be64_to_cpu(((uint64_t *)buf)[0]);
 	fclose(file);
 
 	strcpy(fname, "/proc/device-tree/");
@@ -183,7 +183,7 @@ static int get_dyn_reconf_base_ranges(void)
 		fclose(file);
 		return -1;
 	}
-	num_of_lmbs = ((unsigned int *)buf)[0];
+	num_of_lmbs = be32_to_cpu(((unsigned int *)buf)[0]);
 
 	for (i = 0; i < num_of_lmbs; i++) {
 		if ((n = fread(buf, 1, 24, file)) < 0) {
@@ -194,7 +194,7 @@ static int get_dyn_reconf_base_ranges(void)
 		if (nr_memory_ranges >= max_memory_ranges)
 			return -1;
 
-		start = ((uint64_t *)buf)[0];
+		start = be64_to_cpu(((uint64_t *)buf)[0]);
 		end = start + lmb_size;
 		add_base_memory_range(start, end);
 	}
@@ -278,8 +278,8 @@ static int get_base_ranges(void)
 				if (realloc_memory_ranges() < 0)
 					break;
 			}
-			start = ((uint64_t *)buf)[0];
-			end = start + ((uint64_t *)buf)[1];
+			start =  be64_to_cpu(((uint64_t *)buf)[0]);
+			end = start + be64_to_cpu(((uint64_t *)buf)[1]);
 			add_base_memory_range(start, end);
 			fclose(file);
 		}
@@ -363,6 +363,7 @@ static int get_devtree_details(unsigned long kexec_flags)
 				goto error_openfile;
 			}
 			fclose(file);
+			kernel_end = be64_to_cpu(kernel_end);
 
 			/* Add kernel memory to exclude_range */
 			exclude_range[i].start = 0x0UL;
@@ -386,6 +387,7 @@ static int get_devtree_details(unsigned long kexec_flags)
 					goto error_openfile;
 				}
 				fclose(file);
+				crash_base = be64_to_cpu(crash_base);
 
 				memset(fname, 0, sizeof(fname));
 				strcpy(fname, device_tree);
@@ -400,6 +402,8 @@ static int get_devtree_details(unsigned long kexec_flags)
 					perror(fname);
 					goto error_openfile;
 				}
+				fclose(file);
+				crash_size = be64_to_cpu(crash_size);
 
 				if (crash_base > mem_min)
 					mem_min = crash_base;
@@ -430,10 +434,14 @@ static int get_devtree_details(unsigned long kexec_flags)
 				 * fall through. On older kernel this file
 				 * is not present.
 				 */
-			} else if (fread(&memory_limit, sizeof(uint64_t), 1,
-								file) != 1) {
-				perror(fname);
-				goto error_openfile;
+			} else {
+				if (fread(&memory_limit, sizeof(uint64_t), 1,
+					  file) != 1) {
+					perror(fname);
+					goto error_openfile;
+				}
+				fclose(file);
+				memory_limit = be64_to_cpu(memory_limit);
 			}
 
 			memset(fname, 0, sizeof(fname));
@@ -454,6 +462,9 @@ static int get_devtree_details(unsigned long kexec_flags)
 				perror(fname);
 				goto error_openfile;
 			}
+			fclose(file);
+			htab_base = be64_to_cpu(htab_base);
+
 			memset(fname, 0, sizeof(fname));
 			strcpy(fname, device_tree);
 			strcat(fname, dentry->d_name);
@@ -466,6 +477,9 @@ static int get_devtree_details(unsigned long kexec_flags)
 				perror(fname);
 				goto error_openfile;
 			}
+			fclose(file);
+			htab_size = be64_to_cpu(htab_size);
+
 			/* Add htab address to exclude_range - NON-LPAR only */
 			exclude_range[i].start = htab_base;
 			exclude_range[i].end = htab_base + htab_size;
@@ -492,6 +506,7 @@ static int get_devtree_details(unsigned long kexec_flags)
 					perror(fname);
 					goto error_openfile;
 				}
+				initrd_start = be64_to_cpu(initrd_start);
 				fclose(file);
 
 				memset(fname, 0, sizeof(fname));
@@ -511,6 +526,7 @@ static int get_devtree_details(unsigned long kexec_flags)
 					perror(fname);
 					goto error_openfile;
 				}
+				initrd_end = be64_to_cpu(initrd_end);
 				fclose(file);
 
 				/* Add initrd address to exclude_range */
@@ -532,6 +548,7 @@ static int get_devtree_details(unsigned long kexec_flags)
 				perror(fname);
 				goto error_openfile;
 			}
+			fclose(file);
 			rtas_base = be32_to_cpu(rtas_base);
 			memset(fname, 0, sizeof(fname));
 			strcpy(fname, device_tree);
@@ -545,6 +562,7 @@ static int get_devtree_details(unsigned long kexec_flags)
 				perror(fname);
 				goto error_openfile;
 			}
+			fclose(file);
 			closedir(cdir);
 			rtas_size = be32_to_cpu(rtas_size);
 			/* Add rtas to exclude_range */
@@ -568,8 +586,8 @@ static int get_devtree_details(unsigned long kexec_flags)
 				perror(fname);
 				goto error_openfile;
 			}
-			rmo_base = ((uint64_t *)buf)[0];
-			rmo_top = rmo_base + ((uint64_t *)buf)[1];
+			rmo_base = be64_to_cpu(((uint64_t *)buf)[0]);
+			rmo_top = rmo_base + be64_to_cpu(((uint64_t *)buf)[1]);
 			if (rmo_top > 0x30000000UL)
 				rmo_top = 0x30000000UL;
 
@@ -593,6 +611,8 @@ static int get_devtree_details(unsigned long kexec_flags)
 				perror(fname);
 				goto error_openfile;
 			}
+			fclose(file);
+			tce_base = be64_to_cpu(tce_base);
 			memset(fname, 0, sizeof(fname));
 			strcpy(fname, device_tree);
 			strcat(fname, dentry->d_name);
@@ -605,6 +625,8 @@ static int get_devtree_details(unsigned long kexec_flags)
 				perror(fname);
 				goto error_openfile;
 			}
+			fclose(file);
+			tce_size = be32_to_cpu(tce_size);
 			/* Add tce to exclude_range - NON-LPAR only */
 			exclude_range[i].start = tce_base;
 			exclude_range[i].end = tce_base + tce_size;
diff --git a/kexec/fs2dt.c b/kexec/fs2dt.c
index 7202dc1..73c1fb9 100644
--- a/kexec/fs2dt.c
+++ b/kexec/fs2dt.c
@@ -197,7 +197,7 @@ static void add_dyn_reconf_usable_mem_property__(int fd)
 			die("unrecoverable error: error reading \"%s\": %s\n",
 				pathname, strerror(errno));
 
-		base = (uint64_t) buf[0];
+		base = be64_to_cpu((uint64_t) buf[0]);
 		end = base + lmb_size;
 		if (~0ULL - base < end)
 			die("unrecoverable error: mem property overflow\n");
@@ -229,8 +229,8 @@ static void add_dyn_reconf_usable_mem_property__(int fd)
 						    " ranges.\n",
 						    ranges_size*8);
 				}
-				ranges[rlen++] = loc_base;
-				ranges[rlen++] = loc_end - loc_base;
+				ranges[rlen++] = cpu_to_be64(loc_base);
+				ranges[rlen++] = cpu_to_be64(loc_end - loc_base);
 				rngs_cnt++;
 			}
 		}
@@ -255,7 +255,7 @@ static void add_dyn_reconf_usable_mem_property__(int fd)
 			}
 		} else {
 			/* Store the count of (base, size) duple */
-			ranges[tmp_indx] = rngs_cnt;
+			ranges[tmp_indx] = cpu_to_be64((uint64_t) rngs_cnt);
 		}
 	}
 		
@@ -309,10 +309,11 @@ static void add_usable_mem_property(int fd, size_t len)
 		die("unrecoverable error: error reading \"%s\": %s\n",
 		    pathname, strerror(errno));
 
-	if (~0ULL - buf[0] < buf[1])
-		die("unrecoverable error: mem property overflow\n");
 	base = be64_to_cpu(buf[0]);
-	end = base + be64_to_cpu(buf[1]);
+	end = be64_to_cpu(buf[1]);
+	if (~0ULL - base < end)
+		die("unrecoverable error: mem property overflow\n");
+	end += base;
 
 	ranges = malloc(ranges_size * sizeof(*ranges));
 	if (!ranges)
@@ -342,8 +343,8 @@ static void add_usable_mem_property(int fd, size_t len)
 					    "%d bytes for ranges.\n",
 					    ranges_size*sizeof(*ranges));
 			}
-			ranges[rlen++] = loc_base;
-			ranges[rlen++] = loc_end - loc_base;
+			ranges[rlen++] = cpu_to_be64(loc_base);
+			ranges[rlen++] = cpu_to_be64(loc_end - loc_base);
 		}
 	}
 
