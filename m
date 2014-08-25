Return-Path: <shreyas@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6B3AB1A15CE
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Aug 2014 04:02:00 +1000 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shreyas@linux.vnet.ibm.com>;
 Mon, 25 Aug 2014 14:01:58 -0400
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 7193BC90026
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Aug 2014 14:01:47 -0400 (EDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s7PI1tpC65142938
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Aug 2014 18:01:55 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s7PI1rgK010829
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Aug 2014 14:01:55 -0400
From: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 5/9] powerpc/powernv: Add OPAL call to save and restore
Date: Mon, 25 Aug 2014 23:31:09 +0530
Message-Id: <1408989673-14137-6-git-send-email-shreyas@linux.vnet.ibm.com>
In-Reply-To: <1408989673-14137-1-git-send-email-shreyas@linux.vnet.ibm.com>
References: <1408989673-14137-1-git-send-email-shreyas@linux.vnet.ibm.com>
Cc: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

PORE can be programmed to restore hypervisor registers when waking up
from deep cpu idle states like winkle.

Add call to pass SPR address and value to OPAL, which in turn will
program PORE to restore the register state.

Cc: linuxppc-dev@lists.ozlabs.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Suggested-by: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Signed-off-by: Shreyas B. Prabhu <shreyas@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/opal.h                | 2 ++
 arch/powerpc/platforms/powernv/opal-wrappers.S | 1 +
 2 files changed, 3 insertions(+)

diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 166d572..d376020 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -150,6 +150,7 @@ struct opal_sg_list {
 #define OPAL_PCI_EEH_FREEZE_SET			97
 #define OPAL_HANDLE_HMI				98
 #define OPAL_CONFIG_IDLE_STATE			99
+#define OPAL_SLW_SET_REG			100
 #define OPAL_REGISTER_DUMP_REGION		101
 #define OPAL_UNREGISTER_DUMP_REGION		102
 
@@ -978,6 +979,7 @@ extern int opal_handle_hmi_exception(struct pt_regs *regs);
 extern void opal_shutdown(void);
 extern int opal_resync_timebase(void);
 int64_t opal_config_idle_state(uint64_t state, uint64_t enter);
+int64_t opal_slw_set_reg(uint64_t cpu_pir, uint64_t sprn, uint64_t val);
 
 extern void opal_lpc_init(void);
 
diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
index 8d1e724..12e5d46 100644
--- a/arch/powerpc/platforms/powernv/opal-wrappers.S
+++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
@@ -246,5 +246,6 @@ OPAL_CALL(opal_get_param,			OPAL_GET_PARAM);
 OPAL_CALL(opal_set_param,			OPAL_SET_PARAM);
 OPAL_CALL(opal_handle_hmi,			OPAL_HANDLE_HMI);
 OPAL_CALL(opal_config_idle_state,		OPAL_CONFIG_IDLE_STATE);
+OPAL_CALL(opal_slw_set_reg,			OPAL_SLW_SET_REG);
 OPAL_CALL(opal_register_dump_region,		OPAL_REGISTER_DUMP_REGION);
 OPAL_CALL(opal_unregister_dump_region,		OPAL_UNREGISTER_DUMP_REGION);
-- 
1.9.0
