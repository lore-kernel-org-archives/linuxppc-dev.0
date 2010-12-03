Return-Path: <r58472@freescale.com>
Received: from VA3EHSOBE004.bigfish.com (va3ehsobe004.messaging.microsoft.com
	[216.32.180.14]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6BAAFB708B
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  3 Dec 2010 22:41:15 +1100 (EST)
Received: from mail173-va3 (localhost.localdomain [127.0.0.1])	by
	mail173-va3-R.bigfish.com (Postfix) with ESMTP id 3ED871B502BA	for
	<linuxppc-dev@lists.ozlabs.org>; Fri,  3 Dec 2010 11:41:10 +0000 (UTC)
Received: from VA3EHSMHS033.bigfish.com (unknown [10.7.14.237])	by
	mail173-va3.bigfish.com (Postfix) with ESMTP id 17C04E0051	for
	<linuxppc-dev@lists.ozlabs.org>; Fri,  3 Dec 2010 11:41:10 +0000 (UTC)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.14.3/8.14.3) with ESMTP id
	oB3Bh8go027219	for
	<linuxppc-dev@lists.ozlabs.org>; Fri, 3 Dec 2010 04:43:08 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id
	oB3BxAdZ018881	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 3 Dec 2010 05:59:11 -0600 (CST)
From: Li Yang <leoli@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 1/7] powerpc/85xx: re-enable timebase sync disabled by KEXEC
	patch
Date: Fri, 3 Dec 2010 20:34:05 +0800
Message-ID: <1291379651-8822-1-git-send-email-leoli@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The timebase sync is not only necessary when using KEXEC.  It should also
be used by normal boot up and cpu hotplug.  Remove the ifdef added by
the KEXEC patch.  Fix a problem that cpu hotplugging freezes the whole system.

Signed-off-by: Jin Qing <b24347@freescale.com>
Singed-off-by: Li Yang <leoli@freescale.com>
---
 arch/powerpc/platforms/85xx/smp.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/smp.c b/arch/powerpc/platforms/85xx/smp.c
index 5c91a99..1e8aec8 100644
--- a/arch/powerpc/platforms/85xx/smp.c
+++ b/arch/powerpc/platforms/85xx/smp.c
@@ -2,7 +2,7 @@
  * Author: Andy Fleming <afleming@freescale.com>
  * 	   Kumar Gala <galak@kernel.crashing.org>
  *
- * Copyright 2006-2008 Freescale Semiconductor Inc.
+ * Copyright 2006-2010 Freescale Semiconductor Inc.
  *
  * This program is free software; you can redistribute  it and/or modify it
  * under  the terms of  the GNU General  Public License as published by the
@@ -115,10 +115,8 @@ smp_85xx_setup_cpu(int cpu_nr)
 
 struct smp_ops_t smp_85xx_ops = {
 	.kick_cpu = smp_85xx_kick_cpu,
-#ifdef CONFIG_KEXEC
 	.give_timebase	= smp_generic_give_timebase,
 	.take_timebase	= smp_generic_take_timebase,
-#endif
 };
 
 #ifdef CONFIG_KEXEC
-- 
1.6.6-rc1.GIT
