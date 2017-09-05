Return-Path: <elfring@users.sourceforge.net>
Received: from mout.web.de (mout.web.de [212.227.17.11])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xmthg1nMlzDqYY
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Sep 2017 03:18:10 +1000 (AEST)
Subject: [PATCH v2] axonram: Delete an unnecessary variable initialisation in
 axon_ram_probe()
To: kbuild test robot <lkp@intel.com>, linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, Jan Kara <jack@suse.cz>,
 Jens Axboe <axboe@fb.com>, Dan Williams <dan.j.williams@intel.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Cc: kbuild-all@01.org, LKML <linux-kernel@vger.kernel.org>,
 kernel-janitors@vger.kernel.org
References: <201708042137.1QRfZLa9%fengguang.wu@intel.com>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <96042828-9707-8af9-664a-5c71818dd817@users.sourceforge.net>
Date: Tue, 5 Sep 2017 19:11:31 +0200
MIME-Version: 1.0
In-Reply-To: <201708042137.1QRfZLa9%fengguang.wu@intel.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 5 Sep 2017 18:47:02 +0200

The local variable "rc" will eventually be set only to an error code.
Thus omit the explicit initialisation at the beginning.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---

v2:
Three update steps were integrated for this software module on 2017-09-01.
Thus improve another source code place.

 arch/powerpc/sysdev/axonram.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/sysdev/axonram.c b/arch/powerpc/sysdev/axonram.c
index c60e84e4558d..1b307c80b401 100644
--- a/arch/powerpc/sysdev/axonram.c
+++ b/arch/powerpc/sysdev/axonram.c
@@ -184,7 +184,7 @@ static int axon_ram_probe(struct platform_device *device)
 	static int axon_ram_bank_id = -1;
 	struct axon_ram_bank *bank;
 	struct resource resource;
-	int rc = 0;
+	int rc;
 
 	axon_ram_bank_id++;
 
-- 
2.14.1
