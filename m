Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id DF5802C0088
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jul 2012 08:33:07 +1000 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH] KVM: PPC: Book3S_32: Fix MTMSR_EERI macro
Date: Tue, 31 Jul 2012 00:32:59 +0200
Message-Id: <1343687579-13689-1-git-send-email-agraf@suse.de>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 KVM list <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit b38c77d82e4 moved the MTMSR_EERI macro from the KVM code to generic
ppc_asm.h code. However, while adding it in the headers for the ppc32 case,
it missed out to remove the former definition in the KVM code.

This patch fixes compilation on server type PPC32 targets with CONFIG_KVM
enabled.

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/powerpc/kvm/book3s_rmhandlers.S |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_rmhandlers.S b/arch/powerpc/kvm/book3s_rmhandlers.S
index ab523f3..9ecf6e3 100644
--- a/arch/powerpc/kvm/book3s_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_rmhandlers.S
@@ -67,7 +67,6 @@ kvmppc_skip_Hinterrupt:
 #elif defined(CONFIG_PPC_BOOK3S_32)
 
 #define FUNC(name)		name
-#define MTMSR_EERI(reg)		mtmsr	(reg)
 
 .macro INTERRUPT_TRAMPOLINE intno
 
-- 
1.6.0.2
