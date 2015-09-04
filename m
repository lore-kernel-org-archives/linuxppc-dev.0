Return-Path: <bharata.rao@gmail.com>
Received: from mail-pa0-x22f.google.com (mail-pa0-x22f.google.com
 [IPv6:2607:f8b0:400e:c03::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C1B671A2AC8
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Sep 2015 20:04:41 +1000 (AEST)
Received: by pacwi10 with SMTP id wi10so20192910pac.3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 Sep 2015 03:04:39 -0700 (PDT)
From: Bharata B Rao <bharata.rao@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Bharata B Rao <bharata@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>
Subject: [PATCH FIX] powerpc/pseries: Release DRC when configure_connector
 fails
Date: Fri,  4 Sep 2015 15:34:12 +0530
Message-Id: <1441361052-3319-1-git-send-email-bharata.rao@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Bharata B Rao <bharata@linux.vnet.ibm.com>

dlpar_cpu_probe() should release the acquired DRC if configure_connector
call fails.

Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
Cc: Nathan Fontenot <nfont@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/dlpar.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platforms/pseries/dlpar.c
index 47d9cebe..db17827 100644
--- a/arch/powerpc/platforms/pseries/dlpar.c
+++ b/arch/powerpc/platforms/pseries/dlpar.c
@@ -422,8 +422,10 @@ static ssize_t dlpar_cpu_probe(const char *buf, size_t count)
 
 	dn = dlpar_configure_connector(cpu_to_be32(drc_index), parent);
 	of_node_put(parent);
-	if (!dn)
+	if (!dn) {
+		dlpar_release_drc(drc_index);
 		return -EINVAL;
+	}
 
 	rc = dlpar_attach_node(dn);
 	if (rc) {
-- 
1.8.3.1
