Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1ED821A01FB
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jun 2014 16:37:06 +1000 (EST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] powerpc/kvm: Fix build break with CONFIG_KVM_BOOK3S_64_HV=y
Date: Tue, 24 Jun 2014 16:36:47 +1000
Message-Id: <1403591807-9550-1-git-send-email-mpe@ellerman.id.au>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, agraf@suse.de, linuxppc-dev@ozlabs.org,
 iamjoonsoo.kim@lge.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit e58e263 "PPC, KVM, CMA: use general CMA reserved area management
framework" in next-20140624 removed arch/powerpc/kvm/book3s_hv_cma.c but
neglected to update the Makefile, thus breaking the build.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---

Hi Andrew,

This is in your akpm-current and is breaking some of the builds for
powerpc in linux-next. Squashing this fix into the original patch would
be best for us.

cheers

 arch/powerpc/kvm/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/kvm/Makefile b/arch/powerpc/kvm/Makefile
index ce569b6..72905c3 100644
--- a/arch/powerpc/kvm/Makefile
+++ b/arch/powerpc/kvm/Makefile
@@ -90,7 +90,6 @@ kvm-book3s_64-builtin-objs-$(CONFIG_KVM_BOOK3S_64_HANDLER) += \
 	book3s_hv_rm_mmu.o \
 	book3s_hv_ras.o \
 	book3s_hv_builtin.o \
-	book3s_hv_cma.o \
 	$(kvm-book3s_64-builtin-xics-objs-y)
 endif
 
-- 
1.9.1
