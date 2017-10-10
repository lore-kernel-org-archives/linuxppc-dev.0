Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yBCkS6RMVzDr4W
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Oct 2017 21:18:40 +1100 (AEDT)
Received: by mail-pf0-x241.google.com with SMTP id b85so14163101pfj.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Oct 2017 03:18:40 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	kvm-ppc@vger.kernel.org
Subject: [PATCH] KVM: PPC: Book3S HV: POWER9 more doorbell fixes
Date: Tue, 10 Oct 2017 20:18:28 +1000
Message-Id: <20171010101828.5950-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

- Add another case where msgsync is required.
- Required barrier sequence for global doorbells is msgsync ; lwsync
- POWER9 DD1 has a different barrier sequence that we don't implement,
  so remove

When msgsnd is used for IPIs to other cores, msgsync must be executed by
the target to order stores performed on the source before its msgsnd
(provided the source executes the appropriate sync).

Fixes: 1704a81ccebc ("KVM: PPC: Book3S HV: Use msgsnd for IPIs to other cores on POWER9")
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kvm/book3s_hv_rmhandlers.S | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index 663a4a861e7f..90c07421eba2 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -1300,6 +1300,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
 	bne	3f
 BEGIN_FTR_SECTION
 	PPC_MSGSYNC
+	lwsync
 END_FTR_SECTION_IFSET(CPU_FTR_ARCH_300)
 	lbz	r0, HSTATE_HOST_IPI(r13)
 	cmpwi	r0, 0
@@ -2761,6 +2762,10 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
 	PPC_MSGCLR(6)
 	/* see if it's a host IPI */
 	li	r3, 1
+BEGIN_FTR_SECTION
+	PPC_MSGSYNC
+	lwsync
+END_FTR_SECTION_IFSET(CPU_FTR_ARCH_300)
 	lbz	r0, HSTATE_HOST_IPI(r13)
 	cmpwi	r0, 0
 	bnelr
-- 
2.13.3
