Date: Wed, 3 Apr 2002 12:43:22 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Workaround for USB DMA bugs
Message-ID: <20020403024321.GN1026@zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Well, I'm not sure I'd want to pollute the tree with this sort of
hack, but on the other hand it makes things work that wouldn't
otherwise.

Does anyone think it's a good idea to commit the following patch:

diff -urN /home/dgibson/kernel/linuxppc_2_4_devel/arch/ppc/mm/cachemap.c linux-grinch/arch/ppc/mm/cachemap.c
--- /home/dgibson/kernel/linuxppc_2_4_devel/arch/ppc/mm/cachemap.c	Thu Mar 14 13:49:01 2002
+++ linux-grinch/arch/ppc/mm/cachemap.c	Wed Apr  3 11:51:30 2002
@@ -137,7 +137,18 @@
 	case PCI_DMA_NONE:
 		BUG();
 	case PCI_DMA_FROMDEVICE:	/* invalidate only */
+#ifdef CONFIG_USB
+		/* The USB stack is broken in that it uses DMA buffers
+                   on the stack which are on the stack and not
+                   cacheline aligned.  That means cache invalidates
+                   before DMA transfers corrupt the stack on machines
+                   without DMA-consistent cache.  This is a nasty
+                   workaround until the USB layer is fixed (apparently
+                   done in 2.5). */
+		flush_dcache_range(start, end);
+#else
 		invalidate_dcache_range(start, end);
+#endif
 		break;
 	case PCI_DMA_TODEVICE:		/* writeback only */
 		clean_dcache_range(start, end);


--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.  -- H.L. Mencken
http://www.ozlabs.org/people/dgibson


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
