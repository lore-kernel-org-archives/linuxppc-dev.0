Return-Path: <avorontsov@mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 50659B7D2F
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Apr 2010 03:44:01 +1000 (EST)
Date: Mon, 26 Apr 2010 21:43:58 +0400
From: Anton Vorontsov <avorontsov@mvista.com>
To: Wim Van Sebroeck <wim@iguana.be>,
	Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH] booke_wdt: Fix build (unconstify watchdog_info)
Message-ID: <20100426174358.GA16889@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

commit 42747d712de56cf2087b702d2ad90af114c53138 ("[WATCHDOG]
watchdog_info constify") introduced the following build failure:

   CC      booke_wdt.o
 booke_wdt.c: In function 'booke_wdt_init':
 booke_wdt.c:220: error: assignment of read-only variable 'ident'

Fix this by removing 'const' qualifier from watchdog_info struct.

Signed-off-by: Anton Vorontsov <avorontsov@mvista.com>
---
 drivers/watchdog/booke_wdt.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/watchdog/booke_wdt.c b/drivers/watchdog/booke_wdt.c
index 500d383..801ead1 100644
--- a/drivers/watchdog/booke_wdt.c
+++ b/drivers/watchdog/booke_wdt.c
@@ -121,7 +121,7 @@ static ssize_t booke_wdt_write(struct file *file, const char __user *buf,
 	return count;
 }
 
-static const struct watchdog_info ident = {
+static struct watchdog_info ident = {
 	.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING,
 	.identity = "PowerPC Book-E Watchdog",
 };
-- 
1.7.0.5
