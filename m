Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id C75FFDF4A5
	for <linuxppc-dev@ozlabs.org>; Fri,  1 May 2009 09:48:30 +1000 (EST)
Date: Fri, 1 May 2009 03:48:29 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 6/9] spi_mpc83xx: Split mpc83xx_spi_work() into two routines
Message-ID: <20090430234829.GF7901@oksana.dev.rtsoft.ru>
References: <20090430234739.GA27709@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20090430234739.GA27709@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	David Brownell <dbrownell@users.sourceforge.net>,
	linux-kernel@vger.kernel.org, spi-devel-general@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

mpc83xx_spi_work() is quite large, with up to five indentation
levels and is quite difficult to read.

So, split the function in two parts:
1. mpc83xx_spi_work() now only traverse queued spi messages;
2. mpc83xx_spi_do_one_msg() only manages single messages.

There should be no functional changes.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 drivers/spi/spi_mpc83xx.c |  115 +++++++++++++++++++++++---------------------
 1 files changed, 60 insertions(+), 55 deletions(-)

diff --git a/drivers/spi/spi_mpc83xx.c b/drivers/spi/spi_mpc83xx.c
index 40f7448..50112a5 100644
--- a/drivers/spi/spi_mpc83xx.c
+++ b/drivers/spi/spi_mpc83xx.c
@@ -350,71 +350,76 @@ static int mpc83xx_spi_bufs(struct spi_device *spi, struct spi_transfer *t)
 	return mpc83xx_spi->count;
 }
 
-static void mpc83xx_spi_work(struct work_struct *work)
+static void mpc83xx_spi_do_one_msg(struct spi_message *m)
 {
-	struct mpc83xx_spi *mpc83xx_spi =
-		container_of(work, struct mpc83xx_spi, work);
-
-	spin_lock_irq(&mpc83xx_spi->lock);
-	mpc83xx_spi->busy = 1;
-	while (!list_empty(&mpc83xx_spi->queue)) {
-		struct spi_message *m;
-		struct spi_device *spi;
-		struct spi_transfer *t = NULL;
-		unsigned cs_change;
-		int status, nsecs = 50;
-
-		m = container_of(mpc83xx_spi->queue.next,
-				struct spi_message, queue);
-		list_del_init(&m->queue);
-		spin_unlock_irq(&mpc83xx_spi->lock);
-
-		spi = m->spi;
-		cs_change = 1;
-		status = 0;
-		list_for_each_entry(t, &m->transfers, transfer_list) {
-			if (t->bits_per_word || t->speed_hz) {
-				/* Don't allow changes if CS is active */
-				status = -EINVAL;
-
-				if (cs_change)
-					status = mpc83xx_spi_setup_transfer(spi, t);
-				if (status < 0)
-					break;
-			}
-
-			if (cs_change) {
-				mpc83xx_spi_chipselect(spi, BITBANG_CS_ACTIVE);
-				ndelay(nsecs);
-			}
-			cs_change = t->cs_change;
-			if (t->len)
-				status = mpc83xx_spi_bufs(spi, t);
-			if (status) {
-				status = -EMSGSIZE;
+	struct spi_device *spi = m->spi;
+	struct spi_transfer *t;
+	unsigned int cs_change;
+	const int nsecs = 50;
+	int status;
+
+	cs_change = 1;
+	status = 0;
+	list_for_each_entry(t, &m->transfers, transfer_list) {
+		if (t->bits_per_word || t->speed_hz) {
+			/* Don't allow changes if CS is active */
+			status = -EINVAL;
+
+			if (cs_change)
+				status = mpc83xx_spi_setup_transfer(spi, t);
+			if (status < 0)
 				break;
-			}
-			m->actual_length += t->len;
-
-			if (t->delay_usecs)
-				udelay(t->delay_usecs);
+		}
 
-			if (cs_change) {
-				ndelay(nsecs);
-				mpc83xx_spi_chipselect(spi, BITBANG_CS_INACTIVE);
-				ndelay(nsecs);
-			}
+		if (cs_change) {
+			mpc83xx_spi_chipselect(spi, BITBANG_CS_ACTIVE);
+			ndelay(nsecs);
+		}
+		cs_change = t->cs_change;
+		if (t->len)
+			status = mpc83xx_spi_bufs(spi, t);
+		if (status) {
+			status = -EMSGSIZE;
+			break;
 		}
+		m->actual_length += t->len;
 
-		m->status = status;
-		m->complete(m->context);
+		if (t->delay_usecs)
+			udelay(t->delay_usecs);
 
-		if (status || !cs_change) {
+		if (cs_change) {
 			ndelay(nsecs);
 			mpc83xx_spi_chipselect(spi, BITBANG_CS_INACTIVE);
+			ndelay(nsecs);
 		}
+	}
+
+	m->status = status;
+	m->complete(m->context);
+
+	if (status || !cs_change) {
+		ndelay(nsecs);
+		mpc83xx_spi_chipselect(spi, BITBANG_CS_INACTIVE);
+	}
+
+	mpc83xx_spi_setup_transfer(spi, NULL);
+}
+
+static void mpc83xx_spi_work(struct work_struct *work)
+{
+	struct mpc83xx_spi *mpc83xx_spi = container_of(work, struct mpc83xx_spi,
+						       work);
+
+	spin_lock_irq(&mpc83xx_spi->lock);
+	mpc83xx_spi->busy = 1;
+	while (!list_empty(&mpc83xx_spi->queue)) {
+		struct spi_message *m = container_of(mpc83xx_spi->queue.next,
+						   struct spi_message, queue);
+
+		list_del_init(&m->queue);
+		spin_unlock_irq(&mpc83xx_spi->lock);
 
-		mpc83xx_spi_setup_transfer(spi, NULL);
+		mpc83xx_spi_do_one_msg(m);
 
 		spin_lock_irq(&mpc83xx_spi->lock);
 	}
-- 
1.6.2.2
