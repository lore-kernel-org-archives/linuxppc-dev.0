Return-Path: <thuth@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rJjKQ0mR6zDqR7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 May 2016 15:51:21 +1000 (AEST)
From: Thomas Huth <thuth@redhat.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, kvm-ppc@vger.kernel.org
Subject: [PATCH] powerpc/pseries: Add POWER8NVL support to ibm,
 client-architecture-support call
Date: Tue, 31 May 2016 07:51:17 +0200
Message-Id: <1464673877-30659-1-git-send-email-thuth@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If we do not provide the PVR for POWER8NVL, a guest on this
system currently ends up in PowerISA 2.06 compatibility mode on
KVM, since QEMU does not provide a generic PowerISA 2.07 mode yet.
So some new instructions from POWER8 (like "mtvsrd") get disabled
for the guest, resulting in crashes when using code compiled
explicitly for POWER8 (e.g. with the "-mcpu=power8" option of GCC).

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 arch/powerpc/kernel/prom_init.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index da51925..ccd2037 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -656,6 +656,7 @@ unsigned char ibm_architecture_vec[] = {
 	W(0xffff0000), W(0x003e0000),	/* POWER6 */
 	W(0xffff0000), W(0x003f0000),	/* POWER7 */
 	W(0xffff0000), W(0x004b0000),	/* POWER8E */
+	W(0xffff0000), W(0x004c0000),   /* POWER8NVL */
 	W(0xffff0000), W(0x004d0000),	/* POWER8 */
 	W(0xffffffff), W(0x0f000004),	/* all 2.07-compliant */
 	W(0xffffffff), W(0x0f000003),	/* all 2.06-compliant */
-- 
1.8.3.1
