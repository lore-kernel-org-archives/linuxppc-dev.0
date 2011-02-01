Return-Path: <shaggy@linux.vnet.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6BB6FB70EE
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  2 Feb 2011 05:49:17 +1100 (EST)
Received: from d01dlp02.pok.ibm.com (d01dlp02.pok.ibm.com [9.56.224.85])
	by e3.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id p11ITGkM005752
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 1 Feb 2011 13:29:53 -0500
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
	by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 475DD4DE8049
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  1 Feb 2011 13:48:40 -0500 (EST)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p11InD26241520
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 1 Feb 2011 13:49:13 -0500
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p11InBCU014243
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 1 Feb 2011 16:49:13 -0200
From: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH V2 1/6] powerpc: Move udbg_early_init() after
	early_init_devtree()
Date: Tue,  1 Feb 2011 12:48:41 -0600
Message-Id: <1296586126-32765-2-git-send-email-shaggy@linux.vnet.ibm.com>
In-Reply-To: <1296586126-32765-1-git-send-email-shaggy@linux.vnet.ibm.com>
References: <1296586126-32765-1-git-send-email-shaggy@linux.vnet.ibm.com>
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
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
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
