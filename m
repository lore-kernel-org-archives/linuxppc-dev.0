Return-Path: <mcaraman@mcaraman-VirtualBox.ea.freescale.net>
Received: from db3outboundpool.messaging.microsoft.com
 (db3ehsobe005.messaging.microsoft.com [213.199.154.143])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2C602B6FC3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jun 2012 22:26:51 +1000 (EST)
Received: from mail99-db3 (localhost [127.0.0.1])	by mail99-db3-R.bigfish.com
 (Postfix) with ESMTP id CD85118029F	for
 <linuxppc-dev@lists.ozlabs.org>; Mon,
 25 Jun 2012 12:25:07 +0000 (UTC)
Received: from DB3EHSMHS008.bigfish.com (unknown [10.3.81.234])	by
 mail99-db3.bigfish.com (Postfix) with ESMTP id 6BE2AA0046	for
 <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jun 2012 12:25:06 +0000 (UTC)
Received: from mcaraman-VirtualBox.ea.freescale.net ([10.213.130.145])	by
 tx30smr01.am.freescale.net (8.14.3/8.14.0) with ESMTP id q5PCQeAF003903	for
 <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jun 2012 05:26:41 -0700
From: Mihai Caraman <mihai.caraman@freescale.com>
To: <kvm-ppc@vger.kernel.org>, <kvm@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>, <qemu-ppc@nongnu.org>
Subject: [RFC PATCH 14/17] KVM: PPC32: bookehv: Remove GET_VCPU macro from
 exception handler
Date: Mon, 25 Jun 2012 15:26:32 +0300
Message-ID: <1340627195-11544-15-git-send-email-mihai.caraman@freescale.com>
In-Reply-To: <1340627195-11544-1-git-send-email-mihai.caraman@freescale.com>
References: <1340627195-11544-1-git-send-email-mihai.caraman@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Mihai Caraman <mihai.caraman@freescale.com>
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
index 6048a00..dff8ed4 100644
--- a/arch/powerpc/kvm/bookehv_interrupts.S
+++ b/arch/powerpc/kvm/bookehv_interrupts.S
@@ -32,9 +32,6 @@
 
 #include "../kernel/head_booke.h" /* for THREAD_NORMSAVE() */
 
-#define GET_VCPU(vcpu, thread)	\
-	PPC_LL	vcpu, THREAD_KVM_VCPU(thread)
-
 #define LONGBYTES		(BITS_PER_LONG / 8)
 
 #define VCPU_GPR(n)     	(VCPU_GPRS + (n * LONGBYTES))
@@ -210,7 +207,7 @@
  */
 .macro kvm_handler intno srr0, srr1, flags
 _GLOBAL(kvmppc_handler_\intno\()_\srr1)
-	GET_VCPU(r11, r10)
+	PPC_LL	r11, THREAD_KVM_VCPU(r10)
 	PPC_STL r3, VCPU_GPR(r3)(r11)
 	mfspr	r3, SPRN_SPRG_RSCRATCH0
 	PPC_STL	r4, VCPU_GPR(r4)(r11)
@@ -237,7 +234,7 @@ _GLOBAL(kvmppc_handler_\intno\()_\srr1)
 .macro kvm_lvl_handler intno scratch srr0, srr1, flags
 _GLOBAL(kvmppc_handler_\intno\()_\srr1)
 	mfspr	r10, SPRN_SPRG_THREAD
-	GET_VCPU(r11, r10)
+	PPC_LL	r11, THREAD_KVM_VCPU(r10)
 	PPC_STL r3, VCPU_GPR(r3)(r11)
 	mfspr	r3, \scratch
 	PPC_STL	r4, VCPU_GPR(r4)(r11)
-- 
1.7.4.1
