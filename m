Return-Path: <clg@kaod.org>
Received: from 1.mo179.mail-out.ovh.net (1.mo179.mail-out.ovh.net
 [178.33.111.220])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xzkH16GbQzDqR8
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Sep 2017 18:37:01 +1000 (AEST)
Received: from player794.ha.ovh.net (b6.ovh.net [213.186.33.56])
 by mo179.mail-out.ovh.net (Postfix) with ESMTP id E069C64C9D
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Sep 2017 10:27:47 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH 2/2] powerpc/xive: fix cpu removal
Date: Sat, 23 Sep 2017 10:26:56 +0200
Message-Id: <20170923082656.27219-3-clg@kaod.org>
In-Reply-To: <20170923082656.27219-1-clg@kaod.org>
References: <20170923082656.27219-1-clg@kaod.org>
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

When a CPU is hot unplugged, the IPI interrupt source should be
deconfigured and the event queue cleared.

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
