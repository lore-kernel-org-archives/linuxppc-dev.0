Return-Path: <sam.mj@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CADB1A113F
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Jul 2015 11:24:13 +1000 (AEST)
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 16FB0140B0E
 for <linuxppc-dev@ozlabs.org>; Wed,  8 Jul 2015 11:24:12 +1000 (AEST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sam.mj@au1.ibm.com>;
 Wed, 8 Jul 2015 11:24:12 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 687E4357804C
 for <linuxppc-dev@ozlabs.org>; Wed,  8 Jul 2015 11:24:09 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t681NweU27787404
 for <linuxppc-dev@ozlabs.org>; Wed, 8 Jul 2015 11:24:06 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t681NbfF009631
 for <linuxppc-dev@ozlabs.org>; Wed, 8 Jul 2015 11:23:37 +1000
From: Samuel Mendoza-Jonas <sam.mj@au1.ibm.com>
To: linuxppc-dev@ozlabs.org
Cc: Samuel Mendoza-Jonas <sam.mj@au1.ibm.com>
Subject: [PATCH 2/2] powerpc/kexec: Reset HILE before kexec_sequence
Date: Wed,  8 Jul 2015 11:23:25 +1000
Message-Id: <1436318605-13031-2-git-send-email-sam.mj@au1.ibm.com>
In-Reply-To: <1436318605-13031-1-git-send-email-sam.mj@au1.ibm.com>
References: <1436318605-13031-1-git-send-email-sam.mj@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On powernv secondary cpus are returned to OPAL, and will then enter the
target kernel in big-endian. However if it is set the HILE bit will persist,
causing the first exception in the target kernel to be delivered in
litte-endian regardless of the kernel endianess.
Make sure that the HILE bit is switched off before entering
kexec_sequence.

Signed-off-by: Samuel Mendoza-Jonas <sam.mj@au1.ibm.com>
---
 arch/powerpc/kernel/machine_kexec_64.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/powerpc/kernel/machine_kexec_64.c b/arch/powerpc/kernel/machine_kexec_64.c
index 1a74446..2266135c 100644
--- a/arch/powerpc/kernel/machine_kexec_64.c
+++ b/arch/powerpc/kernel/machine_kexec_64.c
@@ -22,8 +22,10 @@
 #include <asm/page.h>
 #include <asm/current.h>
 #include <asm/machdep.h>
+#include <asm/opal.h>
 #include <asm/cacheflush.h>
 #include <asm/paca.h>
+#include <asm/firmware.h>
 #include <asm/mmu.h>
 #include <asm/sections.h>	/* _end */
 #include <asm/prom.h>
@@ -356,6 +358,10 @@ void default_machine_kexec(struct kimage *image)
 	 * switched to a static version!
 	 */
 
+	/* Reset HILE in case we kexec into an older BE kernel */
+	if (firmware_has_feature(FW_FEATURE_OPALv3))
+		opal_reinit_cpus(OPAL_REINIT_CPUS_HILE_BE);
+
 	/* Some things are best done in assembly.  Finding globals with
 	 * a toc is easier in C, so pass in what we can.
 	 */
-- 
2.4.5
