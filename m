Return-Path: <clg@kaod.org>
Received: from 16.mo3.mail-out.ovh.net (16.mo3.mail-out.ovh.net
 [188.165.56.217])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xRT3K3yMbzDqpL
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Aug 2017 19:03:56 +1000 (AEST)
Received: from player797.ha.ovh.net (b9.ovh.net [213.186.33.59])
 by mo3.mail-out.ovh.net (Postfix) with ESMTP id 69CD012AF0D
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Aug 2017 10:56:56 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH 04/10] powerpc/xive: introduce xive_esb_write
Date: Tue,  8 Aug 2017 10:56:14 +0200
Message-Id: <1502182579-990-5-git-send-email-clg@kaod.org>
In-Reply-To: <1502182579-990-1-git-send-email-clg@kaod.org>
References: <1502182579-990-1-git-send-email-clg@kaod.org>
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

Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 arch/powerpc/sysdev/xive/common.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/sysdev/xive/common.c b/arch/powerpc/sysdev/xive/common.c
index e6b245bb9602..22b6f8954083 100644
--- a/arch/powerpc/sysdev/xive/common.c
+++ b/arch/powerpc/sysdev/xive/common.c
@@ -203,6 +203,15 @@ static u8 xive_peek_esb(struct xive_irq_data *xd, u32 offset)
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
2.7.5
