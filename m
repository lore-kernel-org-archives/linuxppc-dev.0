Return-Path: <elfring@users.sourceforge.net>
Received: from mout.web.de (mout.web.de [212.227.15.14])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xNg7S3JzDzDqJC
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Aug 2017 05:27:48 +1000 (AEST)
Subject: [PATCH 2/4] axonram: Improve a size determination in axon_ram_probe()
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, Jan Kara <jack@suse.cz>,
 Jens Axboe <axboe@fb.com>, Dan Williams <dan.j.williams@intel.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <009fdef0-b2c9-5e98-d32d-14149aec92c5@users.sourceforge.net>
Message-ID: <5dff1619-f3df-a6ef-7a75-11bae170e0d1@users.sourceforge.net>
Date: Thu, 3 Aug 2017 21:14:21 +0200
MIME-Version: 1.0
In-Reply-To: <009fdef0-b2c9-5e98-d32d-14149aec92c5@users.sourceforge.net>
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
Date: Thu, 3 Aug 2017 20:00:16 +0200

Replace the specification of a data structure by a pointer dereference
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/powerpc/sysdev/axonram.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/sysdev/axonram.c b/arch/powerpc/sysdev/axonram.c
index b82d1b023a15..bf1506ec2ca4 100644
--- a/arch/powerpc/sysdev/axonram.c
+++ b/arch/powerpc/sysdev/axonram.c
@@ -191,7 +191,7 @@ static int axon_ram_probe(struct platform_device *device)
 	dev_info(&device->dev, "Found memory controller on %s\n",
 			device->dev.of_node->full_name);
 
-	bank = kzalloc(sizeof(struct axon_ram_bank), GFP_KERNEL);
+	bank = kzalloc(sizeof(*bank), GFP_KERNEL);
 	if (bank == NULL) {
 		rc = -ENOMEM;
 		goto failed;
-- 
2.13.4
