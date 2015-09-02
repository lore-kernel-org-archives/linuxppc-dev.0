Return-Path: <thuth@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0715D1A1E2B
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Sep 2015 19:14:54 +1000 (AEST)
From: Thomas Huth <thuth@redhat.com>
To: kvm-ppc@vger.kernel.org, Alexander Graf <agraf@suse.com>,
 Paul Mackerras <paulus@samba.org>
Cc: kvm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@au1.ibm.com>
Subject: [PATCH v2] KVM: ppc: Fix size of the PSPB register
Date: Wed,  2 Sep 2015 11:14:48 +0200
Message-Id: <1441185288-19348-1-git-send-email-thuth@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The size of the Problem State Priority Boost Register is only
32 bits, but the kvm_vcpu_arch->pspb variable is declared as
"ulong", ie. 64-bit. However, the assembler code accesses this
variable with 32-bit accesses, and the KVM_REG_PPC_PSPB macro
is defined with SIZE_U32, too, so that the current code is
broken on big endian hosts: kvmppc_get_one_reg_hv() will only
return zero for this register since it is using the wrong half
of the pspb variable. Let's fix this problem by adjusting the
size of the pspb field in the kvm_vcpu_arch structure.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 v2: Updated patch description

 arch/powerpc/include/asm/kvm_host.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index d91f65b..c825f3a 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -473,7 +473,7 @@ struct kvm_vcpu_arch {
 	ulong ciabr;
 	ulong cfar;
 	ulong ppr;
-	ulong pspb;
+	u32 pspb;
 	ulong fscr;
 	ulong shadow_fscr;
 	ulong ebbhr;
-- 
1.8.3.1
