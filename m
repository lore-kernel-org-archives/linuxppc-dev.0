Return-Path: <linas@austin.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A902DDDE29
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Mar 2007 09:19:17 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l28MJCDH015904
	for <linuxppc-dev@ozlabs.org>; Thu, 8 Mar 2007 17:19:12 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l28MJCLF191636
	for <linuxppc-dev@ozlabs.org>; Thu, 8 Mar 2007 17:19:12 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l28MJCB8014954
	for <linuxppc-dev@ozlabs.org>; Thu, 8 Mar 2007 17:19:12 -0500
Date: Thu, 8 Mar 2007 16:19:11 -0600
To: Bino.Sebastian@Emulex.Com, James Smart <james.smart@Emulex.Com>
Subject: [PATCH] lpfc: avoid double-free during PCI error failure
Message-ID: <20070308221911.GC30703@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: linas@austin.ibm.com (Linas Vepstas)
Cc: James.Bottomley@SteelEye.com, linuxppc-dev@ozlabs.org, rlary@us.ibm.com,
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Bino, James,
Please review, sign-off and forward upstream.

--linas


If a PCI error is detected that cannot be recovered from, there
will be a double call of lpfc_pci_remove_one(), with the second call
resulting in a null-pointer dereference. The first call occurs in 
lpfc_io_error_detected(), and the second call during pci device 
remove. This patch eliminates the first call; its un-needed.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

----
 drivers/scsi/lpfc/lpfc_init.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

Index: linux-2.6.20-git16/drivers/scsi/lpfc/lpfc_init.c
===================================================================
--- linux-2.6.20-git16.orig/drivers/scsi/lpfc/lpfc_init.c	2007-03-08 15:57:40.000000000 -0600
+++ linux-2.6.20-git16/drivers/scsi/lpfc/lpfc_init.c	2007-03-08 16:03:18.000000000 -0600
@@ -1817,10 +1817,9 @@ static pci_ers_result_t lpfc_io_error_de
 	struct lpfc_sli *psli = &phba->sli;
 	struct lpfc_sli_ring  *pring;
 
-	if (state == pci_channel_io_perm_failure) {
-		lpfc_pci_remove_one(pdev);
+	if (state == pci_channel_io_perm_failure)
 		return PCI_ERS_RESULT_DISCONNECT;
-	}
+
 	pci_disable_device(pdev);
 	/*
 	 * There may be I/Os dropped by the firmware.
