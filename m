Date: Fri, 23 Jul 2004 16:59:02 +0200
From: maximilian attems <janitor@sternwelten.at>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: benh@kernel.crashing.org, linuxppc-dev@lists.linuxppc.org
Subject: [patch-kj] MIN/MAX removal drivers/macintosh/macserial.c
Message-ID: <20040723145902.GL1795@stro.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


removes unnecessary min/max macros and changes
calls to use kernel.h macros instead.

Michael

patch applies cleanly to 2.6.8-rc2

From: michael.veeck at gmx.net (Michael Veeck)
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>


---

 linux-2.6.7-bk20-max/drivers/macintosh/macserial.c |   20 +++++++-------------
 1 files changed, 7 insertions(+), 13 deletions(-)

diff -puN drivers/macintosh/macserial.c~min-max-macintosh_macserial drivers/macintosh/macserial.c
--- linux-2.6.7-bk20/drivers/macintosh/macserial.c~min-max-macintosh_macserial	2004-07-11 15:07:11.000000000 +0200
+++ linux-2.6.7-bk20-max/drivers/macintosh/macserial.c	2004-07-11 15:07:11.000000000 +0200
@@ -158,10 +158,6 @@ static void dma_init(struct mac_serial *
 static void rxdma_start(struct mac_serial * info, int current);
 static void rxdma_to_tty(struct mac_serial * info);

-#ifndef MIN
-#define MIN(a,b)	((a) < (b) ? (a) : (b))
-#endif
-
 /*
  * tmp_buf is used as a temporary buffer by serial_write.  We need to
  * lock it in case the copy_from_user blocks while swapping in a page,
@@ -1485,9 +1481,8 @@ static int rs_write(struct tty_struct *
 	if (from_user) {
 		down(&tmp_buf_sem);
 		while (1) {
-			c = MIN(count,
-				MIN(SERIAL_XMIT_SIZE - info->xmit_cnt - 1,
-				    SERIAL_XMIT_SIZE - info->xmit_head));
+			c = min_t(int, count, min(SERIAL_XMIT_SIZE - info->xmit_cnt - 1,
+						  SERIAL_XMIT_SIZE - info->xmit_head));
 			if (c <= 0)
 				break;

@@ -1498,8 +1493,8 @@ static int rs_write(struct tty_struct *
 				break;
 			}
 			spin_lock_irqsave(&info->lock, flags);
-			c = MIN(c, MIN(SERIAL_XMIT_SIZE - info->xmit_cnt - 1,
-				       SERIAL_XMIT_SIZE - info->xmit_head));
+			c = min_t(int, c, min(SERIAL_XMIT_SIZE - info->xmit_cnt - 1,
+					      SERIAL_XMIT_SIZE - info->xmit_head));
 			memcpy(info->xmit_buf + info->xmit_head, tmp_buf, c);
 			info->xmit_head = ((info->xmit_head + c) &
 					   (SERIAL_XMIT_SIZE-1));
@@ -1513,9 +1508,8 @@ static int rs_write(struct tty_struct *
 	} else {
 		while (1) {
 			spin_lock_irqsave(&info->lock, flags);
-			c = MIN(count,
-				MIN(SERIAL_XMIT_SIZE - info->xmit_cnt - 1,
-				    SERIAL_XMIT_SIZE - info->xmit_head));
+			c = min_t(int, count, min(SERIAL_XMIT_SIZE - info->xmit_cnt - 1,
+						  SERIAL_XMIT_SIZE - info->xmit_head));
 			if (c <= 0) {
 				spin_unlock_irqrestore(&info->lock, flags);
 				break;
@@ -2052,7 +2046,7 @@ static void rs_wait_until_sent(struct tt
 	} else if (char_time == 0)
 		char_time = 1;
 	if (timeout)
-		char_time = MIN(char_time, timeout);
+		char_time = min_t(unsigned long, char_time, timeout);
 	while ((read_zsreg(info->zs_channel, 1) & ALL_SNT) == 0) {
 		current->state = TASK_INTERRUPTIBLE;
 		schedule_timeout(char_time);


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
