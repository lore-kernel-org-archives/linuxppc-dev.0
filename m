Return-Path: <miltonm@sullivan.realtime.net>
Received: from sullivan.realtime.net (sullivan.realtime.net [205.238.132.226])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3DD8E474CF
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Oct 2008 07:39:33 +1100 (EST)
Date: Wed, 22 Oct 2008 15:39:17 -0500 (CDT)
From: Milton Miller <miltonm@bga.com>
Sender: Milton Miller <miltonm@realtime.net>
To: Simon Horman <horms@verge.net.au>
Subject: [PATCH 2/2 kexec-tools] ppc64: segemments are sorted
Message-id: <kexec-user-2@bga.com>
In-Reply-To: <f90d4d7306443a720ca31adf513faf25@bga.com>
Cc: linuxppc-dev@ozlabs.org, Simon Horman <horms@verge.net.au>,
	kexec@lists.infradead.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Every time add_segment is called, the segments are sorted.  If the first
hole in memory is not big enough for the kernel then something besides
the kernel may be at 

Signed-off-by: Milton Miller <miltonm@bga.com>
---
Found during custom environment testing with several reserved blocks of
memory, not the usual case.

Index: kexec-tools/kexec/arch/ppc64/kexec-elf-ppc64.c
===================================================================
--- kexec-tools.orig/kexec/arch/ppc64/kexec-elf-ppc64.c	2008-10-22 06:14:48.000000000 -0500
+++ kexec-tools/kexec/arch/ppc64/kexec-elf-ppc64.c	2008-10-22 06:14:54.000000000 -0500
@@ -86,7 +86,7 @@ int elf_ppc64_load(int argc, char **argv
 	size_t size;
 	uint64_t *rsvmap_ptr;
 	struct bootblock *bb_ptr;
-	unsigned int nr_segments, i;
+	unsigned int i;
 	int result, opt;
 	uint64_t my_kernel, my_dt_offset;
 	unsigned int my_panic_kernel;
@@ -187,7 +187,7 @@ int elf_ppc64_load(int argc, char **argv
 	if (size > phdr->p_memsz)
 		size = phdr->p_memsz;
 
-	hole_addr = (uint64_t)locate_hole(info, size, 0, 0,
+	my_kernel = hole_addr = (uint64_t)locate_hole(info, size, 0, 0,
 			max_addr, 1);
 	ehdr.e_phdr[0].p_paddr = hole_addr;
 	result = elf_exec_load(&ehdr, info);
@@ -233,12 +233,10 @@ int elf_ppc64_load(int argc, char **argv
 			return -1;
 		}
 		seg_buf = (unsigned char *)slurp_file(ramdisk, &seg_size);
-		add_buffer(info, seg_buf, seg_size, seg_size, 0, 0, max_addr, 1);
-		hole_addr = (uintptr_t)
-			info->segment[info->nr_segments-1].mem;
+		hole_addr = add_buffer(info, seg_buf, seg_size, seg_size,
+			0, 0, max_addr, 1);
 		initrd_base = hole_addr;
-		initrd_size = (uint64_t)
-			info->segment[info->nr_segments-1].memsz;
+		initrd_size = seg_size;
 	} /* ramdisk */
 
 	if (devicetreeblob) {
@@ -248,16 +246,18 @@ int elf_ppc64_load(int argc, char **argv
 		/* Grab device tree from buffer */
 		blob_buf =
 			(unsigned char *)slurp_file(devicetreeblob, &blob_size);
-		add_buffer(info, blob_buf, blob_size, blob_size, 0, 0,
-				max_addr, -1);
+		my_dt_offset = add_buffer(info, blob_buf, blob_size, blob_size,
+				0, 0, max_addr, -1);
 
+		seg_buf = blob_buf;
+		seg_size = blob_size;
 	} else {
 		/* create from fs2dt */
 		seg_buf = NULL;
 		seg_size = 0;
 		create_flatten_tree(info, (unsigned char **)&seg_buf,
 				(unsigned long *)&seg_size,cmdline);
-		add_buffer(info, seg_buf, seg_size, seg_size,
+		my_dt_offset = add_buffer(info, seg_buf, seg_size, seg_size,
 				0, 0, max_addr, -1);
 	}
 
@@ -265,27 +265,20 @@ int elf_ppc64_load(int argc, char **argv
 	 * find last entry (both 0) in the reserve mem list.  Assume DT
 	 * entry is before this one
 	 */
-	bb_ptr = (struct bootblock *)(
-		(unsigned char *)info->segment[(info->nr_segments)-1].buf);
-	rsvmap_ptr = (uint64_t *)(
-		(unsigned char *)info->segment[(info->nr_segments)-1].buf +
-		bb_ptr->off_mem_rsvmap);
+	bb_ptr = (struct bootblock *)(seg_buf);
+	rsvmap_ptr = (uint64_t *)
+		(((char *)seg_buf) + bb_ptr->off_mem_rsvmap);
 	while (*rsvmap_ptr || *(rsvmap_ptr+1))
 		rsvmap_ptr += 2;
 	rsvmap_ptr -= 2;
-	*rsvmap_ptr = (uintptr_t)(
-		info->segment[(info->nr_segments)-1].mem);
+	*rsvmap_ptr = my_dt_offset;
 	rsvmap_ptr++;
 	*rsvmap_ptr = (uint64_t)bb_ptr->totalsize;
 
-	nr_segments = info->nr_segments;
-
 	/* Set kernel */
-	my_kernel = (uintptr_t)info->segment[0].mem;
 	elf_rel_set_symbol(&info->rhdr, "kernel", &my_kernel, sizeof(my_kernel));
 
 	/* Set dt_offset */
-	my_dt_offset = (uintptr_t)info->segment[nr_segments-1].mem;
 	elf_rel_set_symbol(&info->rhdr, "dt_offset", &my_dt_offset,
 				sizeof(my_dt_offset));
 
@@ -293,7 +286,7 @@ int elf_ppc64_load(int argc, char **argv
 	elf_rel_get_symbol(&info->rhdr, "purgatory_start", slave_code,
 			sizeof(slave_code));
 	master_entry = slave_code[0];
-	memcpy(slave_code, info->segment[0].buf, sizeof(slave_code));
+	memcpy(slave_code, phdr->p_data, sizeof(slave_code));
 	slave_code[0] = master_entry;
 	elf_rel_set_symbol(&info->rhdr, "purgatory_start", slave_code,
 				sizeof(slave_code));
@@ -366,7 +359,7 @@ int elf_ppc64_load(int argc, char **argv
 	fprintf(stderr, "purgatory size is %zu\n", purgatory_size);
 #endif
 
-	for (i = 0; i < nr_segments; i++)
+	for (i = 0; i < info->nr_segments; i++)
 		fprintf(stderr, "segment[%d].mem:%p memsz:%zu\n", i,
 			info->segment[i].mem, info->segment[i].memsz);
 
