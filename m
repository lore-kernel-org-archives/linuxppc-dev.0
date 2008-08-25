Return-Path: <nfont@austin.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 64F23DE089
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Aug 2008 05:34:37 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m7PJXYbu005231
	for <linuxppc-dev@ozlabs.org>; Mon, 25 Aug 2008 15:33:34 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m7PJXYbs194898
	for <linuxppc-dev@ozlabs.org>; Mon, 25 Aug 2008 13:33:34 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m7PJXYNo007780
	for <linuxppc-dev@ozlabs.org>; Mon, 25 Aug 2008 13:33:34 -0600
Received: from austin.ibm.com (netmail2.austin.ibm.com [9.41.248.176])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	m7PJXX4q007765
	for <linuxppc-dev@ozlabs.org>; Mon, 25 Aug 2008 13:33:34 -0600
Received: from [9.53.40.161] (mudbug-009053040161.austin.ibm.com [9.53.40.161])
	by austin.ibm.com (8.13.8/8.12.10) with ESMTP id m7PJXXXD042802
	for <linuxppc-dev@ozlabs.org>; Mon, 25 Aug 2008 14:33:33 -0500
Message-ID: <48B3090E.70606@austin.ibm.com>
Date: Mon, 25 Aug 2008 14:33:34 -0500
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Check rc of notifier chain for memory remove
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The return code from invocation of the notifier for
pSeries_reconfig_chain during update of the device tree is not 
checked.  This causes writes to /proc/ppc64/ofdt to update memory
properties (i.e. ibm,dyamic-reconfiguration-memory) to always 
return success, instead of the result of the notifier chain.

This happens specifically when we remove/add memory from the
device tree on machines using memory specified in the
ibm,dynamic-reconfiguration-memory property of the device tree.

Signed-off-by: Nathan Fontenot <nfont@austin.ibm.com>
---

Index: linux-2.6-paulus/arch/powerpc/platforms/pseries/reconfig.c
===================================================================
--- linux-2.6-paulus.orig/arch/powerpc/platforms/pseries/reconfig.c	2008-08-25 13:08:27.000000000 -0500
+++ linux-2.6-paulus/arch/powerpc/platforms/pseries/reconfig.c	2008-08-25 13:45:12.000000000 -0500
@@ -466,11 +466,11 @@
 		else
 			action = PSERIES_DRCONF_MEM_REMOVE;
 
-		blocking_notifier_call_chain(&pSeries_reconfig_chain,
-					     action, value);
+		rc = blocking_notifier_call_chain(&pSeries_reconfig_chain,
+						  action, value);
 	}
 
-	return 0;
+	return rc;
 }
 
 /**
