Return-Path: <elfring@users.sourceforge.net>
Received: from mout.web.de (mout.web.de [217.72.192.78])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y7Q0x5cQHzDqpD
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Oct 2017 07:51:29 +1100 (AEDT)
Subject: [PATCH 1/2] powermac: Delete an error message for a failed memory
 allocation in kw_i2c_host_init()
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <5188c0b3-476a-6a14-bab5-052ad0f4dae0@users.sourceforge.net>
Message-ID: <5dc8fe2f-0459-faff-585f-a92137115895@users.sourceforge.net>
Date: Thu, 5 Oct 2017 22:51:13 +0200
MIME-Version: 1.0
In-Reply-To: <5188c0b3-476a-6a14-bab5-052ad0f4dae0@users.sourceforge.net>
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
Date: Thu, 5 Oct 2017 22:30:29 +0200

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/powerpc/platforms/powermac/low_i2c.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/powermac/low_i2c.c b/arch/powerpc/platforms/powermac/low_i2c.c
index 70183eb3d5c8..ecd166b5549b 100644
--- a/arch/powerpc/platforms/powermac/low_i2c.c
+++ b/arch/powerpc/platforms/powermac/low_i2c.c
@@ -493,11 +493,8 @@ static struct pmac_i2c_host_kw *__init kw_i2c_host_init(struct device_node *np)
 	u32			steps;
 
 	host = kzalloc(sizeof(struct pmac_i2c_host_kw), GFP_KERNEL);
-	if (host == NULL) {
-		printk(KERN_ERR "low_i2c: Can't allocate host for %pOF\n",
-		       np);
+	if (!host)
 		return NULL;
-	}
 
 	/* Apple is kind enough to provide a valid AAPL,address property
 	 * on all i2c keywest nodes so far ... we would have to fallback
-- 
2.14.2
