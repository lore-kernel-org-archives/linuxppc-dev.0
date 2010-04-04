Return-Path: <bigeasy@Chamillionaire.breakpoint.cc>
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc
	[85.10.199.196])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9AA15B7D6E
	for <linuxppc-dev@ozlabs.org>; Mon,  5 Apr 2010 06:40:54 +1000 (EST)
From: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 1/3] powerpc/head fsl: fix the case where we are not in the
	first page
Date: Sun,  4 Apr 2010 22:19:01 +0200
Message-Id: <1270412343-19334-2-git-send-email-sebastian@breakpoint.cc>
In-Reply-To: <1270412343-19334-1-git-send-email-sebastian@breakpoint.cc>
References: <1270412343-19334-1-git-send-email-sebastian@breakpoint.cc>
Cc: linuxppc-dev@ozlabs.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

During boot we change the mapping a few times until we have a "defined"
mapping. During this procedure a small 4KiB mapping is created and after
that one a 64MiB. Currently the offset of the 4KiB page in that we run
is zero because the complete startup up code is in first page which
starts at RPN zero.
If the code is recycled and moved to another location then its execution
will fail because the start address in 64 MiB mapping is computed
wrongly. It does not consider the offset to the page from the begin of
the memory.
This patch fixes this. Usually (system boot) r25 is zero so this does
not change anything unless the code is recycled.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/powerpc/kernel/head_fsl_booke.S |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kernel/head_fsl_booke.S
index 7255265..9d00418 100644
--- a/arch/powerpc/kernel/head_fsl_booke.S
+++ b/arch/powerpc/kernel/head_fsl_booke.S
@@ -275,6 +275,7 @@ skpinv:	addi	r6,r6,1				/* Increment */
 1:	mflr	r9
 	rlwimi	r6,r9,0,20,31
 	addi	r6,r6,(2f - 1b)
+	add	r6, r6, r25
 	mtspr	SPRN_SRR0,r6
 	mtspr	SPRN_SRR1,r7
 	rfi				/* start execution out of TLB1[0] entry */
-- 
1.6.6.1
