Return-Path: <linas@austin.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0826FDDE22
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Mar 2007 06:51:04 +1100 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l2JJp19P007206
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Mar 2007 15:51:01 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by westrelay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l2JJp138055872
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Mar 2007 13:51:01 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l2JJp1ba022681
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Mar 2007 13:51:01 -0600
Date: Mon, 19 Mar 2007 14:51:00 -0500
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 1/11] ppc64: EEH: modify order of EEH state checking
Message-ID: <20070319195100.GA11532@austin.ibm.com>
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


Change the order in which pci error state is examined;
the "capabilites" is not valid if "reset state" is 5.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

----
 arch/powerpc/platforms/pseries/eeh.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

Index: linux-2.6.21-rc4-git4/arch/powerpc/platforms/pseries/eeh.c
===================================================================
--- linux-2.6.21-rc4-git4.orig/arch/powerpc/platforms/pseries/eeh.c	2007-03-19 12:51:09.000000000 -0500
+++ linux-2.6.21-rc4-git4/arch/powerpc/platforms/pseries/eeh.c	2007-03-19 13:19:26.000000000 -0500
@@ -367,6 +367,14 @@ int eeh_dn_check_failure(struct device_n
 		goto dn_unlock;
 	}
 
+	/* Note that config-io to empty slots may fail;
+	 * they are empty when they don't have children. */
+	if ((rets[0] == 5) && (dn->child == NULL)) {
+		false_positives++;
+		rc = 0;
+		goto dn_unlock;
+	}
+
 	/* If EEH is not supported on this device, punt. */
 	if (rets[1] != 1) {
 		printk(KERN_WARNING "EEH: event on unsupported device, rc=%d dn=%s\n",
@@ -383,14 +391,6 @@ int eeh_dn_check_failure(struct device_n
 		goto dn_unlock;
 	}
 
-	/* Note that config-io to empty slots may fail;
-	 * we recognize empty because they don't have children. */
-	if ((rets[0] == 5) && (dn->child == NULL)) {
-		false_positives++;
-		rc = 0;
-		goto dn_unlock;
-	}
-
 	slot_resets++;
  
 	/* Avoid repeated reports of this failure, including problems
