Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zYz830L3ZzDqZ1
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  4 Feb 2018 16:01:07 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: stable@vger.kernel.org,
	greg@kroah.com
Cc: linuxppc-dev@ozlabs.org
Subject: [PATCH v4.4 backport 06/16] powerpc/64: Add macros for annotating the
 destination of rfid/hrfid
Date: Sun,  4 Feb 2018 16:00:00 +1100
Message-Id: <20180204050010.13669-7-mpe@ellerman.id.au>
In-Reply-To: <20180204050010.13669-1-mpe@ellerman.id.au>
References: <20180204050010.13669-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Nicholas Piggin <npiggin@gmail.com>

commit 50e51c13b3822d14ff6df4279423e4b7b2269bc3 upstream.

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
index 77f52b26dad6..c8c8a81e3976 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -50,6 +50,35 @@
 #define EX_PPR		88	/* SMT thread status register (priority) */
 #define EX_CTR		96
 
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
 	ld	r12,PACAKBASE(r13);	/* get high part of &label */	\
-- 
2.14.1
