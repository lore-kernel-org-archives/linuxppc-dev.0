Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-wr0-x242.google.com (mail-wr0-x242.google.com
 [IPv6:2a00:1450:400c:c0c::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 402jH22KZXzDrJK
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Mar 2018 22:02:54 +1100 (AEDT)
Received: by mail-wr0-x242.google.com with SMTP id k3so11262951wrg.6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Mar 2018 04:02:54 -0700 (PDT)
Sender: Mathieu Malaterre <mathieu.malaterre@gmail.com>
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 Mathieu Malaterre <malat@debian.org>
Subject: [PATCH 06/19] ppc64: change %lx into %llx
Date: Fri, 16 Mar 2018 12:02:11 +0100
Message-Id: <20180316110224.12260-7-malat@debian.org>
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
../arch/powerpc/xmon/xmon.c: In function ‘dump_by_size’:
../arch/powerpc/xmon/xmon.c:2570:16: error: format ‘%lx’ expects argument of type ‘long unsigned int’, but argument 3 has type ‘u64 {aka long long unsigned int}’ [-Werror=format=]
    printf("%0*lx", size * 2, val);
                ^
cc1: all warnings being treated as errors

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/xmon/xmon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 0d74c0d1a0bf..738888e6a927 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -2564,7 +2564,7 @@ static void dump_by_size(unsigned long addr, long count, int size)
 			default: val = 0;
 			}
 
-			printf("%0*lx", size * 2, val);
+			printf("%0*llx", size * 2, val);
 		}
 		printf("\n");
 	}
-- 
2.11.0
