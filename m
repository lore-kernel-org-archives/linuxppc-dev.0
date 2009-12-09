Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2DAB8B6F14
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  9 Dec 2009 17:06:50 +1100 (EST)
Received: from [IPv6:::1] (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id nB966g9B007841
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Dec 2009 00:06:43 -0600
Subject: powerpc/pmac: Fixup regression in probe with no media bay
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 09 Dec 2009 17:05:32 +1100
Message-ID: <1260338732.16132.10.camel@pasglop>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

A little thinko in my media bay rework breaks the old IDE driver on machines
with no bay. This fixes it.

Note: I haven't pushed my new -next out yet with my rework in, so I'll locally
fold that patch in the rework to avoid bisection breakage and push the result
into my -next branch

Ben.

Index: linux-work/drivers/ide/pmac.c
===================================================================
--- linux-work.orig/drivers/ide/pmac.c	2009-12-09 16:55:59.000000000 +1100
+++ linux-work/drivers/ide/pmac.c	2009-12-09 16:56:27.000000000 +1100
@@ -1078,7 +1078,8 @@ static int __devinit pmac_ide_setup_devi
 	sanitize_timings(pmif);
 
 	/* If we are on a media bay, wait for it to settle and lock it */
-	lock_media_bay(pmif->mdev->media_bay);
+	if (pmif->mdev)
+		lock_media_bay(pmif->mdev->media_bay);
 
 	host = ide_host_alloc(&d, hws, 1);
 	if (host == NULL) {
@@ -1115,7 +1116,8 @@ static int __devinit pmac_ide_setup_devi
 	if (rc)
 		pmif->hwif = NULL;
 
-	unlock_media_bay(pmif->mdev->media_bay);
+	if (pmif->mdev)
+		unlock_media_bay(pmif->mdev->media_bay);
 
  bail:
 	if (rc && host)
