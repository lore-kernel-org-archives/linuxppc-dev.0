Return-Path: <mikey@ozlabs.org>
From: Michael Neuling <mikey@neuling.org>
To: Fastboot mailing list <fastboot@lists.osdl.org>, linuxppc-dev@ozlabs.org
MIME-Version: 1.0
Subject: [PATCH] kexec: remove memory reserve patching for powerpc device tree
Date: Thu, 21 Sep 2006 11:10:30 +1000
Sender: mikey@ozlabs.org
Message-Id: <20060921011031.4BFEA67BCE@ozlabs.org>
Reply-To: Michael Neuling <mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This code no longer needed with Jimi's auto reserve of device tree blob
kernel patch now in 2.6.18.    

This patch will break Linux if you're kexecing to a kernel which doesn't
have this patch (ie. earlier than 2.6.17).  Required kernel patch is
this one:   
http://git.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=4d1f3f25d9c303d1ce63b42cc94c54ac0ab2e950

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
This should be save to include now 2.6.18 has been released.  

 kexec/arch/ppc64/fs2dt.c           |    2 --
 kexec/arch/ppc64/kexec-elf-ppc64.c |   19 -------------------
 2 files changed, 21 deletions(-)

Index: kexec-tools-1.101/kexec/arch/ppc64/fs2dt.c
===================================================================
--- kexec-tools-1.101.orig/kexec/arch/ppc64/fs2dt.c
+++ kexec-tools-1.101/kexec/arch/ppc64/fs2dt.c
@@ -445,8 +445,6 @@ int create_flatten_tree(struct kexec_inf
 	bb->version = 2;
 	bb->last_comp_version = 2;
 
-	reserve(me, bb->totalsize); /* patched later in kexec_load */
-
 	buf = (unsigned char *) malloc(bb->totalsize);
 	*bufp = buf;
 	memcpy(buf, bb, bb->off_mem_rsvmap);
Index: kexec-tools-1.101/kexec/arch/ppc64/kexec-elf-ppc64.c
===================================================================
--- kexec-tools-1.101.orig/kexec/arch/ppc64/kexec-elf-ppc64.c
+++ kexec-tools-1.101/kexec/arch/ppc64/kexec-elf-ppc64.c
@@ -81,8 +81,6 @@ int elf_ppc64_load(int argc, char **argv
 	off_t seg_size = 0;
 	struct mem_phdr *phdr;
 	size_t size;
-	unsigned long long *rsvmap_ptr;
-	struct bootblock *bb_ptr;
 	unsigned int nr_segments, i;
 	int result, opt;
 	unsigned long my_kernel, my_dt_offset;
@@ -249,23 +247,6 @@ int elf_ppc64_load(int argc, char **argv
 				0, 0, max_addr, -1);
 	}
 
-	/* patch reserve map address for flattened device-tree
-	 * find last entry (both 0) in the reserve mem list.  Assume DT
-	 * entry is before this one
-	 */
-	bb_ptr = (struct bootblock *)(
-		(unsigned char *)info->segment[(info->nr_segments)-1].buf);
-	rsvmap_ptr = (unsigned long long *)(
-		(unsigned char *)info->segment[(info->nr_segments)-1].buf +
-		bb_ptr->off_mem_rsvmap);
-	while (*rsvmap_ptr || *(rsvmap_ptr+1))
-		rsvmap_ptr += 2;
-	rsvmap_ptr -= 2;
-	*rsvmap_ptr = (unsigned long long)(
-		info->segment[(info->nr_segments)-1].mem);
-	rsvmap_ptr++;
-	*rsvmap_ptr = (unsigned long long)bb_ptr->totalsize;
-
 	nr_segments = info->nr_segments;
 
 	/* Set kernel */
