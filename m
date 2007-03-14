Return-Path: <swarthou@petra11.am.freescale.net>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 8FDADDDDF5
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Mar 2007 09:34:00 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l2EMXv1l003592
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Mar 2007 15:33:57 -0700 (MST)
From: Ed Swarthout <Ed.Swarthout@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [dtc] ftdump missing be32_to_cpu() on size cell.
Date: Wed, 14 Mar 2007 17:33:19 -0500
Message-Id: <11739115994037-git-send-email-Ed.Swarthout@freescale.com>
Cc: Ed Swarthout <Ed.Swarthout@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

---
 ftdump.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/ftdump.c b/ftdump.c
index 67c5228..55209b6 100644
--- a/ftdump.c
+++ b/ftdump.c
@@ -142,7 +142,7 @@ static void dump_blob(void *blob)
 			fprintf(stderr, "%*s ** Unknown tag 0x%08x\n", depth * shift, "", tag);
 			break;
 		}
-		sz = GET_CELL(p);
+		sz = be32_to_cpu(GET_CELL(p));
 		s = p_strings + be32_to_cpu(GET_CELL(p));
 		if (version < 16 && sz >= 8)
 			p = PALIGN(p, 8);
-- 
1.5.0.3.290.gc390a
