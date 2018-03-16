Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-wm0-x243.google.com (mail-wm0-x243.google.com
 [IPv6:2a00:1450:400c:c09::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 402jH15qdXzF08D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Mar 2018 22:02:53 +1100 (AEDT)
Received: by mail-wm0-x243.google.com with SMTP id h21so2267288wmd.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Mar 2018 04:02:53 -0700 (PDT)
Sender: Mathieu Malaterre <mathieu.malaterre@gmail.com>
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 Mathieu Malaterre <malat@debian.org>
Subject: [PATCH 05/19] ppc32: change %lx into %tx (ptrdiff_t)
Date: Fri, 16 Mar 2018 12:02:10 +0100
Message-Id: <20180316110224.12260-6-malat@debian.org>
In-Reply-To: <20180316110224.12260-1-malat@debian.org>
References: <20180316110224.12260-1-malat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

  CC      arch/powerpc/xmon/xmon.o
arch/powerpc/xmon/xmon.c: In function ‘xmon_core’:
arch/powerpc/xmon/xmon.c:630:36: error: format ‘%lx’ expects argument of type ‘long unsigned int’, but argument 2 has type ‘int’ [-Werror=format=]
    printf("Stopped at breakpoint %lx (", BP_NUM(bp));
                                    ^
arch/powerpc/xmon/xmon.c: In function ‘bpt_cmds’:
arch/powerpc/xmon/xmon.c:1365:32: error: format ‘%lx’ expects argument of type ‘long unsigned int’, but argument 2 has type ‘int’ [-Werror=format=]
   printf("Cleared breakpoint %lx (", BP_NUM(bp));
                                ^
cc1: all warnings being treated as errors

and

  CC      arch/powerpc/xmon/xmon.o
../arch/powerpc/xmon/xmon.c: In function ‘bpt_cmds’:
../arch/powerpc/xmon/xmon.c:1392:15: error: format ‘%x’ expects argument of type ‘unsigned int’, but argument 2 has type ‘long int’ [-Werror=format=]
     printf("%2x %s   ", BP_NUM(bp),
               ^
cc1: all warnings being treated as errors

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/xmon/xmon.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 15011be7a051..0d74c0d1a0bf 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -627,7 +627,7 @@ static int xmon_core(struct pt_regs *regs, int fromipi)
 		excprint(regs);
 		bp = at_breakpoint(regs->nip);
 		if (bp) {
-			printf("Stopped at breakpoint %lx (", BP_NUM(bp));
+			printf("Stopped at breakpoint %tx (", BP_NUM(bp));
 			xmon_print_symbol(regs->nip, " ", ")\n");
 		}
 		if (unrecoverable_excp(regs))
@@ -1362,7 +1362,7 @@ bpt_cmds(void)
 			}
 		}
 
-		printf("Cleared breakpoint %lx (", BP_NUM(bp));
+		printf("Cleared breakpoint %tx (", BP_NUM(bp));
 		xmon_print_symbol(bp->address, " ", ")\n");
 		bp->enabled = 0;
 		break;
@@ -1389,7 +1389,7 @@ bpt_cmds(void)
 			for (bp = bpts; bp < &bpts[NBPTS]; ++bp) {
 				if (!bp->enabled)
 					continue;
-				printf("%2x %s   ", BP_NUM(bp),
+				printf("%tx %s   ", BP_NUM(bp),
 				    (bp->enabled & BP_CIABR) ? "inst": "trap");
 				xmon_print_symbol(bp->address, "  ", "\n");
 			}
-- 
2.11.0
