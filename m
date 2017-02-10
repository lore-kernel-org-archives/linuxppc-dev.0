Return-Path: <christophe.jaillet@wanadoo.fr>
Received: from smtp.smtpout.orange.fr (smtp08.smtpout.orange.fr
 [80.12.242.130])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vKlm16HmZzDqBn
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Feb 2017 06:45:20 +1100 (AEDT)
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 jallen@linux.vnet.ibm.com, nfont@linux.vnet.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH v2] powerpc/pseries: Fix missing of_node_put
Date: Fri, 10 Feb 2017 20:45:05 +0100
Message-Id: <20170210194505.8236-1-christophe.jaillet@wanadoo.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If 'dlpar_configure_connector()' fails, 'parent_dn' should be released.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
v2: Reorder code in order to simplify the proposed patch
---
 arch/powerpc/platforms/pseries/mobility.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/mobility.c b/arch/powerpc/platforms/pseries/mobility.c
index 5a0c7ba429ce..2f8be51f5fd0 100644
--- a/arch/powerpc/platforms/pseries/mobility.c
+++ b/arch/powerpc/platforms/pseries/mobility.c
@@ -226,6 +226,7 @@ static int add_dt_node(__be32 parent_phandle, __be32 drc_index)
 		return -ENOENT;
 
 	dn = dlpar_configure_connector(drc_index, parent_dn);
+	of_node_put(parent_dn);
 	if (!dn)
 		return -ENOENT;
 
@@ -233,7 +234,6 @@ static int add_dt_node(__be32 parent_phandle, __be32 drc_index)
 	if (rc)
 		dlpar_free_cc_nodes(dn);
 
-	of_node_put(parent_dn);
 	return rc;
 }
 
-- 
2.9.3
