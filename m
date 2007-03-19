Return-Path: <linas@austin.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id AAF5DDE074
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Mar 2007 06:55:56 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l2JJtp4Q011803
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Mar 2007 15:55:51 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l2JJtpc6313842
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Mar 2007 15:55:51 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l2JJtprj008335
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Mar 2007 15:55:51 -0400
Date: Mon, 19 Mar 2007 14:55:51 -0500
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 6/11] ppc64: EEH: multifunction recovery bugfix
Message-ID: <20070319195551.GF11532@austin.ibm.com>
References: <20070319194349.GT5151@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070319194349.GT5151@austin.ibm.com>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



If the second or higher function of a multi-function device fails 
to recover, this failure is not reported upwards. Fix this.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

----
 arch/powerpc/platforms/pseries/eeh_driver.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: linux-2.6.21-rc4-git4/arch/powerpc/platforms/pseries/eeh_driver.c
===================================================================
--- linux-2.6.21-rc4-git4.orig/arch/powerpc/platforms/pseries/eeh_driver.c	2007-03-19 13:21:06.000000000 -0500
+++ linux-2.6.21-rc4-git4/arch/powerpc/platforms/pseries/eeh_driver.c	2007-03-19 13:21:35.000000000 -0500
@@ -158,7 +158,8 @@ static void eeh_report_reset(struct pci_
 		return;
 
 	rc = driver->err_handler->slot_reset(dev);
-	if (*res == PCI_ERS_RESULT_NONE) *res = rc;
+	if ((*res == PCI_ERS_RESULT_NONE) ||
+	    (*res == PCI_ERS_RESULT_RECOVERED)) *res = rc;
 	if (*res == PCI_ERS_RESULT_DISCONNECT &&
 	     rc == PCI_ERS_RESULT_NEED_RESET) *res = rc;
 }
