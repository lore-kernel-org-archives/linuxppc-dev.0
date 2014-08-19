Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F6CD1A03CE
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Aug 2014 14:59:33 +1000 (EST)
From: Michael Neuling <mikey@neuling.org>
To: Alexander Graf <agraf@suse.de>,
	Paul Mackerras <paulus@samba.org>
Subject: [PATCH 2/2] KVM: PPC: Book3S HV: Add register name when loading toc
Date: Tue, 19 Aug 2014 14:59:30 +1000
Message-Id: <1408424370-16960-2-git-send-email-mikey@neuling.org>
In-Reply-To: <1408424370-16960-1-git-send-email-mikey@neuling.org>
References: <1408424370-16960-1-git-send-email-mikey@neuling.org>
Cc: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add 'r' to register name r2 in kvmppc_hv_enter.

Also update comment at the top of kvmppc_hv_enter to indicate that R2/TOC is
non-volatile.

Signed-off-by: Michael Neuling <mikey@neuling.org>
Signed-off-by: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/kvm/book3s_hv_rmhandlers.S | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index c4bd2d7..1e8c480 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -355,6 +355,7 @@ kvmppc_hv_entry:
 	 * MSR = ~IR|DR
 	 * R13 = PACA
 	 * R1 = host R1
+	 * R2 = TOC
 	 * all other volatile GPRS = free
 	 */
 	mflr	r0
@@ -503,7 +504,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
 toc_tlbie_lock:
 	.tc	native_tlbie_lock[TC],native_tlbie_lock
 	.previous
-	ld	r3,toc_tlbie_lock@toc(2)
+	ld	r3,toc_tlbie_lock@toc(r2)
 #ifdef __BIG_ENDIAN__
 	lwz	r8,PACA_LOCK_TOKEN(r13)
 #else
-- 
1.9.1
