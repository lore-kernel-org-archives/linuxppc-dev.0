Return-Path: <fabf@skynet.be>
Received: from mailrelay118.isp.belgacom.be (mailrelay118.isp.belgacom.be
 [195.238.20.145])
 by lists.ozlabs.org (Postfix) with ESMTP id 4F0201A0B92
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Mar 2015 06:21:14 +1100 (AEDT)
From: Fabian Frederick <fabf@skynet.be>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 18/35 linux-next] macintosh: constify of_device_id array
Date: Mon, 16 Mar 2015 20:20:34 +0100
Message-Id: <1426533651-25586-9-git-send-email-fabf@skynet.be>
In-Reply-To: <1426533651-25586-1-git-send-email-fabf@skynet.be>
References: <1426533469-25458-1-git-send-email-fabf@skynet.be>
 <1426533651-25586-1-git-send-email-fabf@skynet.be>
Cc: Fabian Frederick <fabf@skynet.be>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

of_device_id is always used as const.
(See driver.of_match_table and open firmware functions)

Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
 drivers/macintosh/mediabay.c   | 2 +-
 drivers/macintosh/rack-meter.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/macintosh/mediabay.c b/drivers/macintosh/mediabay.c
index d98e566..2ddbe87 100644
--- a/drivers/macintosh/mediabay.c
+++ b/drivers/macintosh/mediabay.c
@@ -707,7 +707,7 @@ static const struct mb_ops keylargo_mb_ops = {
  * Therefore we do it all by polling the media bay once each tick.
  */
 
-static struct of_device_id media_bay_match[] =
+static const struct of_device_id media_bay_match[] =
 {
 	{
 	.name		= "media-bay",
diff --git a/drivers/macintosh/rack-meter.c b/drivers/macintosh/rack-meter.c
index 4192901..4585f70 100644
--- a/drivers/macintosh/rack-meter.c
+++ b/drivers/macintosh/rack-meter.c
@@ -578,7 +578,7 @@ static int rackmeter_shutdown(struct macio_dev* mdev)
 	return 0;
 }
 
-static struct of_device_id rackmeter_match[] = {
+static const struct of_device_id rackmeter_match[] = {
 	{ .name = "i2s" },
 	{ }
 };
-- 
2.1.0
