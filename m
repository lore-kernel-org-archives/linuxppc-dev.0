Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41DWv52BH0zF15L
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jun 2018 11:34:57 +1000 (AEST)
From: Michael Neuling <mikey@neuling.org>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
	mikey@neuling.org
Subject: [PATCH v2 2/2] powerpc: Document issues with TM on POWER9
Date: Mon, 25 Jun 2018 11:34:56 +1000
Message-Id: <20180625013456.16157-2-mikey@neuling.org>
In-Reply-To: <20180625013456.16157-1-mikey@neuling.org>
References: <20180625013456.16157-1-mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
v2:
  Spelling mistakes :-/
---
 .../powerpc/transactional_memory.txt          | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/Documentation/powerpc/transactional_memory.txt b/Documentation/powerpc/transactional_memory.txt
index e32fdbb4c9..52c023e14f 100644
--- a/Documentation/powerpc/transactional_memory.txt
+++ b/Documentation/powerpc/transactional_memory.txt
@@ -198,3 +198,47 @@ presented).  The transaction cannot then be continued and will take the failure
 handler route.  Furthermore, the transactional 2nd register state will be
 inaccessible.  GDB can currently be used on programs using TM, but not sensibly
 in parts within transactions.
+
+POWER9
+======
+
+TM on POWER9 has issues with storing the complete register state. This
+is described in this commit:
+
+    commit 4bb3c7a0208fc13ca70598efd109901a7cd45ae7
+    Author: Paul Mackerras <paulus@ozlabs.org>
+    Date:   Wed Mar 21 21:32:01 2018 +1100
+    KVM: PPC: Book3S HV: Work around transactional memory bugs in POWER9
+
+To account for this different POWER9 chips have TM enabled in
+different ways.
+
+On POWER9N DD2.01 and below, TM is disabled. ie
+HWCAP2[PPC_FEATURE2_HTM] is not set.
+
+On POWER9N DD2.1 TM is configured by firmware to always abort a
+transaction when tm suspend occurs. So tsuspend will cause a
+transaction to be aborted and rolled back. Kernel exceptions will also
+cause the transaction to be aborted and rolled back and the exception
+will not occur. If userspace constructs a sigcontext that enables TM
+suspend, the sigcontext will be rejected by the kernel. This mode is
+advertised to users with HWCAP2[PPC_FEATURE2_HTM_NO_SUSPEND] set.
+HWCAP2[PPC_FEATURE2_HTM] is not set in this mode.
+
+On POWER9N DD2.2 and above, KVM and POWERVM emulate TM for guests (as
+described in commit 4bb3c7a0208f), hence TM is enabled for guests
+ie. HWCAP2[PPC_FEATURE2_HTM] is set for guest userspace. Guests that
+makes heavy use of TM suspend (tsuspend or kernel suspend) will result
+in traps into the hypervisor and hence will suffer a performance
+degradation. Host userspace has TM disabled
+ie. HWCAP2[PPC_FEATURE2_HTM] is not set. (although we make enable it
+at some point in the future if we bring the emulation into host
+userspace context switching).
+
+POWER9C DD1.2 and above are only available with POWERVM and hence
+Linux only runs as a guest. On these systems TM is emulated like on
+POWER9N DD2.2.
+
+Guest migration from POWER8 to POWER9 will work with POWER9N DD2.2 and
+POWER9C DD1.2. Since earlier POWER9 processors don't support TM
+emulation, migration from POWER8 to POWER9 is not supported there.
-- 
2.17.1
