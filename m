Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rglK81Cj4zDql5
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Jul 2016 15:27:08 +1000 (AEST)
Date: Fri, 1 Jul 2016 15:27:07 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, <linuxppc-dev@lists.ozlabs.org>
Cc: linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, Colin Ian King
 <colin.king@canonical.com>
Subject: linux-next: build failure after merge of the powerpc tree
Message-ID: <20160701152707.444e03b4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi all,

After merging the powerpc tree, today's linux-next build (powerpc
allyesconfig) failed like this:

arch/powerpc/kernel/fadump.c: In function 'fadump_invalidate_dump':
arch/powerpc/kernel/fadump.c:1014:2: error: expected ';' before '}' token
  }
  ^

Caused by commit

  4a03749f140c ("powerpc/fadump: Trivial fix of spelling mistake, clean up message")

I have added this fix patch for today:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Fri, 1 Jul 2016 15:19:34 +1000
Subject: [PATCH] powerpc/fadump: add missing semicolon

Fixes: 4a03749f140c ("powerpc/fadump: Trivial fix of spelling mistake, clean up message")
Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/kernel/fadump.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index f0664860753e..b3a663333d36 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -1010,7 +1010,7 @@ static int fadump_invalidate_dump(struct fadump_mem_struct *fdm)
 
 	if (rc) {
 		pr_err("Failed to invalidate firmware-assisted dump registration. Unexpected error (%d).\n", rc);
-		return rc
+		return rc;
 	}
 	fw_dump.dump_active = 0;
 	fdm_active = NULL;
-- 
2.8.1

-- 
Cheers,
Stephen Rothwell
