Return-Path: <anton@ozlabs.org>
Date: Thu, 11 Feb 2010 15:07:54 +1100
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, markn@au1.ibm.com
Subject: [PATCH] powerpc: pair loads and stores in copy_4k_page
Message-ID: <20100211040754.GH3399@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


A number of our chips like loads and stores to be paired. A small kernel
module testcase shows the improvement of pairing loads and stores in 
copy_4k_page:

POWER6: +9%
POWER7: +1.5%


#include <linux/module.h>
#include <linux/mm.h>

#define ITERATIONS 10000000

static int __init copypage_init(void)
{
	struct timespec before, after;
	unsigned long i;
	struct page *destpage, *srcpage;
	char *dest, *src;

	destpage = alloc_page(GFP_KERNEL);
	srcpage = alloc_page(GFP_KERNEL);

	dest = page_address(destpage);
	src = page_address(srcpage);

	getnstimeofday(&before);

	for (i = 0; i < ITERATIONS; i++)
		copy_4K_page(dest, src);

	getnstimeofday(&after);

	free_page((unsigned long)dest);
	free_page((unsigned long)src);

	printk(KERN_DEBUG "copy_4K_page loop took %lu ns\n",
		(after.tv_sec - before.tv_sec) * NSEC_PER_SEC +
		(after.tv_nsec - before.tv_nsec));

	return 0;
}

static void __exit copypage_exit(void)
{
}

module_init(copypage_init)
module_exit(copypage_exit)
MODULE_LICENSE("GPL");
MODULE_AUTHOR("Anton Blanchard");


Signed-off-by: Anton Blanchard <anton@samba.org>
---

diff --git a/arch/powerpc/lib/copypage_64.S b/arch/powerpc/lib/copypage_64.S
index 75f3267..22b6c7b 100644
--- a/arch/powerpc/lib/copypage_64.S
+++ b/arch/powerpc/lib/copypage_64.S
@@ -43,62 +43,62 @@ END_FTR_SECTION_IFSET(CPU_FTR_CP_USE_DCBTZ)
 	ld	r7,16(r4)
 	ldu	r8,24(r4)
 1:	std	r5,8(r3)
-	ld	r9,8(r4)
 	std	r6,16(r3)
+	ld	r9,8(r4)
 	ld	r10,16(r4)
 	std	r7,24(r3)
-	ld	r11,24(r4)
 	std	r8,32(r3)
+	ld	r11,24(r4)
 	ld	r12,32(r4)
 	std	r9,40(r3)
-	ld	r5,40(r4)
 	std	r10,48(r3)
+	ld	r5,40(r4)
 	ld	r6,48(r4)
 	std	r11,56(r3)
-	ld	r7,56(r4)
 	std	r12,64(r3)
+	ld	r7,56(r4)
 	ld	r8,64(r4)
 	std	r5,72(r3)
-	ld	r9,72(r4)
 	std	r6,80(r3)
+	ld	r9,72(r4)
 	ld	r10,80(r4)
 	std	r7,88(r3)
-	ld	r11,88(r4)
 	std	r8,96(r3)
+	ld	r11,88(r4)
 	ld	r12,96(r4)
 	std	r9,104(r3)
-	ld	r5,104(r4)
 	std	r10,112(r3)
+	ld	r5,104(r4)
 	ld	r6,112(r4)
 	std	r11,120(r3)
-	ld	r7,120(r4)
 	stdu	r12,128(r3)
+	ld	r7,120(r4)
 	ldu	r8,128(r4)
 	bdnz	1b
 
 	std	r5,8(r3)
-	ld	r9,8(r4)
 	std	r6,16(r3)
+	ld	r9,8(r4)
 	ld	r10,16(r4)
 	std	r7,24(r3)
-	ld	r11,24(r4)
 	std	r8,32(r3)
+	ld	r11,24(r4)
 	ld	r12,32(r4)
 	std	r9,40(r3)
-	ld	r5,40(r4)
 	std	r10,48(r3)
+	ld	r5,40(r4)
 	ld	r6,48(r4)
 	std	r11,56(r3)
-	ld	r7,56(r4)
 	std	r12,64(r3)
+	ld	r7,56(r4)
 	ld	r8,64(r4)
 	std	r5,72(r3)
-	ld	r9,72(r4)
 	std	r6,80(r3)
+	ld	r9,72(r4)
 	ld	r10,80(r4)
 	std	r7,88(r3)
-	ld	r11,88(r4)
 	std	r8,96(r3)
+	ld	r11,88(r4)
 	ld	r12,96(r4)
 	std	r9,104(r3)
 	std	r10,112(r3)
