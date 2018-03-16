Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-wm0-x241.google.com (mail-wm0-x241.google.com
 [IPv6:2a00:1450:400c:c09::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 402jTG5PgJzDrNC
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Mar 2018 22:11:46 +1100 (AEDT)
Received: by mail-wm0-x241.google.com with SMTP id u10so2317941wmu.4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Mar 2018 04:11:46 -0700 (PDT)
Sender: Mathieu Malaterre <mathieu.malaterre@gmail.com>
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 Mathieu Malaterre <malat@debian.org>
Subject: [PATCH 16/19] ppc64: Change %d into %lu
Date: Fri, 16 Mar 2018 12:02:21 +0100
Message-Id: <20180316110224.12260-17-malat@debian.org>
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

  CC      arch/powerpc/xmon/spu-dis.o
../arch/powerpc/xmon/spu-dis.c: In function ‘print_insn_spu’:
../arch/powerpc/xmon/spu-dis.c:137:18: error: format ‘%d’ expects argument of type ‘int’, but argument 2 has type ‘long unsigned int’ [-Werror=format=]
        printf("$%d",
                  ^
../arch/powerpc/xmon/spu-dis.c:141:18: error: format ‘%d’ expects argument of type ‘int’, but argument 2 has type ‘long unsigned int’ [-Werror=format=]
        printf("$%d",
                  ^
../arch/powerpc/xmon/spu-dis.c:145:18: error: format ‘%d’ expects argument of type ‘int’, but argument 2 has type ‘long unsigned int’ [-Werror=format=]
        printf("$%d",
                  ^
../arch/powerpc/xmon/spu-dis.c:149:18: error: format ‘%d’ expects argument of type ‘int’, but argument 2 has type ‘long unsigned int’ [-Werror=format=]
        printf("$%d",
                  ^
../arch/powerpc/xmon/spu-dis.c:153:20: error: format ‘%d’ expects argument of type ‘int’, but argument 2 has type ‘long unsigned int’ [-Werror=format=]
        printf("$sp%d",
                    ^
../arch/powerpc/xmon/spu-dis.c:157:20: error: format ‘%d’ expects argument of type ‘int’, but argument 2 has type ‘long unsigned int’ [-Werror=format=]
        printf("$ch%d",
                    ^
../arch/powerpc/xmon/spu-dis.c:165:17: error: format ‘%d’ expects argument of type ‘int’, but argument 2 has type ‘long unsigned int’ [-Werror=format=]
        printf("%d",
                 ^
../arch/powerpc/xmon/spu-dis.c:169:17: error: format ‘%d’ expects argument of type ‘int’, but argument 2 has type ‘long unsigned int’ [-Werror=format=]
        printf("%d",
                 ^
cc1: all warnings being treated as errors

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/xmon/spu-dis.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/xmon/spu-dis.c b/arch/powerpc/xmon/spu-dis.c
index 6b83b680b9f6..4cbc7da88524 100644
--- a/arch/powerpc/xmon/spu-dis.c
+++ b/arch/powerpc/xmon/spu-dis.c
@@ -134,27 +134,27 @@ print_insn_spu (unsigned long insn, unsigned long memaddr)
 	  switch (arg)
 	    {
 	    case A_T:
-	      printf("$%d",
+	      printf("$%lu",
 				     DECODE_INSN_RT (insn));
 	      break;
 	    case A_A:
-	      printf("$%d",
+	      printf("$%lu",
 				     DECODE_INSN_RA (insn));
 	      break;
 	    case A_B:
-	      printf("$%d",
+	      printf("$%lu",
 				     DECODE_INSN_RB (insn));
 	      break;
 	    case A_C:
-	      printf("$%d",
+	      printf("$%lu",
 				     DECODE_INSN_RC (insn));
 	      break;
 	    case A_S:
-	      printf("$sp%d",
+	      printf("$sp%lu",
 				     DECODE_INSN_RA (insn));
 	      break;
 	    case A_H:
-	      printf("$ch%d",
+	      printf("$ch%lu",
 				     DECODE_INSN_RA (insn));
 	      break;
 	    case A_P:
@@ -162,11 +162,11 @@ print_insn_spu (unsigned long insn, unsigned long memaddr)
 	      printf("(");
 	      break;
 	    case A_U7A:
-	      printf("%d",
+	      printf("%lu",
 				     173 - DECODE_INSN_U8 (insn));
 	      break;
 	    case A_U7B:
-	      printf("%d",
+	      printf("%lu",
 				     155 - DECODE_INSN_U8 (insn));
 	      break;
 	    case A_S3:
-- 
2.11.0
