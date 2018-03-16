Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-wr0-x244.google.com (mail-wr0-x244.google.com
 [IPv6:2a00:1450:400c:c0c::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 402jH84s4QzDr5S
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Mar 2018 22:03:00 +1100 (AEDT)
Received: by mail-wr0-x244.google.com with SMTP id v65so11223842wrc.11
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Mar 2018 04:03:00 -0700 (PDT)
Sender: Mathieu Malaterre <mathieu.malaterre@gmail.com>
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 Mathieu Malaterre <malat@debian.org>
Subject: [PATCH 14/19] ppc64: change %p into %llx
Date: Fri, 16 Mar 2018 12:02:19 +0100
Message-Id: <20180316110224.12260-15-malat@debian.org>
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
../arch/powerpc/xmon/xmon.c: In function ‘dump_spu_fields’:
../arch/powerpc/xmon/xmon.c:3827:10: error: format ‘%p’ expects argument of type ‘void *’, but argument 4 has type ‘long long unsigned int’ [-Werror=format=]
   printf("  %-*s = "format"\n", DUMP_WIDTH,  \
          ^
../arch/powerpc/xmon/xmon.c:3840:2: note: in expansion of macro ‘DUMP_VALUE’
  DUMP_VALUE(format, field, obj->field)
  ^~~~~~~~~~
../arch/powerpc/xmon/xmon.c:3865:2: note: in expansion of macro ‘DUMP_FIELD’
  DUMP_FIELD(spu, "0x%p", timestamp);
  ^~~~~~~~~~
cc1: all warnings being treated as errors

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/xmon/xmon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 61f5e09367d0..6b5b5318099d 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -3859,7 +3859,7 @@ static void dump_spu_fields(struct spu *spu)
 	DUMP_FIELD(spu, "0x%p", mm);
 	DUMP_FIELD(spu, "0x%p", ctx);
 	DUMP_FIELD(spu, "0x%p", rq);
-	DUMP_FIELD(spu, "0x%p", timestamp);
+	DUMP_FIELD(spu, "0x%llx", timestamp);
 	DUMP_FIELD(spu, "0x%lx", problem_phys);
 	DUMP_FIELD(spu, "0x%p", problem);
 	DUMP_VALUE("0x%x", problem->spu_runcntl_RW,
-- 
2.11.0
