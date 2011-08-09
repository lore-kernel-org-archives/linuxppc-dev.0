Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 1B616B6F8D
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Aug 2011 02:31:55 +1000 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 01/10] KVM: PPC: move compute_tlbie_rb to book3s common header
Date: Tue,  9 Aug 2011 18:31:39 +0200
Message-Id: <1312907508-14599-2-git-send-email-agraf@suse.de>
In-Reply-To: <1312907508-14599-1-git-send-email-agraf@suse.de>
References: <1312907508-14599-1-git-send-email-agraf@suse.de>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We need the compute_tlbie_rb in _pr and _hv implementations for papr
soon, so let's move it over to a common header file that both
implementations can leverage.

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/powerpc/include/asm/kvm_book3s.h |   33 +++++++++++++++++++++++++++++++++
 arch/powerpc/kvm/book3s_hv_rm_mmu.c   |   33 ---------------------------------
 2 files changed, 33 insertions(+), 33 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_book3s.h b/arch/powerpc/include/asm/kvm_book3s.h
index 98da010..37dd748 100644
--- a/arch/powerpc/include/asm/kvm_book3s.h
+++ b/arch/powerpc/include/asm/kvm_book3s.h
@@ -382,6 +382,39 @@ static inline bool kvmppc_critical_section(struct kvm_vcpu *vcpu)
 }
 #endif
 
+static inline unsigned long compute_tlbie_rb(unsigned long v, unsigned long r,
+					     unsigned long pte_index)
+{
+	unsigned long rb, va_low;
+
+	rb = (v & ~0x7fUL) << 16;		/* AVA field */
+	va_low = pte_index >> 3;
+	if (v & HPTE_V_SECONDARY)
+		va_low = ~va_low;
+	/* xor vsid from AVA */
+	if (!(v & HPTE_V_1TB_SEG))
+		va_low ^= v >> 12;
+	else
+		va_low ^= v >> 24;
+	va_low &= 0x7ff;
+	if (v & HPTE_V_LARGE) {
+		rb |= 1;			/* L field */
+		if (cpu_has_feature(CPU_FTR_ARCH_206) &&
+		    (r & 0xff000)) {
+			/* non-16MB large page, must be 64k */
+			/* (masks depend on page size) */
+			rb |= 0x1000;		/* page encoding in LP field */
+			rb |= (va_low & 0x7f) << 16; /* 7b of VA in AVA/LP field */
+			rb |= (va_low & 0xfe);	/* AVAL field (P7 doesn't seem to care) */
+		}
+	} else {
+		/* 4kB page */
+		rb |= (va_low & 0x7ff) << 12;	/* remaining 11b of VA */
+	}
+	rb |= (v >> 54) & 0x300;		/* B field */
+	return rb;
+}
+
 /* Magic register values loaded into r3 and r4 before the 'sc' assembly
  * instruction for the OSI hypercalls */
 #define OSI_SC_MAGIC_R3			0x113724FA
diff --git a/arch/powerpc/kvm/book3s_hv_rm_mmu.c b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
index fcfe6b0..bacb0cf 100644
--- a/arch/powerpc/kvm/book3s_hv_rm_mmu.c
+++ b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
@@ -110,39 +110,6 @@ long kvmppc_h_enter(struct kvm_vcpu *vcpu, unsigned long flags,
 	return H_SUCCESS;
 }
 
-static unsigned long compute_tlbie_rb(unsigned long v, unsigned long r,
-				      unsigned long pte_index)
-{
-	unsigned long rb, va_low;
-
-	rb = (v & ~0x7fUL) << 16;		/* AVA field */
-	va_low = pte_index >> 3;
-	if (v & HPTE_V_SECONDARY)
-		va_low = ~va_low;
-	/* xor vsid from AVA */
-	if (!(v & HPTE_V_1TB_SEG))
-		va_low ^= v >> 12;
-	else
-		va_low ^= v >> 24;
-	va_low &= 0x7ff;
-	if (v & HPTE_V_LARGE) {
-		rb |= 1;			/* L field */
-		if (cpu_has_feature(CPU_FTR_ARCH_206) &&
-		    (r & 0xff000)) {
-			/* non-16MB large page, must be 64k */
-			/* (masks depend on page size) */
-			rb |= 0x1000;		/* page encoding in LP field */
-			rb |= (va_low & 0x7f) << 16; /* 7b of VA in AVA/LP field */
-			rb |= (va_low & 0xfe);	/* AVAL field (P7 doesn't seem to care) */
-		}
-	} else {
-		/* 4kB page */
-		rb |= (va_low & 0x7ff) << 12;	/* remaining 11b of VA */
-	}
-	rb |= (v >> 54) & 0x300;		/* B field */
-	return rb;
-}
-
 #define LOCK_TOKEN	(*(u32 *)(&get_paca()->lock_token))
 
 static inline int try_lock_tlbie(unsigned int *lock)
-- 
1.6.0.2
