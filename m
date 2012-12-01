Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 338452C00A4
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  2 Dec 2012 00:58:30 +1100 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH] KVM: PPC: Make EPCR a valid field for booke64 and bookehv
Date: Sat,  1 Dec 2012 14:58:25 +0100
Message-Id: <1354370305-12344-1-git-send-email-agraf@suse.de>
Cc: Mihai Caraman <mihai.caraman@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 "kvm@vger.kernel.org list" <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In BookE, EPCR is defined and valid when either the HV or the 64bit
category are implemented. Reflect this in the field definition.

Today the only KVM target on 64bit is HV enabled, so there is no
change in actual source code, but this keeps the code closer to the
spec and doesn't build up artificial road blocks for a PR KVM
on 64bit.

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/powerpc/include/asm/kvm_host.h |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index 62fbd38..3480526 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -405,14 +405,19 @@ struct kvm_vcpu_arch {
 #ifdef CONFIG_KVM_BOOKE_HV
 	u32 host_mas4;
 	u32 host_mas6;
-	u32 shadow_epcr;
-	u32 epcr;
 	u32 shadow_msrp;
 	u32 eplc;
 	u32 epsc;
 	u32 oldpir;
 #endif
 
+#if defined(CONFIG_BOOKE)
+#if defined(CONFIG_KVM_BOOKE_HV) || defined(CONFIG_64BIT)
+	u32 shadow_epcr;
+	u32 epcr;
+#endif
+#endif
+
 #ifdef CONFIG_PPC_BOOK3S
 	/* For Gekko paired singles */
 	u32 qpr[32];
-- 
1.6.0.2
