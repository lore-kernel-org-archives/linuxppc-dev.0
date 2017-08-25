Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xdpBc5pBfzDrK4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Aug 2017 14:31:04 +1000 (AEST)
Received: by mail-pg0-x242.google.com with SMTP id t3so2161998pgt.5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Aug 2017 21:31:04 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>, kvm-ppc@vger.kernel.org,
 Paul Mackerras <paulus@ozlabs.org>
Subject: [PATCH v3 3/4] powerpc/64s: idle POWER9 can execute stop in virtual
 mode
Date: Fri, 25 Aug 2017 14:30:35 +1000
Message-Id: <20170825043036.18236-4-npiggin@gmail.com>
In-Reply-To: <20170825043036.18236-1-npiggin@gmail.com>
References: <20170825043036.18236-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The hardware can execute stop in any context, and KVM does not
require real mode because siblings do not share MMU state. This
saves a switch to real-mode when going idle.

Acked-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/idle_book3s.S | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/powerpc/kernel/idle_book3s.S b/arch/powerpc/kernel/idle_book3s.S
index 14e97f442167..32d65ee323a0 100644
--- a/arch/powerpc/kernel/idle_book3s.S
+++ b/arch/powerpc/kernel/idle_book3s.S
@@ -195,7 +195,16 @@ pnv_powersave_common:
 	std	r5,_CCR(r1)
 	std	r1,PACAR1(r13)
 
+BEGIN_FTR_SECTION
+	/*
+	 * POWER9 does not require real mode to stop, and presently does not
+	 * set hwthread_state for KVM (threads don't share MMU context), so
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
2.13.3
