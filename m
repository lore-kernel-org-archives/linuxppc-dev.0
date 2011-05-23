Return-Path: <dcarroll@astekcorp.com>
Received: from ether.astekcorp.com (unknown [173.160.34.133])
	by ozlabs.org (Postfix) with ESMTP id DD9E2B6FB4
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 23 May 2011 12:31:37 +1000 (EST)
From: Dave Carroll <dcarroll@astekcorp.com>
To: 'Milton Miller' <miltonm@bga.com>
Date: Sun, 22 May 2011 20:31:11 -0600
Subject: [PATCH v4] powerpc: Force page alignment for initrd reserved memory
Message-ID: <522F24EF533FC546962ECFA2054FF777373072AB75@MAILSERVER2.cos.astekcorp.com>
In-Reply-To: <initrd-reserve-reply2@mdm.bga.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: LPPC <linuxppc-dev@lists.ozlabs.org>, Paul Mackerras <paulus@samba.org>,
	LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When using 64K pages with a separate cpio rootfs, U-Boot will align
the rootfs on a 4K page boundary. When the memory is reserved, and
subsequent early memblock_alloc is called, it will allocate memory
between the 64K page alignment and reserved memory. When the reserved
memory is subsequently freed, it is done so by pages, causing the
early memblock_alloc requests to be re-used, which in my case, caused
the device-tree to be clobbered.

This patch forces the reserved memory for initrd to be kernel page
aligned, and adds the same range extension when freeing initrd.

Signed-off-by: Dave Carroll <dcarroll@astekcorp.com>
---

* I think this handles Milton's concerns with the exception of
  a packed FDT next to initrd with mismatched page sizes. That
  would require coordination with the bootloader.

 arch/powerpc/kernel/prom.c |    4 +++-
 arch/powerpc/mm/init_32.c  |   15 +++++++++------
 arch/powerpc/mm/init_64.c  |   15 +++++++++------
 3 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 48aeb55..387e5c9 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -555,7 +555,9 @@ static void __init early_reserve_mem(void)
 #ifdef CONFIG_BLK_DEV_INITRD
        /* then reserve the initrd, if any */
        if (initrd_start && (initrd_end > initrd_start))
-               memblock_reserve(__pa(initrd_start), initrd_end - initrd_st=
art);
+               memblock_reserve(_ALIGN_DOWN(__pa(initrd_start), PAGE_SIZE)=
,
+                       _ALIGN_UP(initrd_end, PAGE_SIZE) -
+                       _ALIGN_DOWN(initrd_start, PAGE_SIZE));
 #endif /* CONFIG_BLK_DEV_INITRD */

 #ifdef CONFIG_PPC32
diff --git a/arch/powerpc/mm/init_32.c b/arch/powerpc/mm/init_32.c
index d65b591..1aad444 100644
--- a/arch/powerpc/mm/init_32.c
+++ b/arch/powerpc/mm/init_32.c
@@ -226,13 +226,16 @@ void free_initmem(void)
 #ifdef CONFIG_BLK_DEV_INITRD
 void free_initrd_mem(unsigned long start, unsigned long end)
 {
-       if (start < end)
+       if (start && (start < end)) {
+               start =3D _ALIGN_DOWN(start, PAGE_SIZE);
+               end =3D _ALIGN_UP(end, PAGE_SIZE);
                printk ("Freeing initrd memory: %ldk freed\n", (end - start=
) >> 10);
-       for (; start < end; start +=3D PAGE_SIZE) {
-               ClearPageReserved(virt_to_page(start));
-               init_page_count(virt_to_page(start));
-               free_page(start);
-               totalram_pages++;
+               for (; start < end; start +=3D PAGE_SIZE) {
+                       ClearPageReserved(virt_to_page(start));
+                       init_page_count(virt_to_page(start));
+                       free_page(start);
+                       totalram_pages++;
+               }
        }
 }
 #endif
diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
index 6374b21..fa9586b 100644
--- a/arch/powerpc/mm/init_64.c
+++ b/arch/powerpc/mm/init_64.c
@@ -102,13 +102,16 @@ void free_initmem(void)
 #ifdef CONFIG_BLK_DEV_INITRD
 void free_initrd_mem(unsigned long start, unsigned long end)
 {
-       if (start < end)
+       if (start && (start < end)) {
+               start =3D _ALIGN_DOWN(start, PAGE_SIZE);
+               end =3D _ALIGN_UP(end, PAGE_SIZE);
                printk ("Freeing initrd memory: %ldk freed\n", (end - start=
) >> 10);
-       for (; start < end; start +=3D PAGE_SIZE) {
-               ClearPageReserved(virt_to_page(start));
-               init_page_count(virt_to_page(start));
-               free_page(start);
-               totalram_pages++;
+               for (; start < end; start +=3D PAGE_SIZE) {
+                       ClearPageReserved(virt_to_page(start));
+                       init_page_count(virt_to_page(start));
+                       free_page(start);
+                       totalram_pages++;
+               }
        }
 }
 #endif
--
1.7.4
