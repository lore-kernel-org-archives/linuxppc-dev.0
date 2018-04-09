Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x244.google.com (mail-pl0-x244.google.com
 [IPv6:2607:f8b0:400e:c01::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40KJfs3kpQzDrZC
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Apr 2018 15:25:41 +1000 (AEST)
Received: by mail-pl0-x244.google.com with SMTP id a39-v6so4469864pla.10
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 08 Apr 2018 22:25:41 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH v2 3/9] powerpc/powernv: opal_put_chars partial write fix
Date: Mon,  9 Apr 2018 15:24:25 +1000
Message-Id: <20180409052431.26405-4-npiggin@gmail.com>
In-Reply-To: <20180409052431.26405-1-npiggin@gmail.com>
References: <20180409052431.26405-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The intention here is to consume and discard the remaining buffer
upon error. This works if there has not been a previous partial write.
If there has been, then total_len is no longer total number of bytes
to copy. total_len is always "bytes left to copy", so it should be
added to written bytes.

This code may not be exercised any more if partial writes will not be
hit, but this is a small bugfix before a larger change.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/platforms/powernv/opal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index 516e23de5a3d..87d4c0aa7f64 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -388,7 +388,7 @@ int opal_put_chars(uint32_t vtermno, const char *data, int total_len)
 		/* Closed or other error drop */
 		if (rc != OPAL_SUCCESS && rc != OPAL_BUSY &&
 		    rc != OPAL_BUSY_EVENT) {
-			written = total_len;
+			written += total_len;
 			break;
 		}
 		if (rc == OPAL_SUCCESS) {
-- 
2.17.0
