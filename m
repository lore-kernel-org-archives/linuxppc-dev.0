Return-Path: <thuth@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9B7DE1A1E05
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Sep 2015 07:41:23 +1000 (AEST)
From: Thomas Huth <thuth@redhat.com>
To: kvm-ppc@vger.kernel.org, Alexander Graf <agraf@suse.com>,
 Paul Mackerras <paulus@samba.org>
Cc: kvm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] KVM: ppc: Fix size of the PSPB register
Date: Tue,  1 Sep 2015 23:41:18 +0200
Message-Id: <1441143678-14295-1-git-send-email-thuth@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The size of the Problem State Priority Boost Register is only
32 bits, so let's change the type of the corresponding variable
accordingly to avoid future trouble.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
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
