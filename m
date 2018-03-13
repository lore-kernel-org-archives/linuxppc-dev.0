Return-Path: <msuchanek@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4013Qn2nRYzDrF3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Mar 2018 05:33:53 +1100 (AEDT)
From: Michal Suchanek <msuchanek@suse.de>
To: linuxppc-dev@lists.ozlabs.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Peter Zijlstra <peterz@infradead.org>, Michal Suchanek <msuchanek@suse.de>,
 Kate Stewart <kstewart@linuxfoundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Nicholas Piggin <npiggin@gmail.com>, "Tobin C. Harding" <me@tobin.cc>,
 Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Al Viro <viro@zeniv.linux.org.uk>, Michael Neuling <mikey@neuling.org>,
 "Oliver O'Halloran" <oohall@gmail.com>,
 "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Balbir Singh <bsingharora@gmail.com>,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 Christophe Leroy <christophe.leroy@c-s.fr>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Daniel Axtens <dja@axtens.net>, Russell Currey <ruscur@russell.cc>,
 Joe Perches <joe@perches.com>,
 "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 linux-kernel@vger.kernel.org
Subject: [PATCH RFC 1/8] powerpc: Add barrier_nospec
Date: Tue, 13 Mar 2018 19:32:59 +0100
Message-Id: <e1c146e5d43e8b2605af6e1330167d8e18d36f44.1520965380.git.msuchanek@suse.de>
In-Reply-To: <cover.1520965380.git.msuchanek@suse.de>
References: <cover.1520965380.git.msuchanek@suse.de>
In-Reply-To: <cover.1520965380.git.msuchanek@suse.de>
References: <cover.1520965380.git.msuchanek@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Copypasta from original gmb() and rfi implementation

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
