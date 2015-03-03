Return-Path: <geert@linux-m68k.org>
Received: from winston.telenet-ops.be (winston.telenet-ops.be [195.130.137.75])
 by lists.ozlabs.org (Postfix) with ESMTP id C49AF1A01E7
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Mar 2015 21:12:23 +1100 (AEDT)
Received: from andre.telenet-ops.be (andre.telenet-ops.be [195.130.132.53])
 by winston.telenet-ops.be (Postfix) with ESMTP id 5F81D1BE8F0
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Mar 2015 11:02:19 +0100 (CET)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v2] powerpc/pmac: Fix DT refcount imbalance in
 pmac_pic_probe_oldstyle
Date: Tue,  3 Mar 2015 11:02:15 +0100
Message-Id: <1425376935-6226-1-git-send-email-geert+renesas@glider.be>
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Internally, of_find_node_by_name() calls of_node_put() on its "from"
parameter, which must not be done on "master", as it's still in use, and
will be released manually later.  This may cause a zero kref refcount.

Call of_node_get() before to compensate for this.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Compile-tested only

v2:
  - Avoid a logic change by adding a call to of_node_get() instead of
    replacing of_find_node_by_name() by of_get_child_by_name().
    No-one seems to remember which machines are affected by this.
---
 arch/powerpc/platforms/powermac/pic.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/platforms/powermac/pic.c b/arch/powerpc/platforms/powermac/pic.c
index 4c24bf60d39d2834..59cfc9d63c2d51a7 100644
--- a/arch/powerpc/platforms/powermac/pic.c
+++ b/arch/powerpc/platforms/powermac/pic.c
@@ -321,6 +321,9 @@ static void __init pmac_pic_probe_oldstyle(void)
 		max_irqs = max_real_irqs = 64;
 
 		/* We might have a second cascaded heathrow */
+
+		/* Compensate for of_node_put() in of_find_node_by_name() */
+		of_node_get(master);
 		slave = of_find_node_by_name(master, "mac-io");
 
 		/* Check ordering of master & slave */
-- 
1.9.1
