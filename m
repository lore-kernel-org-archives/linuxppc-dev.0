Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xTW1r15DLzDqkX
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Aug 2017 02:39:44 +1000 (AEST)
Received: by mail-pg0-x243.google.com with SMTP id y129so3500110pgy.3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Aug 2017 09:39:44 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH v2 06/14] powerpc/64s: irq replay external use the HV handler
 in HV mode on POWER9
Date: Sat, 12 Aug 2017 02:39:04 +1000
Message-Id: <20170811163912.28783-7-npiggin@gmail.com>
In-Reply-To: <20170811163912.28783-1-npiggin@gmail.com>
References: <20170811163912.28783-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

POWER9 host external interrupts use the h_virt_irq_common handler, so
use that to replay them rather than using the hardware_interrupt_common
handler. Both call do_IRQ, but using the correct handler reduces i-cache
footprint.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/exceptions-64s.S | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index f9d0796fb2c9..29253cecf713 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -1672,7 +1672,11 @@ _GLOBAL(__replay_interrupt)
 	cmpwi	r3,0x900
 	beq	decrementer_common
 	cmpwi	r3,0x500
+BEGIN_FTR_SECTION
+	beq	h_virt_irq_common
+FTR_SECTION_ELSE
 	beq	hardware_interrupt_common
+ALT_FTR_SECTION_END_IFSET(CPU_FTR_HVMODE | CPU_FTR_ARCH_300)
 BEGIN_FTR_SECTION
 	cmpwi	r3,0xa00
 	beq	h_doorbell_common_msgclr
-- 
2.13.3
