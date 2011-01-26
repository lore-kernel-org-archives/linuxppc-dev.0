Return-Path: <shaggy@linux.vnet.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E60E1B7130
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 27 Jan 2011 08:51:25 +1100 (EST)
Received: from d01dlp01.pok.ibm.com (d01dlp01.pok.ibm.com [9.56.224.56])
	by e1.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id p0QLfts0009707
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jan 2011 16:42:17 -0500
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
	by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 24D5C728049
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 26 Jan 2011 16:51:22 -0500 (EST)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p0QLpL0J341404
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jan 2011 16:51:21 -0500
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p0QLpJrL005416
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jan 2011 16:51:21 -0500
From: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 1/5] powerpc: Move udbg_early_init() after early_init_devtree()
Date: Wed, 26 Jan 2011 15:51:12 -0600
Message-Id: <1296078676-13940-2-git-send-email-shaggy@linux.vnet.ibm.com>
In-Reply-To: <1296078676-13940-1-git-send-email-shaggy@linux.vnet.ibm.com>
References: <1296078676-13940-1-git-send-email-shaggy@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Dave Kleikamp <shaggy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

so that it can use information from the device tree.

Signed-off-by: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/setup_32.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
index 1d2fbc9..d1ca976 100644
--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -120,12 +120,12 @@ notrace void __init machine_init(unsigned long dt_ptr)
 {
 	lockdep_init();
 
-	/* Enable early debugging if any specified (see udbg.h) */
-	udbg_early_init();
-
 	/* Do some early initialization based on the flat device tree */
 	early_init_devtree(__va(dt_ptr));
 
+	/* Enable early debugging if any specified (see udbg.h) */
+	udbg_early_init();
+
 	probe_machine();
 
 	setup_kdump_trampoline();
-- 
1.7.3.4
