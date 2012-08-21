Return-Path: <suzuki@in.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp08.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6D7552C00D7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Aug 2012 21:43:03 +1000 (EST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <suzuki@in.ibm.com>;
 Tue, 21 Aug 2012 21:42:42 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q7LBYHmO22741186
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Aug 2012 21:34:17 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q7LBgv79001539
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Aug 2012 21:42:58 +1000
From: "Suzuki K. Poulose" <suzuki@in.ibm.com>
Subject: [PATCH v2 1/2] [powerpc] Change memory_limit from phys_addr_t to
 unsigned long long
To: linuxppc-dev@lists.ozlabs.org
Date: Tue, 21 Aug 2012 17:12:33 +0530
Message-ID: <20120821114225.29282.87841.stgit@suzukikp.in.ibm.com>
In-Reply-To: <20120821113815.29282.4000.stgit@suzukikp.in.ibm.com>
References: <20120821113815.29282.4000.stgit@suzukikp.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: mahesh@linux.vnet.ibm.com, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There are some device-tree nodes, whose values are of type phys_addr_t.
The phys_addr_t is variable sized based on the CONFIG_PHSY_T_64BIT.

Change these to a fixed unsigned long long for consistency.

This patch does the change only for memory_limit.

The following is a list of such variables which need the change:

 1) kernel_end, crashk_size - in arch/powerpc/kernel/machine_kexec.c

 2) (struct resource *)crashk_res.start - We could export a local static
    variable from machine_kexec.c.

Changing the above values might break the kexec-tools. So, I will
fix kexec-tools first to handle the different sized values and then change
 the above.

Suggested-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Suzuki K. Poulose <suzuki@in.ibm.com>
---

 arch/powerpc/include/asm/setup.h    |    2 +-
 arch/powerpc/kernel/fadump.c        |    3 +--
 arch/powerpc/kernel/machine_kexec.c |    2 +-
 arch/powerpc/kernel/prom.c          |    2 +-
 arch/powerpc/mm/mem.c               |    2 +-
 5 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/setup.h b/arch/powerpc/include/asm/setup.h
index d084ce1..8b9a306 100644
--- a/arch/powerpc/include/asm/setup.h
+++ b/arch/powerpc/include/asm/setup.h
@@ -9,7 +9,7 @@ extern void ppc_printk_progress(char *s, unsigned short hex);
 extern unsigned int rtas_data;
 extern int mem_init_done;	/* set on boot once kmalloc can be called */
 extern int init_bootmem_done;	/* set once bootmem is available */
-extern phys_addr_t memory_limit;
+extern unsigned long long memory_limit;
 extern unsigned long klimit;
 extern void *zalloc_maybe_bootmem(size_t size, gfp_t mask);
 
diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index 18bdf74..06c8202 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -289,8 +289,7 @@ int __init fadump_reserve_mem(void)
 		else
 			memory_limit = memblock_end_of_DRAM();
 		printk(KERN_INFO "Adjusted memory_limit for firmware-assisted"
-				" dump, now %#016llx\n",
-				(unsigned long long)memory_limit);
+				" dump, now %#016llx\n", memory_limit);
 	}
 	if (memory_limit)
 		memory_boundary = memory_limit;
diff --git a/arch/powerpc/kernel/machine_kexec.c b/arch/powerpc/kernel/machine_kexec.c
index 5df7777..4074eff 100644
--- a/arch/powerpc/kernel/machine_kexec.c
+++ b/arch/powerpc/kernel/machine_kexec.c
@@ -165,7 +165,7 @@ void __init reserve_crashkernel(void)
 	if (memory_limit && memory_limit <= crashk_res.end) {
 		memory_limit = crashk_res.end + 1;
 		printk("Adjusted memory limit for crashkernel, now 0x%llx\n",
-		       (unsigned long long)memory_limit);
+		       memory_limit);
 	}
 
 	printk(KERN_INFO "Reserving %ldMB of memory at %ldMB "
diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index f191bf0..c82c77d 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -78,7 +78,7 @@ static int __init early_parse_mem(char *p)
 		return 1;
 
 	memory_limit = PAGE_ALIGN(memparse(p, &p));
-	DBG("memory limit = 0x%llx\n", (unsigned long long)memory_limit);
+	DBG("memory limit = 0x%llx\n", memory_limit);
 
 	return 0;
 }
diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index baaafde..0a8f353 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -62,7 +62,7 @@
 
 int init_bootmem_done;
 int mem_init_done;
-phys_addr_t memory_limit;
+unsigned long long memory_limit;
 
 #ifdef CONFIG_HIGHMEM
 pte_t *kmap_pte;
