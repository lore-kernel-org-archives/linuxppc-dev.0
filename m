Return-Path: <abounine@idt.com>
Received: from mxout1.idt.com (mxout1.idt.com [157.165.5.25])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mxout1.idt.com", Issuer "idt.com" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 609F32C00B9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Oct 2012 07:00:05 +1100 (EST)
From: Alexandre Bounine <alexandre.bounine@idt.com>
To: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/3] rapidio: use msleep in discovery wait
Date: Tue,  9 Oct 2012 15:57:54 -0400
Message-Id: <1349812676-27057-2-git-send-email-alexandre.bounine@idt.com>
In-Reply-To: <1349812676-27057-1-git-send-email-alexandre.bounine@idt.com>
References: <1349812676-27057-1-git-send-email-alexandre.bounine@idt.com>
Cc: Alexandre Bounine <alexandre.bounine@idt.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Use msleep() routine for code clarity as suggested by Andrew Morton in his
comments for the original patch: https://lkml.org/lkml/2012/10/3/546.

Signed-off-by: Alexandre Bounine <alexandre.bounine@idt.com>
Cc: Matt Porter <mporter@kernel.crashing.org>
Cc: Li Yang <leoli@freescale.com>
---
 drivers/rapidio/rio-scan.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/rapidio/rio-scan.c b/drivers/rapidio/rio-scan.c
index 48e9041..05f0ed9 100644
--- a/drivers/rapidio/rio-scan.c
+++ b/drivers/rapidio/rio-scan.c
@@ -1391,7 +1391,7 @@ int __devinit rio_disc_mport(struct rio_mport *mport)
 		while (time_before(jiffies, to_end)) {
 			if (rio_enum_complete(mport))
 				goto enum_done;
-			schedule_timeout_uninterruptible(msecs_to_jiffies(10));
+			msleep(10);
 		}
 
 		pr_debug("RIO: discovery timeout on mport %d %s\n",
-- 
1.7.8.4
