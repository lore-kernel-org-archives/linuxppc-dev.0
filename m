Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-wr0-x243.google.com (mail-wr0-x243.google.com
 [IPv6:2a00:1450:400c:c0c::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 402jH00HBhzF07D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Mar 2018 22:02:51 +1100 (AEDT)
Received: by mail-wr0-x243.google.com with SMTP id o8so11327799wra.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Mar 2018 04:02:51 -0700 (PDT)
Sender: Mathieu Malaterre <mathieu.malaterre@gmail.com>
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 Mathieu Malaterre <malat@debian.org>
Subject: [PATCH 03/19] ppc32: Change %.16x into %p
Date: Fri, 16 Mar 2018 12:02:08 +0100
Message-Id: <20180316110224.12260-4-malat@debian.org>
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
arch/powerpc/xmon/xmon.c: In function ‘memdiffs’:
arch/powerpc/xmon/xmon.c:2863:17: error: format ‘%x’ expects argument of type ‘unsigned int’, but argument 2 has type ‘unsigned char *’ [-Werror=format=]
     printf("%.16x %.2x # %.16x %.2x\n", p1 - 1,
                 ^
arch/powerpc/xmon/xmon.c:2863:30: error: format ‘%x’ expects argument of type ‘unsigned int’, but argument 4 has type ‘unsigned char *’ [-Werror=format=]
     printf("%.16x %.2x # %.16x %.2x\n", p1 - 1,
                              ^
cc1: all warnings being treated as errors

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/xmon/xmon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index ee7a8c9a042b..f155f030550f 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -2860,7 +2860,7 @@ memdiffs(unsigned char *p1, unsigned char *p2, unsigned nb, unsigned maxpr)
 	for( n = nb; n > 0; --n )
 		if( *p1++ != *p2++ )
 			if( ++prt <= maxpr )
-				printf("%.16x %.2x # %.16x %.2x\n", p1 - 1,
+				printf("%p %.2x # %p %.2x\n", p1 - 1,
 					p1[-1], p2 - 1, p2[-1]);
 	if( prt > maxpr )
 		printf("Total of %d differences\n", prt);
-- 
2.11.0
