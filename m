Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x243.google.com (mail-pl0-x243.google.com
 [IPv6:2607:f8b0:400e:c01::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40KJg53gcbzDr4q
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Apr 2018 15:25:53 +1000 (AEST)
Received: by mail-pl0-x243.google.com with SMTP id 61-v6so4479054plb.2
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 08 Apr 2018 22:25:53 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
Subject: [PATCH v2 7/9] powerpc/powernv: OPAL dump support standardise
 OPAL_BUSY delays
Date: Mon,  9 Apr 2018 15:24:29 +1000
Message-Id: <20180409052431.26405-8-npiggin@gmail.com>
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

Convert to using the standard delay poll/delay form.

The dump code:

- Did not previously delay or sleep in the OPAL_BUSY case.
- Used a 20ms sleep.

Cc: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/platforms/powernv/opal-dump.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/opal-dump.c b/arch/powerpc/platforms/powernv/opal-dump.c
index 0dc8fa4e0af2..4ab749ceafc2 100644
--- a/arch/powerpc/platforms/powernv/opal-dump.c
+++ b/arch/powerpc/platforms/powernv/opal-dump.c
@@ -260,12 +260,14 @@ static int64_t dump_read_data(struct dump_obj *dump)
 	addr = __pa(list);
 
 	/* Fetch data */
-	rc = OPAL_BUSY_EVENT;
+	rc = OPAL_BUSY;
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
2.17.0
