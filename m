Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x241.google.com (mail-pl0-x241.google.com
 [IPv6:2607:f8b0:400e:c01::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40GwdV6mZ3zF1wk
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Apr 2018 18:16:14 +1000 (AEST)
Received: by mail-pl0-x241.google.com with SMTP id s10-v6so16122670plp.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Apr 2018 01:16:14 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Stewart Smith <stewart@linux.ibm.com>
Subject: [PATCH 5/6] powerpc/powernv: OPAL dump support standardise OPAL_BUSY
 delays
Date: Thu,  5 Apr 2018 18:15:46 +1000
Message-Id: <20180405081547.13266-6-npiggin@gmail.com>
In-Reply-To: <20180405081547.13266-1-npiggin@gmail.com>
References: <20180405081547.13266-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Convert to using the standard delay poll/delay form.

The dump code:

- Did not previously delay or sleep in the OPAL_BUSY case.
- Used a 20ms sleep.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/platforms/powernv/opal-dump.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/opal-dump.c b/arch/powerpc/platforms/powernv/opal-dump.c
index 0dc8fa4e0af2..603c4ffdb45c 100644
--- a/arch/powerpc/platforms/powernv/opal-dump.c
+++ b/arch/powerpc/platforms/powernv/opal-dump.c
@@ -264,8 +264,10 @@ static int64_t dump_read_data(struct dump_obj *dump)
 	while (rc == OPAL_BUSY || rc == OPAL_BUSY_EVENT) {
 		rc = opal_dump_read(dump->id, addr);
 		if (rc == OPAL_BUSY_EVENT) {
+			msleep(OPAL_BUSY_DELAY_MS);
 			opal_poll_events(NULL);
-			msleep(20);
+		} else if (rc == OPAL_BUSY) {
+			msleep(OPAL_BUSY_DELAY_MS);
 		}
 	}
 
-- 
2.16.3
