To: linuxppc-dev@lists.linuxppc.org
Subject: PowerDomain 3940UWD
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Message-Id: <19990910021436Q.roikawa@rr.iij4u.or.jp>
Date: Fri, 10 Sep 1999 02:14:36 +0900
From: Ryuichi Oikawa <roikawa@rr.iij4u.or.jp>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello all,

I've tried Adaptec PowerDomain 3094UWD, dual channel UW SCSI card
with PCI-PCI bridge and two SCSI controllers under the bridge,
and I noticed driver related and OF related problems.

First I tried vger 2.2.12 kernel that caused machine check exception
at first IO write transaction. I thought that this was normal because
OF didn't properly set up P2P bridge's IO forwarding window.
The real problem was this part(aic7xxx.c):

#ifdef MMAPIO
          if ( !(temp_p->flags & AHC_MULTI_CHANNEL) ||
               ((temp_p->chip != (AHC_AIC7870 | AHC_PCI)) &&
                (temp_p->chip != (AHC_AIC7880 | AHC_PCI))) )
          {
	   ...... select MMIO and does ioremap ....
           ...... if it fails select normal IO ....
	  }
#endif

that rejected my SCSI card from MMIO forcing normal IO resulting in machin
check. So I had to ignore this statement by #if !defined(__powerpc__) ...
#endif statement.

Does anyone know what is this restriction for?


After that aic7xxx.c properly detected two SCSI chips but entered in a
timeout/resetting loop:-(  Apparently interrupts weren't fixed-up by
pcibios_fixup. So I scanned OF searching for correnct IRQ number and
found it at AAPL,interrupts field of P2P bridge. SCSI controllers didn't
have any AAPL,interrupts of course. It seems OF inserts AAPL,interrupts
only at the top node of the slot when it detects a card in the physical
slot. Therefore I had to change arch/ppc/kernel/prom.c as 

--- prom.c.orig	Sun Aug 29 00:22:21 1999
+++ prom.c	Thu Sep  9 22:38:07 1999
@@ -915,8 +915,12 @@
 	}
 
 	ip = (int *) get_property(np, "AAPL,interrupts", &l);
-	if (ip == 0)
-		ip = (int *) get_property(np, "interrupts", &l);
+	if (ip == 0) {
+	  if(get_property(np, "AAPL,slot-name", &l) != 0 && np->parent != 0)
+	    ip = (int *) get_property(np->parent, "AAPL,interrupts", &l);
+	  else
+	    ip = (int *) get_property(np, "interrupts", &l);
+	}
 	if (ip != 0) {
 		np->intrs = (struct interrupt_info *) mem_start;
 		np->n_intrs = l / sizeof(int);

,and now aic7xxx.c is working fine for both SCSI channel.

I don't know if it is OF(PowerMac8500, OF 1.0.5) version specific,
or SCSI card specific, or PowerMac OF nature. Any ideas?


Regards,

Ryuichi Oikawa
roikawa@rr.iij4u.or.jp


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
