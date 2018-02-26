Return-Path: <sudeep.holla@arm.com>
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 3zqgmF0tjFzF1J4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Feb 2018 23:16:28 +1100 (AEDT)
From: Sudeep Holla <sudeep.holla@arm.com>
To: linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Subject: [RESEND][PATCH 1/2] powerpc/64: drop redundant defination of
 spin_until_cond
Date: Mon, 26 Feb 2018 12:16:15 +0000
Message-Id: <1519647376-3352-1-git-send-email-sudeep.holla@arm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

linux/processor.h has exactly same defination for spin_until_cond.
Drop the redundant defination in asm/processor.h

Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 arch/powerpc/include/asm/processor.h | 11 -----------
 1 file changed, 11 deletions(-)

Hi,
(Resending as I got some errors from the mail server today)

When I was planning to use spin_until_cond, I came across the same defination
at 2 different headers, one of which includes the other and takes care of
enabling the defination in case of undefinded condition.

I found it redundant, but I may be wrong.

Regards,
Sudeep

diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index 01299cdc9806..4816be3be02c 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -438,17 +438,6 @@ static inline unsigned long __pack_fe01(unsigned int fpmode)

 #define spin_end()	HMT_medium()

-#define spin_until_cond(cond)					\
-do {								\
-	if (unlikely(!(cond))) {				\
-		spin_begin();					\
-		do {						\
-			spin_cpu_relax();			\
-		} while (!(cond));				\
-		spin_end();					\
-	}							\
-} while (0)
-
 #else
 #define cpu_relax()	barrier()
 #endif
--
2.7.4
