Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 07061DE02F
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Mar 2008 06:10:56 +1100 (EST)
Date: Fri, 28 Mar 2008 22:10:54 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Scott Wood <scottwood@freescale.com>
Subject: [PATCH] mtd/nand/fsl_elbc_nand: workaround for hangs during nand
	write [was: Re: [PATCH] mtd/nand/fsl_elbc_nand: workaround for
	hangs on MPC837X]
Message-ID: <20080328191054.GA30765@localhost.localdomain>
References: <20080328184303.GA25882@localhost.localdomain>
	<47ED3EC5.8030508@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <47ED3EC5.8030508@freescale.com>
Cc: linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Mar 28, 2008 at 01:53:57PM -0500, Scott Wood wrote:
> Anton Vorontsov wrote:
> >@@ -495,6 +495,16 @@ static void fsl_elbc_write_buf(struct mtd_info *mtd, 
> >const u8 *buf, int len)
> > 	}
> > 
> > 	memcpy_toio(&ctrl->addr[ctrl->index], buf, len);
> >+#ifdef CONFIG_PPC_MPC837x
> >+	/*
> >+	 * This is workaround for the weird elbc hangs on the MPC837X CPUs,
> >+	 * Scott Wood says: "...perhaps difference in how long it takes a
> >+	 * write to make it through the localbus compared to a write to IMMR
> >+	 * is causing problems, and sync isn't helping for some reason."
> >+	 * Reading back the last byte helps though.
> >+	 */
> >+	in_8(&ctrl->addr[ctrl->index] + len - 1);
> >+#endif
> 
> Let's do it regardless of chip -- odds are the issue exists on all 
> implementations, and it's just a function of what frequencies things are 
> running at.

Ok.

- - - -
From: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: mtd/nand/fsl_elbc_nand: workaround for hangs during nand write

Using current driver elbc sometimes hangs during nand write. Reading back
last byte helps though (thanks to Scott Wood for the idea).

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 drivers/mtd/nand/fsl_elbc_nand.c |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/drivers/mtd/nand/fsl_elbc_nand.c b/drivers/mtd/nand/fsl_elbc_nand.c
index 378b7aa..2f4ce2a 100644
--- a/drivers/mtd/nand/fsl_elbc_nand.c
+++ b/drivers/mtd/nand/fsl_elbc_nand.c
@@ -480,7 +480,7 @@ static void fsl_elbc_write_buf(struct mtd_info *mtd, const u8 *buf, int len)
 	struct fsl_elbc_ctrl *ctrl = priv->ctrl;
 	unsigned int bufsize = mtd->writesize + mtd->oobsize;
 
-	if (len < 0) {
+	if (len <= 0) {
 		dev_err(ctrl->dev, "write_buf of %d bytes", len);
 		ctrl->status = 0;
 		return;
@@ -495,6 +495,15 @@ static void fsl_elbc_write_buf(struct mtd_info *mtd, const u8 *buf, int len)
 	}
 
 	memcpy_toio(&ctrl->addr[ctrl->index], buf, len);
+	/*
+	 * This is workaround for the weird elbc hangs during nand write,
+	 * Scott Wood says: "...perhaps difference in how long it takes a
+	 * write to make it through the localbus compared to a write to IMMR
+	 * is causing problems, and sync isn't helping for some reason."
+	 * Reading back the last byte helps though.
+	 */
+	in_8(&ctrl->addr[ctrl->index] + len - 1);
+
 	ctrl->index += len;
 }
 
-- 
1.5.2.2
