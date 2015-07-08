Return-Path: <sam.mj@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A9E3A1A1D20
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Jul 2015 14:37:59 +1000 (AEST)
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 747E1140B0D
 for <linuxppc-dev@ozlabs.org>; Wed,  8 Jul 2015 14:37:59 +1000 (AEST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sam.mj@au1.ibm.com>;
 Wed, 8 Jul 2015 14:37:59 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id AFF0D2CE8052
 for <linuxppc-dev@ozlabs.org>; Wed,  8 Jul 2015 14:37:57 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t684bnT050135094
 for <linuxppc-dev@ozlabs.org>; Wed, 8 Jul 2015 14:37:57 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t684bPwg007406
 for <linuxppc-dev@ozlabs.org>; Wed, 8 Jul 2015 14:37:25 +1000
From: Samuel Mendoza-Jonas <sam.mj@au1.ibm.com>
To: linuxppc-dev@ozlabs.org
Cc: Samuel Mendoza-Jonas <sam.mj@au1.ibm.com>
Subject: [PATCH V2 2/2] powerpc/kexec: Reset HILE before kexec_sequence
Date: Wed,  8 Jul 2015 14:37:13 +1000
Message-Id: <1436330233-28489-2-git-send-email-sam.mj@au1.ibm.com>
In-Reply-To: <1436330233-28489-1-git-send-email-sam.mj@au1.ibm.com>
References: <1436330233-28489-1-git-send-email-sam.mj@au1.ibm.com>
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
