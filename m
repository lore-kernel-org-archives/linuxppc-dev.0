Return-Path: <rlary@linux.vnet.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e37.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id DFFCC10094A
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 23 Apr 2011 06:00:24 +1000 (EST)
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
	[9.17.195.107])
	by e37.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id p3MJvOdc013452
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Apr 2011 13:57:24 -0600
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p3MK08WE347410
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Apr 2011 14:00:08 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id p3MK07iC010594
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Apr 2011 14:00:08 -0600
Message-ID: <4DB1DE45.1070608@linux.vnet.ibm.com>
Date: Fri, 22 Apr 2011 13:00:05 -0700
From: Richard A Lary <rlary@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/3] powerpc/eeh: Handle functional reset on non-PCIe device
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: antonb@au1.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Richard A Lary <rlary@linux.vnet.ibm.com>

  Fundamental reset is an optional reset type supported only by PCIe adapters.
  Handle the unexpected case where a non-PCIe device has requested a
  fundamental reset. Try hot-reset as a fallback to handle this case.

Signed-off-by: Richard A Lary <rlary@linux.vnet.ibm.com>
---
  arch/powerpc/platforms/pseries/eeh.c |   21 	16 +	5 -	0 !
  1 file changed, 16 insertions(+), 5 deletions(-)

Index: b/arch/powerpc/platforms/pseries/eeh.c
===================================================================
--- a/arch/powerpc/platforms/pseries/eeh.c
+++ b/arch/powerpc/platforms/pseries/eeh.c
@@ -725,15 +725,26 @@ rtas_pci_slot_reset(struct pci_dn *pdn,
  	if (pdn->eeh_pe_config_addr)
  		config_addr = pdn->eeh_pe_config_addr;

-	rc = rtas_call(ibm_set_slot_reset,4,1, NULL,
+	rc = rtas_call(ibm_set_slot_reset, 4, 1, NULL,
  	               config_addr,
  	               BUID_HI(pdn->phb->buid),
  	               BUID_LO(pdn->phb->buid),
  	               state);
-	if (rc)
-		printk (KERN_WARNING "EEH: Unable to reset the failed slot,"
-		        " (%d) #RST=%d dn=%s\n",
-		        rc, state, pdn->node->full_name);
+
+	/* Fundamental-reset not supported on this PE, try hot-reset */
+	if (rc == -8 && state == 3) {
+		state = 1;
+		rc = rtas_call(ibm_set_slot_reset, 4, 1, NULL,
+			       config_addr,
+			       BUID_HI(pdn->phb->buid),
+			       BUID_LO(pdn->phb->buid),
+			       state);
+		if (rc)
+			printk(KERN_WARNING
+				"EEH: Unable to reset the failed slot,"
+				" (%d) #RST=%d dn=%s\n",
+				rc, state, pdn->node->full_name);
+	}
  }

  /**
