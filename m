Return-Path: <nfont@austin.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 359BFDDF3A
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Oct 2008 07:18:25 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e4.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m9DKIN0Q001252
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Oct 2008 16:18:23 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	m9DKIMSs237660
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Oct 2008 16:18:22 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m9DKIMWA024141
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Oct 2008 16:18:22 -0400
Received: from austin.ibm.com (netmail2.austin.ibm.com [9.41.248.176])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	m9DKHmdk021459
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Oct 2008 16:18:22 -0400
Message-ID: <48F39678.9000604@austin.ibm.com>
Date: Mon, 13 Oct 2008 13:42:00 -0500
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc:  pseries_remove_lmb() should validate pfn 
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Badari Pulavarty <pbadari@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The pfn of the memory to be removed should be validated prior to
attempting to remove the memory.  In cases where the probe of a
memory section fails during hotplug add, the pfn for the lmb may
not be valid.

Signed-off-by: Badari Pulavarty <pbadari@us.ibm.com>
Signed-off-by: Nathan Fontenot <nfont@austin.ibm.com>

---

--- linux-2.6.orig/arch/powerpc/platforms/pseries/hotplug-memory.c	2008-10-01 14:20:08.000000000 -0500
+++ linux-2.6/arch/powerpc/platforms/pseries/hotplug-memory.c	2008-10-13 13:19:49.000000000 -0500
@@ -22,6 +22,12 @@
 	int ret;
 
 	start_pfn = base >> PAGE_SHIFT;
+
+	if (!pfn_valid(start_pfn)) {
+		lmb_remove(base, lmb_size);
+		return 0;
+	}
+
 	zone = page_zone(pfn_to_page(start_pfn));
 
 	/*
