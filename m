Return-Path: <elfring@users.sourceforge.net>
Received: from mout.web.de (mout.web.de [217.72.192.78])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v49KY3NhbzDqX8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Jan 2017 04:08:49 +1100 (AEDT)
Subject: [PATCH 1/8] powerpc/nvram: Return directly after a failed parameter
 validation in dev_nvram_write()
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
Message-ID: <5a23fa96-5227-3bcd-414d-65b2ae1f2f52@users.sourceforge.net>
Date: Thu, 19 Jan 2017 17:53:57 +0100
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
Date: Thu, 19 Jan 2017 15:22:56 +0100

* Return directly after an inappropriate input parameter was detected.

* Delete an initialisation for the variable "tmp" at the beginning
  and an assignment for the variable "ret" which became unnecessary
  with this refactoring.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/powerpc/kernel/nvram_64.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/nvram_64.c b/arch/powerpc/kernel/nvram_64.c
index 34d2c595de23..37d08b95c3f0 100644
--- a/arch/powerpc/kernel/nvram_64.c
+++ b/arch/powerpc/kernel/nvram_64.c
@@ -790,17 +790,15 @@ static ssize_t dev_nvram_write(struct file *file, const char __user *buf,
 			  size_t count, loff_t *ppos)
 {
 	ssize_t ret;
-	char *tmp = NULL;
+	char *tmp;
 	ssize_t size;
 
-	ret = -ENODEV;
 	if (!ppc_md.nvram_size)
-		goto out;
+		return -ENODEV;
 
-	ret = 0;
 	size = ppc_md.nvram_size();
 	if (*ppos >= size || size < 0)
-		goto out;
+		return 0;
 
 	count = min_t(size_t, count, size - *ppos);
 	count = min(count, PAGE_SIZE);
-- 
2.11.0
