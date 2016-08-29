Return-Path: <elfring@users.sourceforge.net>
Received: from mout.web.de (mout.web.de [212.227.17.11])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sN1Hr5gqczDrfT
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Aug 2016 16:01:44 +1000 (AEST)
To: linuxppc-dev@lists.ozlabs.org, Andrea Gelmini <andrea.gelmini@gelma.net>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Julia Lawall <julia.lawall@lip6.fr>, Paolo Bonzini <pbonzini@redhat.com>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] powerpc: Use kmalloc_array() in grow()
Message-ID: <68d9b20a-429c-e236-bd74-96d3f2a6a6b1@users.sourceforge.net>
Date: Mon, 29 Aug 2016 08:00:26 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 29 Aug 2016 07:50:33 +0200

* A multiplication for the size determination of a memory allocation
  indicated that an array data structure should be processed.
  Thus use the corresponding function "kmalloc_array".

  This issue was detected by using the Coccinelle software.

* Replace the specification of a data type by a pointer dereference
  to make the corresponding size determination a bit safer according to
  the Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/powerpc/lib/rheap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/lib/rheap.c b/arch/powerpc/lib/rheap.c
index 94058c2..1630764 100644
--- a/arch/powerpc/lib/rheap.c
+++ b/arch/powerpc/lib/rheap.c
@@ -54,7 +54,7 @@ static int grow(rh_info_t * info, int max_blocks)
 
 	new_blocks = max_blocks - info->max_blocks;
 
-	block = kmalloc(sizeof(rh_block_t) * max_blocks, GFP_ATOMIC);
+	block = kmalloc_array(max_blocks, sizeof(*block), GFP_ATOMIC);
 	if (block == NULL)
 		return -ENOMEM;
 
-- 
2.9.3
