Return-Path: <agraf@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 40DA61008EC
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 26 Jun 2010 09:25:23 +1000 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 16/26] KVM: Move kvm_guest_init out of generic code
Date: Sat, 26 Jun 2010 01:25:04 +0200
Message-Id: <1277508314-915-17-git-send-email-agraf@suse.de>
In-Reply-To: <1277508314-915-1-git-send-email-agraf@suse.de>
References: <1277508314-915-1-git-send-email-agraf@suse.de>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	KVM list <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently x86 is the only architecture that uses kvm_guest_init(). With
PowerPC we're getting a second user, but the signature is different there
and we don't need to export it, as it uses the normal kernel init framework.

So let's move the x86 specific definition of that function over to the x86
specfic header file.

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/x86/include/asm/kvm_para.h |    6 ++++++
 include/linux/kvm_para.h        |    5 -----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/kvm_para.h b/arch/x86/include/asm/kvm_para.h
index 05eba5e..7b562b6 100644
--- a/arch/x86/include/asm/kvm_para.h
+++ b/arch/x86/include/asm/kvm_para.h
@@ -158,6 +158,12 @@ static inline unsigned int kvm_arch_para_features(void)
 	return cpuid_eax(KVM_CPUID_FEATURES);
 }
 
+#ifdef CONFIG_KVM_GUEST
+void __init kvm_guest_init(void);
+#else
+#define kvm_guest_init() do { } while (0)
 #endif
 
+#endif /* __KERNEL__ */
+
 #endif /* _ASM_X86_KVM_PARA_H */
diff --git a/include/linux/kvm_para.h b/include/linux/kvm_para.h
index ac2015a..47a070b 100644
--- a/include/linux/kvm_para.h
+++ b/include/linux/kvm_para.h
@@ -26,11 +26,6 @@
 #include <asm/kvm_para.h>
 
 #ifdef __KERNEL__
-#ifdef CONFIG_KVM_GUEST
-void __init kvm_guest_init(void);
-#else
-#define kvm_guest_init() do { } while (0)
-#endif
 
 static inline int kvm_para_has_feature(unsigned int feature)
 {
-- 
1.6.0.2
