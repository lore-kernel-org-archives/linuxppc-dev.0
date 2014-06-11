Return-Path: <anton@samba.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A852C1A0082
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jun 2014 09:08:45 +1000 (EST)
Date: Thu, 12 Jun 2014 09:08:37 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, mahesh@linux.vnet.ibm.com
Subject: [PATCH] powerpc/book3s: Fix some ABIv2 issues in machine check code
Message-ID: <20140612090837.2f7d06cd@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit 2749a2f26a7c (powerpc/book3s: Fix machine check handling for
unhandled errors) introduced a few ABIv2 issues.

We can maintain ABIv1 and ABIv2 compatibility by branching to the
function rather than the dot symbol.

Fixes: 2749a2f26a7c ("powerpc/book3s: Fix machine check handling for unhandled errors")
Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: b/arch/powerpc/kernel/exceptions-64s.S
===================================================================
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -1502,13 +1502,13 @@ machine_check_handle_early:
 unrecover_mce:
 	/* Invoke machine_check_exception to print MCE event and panic. */
 	addi	r3,r1,STACK_FRAME_OVERHEAD
-	bl	.machine_check_exception
+	bl	machine_check_exception
 	/*
 	 * We will not reach here. Even if we did, there is no way out. Call
 	 * unrecoverable_exception and die.
 	 */
 1:	addi	r3,r1,STACK_FRAME_OVERHEAD
-	bl	.unrecoverable_exception
+	bl	unrecoverable_exception
 	b	1b
 /*
  * r13 points to the PACA, r9 contains the saved CR,
