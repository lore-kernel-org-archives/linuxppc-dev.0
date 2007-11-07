Return-Path: <linas@austin.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 5DD67DDE21
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Nov 2007 07:03:57 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e5.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id lA7K3smR029038
	for <linuxppc-dev@ozlabs.org>; Wed, 7 Nov 2007 15:03:54 -0500
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	lA7K3sZU481118
	for <linuxppc-dev@ozlabs.org>; Wed, 7 Nov 2007 15:03:54 -0500
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lA7K3swX012348
	for <linuxppc-dev@ozlabs.org>; Wed, 7 Nov 2007 15:03:54 -0500
Date: Wed, 7 Nov 2007 14:03:53 -0600
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] powerpc/eeh: make sure warning message is printed.
Message-ID: <20071107200353.GF4239@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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


Fix old buglet; a warning message should have been printed 
when a hardware reset takes too long. 

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

----
 arch/powerpc/platforms/pseries/eeh.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.23-rc8-mm1/arch/powerpc/platforms/pseries/eeh.c
===================================================================
--- linux-2.6.23-rc8-mm1.orig/arch/powerpc/platforms/pseries/eeh.c	2007-11-05 16:22:44.000000000 -0600
+++ linux-2.6.23-rc8-mm1/arch/powerpc/platforms/pseries/eeh.c	2007-11-05 16:24:17.000000000 -0600
@@ -325,7 +325,7 @@ eeh_wait_for_slot_status(struct pci_dn *
 
 		if (rets[2] == 0) return -1; /* permanently unavailable */
 
-		if (max_wait_msecs <= 0) return -1;
+		if (max_wait_msecs <= 0) break;
 
 		mwait = rets[2];
 		if (mwait <= 0) {
