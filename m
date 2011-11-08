Return-Path: <whitebox@nefkom.net>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 by ozlabs.org (Postfix) with ESMTP id B533BB6F85
 for <linuxppc-dev@ozlabs.org>; Wed,  9 Nov 2011 04:09:05 +1100 (EST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Alexander Graf <agraf@suse.de>
Subject: [PATCH] KVM: PPC: move compute_tlbie_rb to book3s_64 common header
References: <1312907508-14599-1-git-send-email-agraf@suse.de>
 <1312907508-14599-2-git-send-email-agraf@suse.de>
Date: Tue, 08 Nov 2011 18:08:52 +0100
In-Reply-To: <1312907508-14599-2-git-send-email-agraf@suse.de> (Alexander
 Graf's message of "Tue, 9 Aug 2011 18:31:39 +0200")
Message-ID: <m2bosmpmmz.fsf_-_@igel.home>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, kvm@vger.kernel.org,
 kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

compute_tlbie_rb is only used on ppc64 and cannot be compiled on ppc32.

Signed-off-by: Andreas Schwab <schwab@linux-m68k.org>
---
 arch/powerpc/include/asm/kvm_book3s.h    |   33 ------------------------------
 arch/powerpc/include/asm/kvm_book3s_64.h |   33 ++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+), 33 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_book3s.h b/arch/powerpc/include/asm/kvm_book3s.h
index a384ffd..db73fa3 100644
--- a/arch/powerpc/include/asm/kvm_book3s.h
+++ b/arch/powerpc/include/asm/kvm_book3s.h
@@ -383,39 +383,6 @@ static inline bool kvmppc_critical_section(struct kvm_vcpu *vcpu)
 }
 #endif
 
-static inline unsigned long compute_tlbie_rb(unsigned long v, unsigned long r,
-					     unsigned long pte_index)
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
 /* Magic register values loaded into r3 and r4 before the 'sc' assembly
  * instruction for the OSI hypercalls */
 #define OSI_SC_MAGIC_R3			0x113724FA
diff --git a/arch/powerpc/include/asm/kvm_book3s_64.h b/arch/powerpc/include/asm/kvm_book3s_64.h
index e43fe42..d0ac94f 100644
--- a/arch/powerpc/include/asm/kvm_book3s_64.h
+++ b/arch/powerpc/include/asm/kvm_book3s_64.h
@@ -29,4 +29,37 @@ static inline struct kvmppc_book3s_shadow_vcpu *to_svcpu(struct kvm_vcpu *vcpu)
 
 #define SPAPR_TCE_SHIFT		12
 
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
 #endif /* __ASM_KVM_BOOK3S_64_H__ */
-- 
1.7.7.2


-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
