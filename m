Return-Path: <clg@kaod.org>
Received: from 3.mo2.mail-out.ovh.net (3.mo2.mail-out.ovh.net [46.105.58.226])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40gGLf1SqkzF1xy
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 May 2018 20:43:51 +1000 (AEST)
Received: from player737.ha.ovh.net (unknown [10.109.105.78])
 by mo2.mail-out.ovh.net (Postfix) with ESMTP id 52649131950
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 May 2018 09:05:38 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v2 1/4] powerpc/64/kexec: fix race in kexec when XIVE is
 shutdown
Date: Tue,  8 May 2018 09:05:14 +0200
Message-Id: <20180508070517.947-2-clg@kaod.org>
In-Reply-To: <20180508070517.947-1-clg@kaod.org>
References: <20180508070517.947-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The kexec_state KEXEC_STATE_IRQS_OFF barrier is reached by all
secondary CPUs before the kexec_cpu_down() operation is called on
secondaries. This can raise conflicts and provoque errors in the XIVE
hcalls when XIVE is shutdown with H_INT_RESET on the primary CPU.

To synchronize the kexec_cpu_down() operations and make sure the
secondaries have completed their task before the primary starts doing
the same, let's move the primary kexec_cpu_down() after the
KEXEC_STATE_REAL_MODE barrier.

This change of the ending sequence of kexec is mostly useful on the
pseries platform but it impacts also the powernv, ps3 and 85xx
platforms. powernv can be easily tested and fixed but some caution is
required for the other two.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 arch/powerpc/kernel/machine_kexec_64.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/machine_kexec_64.c b/arch/powerpc/kernel/machine_kexec_64.c
index 1044bf15d5ed..a0f6f45005bd 100644
--- a/arch/powerpc/kernel/machine_kexec_64.c
+++ b/arch/powerpc/kernel/machine_kexec_64.c
@@ -231,16 +231,16 @@ static void kexec_prepare_cpus(void)
 	/* we are sure every CPU has IRQs off at this point */
 	kexec_all_irq_disabled = 1;
 
-	/* after we tell the others to go down */
-	if (ppc_md.kexec_cpu_down)
-		ppc_md.kexec_cpu_down(0, 0);
-
 	/*
 	 * Before removing MMU mappings make sure all CPUs have entered real
 	 * mode:
 	 */
 	kexec_prepare_cpus_wait(KEXEC_STATE_REAL_MODE);
 
+	/* after we tell the others to go down */
+	if (ppc_md.kexec_cpu_down)
+		ppc_md.kexec_cpu_down(0, 0);
+
 	put_cpu();
 }
 
-- 
2.13.6
