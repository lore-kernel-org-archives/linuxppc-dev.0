Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-wm0-x244.google.com (mail-wm0-x244.google.com
 [IPv6:2a00:1450:400c:c09::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 402jGz1VGQzDrLP
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Mar 2018 22:02:50 +1100 (AEDT)
Received: by mail-wm0-x244.google.com with SMTP id w128so2291166wmw.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Mar 2018 04:02:50 -0700 (PDT)
Sender: Mathieu Malaterre <mathieu.malaterre@gmail.com>
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 Mathieu Malaterre <malat@debian.org>
Subject: [PATCH 02/19] ppc32: change %x into %lx
Date: Fri, 16 Mar 2018 12:02:07 +0100
Message-Id: <20180316110224.12260-3-malat@debian.org>
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
../arch/powerpc/xmon/xmon.c: In function ‘memdiffs’:
../arch/powerpc/xmon/xmon.c:2866:17: error: format ‘%x’ expects argument of type ‘unsigned int’, but argument 2 has type ‘unsigned char *’ [-Werror=format=]
     printf("%.16x %.2x # %.16x %.2x\n", p1 - 1,
                 ^
../arch/powerpc/xmon/xmon.c:2866:30: error: format ‘%x’ expects argument of type ‘unsigned int’, but argument 4 has type ‘unsigned char *’ [-Werror=format=]
     printf("%.16x %.2x # %.16x %.2x\n", p1 - 1,
                              ^
cc1: all warnings being treated as errors

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/xmon/xmon.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index ee113a6e008c..ee7a8c9a042b 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -1671,7 +1671,7 @@ static void prregs(struct pt_regs *fp)
 	}
 #else
 	for (n = 0; n < 32; ++n) {
-		printf("R%.2d = %.8x%s", n, fp->gpr[n],
+		printf("R%.2d = %.8lx%s", n, fp->gpr[n],
 		       (n & 3) == 3? "\n": "   ");
 		if (n == 12 && !FULL_REGS(fp)) {
 			printf("\n");
@@ -2728,7 +2728,7 @@ generic_inst_dump(unsigned long adr, long count, int praddr,
 		dotted = 0;
 		last_inst = inst;
 		if (praddr)
-			printf(REG"  %.8x", adr, inst);
+			printf(REG"  %.8lx", adr, inst);
 		printf("\t");
 		dump_func(inst, adr);
 		printf("\n");
@@ -2920,13 +2920,13 @@ memzcan(void)
 		if (ok && !ook) {
 			printf("%.8x .. ", a);
 		} else if (!ok && ook)
-			printf("%.8x\n", a - mskip);
+			printf("%.8lx\n", a - mskip);
 		ook = ok;
 		if (a + mskip < a)
 			break;
 	}
 	if (ook)
-		printf("%.8x\n", a - mskip);
+		printf("%.8lx\n", a - mskip);
 }
 
 static void show_task(struct task_struct *tsk)
-- 
2.11.0
