Return-Path: <linas@austin.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B1FB8DDE00
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Nov 2007 05:57:31 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id lAFIvShn012069
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Nov 2007 13:57:28 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.6) with ESMTP id
	lAFIvSHa111908
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Nov 2007 13:57:28 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lAFIvSNl028215
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Nov 2007 13:57:28 -0500
Date: Thu, 15 Nov 2007 12:57:27 -0600
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 2/3] powerpc: EEH: careful when identifying "empty" slots.
Message-ID: <20071115185727.GB24772@austin.ibm.com>
References: <20071115185420.GF18745@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071115185420.GF18745@austin.ibm.com>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: munsone@us.ibm.com, linuxppc-dev@ozlabs.org,
	Sandra Rhodes <sdrhodes@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


If an "empty" slot is failing, make sure its a permanent failure;
else process the error normally.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

----
 arch/powerpc/platforms/pseries/eeh.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.23-rc8-mm1/arch/powerpc/platforms/pseries/eeh.c
===================================================================
--- linux-2.6.23-rc8-mm1.orig/arch/powerpc/platforms/pseries/eeh.c	2007-11-09 16:56:39.000000000 -0600
+++ linux-2.6.23-rc8-mm1/arch/powerpc/platforms/pseries/eeh.c	2007-11-09 17:02:39.000000000 -0600
@@ -548,7 +548,7 @@ int eeh_dn_check_failure(struct device_n
 
 	/* Note that config-io to empty slots may fail;
 	 * they are empty when they don't have children. */
-	if ((rets[0] == 5) && (dn->child == NULL)) {
+	if ((rets[0] == 5) && (rets[2] == 0) && (dn->child == NULL)) {
 		false_positives++;
 		pdn->eeh_false_positives ++;
 		rc = 0;
