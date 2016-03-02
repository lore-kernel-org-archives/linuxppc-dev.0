Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 05C2B1A0BB7
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Mar 2016 13:30:26 +1100 (AEDT)
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 2 Mar 2016 12:30:25 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 2EA902CE8057
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Mar 2016 13:30:21 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u222UCts59047940
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Mar 2016 13:30:21 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u222TmHt007443
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Mar 2016 13:29:48 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: ruscur@russell.cc, mpe@ellerman.id.au,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v2 3/3] powerpc/eeh: Synchronize recovery in host/guest
Date: Wed,  2 Mar 2016 13:28:52 +1100
Message-Id: <1456885732-23070-4-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1456885732-23070-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1456885732-23070-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When passing through SRIOV VFs to guest, we possibly encounter EEH
error on PF. In this case, the VF PEs are put into frozen state.
The error could be reported to guest before it's captured by the
host. That means the guest could attempt to recover errors on VFs
before host gets chance to recover errors on PFs. The VFs won't be
recovered successfully.

This enforces the recovery order for above case: the recovery on
child PE in guest is hold until the recovery on parent PE in host
is completed.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
Reviewed-by: Russell Currey <ruscur@russell.cc>
---
 arch/powerpc/kernel/eeh.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index fd9c782..5591f05 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -1541,6 +1541,17 @@ int eeh_pe_get_state(struct eeh_pe *pe)
 	if (!eeh_ops || !eeh_ops->get_state)
 		return -ENOENT;
 
+	/*
+	 * If the parent PE is owned by the host kernel and is undergoing
+	 * error recovery, we should return the PE state as temporarily
+	 * unavailable so that the error recovery on the guest is suspended
+	 * until the recovery completes on the host.
+	 */
+	if (pe->parent &&
+	    !(pe->state & EEH_PE_REMOVED) &&
+	    (pe->parent->state & (EEH_PE_ISOLATED | EEH_PE_RECOVERING)))
+		return EEH_PE_STATE_UNAVAIL;
+
 	result = eeh_ops->get_state(pe, NULL);
 	rst_active = !!(result & EEH_STATE_RESET_ACTIVE);
 	dma_en = !!(result & EEH_STATE_DMA_ENABLED);
-- 
2.1.0
