Return-Path: <rickard_strandqvist@spectrumdigital.se>
Received: from mail-wi0-f176.google.com (mail-wi0-f176.google.com
 [209.85.212.176])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A6D4F1A065B
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 Dec 2014 09:39:49 +1100 (AEDT)
Received: by mail-wi0-f176.google.com with SMTP id ex7so5039544wid.9
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Dec 2014 14:39:45 -0800 (PST)
From: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH] arch: powerpc: platforms: embedded6xx: mpc7448_hpc2.c: Remove
 some unused functions
Date: Sat, 20 Dec 2014 23:42:32 +0100
Message-Id: <1419115353-12374-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Removes some functions that are not used anywhere:
mpc7448_hpc2_halt() mpc7448_hpc2_power_off()

This was partially found by using a static code analysis program called cppcheck.

Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
---
 arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c |   11 -----------
 1 file changed, 11 deletions(-)

diff --git a/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c b/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c
index beeaf4a..df4ad95 100644
--- a/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c
+++ b/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c
@@ -156,17 +156,6 @@ void mpc7448_hpc2_restart(char *cmd)
 	for (;;) ;		/* Spin until reset happens */
 }
 
-void mpc7448_hpc2_power_off(void)
-{
-	local_irq_disable();
-	for (;;) ;		/* No way to shut power off with software */
-}
-
-void mpc7448_hpc2_halt(void)
-{
-	mpc7448_hpc2_power_off();
-}
-
 /*
  * Called very early, device-tree isn't unflattened
  */
-- 
1.7.10.4
