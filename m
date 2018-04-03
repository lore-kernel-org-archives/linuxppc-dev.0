Return-Path: <clg@kaod.org>
Received: from 6.mo4.mail-out.ovh.net (6.mo4.mail-out.ovh.net [188.165.36.253])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40Fj7q37jqzF265
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Apr 2018 18:34:47 +1000 (AEST)
Received: from player716.ha.ovh.net (unknown [10.109.122.15])
 by mo4.mail-out.ovh.net (Postfix) with ESMTP id 2E76B159805
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Apr 2018 09:16:01 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH 1/4] powerpc/64/kexec: fix race in kexec when XIVE is
 shutdowned
Date: Tue,  3 Apr 2018 09:15:45 +0200
Message-Id: <20180403071548.19829-2-clg@kaod.org>
In-Reply-To: <20180403071548.19829-1-clg@kaod.org>
References: <20180403071548.19829-1-clg@kaod.org>
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
hcalls when XIVE is shutdowned with H_INT_RESET on the primary CPU.

To synchronize the kexec_cpu_down() operations and make sure the
secondaries have completed their task before the primary starts doing
the same, let's move the primary kexec_cpu_down() after the
KEXEC_STATE_REAL_MODE barrier.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 arch/powerpc/kernel/machine_kexec_64.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/machine_kexec_64.c b/arch/powerpc/kernel/machine_kexec_64.c
index 49d34d7271e7..212ecb8e829c 100644
--- a/arch/powerpc/kernel/machine_kexec_64.c
+++ b/arch/powerpc/kernel/machine_kexec_64.c
@@ -230,16 +230,16 @@ static void kexec_prepare_cpus(void)
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
