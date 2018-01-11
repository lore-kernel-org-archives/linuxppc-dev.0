Return-Path: <elfring@users.sourceforge.net>
Received: from mout.web.de (mout.web.de [212.227.15.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zHYZs5gQ1zF0dJ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jan 2018 05:00:53 +1100 (AEDT)
Subject: [PATCH 1/5] powerpc/4xx: Combine four seq_printf() calls into two in
 ocm_debugfs_show()
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>,
 Rob Herring <robh@kernel.org>, Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <2b9b4285-f1c0-5dc7-35c6-df901c9ca0eb@users.sourceforge.net>
Message-ID: <90e9f81b-25ad-cf02-663c-50a9997d9d53@users.sourceforge.net>
Date: Thu, 11 Jan 2018 19:00:33 +0100
MIME-Version: 1.0
In-Reply-To: <2b9b4285-f1c0-5dc7-35c6-df901c9ca0eb@users.sourceforge.net>
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
Date: Thu, 11 Jan 2018 18:08:08 +0100

Some data were printed into a sequence by four separate function calls.
Print the same data by two single function calls instead.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/powerpc/platforms/4xx/ocm.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/platforms/4xx/ocm.c b/arch/powerpc/platforms/4xx/ocm.c
index 85d9e37f5ccb..5bc1baf809d1 100644
--- a/arch/powerpc/platforms/4xx/ocm.c
+++ b/arch/powerpc/platforms/4xx/ocm.c
@@ -245,9 +245,7 @@ static int ocm_debugfs_show(struct seq_file *m, void *v)
 		seq_printf(m, "PhysAddr     : 0x%llx\n", ocm->phys);
 		seq_printf(m, "MemTotal     : %d Bytes\n", ocm->memtotal);
 		seq_printf(m, "MemTotal(NC) : %d Bytes\n", ocm->nc.memtotal);
-		seq_printf(m, "MemTotal(C)  : %d Bytes\n", ocm->c.memtotal);
-
-		seq_printf(m, "\n");
+		seq_printf(m, "MemTotal(C)  : %d Bytes\n\n", ocm->c.memtotal);
 
 		seq_printf(m, "NC.PhysAddr  : 0x%llx\n", ocm->nc.phys);
 		seq_printf(m, "NC.VirtAddr  : 0x%p\n", ocm->nc.virt);
@@ -259,9 +257,7 @@ static int ocm_debugfs_show(struct seq_file *m, void *v)
 							blk->size, blk->owner);
 		}
 
-		seq_printf(m, "\n");
-
-		seq_printf(m, "C.PhysAddr   : 0x%llx\n", ocm->c.phys);
+		seq_printf(m, "\nC.PhysAddr   : 0x%llx\n", ocm->c.phys);
 		seq_printf(m, "C.VirtAddr   : 0x%p\n", ocm->c.virt);
 		seq_printf(m, "C.MemTotal   : %d Bytes\n", ocm->c.memtotal);
 		seq_printf(m, "C.MemFree    : %d Bytes\n", ocm->c.memfree);
-- 
2.15.1
