Return-Path: <colin.king@canonical.com>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rdR4R0bzRzDq5f
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jun 2016 21:08:07 +1000 (AEST)
From: Colin King <colin.king@canonical.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Jiri Kosina <trivial@kernel.org>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH][V2] powerpc/fadump: trivial fix of spelling mistake,
 clean up message
Date: Mon, 27 Jun 2016 12:07:41 +0100
Message-Id: <1467025661-1410-1-git-send-email-colin.king@canonical.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Colin Ian King <colin.king@canonical.com>

Fix trivial spelling mistake "rgistration". Also use pr_err
instead of printk and unsplit the string to keep it all on one
line.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 arch/powerpc/kernel/fadump.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index 3cb3b02a..09cb2a7 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -1009,9 +1009,9 @@ static int fadump_invalidate_dump(struct fadump_mem_struct *fdm)
 	} while (wait_time);
 
 	if (rc) {
-		printk(KERN_ERR "Failed to invalidate firmware-assisted dump "
-			"rgistration. unexpected error(%d).\n", rc);
-		return rc;
+		pr_err("Failed to invalidate firmware-assisted dump registration. Unexpected error (%d).\n",
+		       rc);
+		return rc
 	}
 	fw_dump.dump_active = 0;
 	fdm_active = NULL;
-- 
2.8.1
