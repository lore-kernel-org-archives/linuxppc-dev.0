Return-Path: <anton@ozlabs.org>
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, rusty@rustcorp.com.au,
 ulrich.weigand@de.ibm.com, amodra@gmail.com, mikey@neuling.org,
 mjw@linux.vnet.ibm.com, rostedt@goodmis.org, philippe.bergheaud@fr.ibm.com
Subject: [PATCH 2/7] powerpc: ftrace_caller,
 _mcount is exported to modules so needs _GLOBAL_TOC()
Date: Fri,  4 Apr 2014 17:09:05 +1100
Message-Id: <1396591750-8203-3-git-send-email-anton@samba.org>
In-Reply-To: <1396591750-8203-1-git-send-email-anton@samba.org>
References: <1396591750-8203-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When testing the ftrace function tracer, I realised that ftrace_caller
and mcount are called from modules and they both call into C, therefore
they need the ABIv2 global entry point to establish r2.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/kernel/entry_64.S | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index cf4f6e6..9fde8a1 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -1175,7 +1175,7 @@ _GLOBAL(mcount)
 _GLOBAL(_mcount)
 	blr
 
-_GLOBAL(ftrace_caller)
+_GLOBAL_TOC(ftrace_caller)
 	/* Taken from output of objdump from lib64/glibc */
 	mflr	r3
 	ld	r11, 0(r1)
@@ -1199,10 +1199,7 @@ _GLOBAL(ftrace_graph_stub)
 _GLOBAL(ftrace_stub)
 	blr
 #else
-_GLOBAL(mcount)
-	blr
-
-_GLOBAL(_mcount)
+_GLOBAL_TOC(_mcount)
 	/* Taken from output of objdump from lib64/glibc */
 	mflr	r3
 	ld	r11, 0(r1)
-- 
1.8.3.2
