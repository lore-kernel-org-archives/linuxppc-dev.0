Return-Path: <shreyas@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0EE271A0021
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Apr 2015 20:58:37 +1000 (AEST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shreyas@linux.vnet.ibm.com>;
 Thu, 16 Apr 2015 06:58:35 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 9F7166E803C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Apr 2015 06:50:12 -0400 (EDT)
Received: from d01av05.pok.ibm.com (d01av05.pok.ibm.com [9.56.224.195])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3GAwMQx61931650
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Apr 2015 10:58:23 GMT
Received: from d01av05.pok.ibm.com (localhost [127.0.0.1])
 by d01av05.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3GAwMOS018950
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Apr 2015 06:58:22 -0400
From: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Subject: [PATCH] kvm: powerpc: Fix ppc64_defconfig + PPC_POWERNV=n build error
Date: Thu, 16 Apr 2015 16:28:09 +0530
Message-Id: <1429181889-1448-1-git-send-email-shreyas@linux.vnet.ibm.com>
Cc: ego@linux.vnet.ibm.com, "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, agraf@suse.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

kvm_no_guest function calls power7_wakeup_loss to put the thread into
the deepest supported idle state. power7_wakeup_loss is defined in
arch/powerpc/kernel/idle_power7.S, which is compiled only when PPC_P7_NAP=y.
And PPC_P7_NAP is selected when PPC_POWERNV=y.
Hence in cases where PPC_POWERNV=n and KVM_BOOK3S_64_HV=y we see the
following error:

arch/powerpc/kvm/built-in.o: In function `kvm_no_guest':
arch/powerpc/kvm/book3s_hv_rmhandlers.o:(.text+0x42c): undefined reference to `power7_wakeup_loss'

Fix this by adding PPC_POWERNV as a dependency for KVM_BOOK3S_64_HV.

Signed-off-by: Shreyas B. Prabhu <shreyas@linux.vnet.ibm.com>
---
 arch/powerpc/kvm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/Kconfig b/arch/powerpc/kvm/Kconfig
index 11850f3..b3b3d9f 100644
--- a/arch/powerpc/kvm/Kconfig
+++ b/arch/powerpc/kvm/Kconfig
@@ -75,7 +75,7 @@ config KVM_BOOK3S_64
 
 config KVM_BOOK3S_64_HV
 	tristate "KVM support for POWER7 and PPC970 using hypervisor mode in host"
-	depends on KVM_BOOK3S_64
+	depends on KVM_BOOK3S_64 && PPC_POWERNV
 	select KVM_BOOK3S_HV_POSSIBLE
 	select MMU_NOTIFIER
 	select CMA
-- 
1.9.3
