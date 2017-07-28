Return-Path: <john.ogness@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a01:7a0:2:106d:700::1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xJtcC1mLNzDrS0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Jul 2017 01:51:07 +1000 (AEST)
From: John Ogness <john.ogness@linutronix.de>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: Avoid reserving hugepages twice on PPC32
Date: Fri, 28 Jul 2017 17:33:32 +0200
Message-ID: <87d18klgoj.fsf@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On PPC32, reserve_hugetlb_gpages() is already called in MMU_init().

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 arch/powerpc/kernel/setup-common.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 94a9482..1d5d2de 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -920,8 +920,11 @@ void __init setup_arch(char **cmdline_p)
 	 * Reserve any gigantic pages requested on the command line.
 	 * memblock needs to have been initialized by the time this is
 	 * called since this will reserve memory.
+	 * (PPC32 did this already in MMU_init())
 	 */
+#ifdef CONFIG_PPC64
 	reserve_hugetlb_gpages();
+#endif
 
 	klp_init_thread_info(&init_thread_info);
 
-- 
1.7.10.4
