Return-Path: <B43198@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bn0108.outbound.protection.outlook.com [157.56.110.108])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DDB911A033E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Mar 2015 21:43:57 +1100 (AEDT)
From: Bogdan Purcareata <bogdan.purcareata@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <scottwood@freescale.com>,
 <segher@kernel.crashing.org>, <benh@kernel.crashing.org>
Subject: [PATCH] powerpc/mpic: Remove WHOAMI readback after EOI
Date: Tue, 24 Mar 2015 10:43:43 +0000
Message-ID: <1427193823-14597-1-git-send-email-bogdan.purcareata@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

After previous discussions regarding the subject [1][2], there's no clear
explanation or reason why the call was needed in the first place. The sensible
argument is some sort of synchronization between the CPU and the MPIC, which
hasn't been pointed out precisely and is no longer required (at least on BookE
platforms).

The benefit of this change is saving a MMIO trap per interrupt when running in a
KVM guest.

[1] https://patchwork.ozlabs.org/patch/429098/
[2] https://patchwork.ozlabs.org/patch/433557/

Signed-off-by: Bogdan Purcareata <bogdan.purcareata@freescale.com>
---
 arch/powerpc/sysdev/mpic.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index bbfbbf2..045e72a9 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -655,7 +655,6 @@ static inline struct mpic * mpic_from_irq_data(struct irq_data *d)
 static inline void mpic_eoi(struct mpic *mpic)
 {
 	mpic_cpu_write(MPIC_INFO(CPU_EOI), 0);
-	(void)mpic_cpu_read(MPIC_INFO(CPU_WHOAMI));
 }
 
 /*
-- 
2.1.4
