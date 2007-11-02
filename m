Return-Path: <linas@austin.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A2E07DDE0D
	for <linuxppc-dev@ozlabs.org>; Sat,  3 Nov 2007 07:27:57 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id lA2KRs3F016768
	for <linuxppc-dev@ozlabs.org>; Fri, 2 Nov 2007 16:27:54 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	lA2KRoRZ084808
	for <linuxppc-dev@ozlabs.org>; Fri, 2 Nov 2007 14:27:51 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lA2KRoMp003261
	for <linuxppc-dev@ozlabs.org>; Fri, 2 Nov 2007 14:27:50 -0600
Date: Fri, 2 Nov 2007 15:27:50 -0500
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 2/3]: powerpc eeh: drivers that need reset trump others
Message-ID: <20071102202750.GB13828@austin.ibm.com>
References: <20071102201957.GU2183@austin.ibm.com>
	<20071102202555.GA13828@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071102202555.GA13828@austin.ibm.com>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Bugfix: if a driver controlling one part of a multi-function
pci card has asked for a reset, honor that request above all 
othres.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

----
 arch/powerpc/platforms/pseries/eeh_driver.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

Index: linux-2.6.23-rc8-mm1/arch/powerpc/platforms/pseries/eeh_driver.c
===================================================================
--- linux-2.6.23-rc8-mm1.orig/arch/powerpc/platforms/pseries/eeh_driver.c	2007-10-16 11:46:30.000000000 -0500
+++ linux-2.6.23-rc8-mm1/arch/powerpc/platforms/pseries/eeh_driver.c	2007-10-16 11:54:27.000000000 -0500
@@ -105,9 +105,10 @@ static void eeh_report_error(struct pci_
 		return;
 
 	rc = driver->err_handler->error_detected (dev, pci_channel_io_frozen);
+
+	/* A driver that needs a reset trumps all others */
+	if (rc == PCI_ERS_RESULT_NEED_RESET) *res = rc;
 	if (*res == PCI_ERS_RESULT_NONE) *res = rc;
-	if (*res == PCI_ERS_RESULT_DISCONNECT &&
-	     rc == PCI_ERS_RESULT_NEED_RESET) *res = rc;
 }
 
 /**
@@ -129,9 +130,10 @@ static void eeh_report_mmio_enabled(stru
 		return;
 
 	rc = driver->err_handler->mmio_enabled (dev);
+
+	/* A driver that needs a reset trumps all others */
+	if (rc == PCI_ERS_RESULT_NEED_RESET) *res = rc;
 	if (*res == PCI_ERS_RESULT_NONE) *res = rc;
-	if (*res == PCI_ERS_RESULT_DISCONNECT &&
-	     rc == PCI_ERS_RESULT_NEED_RESET) *res = rc;
 }
 
 /**
