Return-Path: <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <michael@ellerman.id.au>
From: Michael Neuling <mikey@neuling.org>
Date: Thu, 21 Jun 2012 12:04:39 +1000
Subject: [PATCH 12/18] powerpc: fix VSX macros so register names aren't wrapped
In-Reply-To: <1340244266.960241.475925824909.qpush@ale>
Message-Id: <20120621020439.59C98D4325E@localhost.localdomain>
Cc: mikey@neuling.org, linuxppc-dev@ozlabs.org, schwab@linux-m68k.org,
 Anton Blanchard <anton@samba.org>, Olof Johannsson <olof@lixom.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We need to do this so we can enforce the name of a and b in called
macros PPC_RA/B later.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---

 arch/powerpc/include/asm/ppc-opcode.h |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Index: powerpc-test/arch/powerpc/include/asm/ppc-opcode.h
===================================================================
--- powerpc-test.orig/arch/powerpc/include/asm/ppc-opcode.h
+++ powerpc-test/arch/powerpc/include/asm/ppc-opcode.h
@@ -234,11 +234,11 @@
 #define VSX_XX1(s, a, b)	(__PPC_XS(s) | __PPC_RA(a) | __PPC_RB(b))
 #define VSX_XX3(t, a, b)	(__PPC_XT(t) | __PPC_XA(a) | __PPC_XB(b))
 #define STXVD2X(s, a, b)	stringify_in_c(.long PPC_INST_STXVD2X | \
-					       VSX_XX1((s), (a), (b)))
+					       VSX_XX1((s), a, b))
 #define LXVD2X(s, a, b)		stringify_in_c(.long PPC_INST_LXVD2X | \
-					       VSX_XX1((s), (a), (b)))
+					       VSX_XX1((s), a, b))
 #define XXLOR(t, a, b)		stringify_in_c(.long PPC_INST_XXLOR | \
-					       VSX_XX3((t), (a), (b)))
+					       VSX_XX3((t), a, b))
 
 #define PPC_NAP			stringify_in_c(.long PPC_INST_NAP)
 #define PPC_SLEEP		stringify_in_c(.long PPC_INST_SLEEP)
