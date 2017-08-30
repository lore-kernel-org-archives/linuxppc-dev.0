Return-Path: <clg@kaod.org>
Received: from 4.mo68.mail-out.ovh.net (4.mo68.mail-out.ovh.net [46.105.59.63])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xjH8T12lRzDqNc
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Aug 2017 06:26:17 +1000 (AEST)
Received: from player776.ha.ovh.net (b6.ovh.net [213.186.33.56])
 by mo68.mail-out.ovh.net (Postfix) with ESMTP id 4A1C97AF15
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Aug 2017 21:46:58 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v3 4/8] powerpc/xive: introduce xive_esb_write()
Date: Wed, 30 Aug 2017 21:46:13 +0200
Message-Id: <20170830194617.26621-5-clg@kaod.org>
In-Reply-To: <20170830194617.26621-1-clg@kaod.org>
References: <20170830194617.26621-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Some source support MMIO stores on the ESB page to perform EOI. Let's
introduce a specific routine for this case even if this should be the
only use of it.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
---
 arch/powerpc/sysdev/xive/common.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/sysdev/xive/common.c b/arch/powerpc/sysdev/xive/common.c
index 8a58662ed793..ac5f18a66742 100644
--- a/arch/powerpc/sysdev/xive/common.c
+++ b/arch/powerpc/sysdev/xive/common.c
@@ -203,6 +203,15 @@ static u8 xive_esb_read(struct xive_irq_data *xd, u32 offset)
 	return (u8)val;
 }
 
+static void xive_esb_write(struct xive_irq_data *xd, u32 offset, u64 data)
+{
+	/* Handle HW errata */
+	if (xd->flags & XIVE_IRQ_FLAG_SHIFT_BUG)
+		offset |= offset << 4;
+
+	out_be64(xd->eoi_mmio + offset, data);
+}
+
 #ifdef CONFIG_XMON
 static void xive_dump_eq(const char *name, struct xive_q *q)
 {
@@ -297,7 +306,7 @@ void xive_do_source_eoi(u32 hw_irq, struct xive_irq_data *xd)
 {
 	/* If the XIVE supports the new "store EOI facility, use it */
 	if (xd->flags & XIVE_IRQ_FLAG_STORE_EOI)
-		out_be64(xd->eoi_mmio + XIVE_ESB_STORE_EOI, 0);
+		xive_esb_write(xd, XIVE_ESB_STORE_EOI, 0);
 	else if (hw_irq && xd->flags & XIVE_IRQ_FLAG_EOI_FW) {
 		/*
 		 * The FW told us to call it. This happens for some
-- 
2.13.5
