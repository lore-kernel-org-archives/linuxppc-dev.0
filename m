Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by ozlabs.org (Postfix) with ESMTP id 769D9B709E
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  1 Jul 2010 20:43:07 +1000 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 16/27] KVM: Move kvm_guest_init out of generic code
Date: Thu,  1 Jul 2010 12:42:51 +0200
Message-Id: <1277980982-12433-17-git-send-email-agraf@suse.de>
In-Reply-To: <1277980982-12433-1-git-send-email-agraf@suse.de>
References: <1277980982-12433-1-git-send-email-agraf@suse.de>
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
