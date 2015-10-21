Return-Path: <christophe.jaillet@wanadoo.fr>
Received: from smtp.smtpout.orange.fr (smtp02.smtpout.orange.fr
 [80.12.242.124])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2D4A51A03C0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Oct 2015 15:37:05 +1100 (AEDT)
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: benh@kernel.crashing.org,
	paulus@samba.org,
	mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH v3] powerpc/prom: Avoid reference to potentially freed memory
Date: Wed, 21 Oct 2015 06:36:47 +0200
Message-Id: <1445402207-326-1-git-send-email-christophe.jaillet@wanadoo.fr>
In-Reply-To: <1445246877.30407.1.camel@ellerman.id.au>
References: <1445246877.30407.1.camel@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

of_get_property() is used inside the loop, but then the reference to the
node is dropped before dereferencing the prop pointer, which could by then
point to junk if the node has been freed.
Instead use of_property_read_u32() to actually read the property
value before dropping the reference.

Use of_get_next_parent to simplify code.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
v2: Fix missing '{'
v3: Use of_get_next_parent to simply code
*** COMPILE-TESTED ONLY ***
---
 arch/powerpc/kernel/prom.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index bef76c5..ba29c0d 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -783,17 +783,14 @@ void __init early_get_first_memblock_info(void *params, phys_addr_t *size)
 int of_get_ibm_chip_id(struct device_node *np)
 {
 	of_node_get(np);
-	while(np) {
-		struct device_node *old = np;
-		const __be32 *prop;
+	while (np) {
+		u32 chip_id;
 
-		prop = of_get_property(np, "ibm,chip-id", NULL);
-		if (prop) {
+		if (!of_property_read_u32(np, "ibm,chip-id", &chip_id)) {
 			of_node_put(np);
-			return be32_to_cpup(prop);
+			return chip_id;
 		}
-		np = of_get_parent(np);
-		of_node_put(old);
+		np = of_get_next_parent(np);
 	}
 	return -1;
 }
-- 
2.1.4
