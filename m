Message-Id: <5.1.0.14.2.20030714210220.0308a070@mail.zultys.com>
Date: Mon, 14 Jul 2003 21:32:07 -0700
To: linuxppc-embedded@lists.linuxppc.org
From: Eugene Surovegin <ebs@ebshome.net>
Subject: [RFC] consistent_sync and non L1 cache line aligned buffers
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi!

I think this is a known problem.

There are drivers or even subsystems which use stack allocated DMA buffers.
To make things worse, those buffers usually non L1 cache line aligned
(start and/or end).

When they use pci_map_* with PCI_DMA_FROMDEVICE, consistent_sync calls
invalidate_dcache_range for the buffer.

invalidate_dcache_range works in L1_CACHE_LINE chunks, so if start and/or
end of the buffer are not aligned we may corrupt data located in the same
cache line (usually stack variable(s) declared before or after buffer
declaration).

According to MV kernel, there are USB devices that use such buffers.

After spending last weekend with RISCWatch :) I can say that SCSI subsystem
is also guilty of this behavior (drivers/scsi/scsi_scan.c::scan_scsis,
scsi_result0).

Unfortunately, I don't know how many similar places of code are still
waiting to be found :(.
To be safe I think it's better to modify consistent_sync to handle such
"bad" buffers.

If start and/or end of the buffer are not properly aligned I use "dcbf" to
flush corresponding cache line(s) and then call invalidate_dcache_range.

This change doesn't affect performance of consistent_sync noticeably (like
in the variant I found in MV kernel, where invalidate_dcache_range was
changed to flush_dcache_range if USB was enabled)

I don't know whether we should "ifdef" this for CONFIG_4xx and I know this
fix is ugly :)
I'm not even sure that such hacks should be included in the kernel :)))
(but I will definitely use it in my tree)

Comments/suggestions are welcome!

Thanks,

Eugene


===== arch/ppc/mm/cachemap.c 1.13 vs edited =====
--- 1.13/arch/ppc/mm/cachemap.c	Thu Feb 27 11:40:16 2003
+++ edited/arch/ppc/mm/cachemap.c	Mon Jul 14 20:49:28 2003
@@ -150,6 +150,21 @@
  	case PCI_DMA_NONE:
  		BUG();
  	case PCI_DMA_FROMDEVICE:	/* invalidate only */
+
+		/* Handle cases when the buffer start and/or end
+		   are not L1 cache line aligned.
+		   Some drivers/subsystems (e.g. USB, SCSI) do DMA
+		   from the stack allocated buffers, to prevent
+		   corruption of the other stack variables located
+		   near the buffer, we flush (instead of invalidate)
+		   these "dangerous" areas                     --ebs
+		*/
+		if (unlikely(start & (L1_CACHE_LINE_SIZE - 1)))
+			__asm__ __volatile__("dcbf 0,%0" : : "r" (start));
+
+		if (unlikely(end & (L1_CACHE_LINE_SIZE - 1)))
+			__asm__ __volatile__("dcbf 0,%0" : : "r" (end));
+
  		invalidate_dcache_range(start, end);
  		break;
  	case PCI_DMA_TODEVICE:		/* writeback only */


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
