Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7B0CB1007D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  4 Aug 2010 14:19:49 +1000 (EST)
Subject: [PATCH] memblock: Fix memblock_is_region_reserved() to return a
	boolean
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 04 Aug 2010 14:19:31 +1000
Message-ID: <1280895571.1902.140.camel@pasglop>
Mime-Version: 1.0
Cc: Russell King <linux@arm.linux.org.uk>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

All callers expect a boolean result which is true if the region
overlaps a reserved region. However, the implementation actually
returns -1 if there is no overlap, and a region index (0 based)
if there is.

Make it behave as callers (and common sense) expect.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

Taking that out of my memblock rework branch as it should go in
now regardless of whether my stuff goes or not (which is still
under discussion, I'm fixing ARM up now).

I'll send this fix to Linus tomorrow along with powerpc.git if there
is no adverse comment.

diff --git a/mm/memblock.c b/mm/memblock.c
index 3024eb3..43840b3 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -504,7 +504,7 @@ int __init memblock_is_reserved(u64 addr)
 
 int memblock_is_region_reserved(u64 base, u64 size)
 {
-	return memblock_overlaps_region(&memblock.reserved, base, size);
+	return memblock_overlaps_region(&memblock.reserved, base, size) >= 0;
 }
 
 /*
