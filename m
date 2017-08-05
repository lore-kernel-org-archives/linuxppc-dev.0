Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xPqr83CBfzDqkr
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  6 Aug 2017 03:03:36 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id p13so4853409pfd.4
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 05 Aug 2017 10:03:36 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@ozlabs.org>
Subject: [PATCH 12/13] powerpc/64s: idle POWER9 can execute stop in virtual
 mode
Date: Sun,  6 Aug 2017 03:02:40 +1000
Message-Id: <20170805170241.22966-13-npiggin@gmail.com>
In-Reply-To: <20170805170241.22966-1-npiggin@gmail.com>
References: <20170805170241.22966-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The hardware can execute stop in any context, and KVM does not
require real mode. This saves a switch to real-mode when going
idle.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/idle_book3s.S | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/powerpc/kernel/idle_book3s.S b/arch/powerpc/kernel/idle_book3s.S
index 75746111e2c4..8ac366a51bb5 100644
--- a/arch/powerpc/kernel/idle_book3s.S
+++ b/arch/powerpc/kernel/idle_book3s.S
@@ -141,7 +141,16 @@ pnv_powersave_common:
 	std	r5,_CCR(r1)
 	std	r1,PACAR1(r13)
 
+BEGIN_FTR_SECTION
+	/*
+	 * POWER9 does not require real mode to stop, and does not set
+	 * hwthread_state for KVM (threads don't share MMU context), so
+	 * we can remain in virtual mode for this.
+	 */
+	bctr
+END_FTR_SECTION_IFSET(CPU_FTR_ARCH_300)
 	/*
+	 * POWER8
 	 * Go to real mode to do the nap, as required by the architecture.
 	 * Also, we need to be in real mode before setting hwthread_state,
 	 * because as soon as we do that, another thread can switch
-- 
2.11.0
