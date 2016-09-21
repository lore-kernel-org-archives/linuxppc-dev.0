Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sfBVj60CWzDsgq
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 17:45:17 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id 21so2038329pfy.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 00:45:17 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 19/41] powerpc/64s: consolidate Trace 0xd00 interrupt
Date: Wed, 21 Sep 2016 17:43:45 +1000
Message-Id: <20160921074407.4885-20-npiggin@gmail.com>
In-Reply-To: <20160921074407.4885-1-npiggin@gmail.com>
References: <20160921074407.4885-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/exceptions-64s.S | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 8a12701..1a9618f 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -898,8 +898,9 @@ TRAMP_KVM(PACA_EXGEN, 0xc00)
 
 
 VECTOR_HANDLER_REAL(single_step, 0xd00, 0xe00)
-
+VECTOR_HANDLER_VIRT(single_step, 0x4d00, 0x4e00, 0xd00)
 TRAMP_KVM(PACA_EXGEN, 0xd00)
+COMMON_HANDLER(single_step_common, 0xd00, single_step_exception)
 
 
 	/* At 0xe??? we have a bunch of hypervisor exceptions, we branch
@@ -1213,7 +1214,6 @@ TRAMP_HANDLER_END(kvmppc_skip_Hinterrupt)
 /*** Common interrupt handlers ***/
 
 
-COMMON_HANDLER(single_step_common, 0xd00, single_step_exception)
 COMMON_HANDLER(trap_0e_common, 0xe00, unknown_exception)
 COMMON_HANDLER(emulation_assist_common, 0xe40, emulation_assist_interrupt)
 COMMON_HANDLER_ASYNC(hmi_exception_common, 0xe60, handle_hmi_exception)
@@ -1251,7 +1251,6 @@ COMMON_HANDLER(altivec_assist_common, 0x1700, unknown_exception)
 
 
 
-VECTOR_HANDLER_VIRT(single_step, 0x4d00, 0x4e00, 0xd00)
 
 VECTOR_HANDLER_VIRT_BEGIN(unused, 0x4e00, 0x4e20)
 	b       .       /* Can't happen, see v2.07 Book III-S section 6.5 */
-- 
2.9.3
