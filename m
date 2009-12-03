Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 9097BB840B
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Dec 2009 10:32:07 +1100 (EST)
Date: Fri, 4 Dec 2009 02:32:06 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: systemtap@sourceware.org
Subject: [PATCH 4/4] powerpc: Improve backtrace output for ppc32
Message-ID: <20091203233206.GD3416@oksana.dev.rtsoft.ru>
References: <20091203233059.GA28186@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20091203233059.GA28186@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org, Jim Keniston <jkenisto@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

0x%016lx format causes a lot of unnecessary zero-padding on ppc32, so
let's use %p instead.

Before:

--- Exception: c00095c8 at 0xc02cff60 : _edata+0x1f60/0x2000 [kernel]
    LR =0xc02aef58 : per_cpu__runqueues+0x0/0x400 [kernel]
[0x00000000c02cfed0] [0x00000000c00113fc] 0xc00113fc : ret_from_except+0x0/0x14 [kernel] (unreliable)

After:

--- Exception: c00095c8 at 0xc02cff60 : _edata+0x1f60/0x2000 [kernel]
    LR =0xc02aef58 : per_cpu__runqueues+0x0/0x400 [kernel]
[0xc02cfed0] [0xc00113fc] 0xc00113fc : ret_from_except+0x0/0x14 [kernel] (unreliable)

p.s.
Note that the second and the third columns are dups, this is because
_stp_symbol_print(ip) also prints ip. Though, for now I wouldn't touch
this since I'm not sure if anybody depends on the current columns count
or "[]" around addresses.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 runtime/stack-ppc.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/runtime/stack-ppc.c b/runtime/stack-ppc.c
index df2db15..e3b3ede 100644
--- a/runtime/stack-ppc.c
+++ b/runtime/stack-ppc.c
@@ -24,14 +24,15 @@ static void __stp_stack_print (struct pt_regs *regs, int verbose, int levels,
 		ip = _sp[STACK_FRAME_LR_SAVE];
 		if (!firstframe || ip != lr) {
 			if (verbose) {
-				_stp_printf("[0x%016lx] [0x%016lx] ", sp, ip);
+				_stp_printf("[%p] [%p] ",
+					    (int64_t)sp, (int64_t)ip);
 				_stp_symbol_print(ip);
 				if (firstframe)
 					_stp_print(" (unreliable)");
 				_stp_print_char('\n');
 			}
 			else
-				_stp_printf("0x%016lx ", ip);
+				_stp_printf("%p ", (int64_t)ip);
 		}
 		firstframe = 0;
 		/*
@@ -52,8 +53,8 @@ static void __stp_stack_print (struct pt_regs *regs, int verbose, int levels,
 				firstframe = 1;
 			}
 			else {
-				_stp_printf("0x%016lx ",regs->nip);
-				_stp_printf("0x%016lx ",regs->link);
+				_stp_printf("%p ", (int64_t)regs->nip);
+				_stp_printf("%p ", (int64_t)regs->link);
 			}
 		}
 
-- 
1.6.3.3
