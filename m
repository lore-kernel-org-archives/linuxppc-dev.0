Return-Path: <aik@ozlabs.ru>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qx1h947xVzDqB2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Apr 2016 14:59:21 +1000 (AEST)
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Fri, 29 Apr 2016 14:59:20 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id ED8D02BB0062
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Apr 2016 14:58:56 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3T4wc2t46596234
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Apr 2016 14:58:46 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3T4wEVk010035
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Apr 2016 14:58:14 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Paul Mackerras <paulus@samba.org>,
 kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
Subject: [PATCH kernel] KVM: PPC: Fix debug macros
Date: Fri, 29 Apr 2016 14:57:23 +1000
Message-Id: <1461905843-22673-1-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When XICS_DBG is enabled, gcc produces format errors. This fixes
formats to match passed values types.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/kvm/book3s_xics.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_xics.c b/arch/powerpc/kvm/book3s_xics.c
index 46871d5..95896d7 100644
--- a/arch/powerpc/kvm/book3s_xics.c
+++ b/arch/powerpc/kvm/book3s_xics.c
@@ -280,7 +280,7 @@ static inline bool icp_try_update(struct kvmppc_icp *icp,
 	if (!success)
 		goto bail;
 
-	XICS_DBG("UPD [%04x] - C:%02x M:%02x PP: %02x PI:%06x R:%d O:%d\n",
+	XICS_DBG("UPD [%04lx] - C:%02x M:%02x PP: %02x PI:%06x R:%d O:%d\n",
 		 icp->server_num,
 		 old.cppr, old.mfrr, old.pending_pri, old.xisr,
 		 old.need_resend, old.out_ee);
@@ -336,7 +336,7 @@ static bool icp_try_to_deliver(struct kvmppc_icp *icp, u32 irq, u8 priority,
 	union kvmppc_icp_state old_state, new_state;
 	bool success;
 
-	XICS_DBG("try deliver %#x(P:%#x) to server %#x\n", irq, priority,
+	XICS_DBG("try deliver %#x(P:%#x) to server %#lx\n", irq, priority,
 		 icp->server_num);
 
 	do {
-- 
2.5.0.rc3
