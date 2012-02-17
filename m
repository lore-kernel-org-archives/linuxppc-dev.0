Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 42A15B7011
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Feb 2012 04:14:10 +1100 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 21/30] KVM: PPC: make e500v2 and e500mc mutually exclusive
Date: Fri, 17 Feb 2012 18:13:48 +0100
Message-Id: <1329498837-11717-22-git-send-email-agraf@suse.de>
In-Reply-To: <1329498837-11717-1-git-send-email-agraf@suse.de>
References: <1329498837-11717-1-git-send-email-agraf@suse.de>
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

We can't build e500v2 and e500mc (kvm) support inside the same kernel.
So indicate that by making the 2 options mutually exclusive in kconfig.

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/powerpc/kvm/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kvm/Kconfig b/arch/powerpc/kvm/Kconfig
index 44a998d..25ffc1e 100644
--- a/arch/powerpc/kvm/Kconfig
+++ b/arch/powerpc/kvm/Kconfig
@@ -134,7 +134,7 @@ config KVM_E500V2
 
 config KVM_E500MC
 	bool "KVM support for PowerPC E500MC/E5500 processors"
-	depends on EXPERIMENTAL && PPC_E500MC
+	depends on EXPERIMENTAL && PPC_E500MC && !KVM_E500V2
 	select KVM
 	select KVM_MMIO
 	select KVM_BOOKE_HV
-- 
1.6.0.2
