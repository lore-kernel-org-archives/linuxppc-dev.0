Return-Path: <anton@samba.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8F2371A0B8D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jun 2014 18:16:11 +1000 (EST)
Date: Thu, 12 Jun 2014 18:16:10 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, agraf@suse.de, clg@fr.ibm.com
Subject: [PATCH 3/4] KVM: PPC: Book3S HV: Fix ABIv2 indirect branch issue
Message-ID: <20140612181610.3479c3f2@kryten>
In-Reply-To: <20140612181420.65b05675@kryten>
References: <20140612181420.65b05675@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

To establish addressability quickly, ABIv2 requires the target
address of the function being called to be in r12.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
===================================================================
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -1920,8 +1920,8 @@ hcall_try_real_mode:
 	lwax	r3,r3,r4
 	cmpwi	r3,0
 	beq	guest_exit_cont
-	add	r3,r3,r4
-	mtctr	r3
+	add	r12,r3,r4
+	mtctr	r12
 	mr	r3,r9		/* get vcpu pointer */
 	ld	r4,VCPU_GPR(R4)(r9)
 	bctrl
