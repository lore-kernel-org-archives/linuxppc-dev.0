Return-Path: <elfring@users.sourceforge.net>
Received: from mout.web.de (mout.web.de [212.227.15.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xNg2b1MYSzDqHq
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Aug 2017 05:23:34 +1000 (AEST)
Subject: [PATCH 4/4] axonram: Delete an unnecessary variable initialisation in
 axon_ram_probe()
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, Jan Kara <jack@suse.cz>,
 Jens Axboe <axboe@fb.com>, Dan Williams <dan.j.williams@intel.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <009fdef0-b2c9-5e98-d32d-14149aec92c5@users.sourceforge.net>
Message-ID: <d833a646-8345-4cd1-0701-4450615b7a65@users.sourceforge.net>
Date: Thu, 3 Aug 2017 21:17:28 +0200
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
Date: Thu, 3 Aug 2017 20:34:00 +0200

The local variable "rc" will eventually be set only to an error code.
Thus omit the explicit initialisation at the beginning.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/powerpc/sysdev/axonram.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/sysdev/axonram.c b/arch/powerpc/sysdev/axonram.c
index 93cc902350db..5677f3371e30 100644
--- a/arch/powerpc/sysdev/axonram.c
+++ b/arch/powerpc/sysdev/axonram.c
@@ -184,7 +184,6 @@ static int axon_ram_probe(struct platform_device *device)
 	static int axon_ram_bank_id = -1;
 	struct axon_ram_bank *bank;
 	struct resource resource;
-	int rc = 0;
 
 	axon_ram_bank_id++;
 
-- 
2.13.4
