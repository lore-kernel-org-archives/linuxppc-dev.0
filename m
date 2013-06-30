Return-Path: <geert@linux-m68k.org>
Received: from wilson.telenet-ops.be (wilson.telenet-ops.be [195.130.132.42])
 by ozlabs.org (Postfix) with ESMTP id 21A422C01FC
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Jun 2013 20:03:38 +1000 (EST)
Received: from juliette.telenet-ops.be (juliette.telenet-ops.be
 [195.130.137.74])
 by wilson.telenet-ops.be (Postfix) with ESMTP id 4920B34A0D
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Jun 2013 12:03:28 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] mac: Make cuda_init_via() __init
Date: Sun, 30 Jun 2013 12:03:23 +0200
Message-Id: <1372586603-1373-1-git-send-email-geert@linux-m68k.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@lists.linux-m68k.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

cuda_init_via() is called from find_via_cuda() only, which is __init.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/macintosh/via-cuda.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/macintosh/via-cuda.c b/drivers/macintosh/via-cuda.c
index 86511c5..d61f271 100644
--- a/drivers/macintosh/via-cuda.c
+++ b/drivers/macintosh/via-cuda.c
@@ -259,7 +259,7 @@ cuda_probe(void)
     } while (0)
 
 static int
-cuda_init_via(void)
+__init cuda_init_via(void)
 {
     out_8(&via[DIRB], (in_8(&via[DIRB]) | TACK | TIP) & ~TREQ);	/* TACK & TIP out */
     out_8(&via[B], in_8(&via[B]) | TACK | TIP);			/* negate them */
-- 
1.7.9.5
