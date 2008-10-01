Return-Path: <nfont@austin.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 283EFDDFA4
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Oct 2008 05:44:06 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m91Ji4xT000711
	for <linuxppc-dev@ozlabs.org>; Wed, 1 Oct 2008 15:44:04 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	m91Ji25a181958
	for <linuxppc-dev@ozlabs.org>; Wed, 1 Oct 2008 13:44:02 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m91Ji1bY002267
	for <linuxppc-dev@ozlabs.org>; Wed, 1 Oct 2008 13:44:02 -0600
Received: from austin.ibm.com (netmail2.austin.ibm.com [9.41.248.176])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	m91Ji1sx002257
	for <linuxppc-dev@ozlabs.org>; Wed, 1 Oct 2008 13:44:01 -0600
Received: from [9.53.40.162] (mudbug-009053040162.austin.ibm.com [9.53.40.162])
	by austin.ibm.com (8.13.8/8.12.10) with ESMTP id m91Ji1ZY063908
	for <linuxppc-dev@ozlabs.org>; Wed, 1 Oct 2008 14:44:01 -0500
Message-ID: <48E3D302.5040206@austin.ibm.com>
Date: Wed, 01 Oct 2008 14:44:02 -0500
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: oops in pseries_lmb_remove()
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Testing hotplug memory remove has revealed that we can oops in
pseries_lmb_remove().  The incorrect shift causes a NULL pointer
dereference in the page_zone() inline routine.

I have only been able to reproduce the oops on kernels with large pages
enabled.

Tested on Power5 and Power6 with and without large pages enabled.

Signed-off-by: Nathan Fontenot <nfont@austin.ibm.com>

---

Index: linux-2.6-paulus/arch/powerpc/platforms/pseries/hotplug-memory.c
===================================================================
--- linux-2.6-paulus.orig/arch/powerpc/platforms/pseries/hotplug-memory.c	2008-08-25 13:08:27.000000000 -0500
+++ linux-2.6-paulus/arch/powerpc/platforms/pseries/hotplug-memory.c	2008-10-01 14:20:08.000000000 -0500
@@ -21,7 +21,7 @@
 	struct zone *zone;
 	int ret;
 
-	start_pfn = base >> PFN_SECTION_SHIFT;
+	start_pfn = base >> PAGE_SHIFT;
 	zone = page_zone(pfn_to_page(start_pfn));
 
 	/*
