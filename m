Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zFhH36Yf4zF0Pp
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Jan 2018 03:55:43 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, peterz@infradead.org,
 npiggin@gmail.com, anton@samba.org, mikey@neuling.org, oohall@gmail.com,
 paulus@samba.org
Subject: [PATCH 02/11] powerpc/64: Add macros for annotating the destination
 of rfid/hrfid
Date: Tue,  9 Jan 2018 03:54:44 +1100
Message-Id: <20180108165453.26066-2-mpe@ellerman.id.au>
In-Reply-To: <20180108165453.26066-1-mpe@ellerman.id.au>
References: <20180108165453.26066-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Nicholas Piggin <npiggin@gmail.com>

The rfid/hrfid ((Hypervisor) Return From Interrupt) instruction is
used for switching from the kernel to userspace, and from the
hypervisor to the guest kernel. However it can and is also used for
other transitions, eg. from real mode kernel code to virtual mode
kernel code, and it's not always clear from the code what the
destination context is.

To make it clearer when reading the code, add macros which encode the
expected destination context.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/exception-64e.h |  6 ++++++
 arch/powerpc/include/asm/exception-64s.h | 29 +++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/arch/powerpc/include/asm/exception-64e.h b/arch/powerpc/include/asm/exception-64e.h
index a703452d67b6..555e22d5e07f 100644
--- a/arch/powerpc/include/asm/exception-64e.h
+++ b/arch/powerpc/include/asm/exception-64e.h
@@ -209,5 +209,11 @@ exc_##label##_book3e:
 	ori	r3,r3,vector_offset@l;		\
 	mtspr	SPRN_IVOR##vector_number,r3;
 
+#define RFI_TO_KERNEL							\
+	rfi
+
+#define RFI_TO_USER							\
+	rfi
+
 #endif /* _ASM_POWERPC_EXCEPTION_64E_H */
 
diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index b27205297e1d..1af427a3c74f 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -74,6 +74,35 @@
  */
 #define EX_R3		EX_DAR
 
+/* Macros for annotating the expected destination of (h)rfid */
+
+#define RFI_TO_KERNEL							\
+	rfid
+
+#define RFI_TO_USER							\
+	rfid
+
+#define RFI_TO_USER_OR_KERNEL						\
+	rfid
+
+#define RFI_TO_GUEST							\
+	rfid
+
+#define HRFI_TO_KERNEL							\
+	hrfid
+
+#define HRFI_TO_USER							\
+	hrfid
+
+#define HRFI_TO_USER_OR_KERNEL						\
+	hrfid
+
+#define HRFI_TO_GUEST							\
+	hrfid
+
+#define HRFI_TO_UNKNOWN							\
+	hrfid
+
 #ifdef CONFIG_RELOCATABLE
 #define __EXCEPTION_RELON_PROLOG_PSERIES_1(label, h)			\
 	mfspr	r11,SPRN_##h##SRR0;	/* save SRR0 */			\
-- 
2.14.3
