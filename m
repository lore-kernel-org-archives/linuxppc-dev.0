Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D20A91A0BC6
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Mar 2016 10:54:43 +1100 (AEDT)
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Fri, 4 Mar 2016 09:54:43 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id E7EA93578058
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Mar 2016 10:54:37 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u23NsTLF9961906
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 4 Mar 2016 10:54:37 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u23Ns51G002722
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 4 Mar 2016 10:54:05 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: ruscur@russell.cc, mpe@ellerman.id.au,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v15 12/12] powerpc/eeh: Synchronize recovery in host/guest
Date: Fri,  4 Mar 2016 10:53:14 +1100
Message-Id: <1457049194-9281-13-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1457049194-9281-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1457049194-9281-1-git-send-email-gwshan@linux.vnet.ibm.com>
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
index b7338a9..2e39a4d 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -1548,6 +1548,17 @@ int eeh_pe_get_state(struct eeh_pe *pe)
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
