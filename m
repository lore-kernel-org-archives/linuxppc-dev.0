Return-Path: <nfont@austin.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e9.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 69222DDDB2
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Mar 2009 06:53:24 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e9.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n25Jj1IH010112
	for <linuxppc-dev@ozlabs.org>; Thu, 5 Mar 2009 14:45:01 -0500
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n25JrI9J170938
	for <linuxppc-dev@ozlabs.org>; Thu, 5 Mar 2009 14:53:20 -0500
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n25JrIaI014001
	for <linuxppc-dev@ozlabs.org>; Thu, 5 Mar 2009 14:53:18 -0500
Received: from [9.53.40.180] (mudbug-009053040180.austin.ibm.com [9.53.40.180])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	n25JrG9w013801
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Thu, 5 Mar 2009 14:53:18 -0500
Message-ID: <49B02DB5.7020301@austin.ibm.com>
Date: Thu, 05 Mar 2009 13:53:25 -0600
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/pseries failed reconfig notifier chain call cleanup
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The return code from invoking the notifier chain when updating the
ibm,dynamic-memory property is not handled properly. In failure
cases (rc == NOTIFY_BAD) we should be restoring the original value
of the property.  In success (rc == NOTIFY_OK) we should be returning
zero from the calling routine.
 
Signed-off-by: Nathan Fontenot <nfont@austin.ibm.com>
---
 arch/powerpc/platforms/pseries/reconfig.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

Index: linux-2.6/arch/powerpc/platforms/pseries/reconfig.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/pseries/reconfig.c	2008-10-23 22:29:24.000000000 -0500
+++ linux-2.6/arch/powerpc/platforms/pseries/reconfig.c	2009-03-05 13:20:00.000000000 -0600
@@ -468,9 +468,13 @@
 
 		rc = blocking_notifier_call_chain(&pSeries_reconfig_chain,
 						  action, value);
+		if (rc == NOTIFY_BAD) {
+			rc = prom_update_property(np, oldprop, newprop);
+			return -ENOMEM;
+		}
 	}
 
-	return rc;
+	return 0;
 }
 
 /**
