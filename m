Return-Path: <miltonm@bga.com>
Received: from mercury.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id DBE6DDE01E
	for <linuxppc-dev@ozlabs.org>; Sat,  3 Jan 2009 08:04:58 +1100 (EST)
From: Milton Miller <miltonm@bga.com>
To: Simon Horman <horms@verge.net.au>, <kexec@lists.infradead.org> 
Message-Id: <kexec-29-1-3r.miltonm@bga.com>
In-Reply-To: <kexec-29-3.miltonm@bga.com>
Subject: [PATCH kexec-tools 3/5] ppc64: segments may be reordered
Date: Fri, 02 Jan 2009 15:04:45 -0600
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Instead of fetching data from the segment array, remember the address
when added and find the kernel text from the parsed elf header.

While add_segment (and hence add_buffer) always adds to the end of
the list of segments, it sorts the previous segments before each
allocation.  In some layouts, the device tree or initrd will fit
in a hole below the the kernel.   When that happens, the previus
code mis-patches purgatory and the kexec fails.

Signed-off-by: Milton Miller <miltonm@bga.com>
---

The only safe reference is to info->segments[info->nr_segments]

 kexec/arch/ppc64/kexec-elf-ppc64.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

Index: kexec-tools/kexec/arch/ppc64/kexec-elf-ppc64.c
===================================================================
--- kexec-tools.orig/kexec/arch/ppc64/kexec-elf-ppc64.c	2009-01-01 21:46:24.000000000 -0600
+++ kexec-tools/kexec/arch/ppc64/kexec-elf-ppc64.c	2009-01-02 01:48:28.000000000 -0600
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
@@ -248,44 +246,37 @@ int elf_ppc64_load(int argc, char **argv
 		/* Grab device tree from buffer */
 		blob_buf =
 			(unsigned char *)slurp_file(devicetreeblob, &blob_size);
-		add_buffer(info, blob_buf, blob_size, blob_size, 0, 0,
-				max_addr, -1);
 
+		seg_buf = blob_buf;
+		seg_size = blob_size;
 	} else {
 		/* create from fs2dt */
 		seg_buf = NULL;
 		seg_size = 0;
 		create_flatten_tree(info, (unsigned char **)&seg_buf,
 				(unsigned long *)&seg_size,cmdline);
-		add_buffer(info, seg_buf, seg_size, seg_size,
-				0, 0, max_addr, -1);
 	}
+	my_dt_offset = add_buffer(info, seg_buf, seg_size, seg_size,
+				0, 0, max_addr, -1);
 
 	/* patch reserve map address for flattened device-tree
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
 
@@ -293,7 +284,7 @@ int elf_ppc64_load(int argc, char **argv
 	elf_rel_get_symbol(&info->rhdr, "purgatory_start", slave_code,
 			sizeof(slave_code));
 	master_entry = slave_code[0];
-	memcpy(slave_code, info->segment[0].buf, sizeof(slave_code));
+	memcpy(slave_code, phdr->p_data, sizeof(slave_code));
 	slave_code[0] = master_entry;
 	elf_rel_set_symbol(&info->rhdr, "purgatory_start", slave_code,
 				sizeof(slave_code));
@@ -366,7 +357,7 @@ int elf_ppc64_load(int argc, char **argv
 	fprintf(stderr, "purgatory size is %zu\n", purgatory_size);
 #endif
 
-	for (i = 0; i < nr_segments; i++)
+	for (i = 0; i < info->nr_segments; i++)
 		fprintf(stderr, "segment[%d].mem:%p memsz:%zu\n", i,
 			info->segment[i].mem, info->segment[i].memsz);
 
