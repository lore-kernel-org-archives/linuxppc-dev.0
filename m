Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 204CC1A070C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 May 2014 14:43:56 +1000 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Wed, 28 May 2014 00:43:54 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 4FFA5C9003E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 May 2014 00:43:46 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp22034.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s4S4hp8q2818374
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 May 2014 04:43:51 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s4S4hoBf021237
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 May 2014 00:43:51 -0400
Subject: [PATCH 4/6] KVM: PPC: Book3S HV: Consolidate the idle-state enter
 sequence in KVM
To: benh@kernel.crashing.org, linux-kernel@vger.kernel.org,
 svaidyan@in.ibm.com, paulus@samba.org,
 srivatsa.bhat@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Date: Wed, 28 May 2014 10:09:12 +0530
Message-ID: <20140528043912.15676.7002.stgit@preeti.in.ibm.com>
In-Reply-To: <20140528043703.15676.58580.stgit@preeti.in.ibm.com>
References: <20140528043703.15676.58580.stgit@preeti.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>

Now that the support for fast sleep idle state is present, the KVM
standby threads can be put to fast sleep when they are either idle
or do not have a guest to run. Today they enter nap in these scenarios.
The purpose is to gain maximum power savings in a KVM scenario as well
when an entire cpu core is idle.

As a precursor, consolidate the code common across all idle states.

Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
[ Changelog added by <preeti@linux.vnet.ibm.com> ]
Signed-off-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>
---

 arch/powerpc/kvm/book3s_hv_rmhandlers.S |   30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index b031f93..43aa806 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -40,6 +40,17 @@
 #define NAPPING_CEDE	1
 #define NAPPING_NOVCPU	2
 
+#define IDLE_STATE_ENTER_SEQ_HV(IDLE_INST)			\
+	/* Magic NAP/SLEEP/WINKLE mode enter sequence */	\
+	std	r0, HSTATE_SCRATCH0(r13);			\
+	ptesync;						\
+	ld	r0, HSTATE_SCRATCH0(r13);			\
+1:	cmpd	r0, r0;						\
+	bne	1b;						\
+	IDLE_INST;						\
+	b	.
+
+
 /*
  * Call kvmppc_hv_entry in real mode.
  * Must be called with interrupts hard-disabled.
@@ -325,13 +336,9 @@ kvm_do_nap:
 	rlwimi	r4, r3, 0, LPCR_PECE0 | LPCR_PECE1
 	mtspr	SPRN_LPCR, r4
 	isync
-	std	r0, HSTATE_SCRATCH0(r13)
-	ptesync
-	ld	r0, HSTATE_SCRATCH0(r13)
-1:	cmpd	r0, r0
-	bne	1b
-	nap
-	b	.
+	IDLE_STATE_ENTER_SEQ_HV(PPC_NAP)
+	/* No return */
+
 
 /******************************************************************************
  *                                                                            *
@@ -2027,13 +2034,8 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
 	mtspr	SPRN_LPCR,r5
 	isync
 	li	r0, 0
-	std	r0, HSTATE_SCRATCH0(r13)
-	ptesync
-	ld	r0, HSTATE_SCRATCH0(r13)
-1:	cmpd	r0, r0
-	bne	1b
-	nap
-	b	.
+	IDLE_STATE_ENTER_SEQ_HV(PPC_NAP)
+	/* No return */
 
 33:	mr	r4, r3
 	li	r3, 0
