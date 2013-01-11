Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org, Ian Munsie <imunsie@au1.ibm.com>
Subject: [PATCH] powerpc: Fix typo in breakpoint kgdb code.
In-reply-to: <1356048405-20560-7-git-send-email-mikey@neuling.org>
References: <1356048405-20560-1-git-send-email-mikey@neuling.org>
 <1356048405-20560-7-git-send-email-mikey@neuling.org>
Date: Fri, 11 Jan 2013 13:11:11 +1100
Message-ID: <19922.1357870271@ale.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently we are getting: 
 arch/powerpc/kernel/kgdb.c: In function 'kgdb_arch_exit':
 arch/powerpc/kernel/kgdb.c:492:2: error: '__debugger_breakx_match' undeclared (first use in this function)
 arch/powerpc/kernel/kgdb.c:492:2: note: each undeclared identifier is reported only once for each function it appears in

Fix the typo.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
Stupid error.  I guess my defconfigs didn't compile this
code... sorry.

diff --git a/arch/powerpc/kernel/kgdb.c b/arch/powerpc/kernel/kgdb.c
index a05f0e4..8747447 100644
--- a/arch/powerpc/kernel/kgdb.c
+++ b/arch/powerpc/kernel/kgdb.c
@@ -489,6 +489,6 @@ void kgdb_arch_exit(void)
 	__debugger_bpt = old__debugger_bpt;
 	__debugger_sstep = old__debugger_sstep;
 	__debugger_iabr_match = old__debugger_iabr_match;
-	__debugger_breakx_match = old__debugger_break_match;
+	__debugger_break_match = old__debugger_break_match;
 	__debugger_fault_handler = old__debugger_fault_handler;
 }
