Return-Path: <swarthou@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 87CCFDDEB8
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Sep 2007 12:53:33 +1000 (EST)
From: Ed Swarthout <Ed.Swarthout@freescale.com>
To: galak@kernel.crashing.org, linuxppc-dev@ozlabs.org
Subject: [PATCH V2] powerpc mm init_32 gdb regions
Date: Thu, 20 Sep 2007 21:53:02 -0500
Message-Id: <11903431823954-git-send-email-Ed.Swarthout@freescale.com>
In-Reply-To: <1190270195801-git-send-email-Ed.Swarthout@freescale.com>
References: <1190270195801-git-send-email-Ed.Swarthout@freescale.com>
Cc: Ed Swarthout <Ed.Swarthout@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add memory regions to the kcore list for 32-bit machines.

The entries are only 32-bit, so restrict the virtual address to stay
below 0xffff_ffff.  With KERNELBASE set to 0xc000_0000, this in effect
restricts access to the first 1GB of real memory.

Make setup_kcore conditional on CONFIG_PROC_KCORE for both 32/64.

Signed-off-by: Ed Swarthout <Ed.Swarthout@freescale.com>
---

 arch/powerpc/mm/init_32.c |   37 +++++++++++++++++++++++++++++++++++++
 arch/powerpc/mm/init_64.c |    2 ++
 2 files changed, 39 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/mm/init_32.c b/arch/powerpc/mm/init_32.c
index d65995a..27c234f 100644
--- a/arch/powerpc/mm/init_32.c
+++ b/arch/powerpc/mm/init_32.c
@@ -255,3 +255,40 @@ void free_initrd_mem(unsigned long start, unsigned long end)
 	}
 }
 #endif
+
+#ifdef CONFIG_PROC_KCORE
+static struct kcore_list kcore_vmem;
+
+static int __init setup_kcore(void)
+{
+	int i;
+
+	for (i = 0; i < lmb.memory.cnt; i++) {
+		unsigned long base;
+		unsigned long size;
+		struct kcore_list *kcore_mem;
+
+		base = lmb.memory.region[i].base;
+		size = lmb.memory.region[i].size;
+
+		kcore_mem = kmalloc(sizeof(struct kcore_list), GFP_ATOMIC);
+		if (!kcore_mem)
+			panic("%s: kmalloc failed\n", __FUNCTION__);
+
+		/* must stay under 32 bits */
+		if ( 0xfffffffful - (unsigned long)__va(base) < size) {
+			size = 0xfffffffful - (unsigned long)(__va(base));
+			printk(KERN_DEBUG "setup_kcore: restrict size=%lx\n",
+						size);
+		}
+
+		kclist_add(kcore_mem, __va(base), size);
+	}
+
+	kclist_add(&kcore_vmem, (void *)VMALLOC_START,
+		VMALLOC_END-VMALLOC_START);
+
+	return 0;
+}
+module_init(setup_kcore);
+#endif
diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
index 9f27bb5..fa90f65 100644
--- a/arch/powerpc/mm/init_64.c
+++ b/arch/powerpc/mm/init_64.c
@@ -113,6 +113,7 @@ void free_initrd_mem(unsigned long start, unsigned long end)
 }
 #endif
 
+#ifdef CONFIG_PROC_KCORE
 static struct kcore_list kcore_vmem;
 
 static int __init setup_kcore(void)
@@ -139,6 +140,7 @@ static int __init setup_kcore(void)
 	return 0;
 }
 module_init(setup_kcore);
+#endif
 
 static void zero_ctor(void *addr, struct kmem_cache *cache, unsigned long flags)
 {
-- 
1.5.3.1.65.g47184
