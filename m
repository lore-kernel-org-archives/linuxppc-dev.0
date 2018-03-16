Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-wr0-x242.google.com (mail-wr0-x242.google.com
 [IPv6:2a00:1450:400c:c0c::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 402jH556njzF07s
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Mar 2018 22:02:57 +1100 (AEDT)
Received: by mail-wr0-x242.google.com with SMTP id s18so11222450wrg.9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Mar 2018 04:02:57 -0700 (PDT)
Sender: Mathieu Malaterre <mathieu.malaterre@gmail.com>
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 Mathieu Malaterre <malat@debian.org>
Subject: [PATCH 11/19] ppc64: change %lx into %x
Date: Fri, 16 Mar 2018 12:02:16 +0100
Message-Id: <20180316110224.12260-12-malat@debian.org>
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
../arch/powerpc/xmon/xmon.c: In function ‘dump_one_paca’:
../arch/powerpc/xmon/xmon.c:2380:43: error: format ‘%lx’ expects argument of type ‘long unsigned int’, but argument 3 has type ‘u32 {aka unsigned int}’ [-Werror=format=]
   printf(" slb_cache[%d]:        = 0x%016lx\n", i, p->slb_cache[i]);
                                           ^
cc1: all warnings being treated as errors

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/xmon/xmon.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index e706139030ad..7eb656274ea7 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -2374,7 +2374,7 @@ static void dump_one_paca(int cpu)
 	DUMP(p, vmalloc_sllp, "x");
 	DUMP(p, slb_cache_ptr, "x");
 	for (i = 0; i < SLB_CACHE_ENTRIES; i++)
-		printf(" slb_cache[%d]:        = 0x%016lx\n", i, p->slb_cache[i]);
+		printf(" slb_cache[%d]:        = 0x%016x\n", i, p->slb_cache[i]);
 
 	DUMP(p, rfi_flush_fallback_area, "px");
 #endif
@@ -3851,9 +3851,9 @@ static void dump_spu_fields(struct spu *spu)
 	DUMP_FIELD(spu, "0x%lx", class_0_dar);
 	DUMP_FIELD(spu, "0x%lx", class_1_dar);
 	DUMP_FIELD(spu, "0x%lx", class_1_dsisr);
-	DUMP_FIELD(spu, "0x%lx", irqs[0]);
-	DUMP_FIELD(spu, "0x%lx", irqs[1]);
-	DUMP_FIELD(spu, "0x%lx", irqs[2]);
+	DUMP_FIELD(spu, "0x%x", irqs[0]);
+	DUMP_FIELD(spu, "0x%x", irqs[1]);
+	DUMP_FIELD(spu, "0x%x", irqs[2]);
 	DUMP_FIELD(spu, "0x%x", slb_replace);
 	DUMP_FIELD(spu, "%d", pid);
 	DUMP_FIELD(spu, "0x%p", mm);
-- 
2.11.0
