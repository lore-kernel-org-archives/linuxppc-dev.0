Return-Path: <msm@freescale.com>
Received: from VA3EHSOBE008.bigfish.com (va3ehsobe006.messaging.microsoft.com
	[216.32.180.16]) by ozlabs.org (Postfix) with ESMTP id AA4241007D8
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Sep 2010 08:49:21 +1000 (EST)
Received: from mail7-va3 (localhost.localdomain [127.0.0.1])	by
	mail7-va3-R.bigfish.com (Postfix) with ESMTP id 57D756025E	for
	<linuxppc-dev@ozlabs.org>; Thu, 16 Sep 2010 22:49:18 +0000 (UTC)
Received: from VA3EHSMHS018.bigfish.com (unknown [10.7.14.237])	by
	mail7-va3.bigfish.com (Postfix) with ESMTP id 305231B7004D	for
	<linuxppc-dev@ozlabs.org>; Thu, 16 Sep 2010 22:49:18 +0000 (UTC)
Received: from az33smr01.freescale.net (az33smr01.freescale.net
	[10.64.34.199])	by de01egw02.freescale.net (8.14.3/8.14.3) with ESMTP
	id o8GMnG5U012785	for <linuxppc-dev@ozlabs.org>;
	Thu, 16 Sep 2010 15:49:16 -0700 (MST)
From: Matthew McClintock <msm@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/4] powerpc/85xx: Remove call to mpic_teardown_this_cpu in
	kexec
Date: Thu, 16 Sep 2010 17:58:24 -0500
Message-ID: <1284677906-23787-2-git-send-email-msm@freescale.com>
In-Reply-To: <1284677906-23787-1-git-send-email-msm@freescale.com>
References: <1284677906-23787-1-git-send-email-msm@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Matthew McClintock <msm@freescale.com>, kumar.gala@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We no longer need to call this explicitly as a generic version is
called by default

Signed-off-by: Matthew McClintock <msm@freescale.com>
---
 arch/powerpc/platforms/85xx/smp.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/smp.c b/arch/powerpc/platforms/85xx/smp.c
index a6b1065..cb8ad3b 100644
--- a/arch/powerpc/platforms/85xx/smp.c
+++ b/arch/powerpc/platforms/85xx/smp.c
@@ -118,8 +118,6 @@ static int kexec_down_cpus = 0;
 
 void mpc85xx_smp_kexec_cpu_down(int crash_shutdown, int secondary)
 {
-	mpic_teardown_this_cpu(1);
-
 	/* When crashing, this gets called on all CPU's we only
 	 * take down the non-boot cpus */
 	if (smp_processor_id() != boot_cpuid)
-- 
1.6.6.1
