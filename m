Return-Path: <christophe.jaillet@wanadoo.fr>
Received: from smtp.smtpout.orange.fr (smtp06.smtpout.orange.fr
 [80.12.242.128])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vHLQ60k7kzDq8M
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Feb 2017 08:36:29 +1100 (AEDT)
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 nfont@linux.vnet.ibm.com, jallen@linux.vnet.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] powerpc/pseries: Fix missing of_node_put
Date: Mon,  6 Feb 2017 22:36:16 +0100
Message-Id: <20170206213616.3661-1-christophe.jaillet@wanadoo.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If 'dlpar_configure_connector()' fails, 'parent_dn' should be released as
already done in the normal case.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 arch/powerpc/platforms/pseries/mobility.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/mobility.c b/arch/powerpc/platforms/pseries/mobility.c
index 5a0c7ba429ce..b8060c182ae2 100644
--- a/arch/powerpc/platforms/pseries/mobility.c
+++ b/arch/powerpc/platforms/pseries/mobility.c
@@ -226,13 +226,16 @@ static int add_dt_node(__be32 parent_phandle, __be32 drc_index)
 		return -ENOENT;
 
 	dn = dlpar_configure_connector(drc_index, parent_dn);
-	if (!dn)
-		return -ENOENT;
+	if (!dn) {
+		rc = -ENOENT;
+		goto out;
+	}
 
 	rc = dlpar_attach_node(dn);
 	if (rc)
 		dlpar_free_cc_nodes(dn);
 
+out:
 	of_node_put(parent_dn);
 	return rc;
 }
-- 
2.9.3
