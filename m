Date: Wed, 02 May 2001 14:44:39 -0400
From: Ira Weiny <iweiny@acm.org>
Subject: Creative SBLive card
To: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Message-id: <3AF05597.F7D0C433@acm.org>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="------------5F88F4046AD8E59D5769958F"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------5F88F4046AD8E59D5769958F
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

I had the chance to work on getting an SBLive card running on my G3 the
other day.  The fix is basic and is
in the following patch if anyone is interested.  I have only testing for
sound output though.

Ira



--------------5F88F4046AD8E59D5769958F
Content-Type: text/plain; charset=us-ascii;
 name="emu10k1.ppc.patch"
Content-Disposition: inline;
 filename="emu10k1.ppc.patch"
Content-Transfer-Encoding: 7bit

diff -r -U 5 linux.orig/drivers/sound/emu10k1/cardwo.c linux/drivers/sound/emu10k1/cardwo.c
--- linux.orig/drivers/sound/emu10k1/cardwo.c	Sat Mar  3 12:51:48 2001
+++ linux/drivers/sound/emu10k1/cardwo.c	Tue May  1 15:43:01 2001
@@ -85,11 +85,12 @@

 			DPD(3, "Bus Addx: %lx\n", busaddx);

 			pageindex = buffer->emupageindex + pagecount * PAGE_SIZE / EMUPAGESIZE + i;

-			((u32 *) card->virtualpagetable.addr)[pageindex] = (busaddx * 2) | pageindex;
+			((u32 *) card->virtualpagetable.addr)[pageindex] =
+            cpu_to_le32((busaddx * 2) | pageindex);
 		}
 	}

 	return 0;
 }
diff -r -U 5 linux.orig/drivers/sound/emu10k1/main.c linux/drivers/sound/emu10k1/main.c
--- linux.orig/drivers/sound/emu10k1/main.c	Sat Mar  3 12:51:07 2001
+++ linux/drivers/sound/emu10k1/main.c	Tue May  1 15:42:29 2001
@@ -473,11 +473,12 @@
 		pci_free_consistent(card->pci_dev, card->virtualpagetable.size, card->virtualpagetable.addr, card->virtualpagetable.dma_handle);
 		return -1;
 	}

 	for (pagecount = 0; pagecount < MAXPAGES; pagecount++)
-		((u32 *) card->virtualpagetable.addr)[pagecount] = (card->silentpage.dma_handle * 2) | pagecount;
+		((u32 *) card->virtualpagetable.addr)[pagecount] =
+         cpu_to_le32((card->silentpage.dma_handle * 2) | pagecount);

 	/* Init page table & tank memory base register */
 	sblive_writeptr_tag(card, 0,
 			    PTB, card->virtualpagetable.dma_handle,
 			    TCB, 0,

--------------5F88F4046AD8E59D5769958F--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
