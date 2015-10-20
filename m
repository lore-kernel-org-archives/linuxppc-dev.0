Return-Path: <luisbg@osg.samsung.com>
Received: from lists.s-osg.org (lists.s-osg.org [54.187.51.154])
 by lists.ozlabs.org (Postfix) with ESMTP id 075211A0293
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Oct 2015 02:13:44 +1100 (AEDT)
From: Luis de Bethencourt <luisbg@osg.samsung.com>
To: linux-kernel@vger.kernel.org
Cc: benh@kernel.crashing.org, linuxppc-dev@lists.ozlabs.org,
 Luis de Bethencourt <luis@debethencourt.com>,
 Luis de Bethencourt <luisbg@osg.samsung.com>
Subject: [RESEND PATCH] powerpc: rackmeter: Fix module autoload for OF
 platform driver
Date: Tue, 20 Oct 2015 16:13:53 +0100
Message-Id: <1445354033-3619-1-git-send-email-luisbg@osg.samsung.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Luis de Bethencourt <luis@debethencourt.com>

This platform driver has a OF device ID table but the OF module
alias information is not created so module autoloading won't work.

Signed-off-by: Luis de Bethencourt <luisbg@osg.samsung.com>
---

Hi,

This is a resend of a patch sent September 17 [0]

This patch adds the missing MODULE_DEVICE_TABLE() for OF to export
that information so modules have the correct aliases built-in and
autoloading works correctly.

A longer explanation by Javier Canillas can be found here:
https://lkml.org/lkml/2015/7/30/519

Thanks,
Luis

[0] https://lkml.org/lkml/2015/9/17/598

 drivers/macintosh/rack-meter.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/macintosh/rack-meter.c b/drivers/macintosh/rack-meter.c
index 048901a..caaec65 100644
--- a/drivers/macintosh/rack-meter.c
+++ b/drivers/macintosh/rack-meter.c
@@ -582,6 +582,7 @@ static struct of_device_id rackmeter_match[] = {
 	{ .name = "i2s" },
 	{ }
 };
+MODULE_DEVICE_TABLE(of, rackmeter_match);
 
 static struct macio_driver rackmeter_driver = {
 	.driver = {
-- 
2.5.3
