To: linuxppc-embedded@lists.linuxppc.org
Subject: bug in m8260_mask_and_ack() in Linux/PPC 2.4.x ??
Mime-Version: 1.0
Content-Type: text/plain
Date: Wed, 25 Oct 2000 14:32:28 +1100
Message-ID: <2098.972444748@msa.cmst.csiro.au>
From: Murray Jensen <Murray.Jensen@cmst.csiro.au>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Either I'm going crazy, or this code in m8260_mask_and_ack(), in
arch/ppc/kernel/ppc8260_pic.c from the 2.4.x Linux/PPC source, is wrong...

--- arch/ppc/kernel/ppc8260_pic.c-dist	Wed Oct 25 12:30:37 2000
+++ arch/ppc/kernel/ppc8260_pic.c	Wed Oct 25 13:36:29 2000
@@ -79,7 +79,7 @@
 	sipnr = &(immr->im_intctl.ic_sipnrh);
 	ppc_cached_irq_mask[word] &= ~(1 << (31 - bit));
 	simr[word] = ppc_cached_irq_mask[word];
-	sipnr[word] = 1 << bit;
+	sipnr[word] = 1 << (31 - bit);
 }

 struct hw_interrupt_type ppc8260_pic = {

In my MPC8260 User Manual, the SIMR_[HL] and SIPNR_[HL] have the same
bits in the same positions. Unless this has been changed in errata or
something, the 1 << bit is wrong, it should be 1 << (31 - bit). It seems
like a big obvious bug - maybe m8260_mask_and_ack() is never used...

Could someone confirm this please? Cheers!
								Murray...
--
Murray Jensen, CSIRO Manufacturing Sci & Tech,         Phone: +61 3 9662 7763
Locked Bag No. 9, Preston, Vic, 3072, Australia.         Fax: +61 3 9662 7853
Internet: Murray.Jensen@cmst.csiro.au  (old address was mjj@mlb.dmt.csiro.au)


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
