Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 4CDE72C013E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Aug 2012 17:33:35 +1000 (EST)
From: Anatolij Gustschin <agust@denx.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/mpc52xx_lpbfifo: optionally defer fifo transfer start
Date: Thu, 30 Aug 2012 09:33:28 +0200
Message-Id: <1346312008-7136-1-git-send-email-agust@denx.de>
Cc: dzu@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently fifo transfer is started when submitting a transfer
request. Add posibility to defer the fifo transfer and start it
later by calling additional function. This change is backward
compatible, the behaviour of mpc52xx_lpbfifo_submit() is the same
for previous driver users, so there is no need to adapt them.

Signed-off-by: Anatolij Gustschin <agust@denx.de>
---
 arch/powerpc/include/asm/mpc52xx.h            |    2 +
 arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c |   35 ++++++++++++++++++++++++-
 2 files changed, 36 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/include/asm/mpc52xx.h b/arch/powerpc/include/asm/mpc52xx.h
index 1f41382..0acc7c7 100644
--- a/arch/powerpc/include/asm/mpc52xx.h
+++ b/arch/powerpc/include/asm/mpc52xx.h
@@ -307,6 +307,7 @@ struct mpc52xx_lpbfifo_request {
 	size_t size;
 	size_t pos;	/* current position of transfer */
 	int flags;
+	int defer_xfer_start;
 
 	/* What to do when finished */
 	void (*callback)(struct mpc52xx_lpbfifo_request *);
@@ -323,6 +324,7 @@ struct mpc52xx_lpbfifo_request {
 extern int mpc52xx_lpbfifo_submit(struct mpc52xx_lpbfifo_request *req);
 extern void mpc52xx_lpbfifo_abort(struct mpc52xx_lpbfifo_request *req);
 extern void mpc52xx_lpbfifo_poll(void);
+extern int mpc52xx_lpbfifo_start_xfer(struct mpc52xx_lpbfifo_request *req);
 
 /* mpc52xx_pic.c */
 extern void mpc52xx_init_irq(void);
diff --git a/arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c b/arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c
index d61fb1c..2351f9e 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c
@@ -170,7 +170,8 @@ static void mpc52xx_lpbfifo_kick(struct mpc52xx_lpbfifo_request *req)
 	out_be32(lpbfifo.regs + LPBFIFO_REG_CONTROL, bit_fields);
 
 	/* Kick it off */
-	out_8(lpbfifo.regs + LPBFIFO_REG_PACKET_SIZE, 0x01);
+	if (!lpbfifo.req->defer_xfer_start)
+		out_8(lpbfifo.regs + LPBFIFO_REG_PACKET_SIZE, 0x01);
 	if (dma)
 		bcom_enable(lpbfifo.bcom_cur_task);
 }
@@ -421,6 +422,38 @@ int mpc52xx_lpbfifo_submit(struct mpc52xx_lpbfifo_request *req)
 }
 EXPORT_SYMBOL(mpc52xx_lpbfifo_submit);
 
+int mpc52xx_lpbfifo_start_xfer(struct mpc52xx_lpbfifo_request *req)
+{
+	unsigned long flags;
+
+	if (!lpbfifo.regs)
+		return -ENODEV;
+
+	spin_lock_irqsave(&lpbfifo.lock, flags);
+
+	/*
+	 * If the req pointer is already set and a transfer was
+	 * started on submit, then this transfer is in progress
+	 */
+	if (lpbfifo.req && !lpbfifo.req->defer_xfer_start) {
+		spin_unlock_irqrestore(&lpbfifo.lock, flags);
+		return -EBUSY;
+	}
+
+	/*
+	 * If the req was previously submitted but not
+	 * started, start it now
+	 */
+	if (lpbfifo.req && lpbfifo.req == req &&
+	    lpbfifo.req->defer_xfer_start) {
+		out_8(lpbfifo.regs + LPBFIFO_REG_PACKET_SIZE, 0x01);
+	}
+
+	spin_unlock_irqrestore(&lpbfifo.lock, flags);
+	return 0;
+}
+EXPORT_SYMBOL(mpc52xx_lpbfifo_start_xfer);
+
 void mpc52xx_lpbfifo_abort(struct mpc52xx_lpbfifo_request *req)
 {
 	unsigned long flags;
-- 
1.7.1
