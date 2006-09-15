Return-Path: <linas@austin.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 17AAB67B7B
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Sep 2006 09:57:49 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e3.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id k8FNvh3H011491
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Sep 2006 19:57:43 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k8FNvh0L229606
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Sep 2006 19:57:43 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k8FNvhrR027243
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Sep 2006 19:57:43 -0400
Date: Fri, 15 Sep 2006 18:57:42 -0500
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 3/4]: PowerPC: EEH: enable MMIO/DMA on frozen slot
Message-ID: <20060915235742.GT29167@austin.ibm.com>
References: <20060915235025.GQ29167@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060915235025.GQ29167@austin.ibm.com>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



Add wrapper around the rtas call to enable MMIO or DMA
on a frozen pci slot.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

----
 arch/powerpc/platforms/pseries/eeh.c |   29 +++++++++++++++++++++++++++++
 include/asm-powerpc/ppc-pci.h        |   11 +++++++++++
 2 files changed, 40 insertions(+)

Index: linux-2.6.18-rc7-git1/arch/powerpc/platforms/pseries/eeh.c
===================================================================
--- linux-2.6.18-rc7-git1.orig/arch/powerpc/platforms/pseries/eeh.c	2006-09-14 14:44:40.000000000 -0500
+++ linux-2.6.18-rc7-git1/arch/powerpc/platforms/pseries/eeh.c	2006-09-14 15:22:23.000000000 -0500
@@ -482,6 +482,35 @@ eeh_slot_availability(struct pci_dn *pdn
 }
 
 /**
+ * rtas_pci_enable - enable MMIO or DMA transfers for this slot
+ * @pdn pci device node
+ */
+
+int
+rtas_pci_enable(struct pci_dn *pdn, int function)
+{
+	int config_addr;
+	int rc;
+
+	/* Use PE configuration address, if present */
+	config_addr = pdn->eeh_config_addr;
+	if (pdn->eeh_pe_config_addr)
+		config_addr = pdn->eeh_pe_config_addr;
+
+	rc = rtas_call(ibm_set_eeh_option, 4, 1, NULL,
+	               config_addr,
+	               BUID_HI(pdn->phb->buid),
+	               BUID_LO(pdn->phb->buid),
+		            function);
+
+	if (rc)
+		printk(KERN_WARNING "EEH: Cannot enable function %d, err=%d dn=%s\n",
+		        function, rc, pdn->node->full_name);
+
+	return rc;
+}
+
+/**
  * rtas_pci_slot_reset - raises/lowers the pci #RST line
  * @pdn pci device node
  * @state: 1/0 to raise/lower the #RST
Index: linux-2.6.18-rc7-git1/include/asm-powerpc/ppc-pci.h
===================================================================
--- linux-2.6.18-rc7-git1.orig/include/asm-powerpc/ppc-pci.h	2006-09-14 14:44:40.000000000 -0500
+++ linux-2.6.18-rc7-git1/include/asm-powerpc/ppc-pci.h	2006-09-14 15:25:14.000000000 -0500
@@ -69,6 +69,17 @@ struct pci_dev *pci_get_device_by_addr(u
 void eeh_slot_error_detail (struct pci_dn *pdn, int severity);
 
 /**
+ * rtas_pci_enableo - enable IO transfers for this slot
+ * @pdn:       pci device node
+ * @function:  either EEH_THAW_MMIO or EEH_THAW_DMA 
+ *
+ * Enable I/O transfers to this slot 
+ */
+#define EEH_THAW_MMIO 2
+#define EEH_THAW_DMA  3
+int rtas_pci_enable(struct pci_dn *pdn, int function);
+
+/**
  * rtas_set_slot_reset -- unfreeze a frozen slot
  *
  * Clear the EEH-frozen condition on a slot.  This routine
