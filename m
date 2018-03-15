Return-Path: <msuchanek@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 402JGw0FYtzF15q
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Mar 2018 06:16:24 +1100 (AEDT)
From: Michal Suchanek <msuchanek@suse.de>
To: linuxppc-dev@lists.ozlabs.org
Cc: Kate Stewart <kstewart@linuxfoundation.org>,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, Michael Neuling <mikey@neuling.org>,
 "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>,
 Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
 "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Daniel Axtens <dja@axtens.net>, Nicholas Piggin <npiggin@gmail.com>,
 Al Viro <viro@zeniv.linux.org.uk>,
 David Gibson <david@gibson.dropbear.id.au>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Philippe Ombredanne <pombredanne@nexb.com>, Joe Perches <joe@perches.com>,
 Oliver O'Halloran <oohall@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Tobin C. Harding" <me@tobin.cc>, Michal Suchanek <msuchanek@suse.de>
Subject: [PATCH RFC rebase 1/9] powerpc: Add barrier_nospec
Date: Thu, 15 Mar 2018 20:15:50 +0100
Message-Id: <8cb7d41beef9bdd351120d0512f73ac3bfada168.1521141122.git.msuchanek@suse.de>
In-Reply-To: <cover.1521141122.git.msuchanek@suse.de>
References: <20180313200108.GA4082@hirez.programming.kicks-ass.net>
 <cover.1521141122.git.msuchanek@suse.de>
In-Reply-To: <cover.1521141122.git.msuchanek@suse.de>
References: <cover.1521141122.git.msuchanek@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When the firmware supports it an otherwise useless combination of ORI
instruction arguments is interpreted as speculation barrier. Implement
barrier_nospec using this instruction.

Based on the out-of-tree gmb() implementation.

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 arch/powerpc/include/asm/barrier.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/powerpc/include/asm/barrier.h b/arch/powerpc/include/asm/barrier.h
index 10daa1d56e0a..8e47b3abe405 100644
--- a/arch/powerpc/include/asm/barrier.h
+++ b/arch/powerpc/include/asm/barrier.h
@@ -75,6 +75,15 @@ do {									\
 	___p1;								\
 })
 
+/* TODO: add patching so this can be disabled */
+/* Prevent speculative execution past this barrier. */
+#define barrier_nospec_asm ori 31,31,0
+#ifdef __ASSEMBLY__
+#define barrier_nospec barrier_nospec_asm
+#else
+#define barrier_nospec() __asm__ __volatile__ (stringify_in_c(barrier_nospec_asm) : : :)
+#endif
+
 #include <asm-generic/barrier.h>
 
 #endif /* _ASM_POWERPC_BARRIER_H */
-- 
2.13.6
