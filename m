To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: FEC question about setting SIEL register 
In-Reply-To: Message from greyham@research.canon.com.au (Graham Stoney)
   of "Tue, 08 Aug 2000 15:51:21 +1000." <20000808055121.7716D220@elph.research.canon.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 08 Aug 2000 18:33:41 +1000
Message-ID: <23468.965723621@msa.cmst.csiro.au>
From: Murray Jensen <Murray.Jensen@cmst.csiro.au>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, 8 Aug 2000 15:51:21 +1000 (EST), greyham@research.canon.com.au (Graham Stoney) writes:
>Setting the SIEL is trivial enough,

Yes, but this might save you 5 minutes, if you choose to do it in
the kernel :-)

--- arch/ppc/kernel/ppc8xx_pic.c	2000/04/25 11:08:12	1.1.1.4
+++ arch/ppc/kernel/ppc8xx_pic.c	2000/08/08 08:29:59
@@ -156,3 +156,20 @@
 	panic("request_irq");
 #endif
 }
+
+void
+m8xx_set_irq_sense(unsigned int irq_nr, int isedge)
+{
+	volatile uint *psiel = &((immap_t *)IMAP_ADDR)->im_siu_conf.sc_siel;
+	unsigned int mask;
+
+	if (irq_nr >= NR_SIU_INTS || (irq_nr & 1) != 0)
+		panic("m8xx_set_irq_sense got bad irq number (%d)", irq_nr);
+
+	mask = 1 << (31 - irq_nr);
+
+	if (isedge != 0)
+		*psiel |= mask;
+	else
+		*psiel &= ~mask;
+}
--- arch/ppc/kernel/ppc8xx_pic.h	1999/12/20 06:33:23	1.1.1.2
+++ arch/ppc/kernel/ppc8xx_pic.h	2000/01/24 06:49:15	1.3
@@ -18,4 +18,6 @@
 void mbx_i8259_action(int cpl, void *dev_id, struct pt_regs *regs);
 #endif

+void m8xx_set_irq_sense(unsigned int irq_nr, int isedge);
+
 #endif /* _PPC_KERNEL_PPC8xx_H */


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
