Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rdRZf2LCXzDqnx
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jun 2016 21:30:50 +1000 (AEST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 23/38] powerpc: Ensure that ppc_md is empty before probing for
 machine type
Date: Mon, 27 Jun 2016 21:29:21 +1000
Message-Id: <1467026976-7974-24-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1467026976-7974-1-git-send-email-benh@kernel.crashing.org>
References: <1467026976-7974-1-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Anything in there will be overwritten, so it helps catching nasty
bugs if we check that it's indeed full of NULL's before we do so.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kernel/setup-common.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 2a3564c..7e85fac 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -575,6 +575,7 @@ void probe_machine(void)
 {
 	extern struct machdep_calls __machine_desc_start;
 	extern struct machdep_calls __machine_desc_end;
+	unsigned int i;
 
 	/*
 	 * Iterate all ppc_md structures until we find the proper
@@ -582,6 +583,16 @@ void probe_machine(void)
 	 */
 	DBG("Probing machine type ...\n");
 
+	/* Check ppc_md is empty, if not we have a bug, ie, we setup an
+	 * entry before probe_machine() which will be overwritten
+	 */
+	for (i = 0; i < (sizeof(ppc_md) / sizeof(void *)); i++) {
+		if (((void **)&ppc_md)[i]) {
+			printk(KERN_ERR "Entry %d in ppc_md non empty before"
+			       " machine probe !\n", i);
+		}
+	}
+
 	for (machine_id = &__machine_desc_start;
 	     machine_id < &__machine_desc_end;
 	     machine_id++) {
-- 
2.7.4
