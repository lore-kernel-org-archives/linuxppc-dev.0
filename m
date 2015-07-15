Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 91D841A1F32
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jul 2015 17:37:23 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: <linux-kernel@vger.kernel.org>, keescook@chromium.org, luto@amacapital.net,
 wad@chromium.org, strosake@linux.vnet.ibm.com,
 bogdan.purcareata@freescale.com
Subject: [RFC PATCH 04/12] powerpc: Drop unused syscall_get_error()
Date: Wed, 15 Jul 2015 17:37:06 +1000
Message-Id: <1436945834-26660-4-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1436945834-26660-1-git-send-email-mpe@ellerman.id.au>
References: <1436945834-26660-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

syscall_get_error() is unused, and never has been.

It's also probably wrong, as it negates r3 before returning it, but that
depends on what the caller is expecting.

It also doesn't deal with compat, and doesn't deal with TIF_NOERROR.

Although we could fix those, until it has a caller and it's clear what
semantics the caller wants it's just untested code. So drop it.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/syscall.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/powerpc/include/asm/syscall.h b/arch/powerpc/include/asm/syscall.h
index ff21b7a2f0cc..c6239dabcfb1 100644
--- a/arch/powerpc/include/asm/syscall.h
+++ b/arch/powerpc/include/asm/syscall.h
@@ -34,12 +34,6 @@ static inline void syscall_rollback(struct task_struct *task,
 	regs->gpr[3] = regs->orig_gpr3;
 }
 
-static inline long syscall_get_error(struct task_struct *task,
-				     struct pt_regs *regs)
-{
-	return (regs->ccr & 0x10000000) ? -regs->gpr[3] : 0;
-}
-
 static inline long syscall_get_return_value(struct task_struct *task,
 					    struct pt_regs *regs)
 {
-- 
2.1.0
