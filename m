Return-Path: <swarthou@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3A178DDE24
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Sep 2007 15:10:03 +1000 (EST)
From: Ed Swarthout <Ed.Swarthout@freescale.com>
To: galak@kernel.crashing.org, linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc mm init_32 gdb regions
Date: Wed, 19 Sep 2007 00:09:36 -0500
Message-Id: <11901785761816-git-send-email-Ed.Swarthout@freescale.com>
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
Since the entries are only 32-bit, keep under 4G.

Signed-off-by: Ed Swarthout <Ed.Swarthout@freescale.com>
---

Adapted from init_64.c

 arch/powerpc/mm/init_32.c |   34 ++++++++++++++++++++++++++++++++++
 1 files changed, 34 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/mm/init_32.c b/arch/powerpc/mm/init_32.c
index d65995a..d804c65 100644
--- a/arch/powerpc/mm/init_32.c
+++ b/arch/powerpc/mm/init_32.c
@@ -255,3 +255,37 @@ void free_initrd_mem(unsigned long start, unsigned long end)
 	}
 }
 #endif
+
+static struct kcore_list kcore_vmem;
+
+static int __init setup_kcore(void)
+{
+	int i;
+
+	for (i=0; i < lmb.memory.cnt; i++) {
+		unsigned long base, size;
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
-- 
1.5.3.rc6.63.gf7c18
