Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 69740DE2E3
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Mar 2008 07:24:40 +1100 (EST)
Date: Wed, 26 Mar 2008 23:24:39 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Richard Purdie <rpurdie@rpsys.net>
Subject: [PATCH 2/5] leds: mark led_classdev.default_trigger as const
Message-ID: <20080326202439.GB1772@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

LED classdev core doesn't modify memory pointed by the default_trigger,
so mark it as const and we'll able to pass const char *s without getting
compiler warnings.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 include/linux/leds.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/linux/leds.h b/include/linux/leds.h
index 0201f6f..2122a77 100644
--- a/include/linux/leds.h
+++ b/include/linux/leds.h
@@ -45,7 +45,7 @@ struct led_classdev {
 
 	struct device		*dev;
 	struct list_head	 node;			/* LED Device list */
-	char			*default_trigger;	/* Trigger to use */
+	const char		*default_trigger;	/* Trigger to use */
 
 #ifdef CONFIG_LEDS_TRIGGERS
 	/* Protects the trigger data below */
-- 
1.5.2.2
