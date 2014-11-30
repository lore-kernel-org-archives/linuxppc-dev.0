Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7401F1A09B4
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Dec 2014 06:46:24 +1100 (AEDT)
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 agraf@suse.de
Subject: [PATCH] KVM: PPC: Enable in kernel XICS emulation by default
Date: Mon,  1 Dec 2014 06:46:22 +1100
Message-Id: <1417376782-18632-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The in kernel XICS emulation is faster than doing it all in QEMU
and it has got a lot of testing, so enable it by default

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/kvm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/kvm/Kconfig b/arch/powerpc/kvm/Kconfig
index 602eb51..f5769f1 100644
--- a/arch/powerpc/kvm/Kconfig
+++ b/arch/powerpc/kvm/Kconfig
@@ -172,6 +172,7 @@ config KVM_XICS
 	depends on KVM_BOOK3S_64 && !KVM_MPIC
 	select HAVE_KVM_IRQCHIP
 	select HAVE_KVM_IRQFD
+	default y
 	---help---
 	  Include support for the XICS (eXternal Interrupt Controller
 	  Specification) interrupt controller architecture used on
-- 
2.1.0
