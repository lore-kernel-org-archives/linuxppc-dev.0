Message-ID: <3C3B1162.4000405@humboldt.co.uk>
Date: Tue, 08 Jan 2002 15:33:54 +0000
From: Adrian Cox <adrian@humboldt.co.uk>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: ISA DMA take 2
Content-Type: multipart/mixed;
 boundary="------------020309020601050105090501"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------020309020601050105090501
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Attached is an update to my ISA DMA patch. The main change from the
previous patch is that it works, because it now changes MAX_DMA_ADDRESS.
I've tested it on my platform (Via 686 southbridge, ISA DMA for floppy),
and it shouldn't break any others.

Can somebody please apply this one?

--
Adrian Cox   http://www.humboldt.co.uk/

--------------020309020601050105090501
Content-Type: text/plain;
 name="dma.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dma.patch"

diff --minimal -Nru a/arch/ppc/mm/init.c b/arch/ppc/mm/init.c
--- a/arch/ppc/mm/init.c	Tue Jan  8 14:59:58 2002
+++ b/arch/ppc/mm/init.c	Tue Jan  8 14:59:58 2002
@@ -440,11 +440,18 @@
 	kmap_prot = PAGE_KERNEL;
 #endif /* CONFIG_HIGHMEM */

-	/*
-	 * All pages are DMA-able so we put them all in the DMA zone.
-	 */
-	zones_size[ZONE_DMA] = total_lowmem >> PAGE_SHIFT;
-	for (i = 1; i < MAX_NR_ZONES; i++)
+    	if (ISA_DMA_THRESHOLD && ISA_DMA_THRESHOLD < total_lowmem - 1)
+	{
+		zones_size[ZONE_DMA] = (ISA_DMA_THRESHOLD + 1) >> PAGE_SHIFT;
+		zones_size[ZONE_NORMAL] =
+			(total_lowmem - ISA_DMA_THRESHOLD - 1) >> PAGE_SHIFT;
+	}
+	else
+	{
+	    	zones_size[ZONE_DMA] = total_lowmem >> PAGE_SHIFT;
+	    	zones_size[ZONE_NORMAL] = 0;
+	}
+	for (i = 2; i < MAX_NR_ZONES; i++)
 		zones_size[i] = 0;

 #ifdef CONFIG_HIGHMEM
diff --minimal -Nru a/include/asm-ppc/dma.h b/include/asm-ppc/dma.h
--- a/include/asm-ppc/dma.h	Tue Jan  8 14:59:58 2002
+++ b/include/asm-ppc/dma.h	Tue Jan  8 14:59:58 2002
@@ -37,8 +37,7 @@
 #endif

 /* The maximum address that we can perform a DMA transfer to on this platform */
-/* Doesn't really apply... */
-#define MAX_DMA_ADDRESS		0xFFFFFFFF
+#define MAX_DMA_ADDRESS		ISA_DMA_THRESHOLD

 /* in arch/ppc/kernel/setup.c -- Cort */
 extern unsigned long DMA_MODE_WRITE, DMA_MODE_READ;

--------------020309020601050105090501--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
