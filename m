Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7E88FB6FA9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Feb 2012 11:10:23 +1100 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 21/38] KVM: PPC: make e500v2 kvm and e500mc cpu mutually
 exclusive
Date: Wed, 29 Feb 2012 01:09:49 +0100
Message-Id: <1330474206-14794-22-git-send-email-agraf@suse.de>
In-Reply-To: <1330474206-14794-1-git-send-email-agraf@suse.de>
References: <1330474206-14794-1-git-send-email-agraf@suse.de>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We can't run e500v2 kvm on e500mc kernels, so indicate that by
making the 2 options mutually exclusive in kconfig.

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/powerpc/kvm/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kvm/Kconfig b/arch/powerpc/kvm/Kconfig
index 44a998d..f4dacb9 100644
--- a/arch/powerpc/kvm/Kconfig
+++ b/arch/powerpc/kvm/Kconfig
@@ -120,7 +120,7 @@ config KVM_EXIT_TIMING
 
 config KVM_E500V2
 	bool "KVM support for PowerPC E500v2 processors"
-	depends on EXPERIMENTAL && E500
+	depends on EXPERIMENTAL && E500 && !PPC_E500MC
 	select KVM
 	select KVM_MMIO
 	---help---
-- 
1.6.0.2
