Return-Path: <anton@samba.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 586EA1A0A1D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jun 2014 18:16:54 +1000 (EST)
Date: Thu, 12 Jun 2014 18:16:53 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, agraf@suse.de, clg@fr.ibm.com
Subject: [PATCH 4/4] KVM: PPC: Assembly functions exported to modules need
 _GLOBAL_TOC()
Message-ID: <20140612181653.7141a7b8@kryten>
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

Both kvmppc_hv_entry_trampoline and kvmppc_entry_trampoline are
assembly functions that are exported to modules and also require
a valid r2.

As such we need to use _GLOBAL_TOC so we provide a global entry
point that establishes the TOC (r2).

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
===================================================================
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -51,7 +51,7 @@
  *
  * LR = return address to continue at after eventually re-enabling MMU
  */
-_GLOBAL(kvmppc_hv_entry_trampoline)
+_GLOBAL_TOC(kvmppc_hv_entry_trampoline)
 	mflr	r0
 	std	r0, PPC_LR_STKOFF(r1)
 	stdu	r1, -112(r1)
Index: b/arch/powerpc/kvm/book3s_rmhandlers.S
===================================================================
--- a/arch/powerpc/kvm/book3s_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_rmhandlers.S
@@ -140,7 +140,7 @@ kvmppc_handler_skip_ins:
  * On entry, r4 contains the guest shadow MSR
  * MSR.EE has to be 0 when calling this function
  */
-_GLOBAL(kvmppc_entry_trampoline)
+_GLOBAL_TOC(kvmppc_entry_trampoline)
 	mfmsr	r5
 	LOAD_REG_ADDR(r7, kvmppc_handler_trampoline_enter)
 	toreal(r7)
