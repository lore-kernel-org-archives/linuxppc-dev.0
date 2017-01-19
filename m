Return-Path: <elfring@users.sourceforge.net>
Received: from mout.web.de (mout.web.de [212.227.15.3])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v49Hz374DzDqT8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Jan 2017 04:07:27 +1100 (AEDT)
Subject: [PATCH 5/8] powerpc/nvram: Return directly after a failed kmalloc()
 in dev_nvram_read()
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
Message-ID: <60b730d9-c683-a6ee-42fb-1c874ad86205@users.sourceforge.net>
Date: Thu, 19 Jan 2017 17:59:00 +0100
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
Date: Thu, 19 Jan 2017 16:50:31 +0100

Return directly after a call of the function "kmalloc" failed here.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/powerpc/kernel/nvram_64.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/nvram_64.c b/arch/powerpc/kernel/nvram_64.c
index 463551589b97..68b970bcf2fc 100644
--- a/arch/powerpc/kernel/nvram_64.c
+++ b/arch/powerpc/kernel/nvram_64.c
@@ -762,10 +762,8 @@ static ssize_t dev_nvram_read(struct file *file, char __user *buf,
 	count = min(count, PAGE_SIZE);
 
 	tmp = kmalloc(count, GFP_KERNEL);
-	if (!tmp) {
-		ret = -ENOMEM;
-		goto out;
-	}
+	if (!tmp)
+		return -ENOMEM;
 
 	ret = ppc_md.nvram_read(tmp, count, ppos);
 	if (ret <= 0)
-- 
2.11.0
