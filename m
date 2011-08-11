Return-Path: <anton@samba.org>
Message-Id: <20110811064427.775019703@samba.org>
Date: Thu, 11 Aug 2011 16:44:24 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, sfr@ozlabs.org,
	nfont@austin.ibm.com
Subject: [PATCH 4/4] powerpc: Fix oops when echoing bad values to
	/sys/devices/system/memory/probe
References: <20110811064427.515781037@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If we echo an address the hypervisor doesn't like to
/sys/devices/system/memory/probe we oops the box:

# echo 0x10000000000 > /sys/devices/system/memory/probe

kernel BUG at arch/powerpc/mm/hash_utils_64.c:541!

The backtrace is:

create_section_mapping
arch_add_memory
add_memory
memory_probe_store
sysdev_class_store
sysfs_write_file
vfs_write
SyS_write

In create_section_mapping we BUG if htab_bolt_mapping returned
an error. A better approach is to return an error which will
propagate back to userspace.

Rerunning the test with this patch applied:

# echo 0x10000000000 > /sys/devices/system/memory/probe
-bash: echo: write error: Invalid argument

Signed-off-by: Anton Blanchard <anton@samba.org>
Cc: stable@kernel.org
---

Index: linux-build/arch/powerpc/mm/hash_utils_64.c
===================================================================
--- linux-build.orig/arch/powerpc/mm/hash_utils_64.c	2011-08-10 17:00:42.603007554 +1000
+++ linux-build/arch/powerpc/mm/hash_utils_64.c	2011-08-10 17:05:56.338457482 +1000
@@ -534,11 +534,11 @@ static unsigned long __init htab_get_tab
 }
 
 #ifdef CONFIG_MEMORY_HOTPLUG
-void create_section_mapping(unsigned long start, unsigned long end)
+int create_section_mapping(unsigned long start, unsigned long end)
 {
-	BUG_ON(htab_bolt_mapping(start, end, __pa(start),
+	return htab_bolt_mapping(start, end, __pa(start),
 				 pgprot_val(PAGE_KERNEL), mmu_linear_psize,
-				 mmu_kernel_ssize));
+				 mmu_kernel_ssize);
 }
 
 int remove_section_mapping(unsigned long start, unsigned long end)
Index: linux-build/arch/powerpc/include/asm/sparsemem.h
===================================================================
--- linux-build.orig/arch/powerpc/include/asm/sparsemem.h	2011-08-10 17:06:11.948728948 +1000
+++ linux-build/arch/powerpc/include/asm/sparsemem.h	2011-08-10 17:06:21.878901648 +1000
@@ -16,7 +16,7 @@
 #endif /* CONFIG_SPARSEMEM */
 
 #ifdef CONFIG_MEMORY_HOTPLUG
-extern void create_section_mapping(unsigned long start, unsigned long end);
+extern int create_section_mapping(unsigned long start, unsigned long end);
 extern int remove_section_mapping(unsigned long start, unsigned long end);
 #ifdef CONFIG_NUMA
 extern int hot_add_scn_to_nid(unsigned long scn_addr);
Index: linux-build/arch/powerpc/mm/mem.c
===================================================================
--- linux-build.orig/arch/powerpc/mm/mem.c	2011-08-10 17:06:42.539260996 +1000
+++ linux-build/arch/powerpc/mm/mem.c	2011-08-10 17:06:45.269308484 +1000
@@ -123,7 +123,8 @@ int arch_add_memory(int nid, u64 start,
 	pgdata = NODE_DATA(nid);
 
 	start = (unsigned long)__va(start);
-	create_section_mapping(start, start + size);
+	if (create_section_mapping(start, start + size))
+		return -EINVAL;
 
 	/* this should work for most non-highmem platforms */
 	zone = pgdata->node_zones;
