Return-Path: <sam.mj@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 062251A1A46
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jul 2015 15:51:27 +1000 (AEST)
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 84D541402C8
 for <linuxppc-dev@ozlabs.org>; Wed, 22 Jul 2015 15:51:26 +1000 (AEST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sam.mj@au1.ibm.com>;
 Wed, 22 Jul 2015 15:51:26 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 7B0E9357804C
 for <linuxppc-dev@ozlabs.org>; Wed, 22 Jul 2015 15:51:21 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t6M5pDqd22675560
 for <linuxppc-dev@ozlabs.org>; Wed, 22 Jul 2015 15:51:21 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6M5omRb029863
 for <linuxppc-dev@ozlabs.org>; Wed, 22 Jul 2015 15:50:49 +1000
From: Samuel Mendoza-Jonas <sam.mj@au1.ibm.com>
To: linuxppc-dev@ozlabs.org
Cc: Samuel Mendoza-Jonas <sam.mj@au1.ibm.com>, benh@kernel.crashing.org,
 mpe@ellerman.id.au
Subject: [PATCH V4 2/2] powerpc/kexec: Reset HILE before kexec_sequence
Date: Wed, 22 Jul 2015 15:50:51 +1000
Message-Id: <1437544251-19016-3-git-send-email-sam.mj@au1.ibm.com>
In-Reply-To: <1437544251-19016-1-git-send-email-sam.mj@au1.ibm.com>
References: <1437544251-19016-1-git-send-email-sam.mj@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On powernv secondary cpus are returned to OPAL, and will then enter
the target kernel in big-endian. However if it is set the HILE bit
will persist, causing the first exception in the target kernel to be
delivered in litte-endian regardless of the current endianess.

If running on top of OPAL make sure the HILE bit is reset once we've
finished waiting for all of the secondaries to be returned to OPAL.

Signed-off-by: Samuel Mendoza-Jonas <sam.mj@au1.ibm.com>
---
 arch/powerpc/platforms/powernv/setup.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platforms/powernv/setup.c
index 53737e0..59076db 100644
--- a/arch/powerpc/platforms/powernv/setup.c
+++ b/arch/powerpc/platforms/powernv/setup.c
@@ -243,6 +243,13 @@ static void pnv_kexec_cpu_down(int crash_shutdown, int secondary)
 	} else {
 		/* Primary waits for the secondaries to have reached OPAL */
 		pnv_kexec_wait_secondaries_down();
+
+		/*
+		 * We might be running as little-endian - now that interrupts
+		 * are disabled, reset the HILE bit to big-endian so we don't
+		 * take interrupts in the wrong endian later
+		 */
+		opal_reinit_cpus(OPAL_REINIT_CPUS_HILE_BE);
 	}
 }
 #endif /* CONFIG_KEXEC */
-- 
2.4.6
