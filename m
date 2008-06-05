Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 01AE4DEEA0
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jun 2008 03:10:14 +1000 (EST)
Date: Thu, 5 Jun 2008 21:10:13 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Marc Pignat <marc.pignat@hevs.ch>
Subject: [PATCH] mmc: toughen get_ro() and get_cd() return values
Message-ID: <20080605171013.GA10513@polina.dev.rtsoft.ru>
References: <20080523154204.GA19803@polina.dev.rtsoft.ru>
	<200806031207.49843.marc.pignat@hevs.ch>
	<20080605144310.GA31596@polina.dev.rtsoft.ru>
	<200806051759.00202.marc.pignat@hevs.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <200806051759.00202.marc.pignat@hevs.ch>
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	spi-devel-general@lists.sourceforge.net, Timur Tabi <timur@freescale.com>,
	Pierre Ossman <drzeus-mmc@drzeus.cx>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

For the sake of safety, document that drivers should return only
1 or 0 from the get_ro() and get_cd() callbacks. Also document context
in which these callbacks should be executed.

wbsd driver modified to comply with this requirement.

Also, fix mmc_spi driver to not return raw values from the platform
get_cd hook (oops).

Suggested-by: Marc Pignat <marc.pignat@hevs.ch>
Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---

On Thu, Jun 05, 2008 at 05:58:59PM +0200, Marc Pignat wrote:
[...]
> > >  * get_ro will return:
> > >  *   0 for a read/write card
> > >  *   1 for a read-only card 
> > 
> > This isn't always practical. For example, host is using u8 register for
> > the status, so it might safely return u8 & mask, that will always fit
> > into int. Or very smart/adventurous authors might be aware that, for the
> > particular host, mask's bit isn't last, and safely do uXX & mask. :-)
> > 
> > The above is weak argument of course, since it is about optimization.
> 
> Ack, we will gain at most 1-4 assembly instructions, in a function that
> is unlikely to be called more than once a second.
> 
> > 
> > As an counter-evidence, the strict scheme that you described probably
> > less error prone. But is it? To implement it we'll need something like
> > WARN_ON(ret > 0 && ret != 1) to catch erroneous users. Take a closer
> > look though, will it catch uXX & lastbit case? Nope. :-)
> 
> WARN_ON(ret > 0 && ret != 1 || ret == INT_MIN) will do ;)
> 
> I agree with you once more, I never thinked about a runtime check.
> 
> I don't really want to see a WARN_ON(foo) after each call to get_ro or get_cd.
> 
> But I'm sure if we specify "give me a positive value when a card is detected",
> someone will write gpio & bit, and three years later, someone will fall in
> the (gpio & lastbit < 0 case).
> 
> So we should specify: "give me 1 whan a card is present, 0 when not, -ENOSYS if
> you don't know and a negative errno when something else goes wrong".

Well, ok.

Pierre, I see you didn't yet pushed out the mmc tree, so.. would you
prefer this patch folded into 0/3 series and resent?

 drivers/mmc/host/mmc_spi.c |    2 +-
 drivers/mmc/host/wbsd.c    |    2 +-
 include/linux/mmc/host.h   |   16 ++++++++++++++--
 3 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
index 85d9853..4e82f64 100644
--- a/drivers/mmc/host/mmc_spi.c
+++ b/drivers/mmc/host/mmc_spi.c
@@ -1139,7 +1139,7 @@ static int mmc_spi_get_cd(struct mmc_host *mmc)
 	struct mmc_spi_host *host = mmc_priv(mmc);
 
 	if (host->pdata && host->pdata->get_cd)
-		return host->pdata->get_cd(mmc->parent);
+		return !!host->pdata->get_cd(mmc->parent);
 	return -ENOSYS;
 }
 
diff --git a/drivers/mmc/host/wbsd.c b/drivers/mmc/host/wbsd.c
index be624a0..9283b85 100644
--- a/drivers/mmc/host/wbsd.c
+++ b/drivers/mmc/host/wbsd.c
@@ -939,7 +939,7 @@ static int wbsd_get_ro(struct mmc_host *mmc)
 
 	spin_unlock_bh(&host->lock);
 
-	return csr & WBSD_WRPT;
+	return !!(csr & WBSD_WRPT);
 }
 
 static const struct mmc_host_ops wbsd_ops = {
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index ef3b773..753b723 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -56,8 +56,20 @@ struct mmc_host_ops {
 	 * since underlaying controller might implement them in an expensive
 	 * and/or slow way.
 	 *
-	 * .get_ro and .get_cd should return >= 0 for their logical values,
-	 * or negative errno value in case of error.
+	 * Also note that these functions might sleep, so don't call them
+	 * in the atomic contexts!
+	 *
+	 * Return values for the get_ro callback should be:
+	 *   0 for a read/write card
+	 *   1 for a read-only card
+	 *   -ENOSYS when not supported (equal to NULL callback)
+	 *   or a negative errno value when something bad happened
+	 *
+	 * Return values for the get_ro callback should be:
+	 *   0 for a absent card
+	 *   1 for a present card
+	 *   -ENOSYS when not supported (equal to NULL callback)
+	 *   or a negative errno value when something bad happened
 	 */
 	void	(*set_ios)(struct mmc_host *host, struct mmc_ios *ios);
 	int	(*get_ro)(struct mmc_host *host);
-- 
1.5.5.1
