Return-Path: <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <michael@ellerman.id.au>
From: Michael Neuling <mikey@neuling.org>
Date: Thu, 14 Jun 2012 16:15:50 +1000
Subject: [PATCH 14/18] powerpc: start using ___PPC_RA/B/S/T where necessary
In-Reply-To: <1339654536.159274.140684871779.qpush@ale>
Message-Id: <20120614061550.7F0BFD439BB@localhost.localdomain>
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

Now have ___PPC_RA/B/S/T we can use it in some places.  These are
places where we can't use the existing defines which will soon enforce
R0-R31 usage.  

The macros being changed here are being used in inline asm, which
can't convert to enforce the R0-R31 usage.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---

 arch/powerpc/include/asm/ppc-opcode.h |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

Index: powerpc-test/arch/powerpc/include/asm/ppc-opcode.h
===================================================================
--- powerpc-test.orig/arch/powerpc/include/asm/ppc-opcode.h
+++ powerpc-test/arch/powerpc/include/asm/ppc-opcode.h
@@ -147,13 +147,13 @@
 #define	PPC_DCBZL(a, b)		stringify_in_c(.long PPC_INST_DCBZL | \
 					__PPC_RA(a) | __PPC_RB(b))
 #define PPC_LDARX(t, a, b, eh)	stringify_in_c(.long PPC_INST_LDARX | \
-					__PPC_RT(t) | __PPC_RA(a) | \
-					__PPC_RB(b) | __PPC_EH(eh))
+					___PPC_RT(t) | ___PPC_RA(a) | \
+					___PPC_RB(b) | __PPC_EH(eh))
 #define PPC_LWARX(t, a, b, eh)	stringify_in_c(.long PPC_INST_LWARX | \
-					__PPC_RT(t) | __PPC_RA(a) | \
-					__PPC_RB(b) | __PPC_EH(eh))
+					___PPC_RT(t) | ___PPC_RA(a) | \
+					___PPC_RB(b) | __PPC_EH(eh))
 #define PPC_MSGSND(b)		stringify_in_c(.long PPC_INST_MSGSND | \
-					__PPC_RB(b))
+					___PPC_RB(b))
 #define PPC_POPCNTB(a, s)	stringify_in_c(.long PPC_INST_POPCNTB | \
 					__PPC_RA(a) | __PPC_RS(s))
 #define PPC_POPCNTD(a, s)	stringify_in_c(.long PPC_INST_POPCNTD | \
@@ -171,7 +171,7 @@
 #define PPC_WAIT(w)		stringify_in_c(.long PPC_INST_WAIT | \
 					__PPC_WC(w))
 #define PPC_TLBIE(lp,a) 	stringify_in_c(.long PPC_INST_TLBIE | \
-					       __PPC_RB(a) | __PPC_RS(lp))
+					       ___PPC_RB(a) | ___PPC_RS(lp))
 #define PPC_TLBSRX_DOT(a,b)	stringify_in_c(.long PPC_INST_TLBSRX_DOT | \
 					__PPC_RA(a) | __PPC_RB(b))
 #define PPC_TLBIVAX(a,b)	stringify_in_c(.long PPC_INST_TLBIVAX | \
