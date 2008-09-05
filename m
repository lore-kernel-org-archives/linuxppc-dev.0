Return-Path: <hannes.hering@gmx.de>
Received: from mtagate2.de.ibm.com (mtagate2.de.ibm.com [195.212.17.162])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate2.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A9AE6DDF5F
	for <linuxppc-dev@ozlabs.org>; Sat,  6 Sep 2008 00:36:37 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate2.de.ibm.com (8.13.1/8.13.1) with ESMTP id m85EaWEC001882
	for <linuxppc-dev@ozlabs.org>; Fri, 5 Sep 2008 14:36:32 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com
	[9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v9.0) with
	ESMTP id m85EaVAT3506234
	for <linuxppc-dev@ozlabs.org>; Fri, 5 Sep 2008 16:36:31 +0200
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id m85EaRqp002922
	for <linuxppc-dev@ozlabs.org>; Fri, 5 Sep 2008 16:36:27 +0200
From: Hannes Hering <hannes.hering@gmx.de>
Subject: [PATCH 1/2] ehea: Fix DLPAR memory handling
Date: Fri, 5 Sep 2008 16:36:26 +0200
MIME-Version: 1.0
To: jeff@garzik.org
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200809051636.26545.hannes.hering@gmx.de>
Cc: themann@de.ibm.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	raisch@de.ibm.com, ossrosch@linux.vnet.ibm.com,
	linuxppc-dev@ozlabs.org, ossthema@de.ibm.com, osstklei@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The ehea busmap must be allocated only once in the first of many calls of the
ehea_create_busmap_callback.

Signed-off-by: Hannes Hering <hering2@de.ibm.com>
---

diff -Nurp -X dontdiff linux-2.6.27-rc5/drivers/net/ehea/ehea_qmr.c patched_kernel/drivers/net/ehea/ehea_qmr.c
--- linux-2.6.27-rc5/drivers/net/ehea/ehea_qmr.c	2008-08-29 00:52:02.000000000 +0200
+++ patched_kernel/drivers/net/ehea/ehea_qmr.c	2008-09-05 15:31:30.000000000 +0200
@@ -595,7 +595,8 @@ static int ehea_create_busmap_callback(u
 	end_section = start_section + ((nr_pages * PAGE_SIZE) / EHEA_SECTSIZE);
 	mr_len = *(unsigned long *)arg;
 
-	ehea_bmap = kzalloc(sizeof(struct ehea_bmap), GFP_KERNEL);
+	if (!ehea_bmap)
+		ehea_bmap = kzalloc(sizeof(struct ehea_bmap), GFP_KERNEL);
 	if (!ehea_bmap)
 		return -ENOMEM;
 
