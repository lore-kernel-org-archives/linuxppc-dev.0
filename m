Return-Path: <elfring@users.sourceforge.net>
Received: from mout.web.de (mout.web.de [212.227.15.14])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v49CZ6KsRzDqWX
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Jan 2017 04:03:38 +1100 (AEDT)
Subject: [PATCH 4/8] powerpc/nvram: Return directly after a failed parameter
 validation in dev_nvram_read()
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
Message-ID: <b5dc24f8-4b74-9dfe-fb18-7dc0699b87ec@users.sourceforge.net>
Date: Thu, 19 Jan 2017 17:57:37 +0100
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
Date: Thu, 19 Jan 2017 16:12:48 +0100

* Return directly after an inappropriate input parameter was detected.

* Delete an initialisation for the variable "tmp" at the beginning
  which became unnecessary with this refactoring.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/powerpc/kernel/nvram_64.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/kernel/nvram_64.c b/arch/powerpc/kernel/nvram_64.c
index dc90a0e9ad65..463551589b97 100644
--- a/arch/powerpc/kernel/nvram_64.c
+++ b/arch/powerpc/kernel/nvram_64.c
@@ -745,24 +745,18 @@ static ssize_t dev_nvram_read(struct file *file, char __user *buf,
 			  size_t count, loff_t *ppos)
 {
 	ssize_t ret;
-	char *tmp = NULL;
+	char *tmp;
 	ssize_t size;
 
-	if (!ppc_md.nvram_size) {
-		ret = -ENODEV;
-		goto out;
-	}
+	if (!ppc_md.nvram_size)
+		return -ENODEV;
 
 	size = ppc_md.nvram_size();
-	if (size < 0) {
-		ret = size;
-		goto out;
-	}
+	if (size < 0)
+		return size;
 
-	if (*ppos >= size) {
-		ret = 0;
-		goto out;
-	}
+	if (*ppos >= size)
+		return 0;
 
 	count = min_t(size_t, count, size - *ppos);
 	count = min(count, PAGE_SIZE);
-- 
2.11.0
