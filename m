Return-Path: <christophe.jaillet@wanadoo.fr>
Received: from smtp.smtpout.orange.fr (smtp07.smtpout.orange.fr
 [80.12.242.129])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 28A6B1A0491
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Oct 2015 16:56:36 +1100 (AEDT)
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: benh@kernel.crashing.org,
	paulus@samba.org,
	mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH v2] powerpc/mpc5xxx: Avoid dereferencing potentially freed
 memory
Date: Thu, 15 Oct 2015 07:56:20 +0200
Message-Id: <1444888580-12966-1-git-send-email-christophe.jaillet@wanadoo.fr>
In-Reply-To: <20151014040011.8AB1514110A@ozlabs.org>
References: <20151014040011.8AB1514110A@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Use 'of_property_read_u32()' instead of 'of_get_property()'+pointer
dereference in order to avoid access to potentially freed memory.

Use 'of_get_next_parent()' to simplify the while() loop and avoid the
need of a temp variable.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
v2: Use of_property_read_u32 instead of of_get_property+pointer dereference
*** Untested ***
---
 arch/powerpc/sysdev/mpc5xxx_clocks.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/sysdev/mpc5xxx_clocks.c b/arch/powerpc/sysdev/mpc5xxx_clocks.c
index f4f0301..92fbcf8 100644
--- a/arch/powerpc/sysdev/mpc5xxx_clocks.c
+++ b/arch/powerpc/sysdev/mpc5xxx_clocks.c
@@ -13,21 +13,17 @@
 
 unsigned long mpc5xxx_get_bus_frequency(struct device_node *node)
 {
-	struct device_node *np;
-	const unsigned int *p_bus_freq = NULL;
+	u32 bus_freq = 0;
 
 	of_node_get(node);
 	while (node) {
-		p_bus_freq = of_get_property(node, "bus-frequency", NULL);
-		if (p_bus_freq)
+		if (!of_property_read_u32(node, "bus-frequency", &bus_freq))
 			break;
 
-		np = of_get_parent(node);
-		of_node_put(node);
-		node = np;
+		node = of_get_next_parent(node);
 	}
 	of_node_put(node);
 
-	return p_bus_freq ? *p_bus_freq : 0;
+	return bus_freq;
 }
 EXPORT_SYMBOL(mpc5xxx_get_bus_frequency);
-- 
2.1.4
