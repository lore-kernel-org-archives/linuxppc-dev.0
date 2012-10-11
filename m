Return-Path: <mcaraman@mcaraman-VirtualBox.ea.freescale.net>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe001.messaging.microsoft.com [216.32.181.181])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A9ACC2C0325
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Oct 2012 03:14:23 +1100 (EST)
Received: from mail152-ch1 (localhost [127.0.0.1])	by
 mail152-ch1-R.bigfish.com (Postfix) with ESMTP id 0346560096	for
 <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Oct 2012 16:14:19 +0000 (UTC)
Received: from CH1EHSMHS006.bigfish.com (snatpool3.int.messaging.microsoft.com
 [10.43.68.227])	by mail152-ch1.bigfish.com (Postfix) with ESMTP id
 3774C3400A1	for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Oct 2012 16:14:17
 +0000 (UTC)
Received: from mcaraman-VirtualBox.ea.freescale.net ([10.213.130.145])	by
 tx30smr01.am.freescale.net (8.14.3/8.14.0) with ESMTP id q9BGEB8N028137	for
 <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Oct 2012 09:14:12 -0700
From: Mihai Caraman <mihai.caraman@freescale.com>
To: <kvm-ppc@vger.kernel.org>
Subject: [PATCH 03/12] KVM: PPC: bookehv: Remove GET_VCPU macro from exception
 handler
Date: Thu, 11 Oct 2012 19:13:20 +0300
Message-ID: <1349972009-23027-4-git-send-email-mihai.caraman@freescale.com>
In-Reply-To: <1349972009-23027-1-git-send-email-mihai.caraman@freescale.com>
References: <1349972009-23027-1-git-send-email-mihai.caraman@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Mihai Caraman <mihai.caraman@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

GET_VCPU define will not be implemented for 64-bit for performance reasons
so get rid of it also on 32-bit.

Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
---
 arch/powerpc/kvm/bookehv_interrupts.S |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kvm/bookehv_interrupts.S b/arch/powerpc/kvm/bookehv_interrupts.S
index 099fe82..fa6d552 100644
--- a/arch/powerpc/kvm/bookehv_interrupts.S
+++ b/arch/powerpc/kvm/bookehv_interrupts.S
@@ -32,9 +32,6 @@
 
 #include "../kernel/head_booke.h" /* for THREAD_NORMSAVE() */
 
-#define GET_VCPU(vcpu, thread)	\
-	PPC_LL	vcpu, THREAD_KVM_VCPU(thread)
-
 #define LONGBYTES		(BITS_PER_LONG / 8)
 
 #define VCPU_GUEST_SPRG(n)	(VCPU_GUEST_SPRGS + (n * LONGBYTES))
@@ -206,7 +203,7 @@
  */
 .macro kvm_handler intno srr0, srr1, flags
 _GLOBAL(kvmppc_handler_\intno\()_\srr1)
-	GET_VCPU(r11, r10)
+	PPC_LL	r11, THREAD_KVM_VCPU(r10)
 	PPC_STL r3, VCPU_GPR(R3)(r11)
 	mfspr	r3, SPRN_SPRG_RSCRATCH0
 	PPC_STL	r4, VCPU_GPR(R4)(r11)
@@ -233,7 +230,7 @@ _GLOBAL(kvmppc_handler_\intno\()_\srr1)
 .macro kvm_lvl_handler intno scratch srr0, srr1, flags
 _GLOBAL(kvmppc_handler_\intno\()_\srr1)
 	mfspr	r10, SPRN_SPRG_THREAD
-	GET_VCPU(r11, r10)
+	PPC_LL	r11, THREAD_KVM_VCPU(r10)
 	PPC_STL r3, VCPU_GPR(R3)(r11)
 	mfspr	r3, \scratch
 	PPC_STL	r4, VCPU_GPR(R4)(r11)
-- 
1.7.4.1
