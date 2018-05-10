Return-Path: <j.neuschaefer@gmx.net>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40hnFh4myLzF29t
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 May 2018 07:59:52 +1000 (AEST)
From: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org,
 Segher Boessenkool <segher@kernel.crashing.org>,
 Joel Stanley <joel@jms.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Mathieu Malaterre <malat@debian.org>,
 =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: [PATCH 1/2] powerpc: flipper-pic: Don't match all IRQ domains
Date: Thu, 10 May 2018 23:59:18 +0200
Message-Id: <20180510215919.27808-2-j.neuschaefer@gmx.net>
In-Reply-To: <20180510215919.27808-1-j.neuschaefer@gmx.net>
References: <20180510215919.27808-1-j.neuschaefer@gmx.net>
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

On the Wii, there is a secondary IRQ controller (hlwd-pic), so
flipper-pic's match operation should not be hardcoded to return 1.
In fact, the default matching logic is sufficient, and we can completely
omit flipper_pic_match.

Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
---

Note: This shouldn't break Linux on the GameCube, but I've only tested
on the Wii. Some confirmation that I didn't break interrupt handling on
the GC would be nice. (If someone still runs mainline on the GC.)
---
 arch/powerpc/platforms/embedded6xx/flipper-pic.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/powerpc/platforms/embedded6xx/flipper-pic.c b/arch/powerpc/platforms/embedded6xx/flipper-pic.c
index 7206f3f573d4..db0be007fd06 100644
--- a/arch/powerpc/platforms/embedded6xx/flipper-pic.c
+++ b/arch/powerpc/platforms/embedded6xx/flipper-pic.c
@@ -108,16 +108,8 @@ static int flipper_pic_map(struct irq_domain *h, unsigned int virq,
 	return 0;
 }
 
-static int flipper_pic_match(struct irq_domain *h, struct device_node *np,
-			     enum irq_domain_bus_token bus_token)
-{
-	return 1;
-}
-
-
 static const struct irq_domain_ops flipper_irq_domain_ops = {
 	.map = flipper_pic_map,
-	.match = flipper_pic_match,
 };
 
 /*
-- 
2.17.0
