Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-wr0-x241.google.com (mail-wr0-x241.google.com
 [IPv6:2a00:1450:400c:c0c::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40VH4g3pkSzDqhm
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Apr 2018 05:45:39 +1000 (AEST)
Received: by mail-wr0-x241.google.com with SMTP id p5-v6so16648687wre.12
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Apr 2018 12:45:39 -0700 (PDT)
Sender: Mathieu Malaterre <mathieu.malaterre@gmail.com>
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Mathieu Malaterre <malat@debian.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/wii: Make hlwd_pic_init function static
Date: Mon, 23 Apr 2018 21:45:32 +0200
Message-Id: <20180423194533.23487-1-malat@debian.org>
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

The function hlwd_pic_init can be made static, so do it. Fix the following
warning treated as error (W=1):

../arch/powerpc/platforms/embedded6xx/hlwd-pic.c:158:20: error: no previous prototype for ‘hlwd_pic_init’ [-Werror=missing-prototypes]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/platforms/embedded6xx/hlwd-pic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/embedded6xx/hlwd-pic.c b/arch/powerpc/platforms/embedded6xx/hlwd-pic.c
index 89c54de88b7a..e3e3af73e9d8 100644
--- a/arch/powerpc/platforms/embedded6xx/hlwd-pic.c
+++ b/arch/powerpc/platforms/embedded6xx/hlwd-pic.c
@@ -155,7 +155,7 @@ static void __hlwd_quiesce(void __iomem *io_base)
 	out_be32(io_base + HW_BROADWAY_ICR, 0xffffffff);
 }
 
-struct irq_domain *hlwd_pic_init(struct device_node *np)
+static struct irq_domain *hlwd_pic_init(struct device_node *np)
 {
 	struct irq_domain *irq_domain;
 	struct resource res;
-- 
2.11.0
