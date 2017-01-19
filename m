Return-Path: <elfring@users.sourceforge.net>
Received: from mout.web.de (mout.web.de [212.227.17.12])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v49Dg34Y8zDqQH
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Jan 2017 04:04:35 +1100 (AEDT)
Subject: [PATCH 7/8] powerpc/nvram: Improve size determinations in three
 functions
To: linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Daniel Axtens <dja@axtens.net>, Geliang Tang <geliangtang@163.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>,
 Paul Gortmaker <paul.gortmaker@windriver.com>,
 Paul Mackerras <paulus@samba.org>
References: <53545d97-6ed5-ff17-384f-82e72b3592f9@users.sourceforge.net>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <ccc156b4-26ff-02b2-c50a-91d9502d0db3@users.sourceforge.net>
Date: Thu, 19 Jan 2017 18:03:54 +0100
MIME-Version: 1.0
In-Reply-To: <53545d97-6ed5-ff17-384f-82e72b3592f9@users.sourceforge.net>
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
Date: Thu, 19 Jan 2017 17:15:30 +0100

Replace the specification of data structures by references for local
variables as the parameter for the operator "sizeof" to make
the corresponding size determination a bit safer.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/powerpc/kernel/nvram_64.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/nvram_64.c b/arch/powerpc/kernel/nvram_64.c
index 7af1baaaf01b..ed54147e3c60 100644
--- a/arch/powerpc/kernel/nvram_64.c
+++ b/arch/powerpc/kernel/nvram_64.c
@@ -207,8 +207,7 @@ int nvram_write_os_partition(struct nvram_os_partition *part,
 
 	tmp_index = part->index;
 
-	rc = ppc_md.nvram_write((char *)&info, sizeof(struct err_log_info),
-				&tmp_index);
+	rc = ppc_md.nvram_write((char *)&info, sizeof(info), &tmp_index);
 	if (rc <= 0) {
 		pr_err("%s: Failed nvram_write (%d)\n", __func__, rc);
 		return rc;
@@ -244,9 +243,7 @@ int nvram_read_partition(struct nvram_os_partition *part, char *buff,
 	tmp_index = part->index;
 
 	if (part->os_partition) {
-		rc = ppc_md.nvram_read((char *)&info,
-					sizeof(struct err_log_info),
-					&tmp_index);
+		rc = ppc_md.nvram_read((char *)&info, sizeof(info), &tmp_index);
 		if (rc <= 0) {
 			pr_err("%s: Failed nvram_read (%d)\n", __func__, rc);
 			return rc;
@@ -1175,7 +1172,7 @@ int __init nvram_scan_partitions(void)
 			       "detected: 0-length partition\n");
 			goto out;
 		}
-		tmp_part = kmalloc(sizeof(struct nvram_partition), GFP_KERNEL);
+		tmp_part = kmalloc(sizeof(*tmp_part), GFP_KERNEL);
 		err = -ENOMEM;
 		if (!tmp_part)
 			goto out;
-- 
2.11.0
