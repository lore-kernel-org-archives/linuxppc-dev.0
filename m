Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id C07B9DDE04
	for <linuxppc-dev@ozlabs.org>; Sun, 22 Jul 2007 00:22:53 +1000 (EST)
Date: Sun, 22 Jul 2007 00:23:03 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] constify of_platform_driver name
Message-Id: <20070722002303.df29f666.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: LKML <linux-kernel@vger.kernel.org>, wli@holomorphy.com,
	ppc-dev <linuxppc-dev@ozlabs.org>, paulus@samba.org,
	sparclinux@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/pcmcia/m8xx_pcmcia.c |    2 +-
 include/linux/of_platform.h  |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

Built for PowerPC allmodconfig and ppc64_defconfig, and for Sparc and
Sparc64 defconfig.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/drivers/pcmcia/m8xx_pcmcia.c b/drivers/pcmcia/m8xx_pcmcia.c
index 3c45142..b019854 100644
--- a/drivers/pcmcia/m8xx_pcmcia.c
+++ b/drivers/pcmcia/m8xx_pcmcia.c
@@ -1316,7 +1316,7 @@ static struct of_device_id m8xx_pcmcia_match[] = {
 MODULE_DEVICE_TABLE(of, m8xx_pcmcia_match);
 
 static struct of_platform_driver m8xx_pcmcia_driver = {
-	.name = (char *)driver_name,
+	.name = driver_name,
 	.match_table = m8xx_pcmcia_match,
 	.probe = m8xx_probe,
 	.remove = m8xx_remove,
diff --git a/include/linux/of_platform.h b/include/linux/of_platform.h
index 5fd44e6..22c3837 100644
--- a/include/linux/of_platform.h
+++ b/include/linux/of_platform.h
@@ -31,7 +31,7 @@ extern struct bus_type of_platform_bus_type;
  */
 struct of_platform_driver
 {
-	char			*name;
+	const char		*name;
 	struct of_device_id	*match_table;
 	struct module		*owner;
 
-- 
1.5.2.3
