Message-ID: <3C206A41.1080501@humboldt.co.uk>
Date: Wed, 19 Dec 2001 10:21:53 +0000
From: Adrian Cox <adrian@humboldt.co.uk>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: ISA DMA
Content-Type: multipart/mixed;
 boundary="------------060806090501030401020608"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------060806090501030401020608
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

The current 2.4-devel tree never assigns any memory to the ISA DMA zone,
irrespective of the setting of ISA_DMA_THRESHOLD. As I'm currently
trying to get a floppy working on a platform with 24-bit ISA DMA in its
Southbridge, this looks like a problem.

How do people feel about the attached patch? This should only change
behavior for platforms which set ISA_DMA_THRESHOLD to a value other than
0 or (-1)L.


--
Adrian Cox   http://www.humboldt.co.uk/

--------------060806090501030401020608
Content-Type: text/plain;
 name="isadma.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="isadma.patch"

===== arch/ppc/mm/init.c 1.41 vs edited =====
--- 1.41/arch/ppc/mm/init.c	Fri Nov 30 15:07:14 2001
+++ edited/arch/ppc/mm/init.c	Wed Dec 19 10:15:44 2001
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

--------------060806090501030401020608--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
