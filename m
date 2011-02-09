Return-Path: <shaggy@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e8.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E7B4FB7893
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 10 Feb 2011 10:10:40 +1100 (EST)
Received: from d01dlp01.pok.ibm.com (d01dlp01.pok.ibm.com [9.56.224.56])
	by e8.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id p19ImPhg030085
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Feb 2011 13:52:29 -0500
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by d01dlp01.pok.ibm.com (Postfix) with ESMTP id E4AFC728192
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  9 Feb 2011 18:09:33 -0500 (EST)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p19N8GOI135118
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Feb 2011 18:08:16 -0500
Received: from d03av05.boulder.ibm.com (loopback [127.0.0.1])
	by d03av05.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id p19N8Gte001865
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Feb 2011 16:08:16 -0700
From: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH v3 1/6] powerpc: Move udbg_early_init() after
	early_init_devtree()
Date: Wed,  9 Feb 2011 17:08:08 -0600
Message-Id: <1297292893-30241-2-git-send-email-shaggy@linux.vnet.ibm.com>
In-Reply-To: <1297292893-30241-1-git-send-email-shaggy@linux.vnet.ibm.com>
References: <1297292893-30241-1-git-send-email-shaggy@linux.vnet.ibm.com>
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
