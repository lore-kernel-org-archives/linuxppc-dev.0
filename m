Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 32462B6F8B
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 10 Mar 2011 10:00:33 +1100 (EST)
Subject: [PATCH] powerpc/pseries: Disable VPNH feature
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 10 Mar 2011 10:00:14 +1100
Message-ID: <1299711614.22236.392.camel@pasglop>
Mime-Version: 1.0
Cc: Jesse Larrew <jlarrew@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This feature triggers nasty races in the scheduler between the
rebuilding of the topology and the load balancing code, causing
the machine to hang.

Disable it for now until the races are fixed.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

Jesse: I'm sending that to Linus now. We'll sort things out for the
next release.

diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index fd48123..74f1baa 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -1516,6 +1516,7 @@ int start_topology_update(void)
 {
 	int rc = 0;
 
+#if 0 /* Disabled until races with load balancing are fixed */
 	if (firmware_has_feature(FW_FEATURE_VPHN) &&
 	    get_lppaca()->shared_proc) {
 		vphn_enabled = 1;
@@ -1524,6 +1525,7 @@ int start_topology_update(void)
 		set_topology_timer();
 		rc = 1;
 	}
+#endif
 
 	return rc;
 }
