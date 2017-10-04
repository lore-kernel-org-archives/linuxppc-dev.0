Return-Path: <clg@kaod.org>
Received: from 10.mo4.mail-out.ovh.net (10.mo4.mail-out.ovh.net
 [188.165.33.109])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y6VnX0XSlzDqs9
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Oct 2017 20:23:27 +1100 (AEDT)
Received: from player746.ha.ovh.net (b6.ovh.net [213.186.33.56])
 by mo4.mail-out.ovh.net (Postfix) with ESMTP id BAC23C461B
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Oct 2017 11:15:26 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v2 2/2] powerpc/xive: clear XIVE internal structures when a
 CPU is removed
Date: Wed,  4 Oct 2017 11:15:05 +0200
Message-Id: <20171004091505.16776-3-clg@kaod.org>
In-Reply-To: <20171004091505.16776-1-clg@kaod.org>
References: <20171004091505.16776-1-clg@kaod.org>
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

Commit eac1e731b59e ("powerpc/xive: guest exploitation of the XIVE
interrupt controller") introduced support for the XIVE exploitation
mode of the P9 interrupt controller on the pseries platform. 

At that time, support for CPU removal was not complete on PowerVM and
CPU hot unplug remained untested. It appears that some cleanups of the
XIVE internal structures are required before releasing the CPU,
without which the kernel crashes in a rtas call doing the CPU
isolation.

These changes fix the crash by deconfiguring the IPI interrupt source
and clearing the event queues of the CPU when it is removed.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 arch/powerpc/sysdev/xive/common.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/powerpc/sysdev/xive/common.c b/arch/powerpc/sysdev/xive/common.c
index 1c087ed7427f..b9440ac7a3c1 100644
--- a/arch/powerpc/sysdev/xive/common.c
+++ b/arch/powerpc/sysdev/xive/common.c
@@ -1398,6 +1398,14 @@ void xive_teardown_cpu(void)
 
 	if (xive_ops->teardown_cpu)
 		xive_ops->teardown_cpu(cpu, xc);
+
+#ifdef CONFIG_SMP
+	/* Get rid of IPI */
+	xive_cleanup_cpu_ipi(cpu, xc);
+#endif
+
+	/* Disable and free the queues */
+	xive_cleanup_cpu_queues(cpu, xc);
 }
 
 void xive_kexec_teardown_cpu(int secondary)
-- 
2.13.5
