Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s7rNJ0DlxzDqQ5
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Aug 2016 20:38:24 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: gwshan@linux.vnet.ibm.com, naveen.n.rao@linux.vnet.ibm.com,
 Michael Neuling <mikey@neuling.org>
Subject: [PATCH stable 4.6 2/4] powerpc/bpf/jit: Disable classic BPF JIT on
 ppc64le
Date: Tue,  9 Aug 2016 20:38:06 +1000
Message-Id: <1470739088-17850-3-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1470739088-17850-1-git-send-email-mpe@ellerman.id.au>
References: <1470739088-17850-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>

commit 844e3be47693f92a108cb1fb3b0606bf25e9c7a6 upstream.

Backport required due to rename of HAVE_BPF_JIT to HAVE_CBPF_JIT
upstream - mpe.

Classic BPF JIT was never ported completely to work on little endian
powerpc. However, it can be enabled and will crash the system when used.
As such, disable use of BPF JIT on ppc64le.

Fixes: 7c105b63bd98 ("powerpc: Add CONFIG_CPU_LITTLE_ENDIAN kernel config option.")
Reported-by: Thadeu Lima de Souza Cascardo <cascardo@redhat.com>
Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Acked-by: Thadeu Lima de Souza Cascardo <cascardo@redhat.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 7cd32c038286..4e1b060b8481 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -126,7 +126,7 @@ config PPC
 	select IRQ_FORCED_THREADING
 	select HAVE_RCU_TABLE_FREE if SMP
 	select HAVE_SYSCALL_TRACEPOINTS
-	select HAVE_BPF_JIT
+	select HAVE_BPF_JIT if CPU_BIG_ENDIAN
 	select HAVE_ARCH_JUMP_LABEL
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
 	select ARCH_HAS_GCOV_PROFILE_ALL
-- 
2.7.4
