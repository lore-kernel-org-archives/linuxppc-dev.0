Return-Path: <gang.chen@asianux.com>
Received: from intranet.asianux.com (intranet.asianux.com [58.214.24.6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 100472C00BA
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 May 2013 15:49:54 +1000 (EST)
Message-ID: <519B0ACA.6090008@asianux.com>
Date: Tue, 21 May 2013 13:48:58 +0800
From: Chen Gang <gang.chen@asianux.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 "paulus@samba.org" <paulus@samba.org>, zhangyanfei@cn.fujitsu.com,
 Jiri Kosina <jkosina@suse.cz>, Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH] PowerPC: kernel: need return the related error code when
 failure occurs.
Content-Type: text/plain; charset=ISO-8859-1
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


When error occurs, need return the related error code to let upper
caller know about it.

ppc_md.nvram_size() can return the error code (e.g. core99_nvram_size()
in 'arch/powerpc/platforms/powermac/nvram.c').

And when '*ppos >= size', need return -ESPIPE (Illegal seek)

The original related patch: "f9ce299 [PATCH] powerpc: fix large nvram
access"


Signed-off-by: Chen Gang <gang.chen@asianux.com>
---
 arch/powerpc/kernel/nvram_64.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/nvram_64.c b/arch/powerpc/kernel/nvram_64.c
index 48fbc2b..db2a636 100644
--- a/arch/powerpc/kernel/nvram_64.c
+++ b/arch/powerpc/kernel/nvram_64.c
@@ -88,10 +88,15 @@ static ssize_t dev_nvram_read(struct file *file, char __user *buf,
 	if (!ppc_md.nvram_size)
 		goto out;
 
-	ret = 0;
 	size = ppc_md.nvram_size();
-	if (*ppos >= size || size < 0)
+	if (size < 0) {
+		ret = size;
 		goto out;
+	}
+	if (*ppos >= size) {
+		ret = -ESPIPE;
+		goto out;
+	}
 
 	count = min_t(size_t, count, size - *ppos);
 	count = min(count, PAGE_SIZE);
-- 
1.7.7.6
