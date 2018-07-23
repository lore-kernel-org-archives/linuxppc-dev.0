Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Z4cY5WQPzDqnK
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jul 2018 01:08:13 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/5] powerpc/64s: Add new security feature flags for count
 cache flush
Date: Tue, 24 Jul 2018 01:07:53 +1000
Message-Id: <20180723150756.11108-2-mpe@ellerman.id.au>
In-Reply-To: <20180723150756.11108-1-mpe@ellerman.id.au>
References: <20180723150756.11108-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add security feature flags to indicate the need for software to flush
the count cache on context switch, and for the presence of a hardware
assisted count cache flush.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/security_features.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/powerpc/include/asm/security_features.h b/arch/powerpc/include/asm/security_features.h
index 44989b22383c..a0d47bc18a5c 100644
--- a/arch/powerpc/include/asm/security_features.h
+++ b/arch/powerpc/include/asm/security_features.h
@@ -59,6 +59,9 @@ static inline bool security_ftr_enabled(unsigned long feature)
 // Indirect branch prediction cache disabled
 #define SEC_FTR_COUNT_CACHE_DISABLED	0x0000000000000020ull
 
+// bcctr 2,0,0 triggers a hardware assisted count cache flush
+#define SEC_FTR_BCCTR_FLUSH_ASSIST	0x0000000000000800ull
+
 
 // Features indicating need for Spectre/Meltdown mitigations
 
@@ -74,6 +77,9 @@ static inline bool security_ftr_enabled(unsigned long feature)
 // Firmware configuration indicates user favours security over performance
 #define SEC_FTR_FAVOUR_SECURITY		0x0000000000000200ull
 
+// Software required to flush count cache on context switch
+#define SEC_FTR_FLUSH_COUNT_CACHE	0x0000000000000400ull
+
 
 // Features enabled by default
 #define SEC_FTR_DEFAULT \
-- 
2.14.1
