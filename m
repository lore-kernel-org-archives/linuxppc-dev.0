Return-Path: <elfring@users.sourceforge.net>
Received: from mout.web.de (mout.web.de [212.227.15.14])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zHYc22LP0zF0fb
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jan 2018 05:01:53 +1100 (AEDT)
Subject: [PATCH 2/5] powerpc/4xx: Use seq_putc() in ocm_debugfs_show()
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>,
 Rob Herring <robh@kernel.org>, Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <2b9b4285-f1c0-5dc7-35c6-df901c9ca0eb@users.sourceforge.net>
Message-ID: <400b7f67-bd62-9f5f-228b-9633c23671d7@users.sourceforge.net>
Date: Thu, 11 Jan 2018 19:01:33 +0100
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
Date: Thu, 11 Jan 2018 18:10:02 +0100

A single character (line break) should be put into a sequence.
Thus use the corresponding function "seq_putc".

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/powerpc/platforms/4xx/ocm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/4xx/ocm.c b/arch/powerpc/platforms/4xx/ocm.c
index 5bc1baf809d1..8cb601e8bed7 100644
--- a/arch/powerpc/platforms/4xx/ocm.c
+++ b/arch/powerpc/platforms/4xx/ocm.c
@@ -267,7 +267,7 @@ static int ocm_debugfs_show(struct seq_file *m, void *v)
 						blk->size, blk->owner);
 		}
 
-		seq_printf(m, "\n");
+		seq_putc(m, '\n');
 	}
 
 	return 0;
-- 
2.15.1
