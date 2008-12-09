Return-Path: <gknispel@proformatique.com>
Received: from proformatique.com (web.proformatique.com [91.194.179.68])
	by ozlabs.org (Postfix) with ESMTP id CA378DDD01
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Dec 2008 01:35:19 +1100 (EST)
Received: from unknown (HELO xilun.lan.proformatique.com) ([82.66.48.176])
	(envelope-sender <gknispel@proformatique.com>)
	by proformatique.com (qmail-ldap-1.03) with SMTP
	for <linuxppc-dev@ozlabs.org>; 9 Dec 2008 15:05:23 -0000
Date: Tue, 9 Dec 2008 15:28:34 +0100
From: Guillaume Knispel <gknispel@proformatique.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Fix corruption error in rh_alloc_fixed()
Message-ID: <20081209152834.1d6ff291@xilun.lan.proformatique.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Joakim Tjernlund <joakim.tjernlund@transmode.se>,
	Pantelis Antoniou <pantelis@embeddedalley.com>,
	Li Yang <leoli@freescale.com>, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

There is an error in rh_alloc_fixed() of the Remote Heap code:
If there is at least one free block blk won't be NULL at the end of the
search loop, so -ENOMEM won't be returned and the else branch of
"if (bs == s || be == e)" will be taken, corrupting the management
structures.

Signed-off-by: Guillaume Knispel <gknispel@proformatique.com>
---
Fix an error in rh_alloc_fixed() that made allocations succeed when
they should fail, and corrupted management structures.

diff --git a/arch/powerpc/lib/rheap.c b/arch/powerpc/lib/rheap.c
index 29b2941..45907c1 100644
--- a/arch/powerpc/lib/rheap.c
+++ b/arch/powerpc/lib/rheap.c
@@ -556,6 +556,7 @@ unsigned long rh_alloc_fixed(rh_info_t * info, unsigned long start, int size, co
 		be = blk->start + blk->size;
 		if (s >= bs && e <= be)
 			break;
+		blk = NULL;
 	}
 
 	if (blk == NULL)
