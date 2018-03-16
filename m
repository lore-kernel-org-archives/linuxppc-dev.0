Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-wr0-x242.google.com (mail-wr0-x242.google.com
 [IPv6:2a00:1450:400c:c0c::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 402jTF743RzDqj7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Mar 2018 22:11:45 +1100 (AEDT)
Received: by mail-wr0-x242.google.com with SMTP id v65so11252310wrc.11
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Mar 2018 04:11:45 -0700 (PDT)
Sender: Mathieu Malaterre <mathieu.malaterre@gmail.com>
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 Mathieu Malaterre <malat@debian.org>
Subject: [PATCH 18/19] ppc64: change %ld into %d
Date: Fri, 16 Mar 2018 12:02:23 +0100
Message-Id: <20180316110224.12260-19-malat@debian.org>
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
../arch/powerpc/xmon/xmon.c: In function ‘prregs’:
../arch/powerpc/xmon/xmon.c:1665:17: error: format ‘%ld’ expects argument of type ‘long int’, but argument 2 has type ‘int’ [-Werror=format=]
    printf("R%.2ld = "REG"   R%.2ld = "REG"\n",
                 ^
../arch/powerpc/xmon/xmon.c:1665:11: error: format ‘%ld’ expects argument of type ‘long int’, but argument 4 has type ‘int’ [-Werror=format=]
    printf("R%.2ld = "REG"   R%.2ld = "REG"\n",
           ^~~~~~~~~~~
../arch/powerpc/xmon/xmon.c:1669:17: error: format ‘%ld’ expects argument of type ‘long int’, but argument 2 has type ‘int’ [-Werror=format=]
    printf("R%.2ld = "REG"   R%.2ld = "REG"\n",
                 ^
../arch/powerpc/xmon/xmon.c:1669:11: error: format ‘%ld’ expects argument of type ‘long int’, but argument 4 has type ‘int’ [-Werror=format=]
    printf("R%.2ld = "REG"   R%.2ld = "REG"\n",
           ^~~~~~~~~~~
cc1: all warnings being treated as errors

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/xmon/xmon.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 4479245c6361..a87f14a24849 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -1662,11 +1662,11 @@ static void prregs(struct pt_regs *fp)
 #ifdef CONFIG_PPC64
 	if (FULL_REGS(fp)) {
 		for (n = 0; n < 16; ++n)
-			printf("R%.2ld = "REG"   R%.2ld = "REG"\n",
+			printf("R%.2d = "REG"   R%.2d = "REG"\n",
 			       n, fp->gpr[n], n+16, fp->gpr[n+16]);
 	} else {
 		for (n = 0; n < 7; ++n)
-			printf("R%.2ld = "REG"   R%.2ld = "REG"\n",
+			printf("R%.2d = "REG"   R%.2d = "REG"\n",
 			       n, fp->gpr[n], n+7, fp->gpr[n+7]);
 	}
 #else
-- 
2.11.0
