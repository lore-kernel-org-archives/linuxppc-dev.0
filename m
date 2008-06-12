Return-Path: <bzolnier@gmail.com>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.158])
	by ozlabs.org (Postfix) with ESMTP id 24580DE0E3
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jun 2008 09:10:45 +1000 (EST)
Received: by fg-out-1718.google.com with SMTP id d23so2639026fga.39
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jun 2008 16:10:43 -0700 (PDT)
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: linux-ide@vger.kernel.org
Date: Fri, 13 Jun 2008 01:12:24 +0200
Message-Id: <20080612231224.18335.91182.sendpatchset@localhost.localdomain>
Subject: [PATCH 1/7] ide-pmac: bugfix for media-bay support rework
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Fix bug introduced by:

commit 2dde7861afa23cd59db83515cb0b810b92b220aa
Author: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Date:   Fri Apr 18 00:46:23 2008 +0200

    ide: rework PowerMac media-bay support (take 2)
...

[ Yeah, I suck. ]

bay->cd_index shouldn't be changed if IDE devices are not present
or retry operations won't happen.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
first three patches are meant for 2.6.26, the rest for 2.6.27

drivers/macintosh/mediabay.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: b/drivers/macintosh/mediabay.c
===================================================================
--- a/drivers/macintosh/mediabay.c
+++ b/drivers/macintosh/mediabay.c
@@ -556,7 +556,8 @@ static void media_bay_step(int i)
 				printk("mediabay %d, registering IDE...\n", i);
 				pmu_suspend();
 				ide_port_scan(bay->cd_port);
-				bay->cd_index = bay->cd_port->index;
+				if (bay->cd_port->present)
+					bay->cd_index = bay->cd_port->index;
 				pmu_resume();
 			}
 			if (bay->cd_index == -1) {
