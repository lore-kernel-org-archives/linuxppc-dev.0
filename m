Return-Path: <wfp5p@viridian.itc.virginia.edu>
Received: from viridian.itc.virginia.edu (viridian.itc.Virginia.EDU
 [128.143.12.139]) by ozlabs.org (Postfix) with ESMTP id EE22D2C00A7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Nov 2012 05:32:59 +1100 (EST)
From: Bill Pemberton <wfp5p@virginia.edu>
To: gregkh@linuxfoundation.org
Subject: [PATCH 072/493] drivers/macintosh: remove use of __devexit_p
Date: Mon, 19 Nov 2012 13:20:21 -0500
Message-Id: <1353349642-3677-72-git-send-email-wfp5p@virginia.edu>
In-Reply-To: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

CONFIG_HOTPLUG is going away as an option so __devexit_p is no longer
needed.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org> 
Cc: linuxppc-dev@lists.ozlabs.org 
---
 drivers/macintosh/rack-meter.c     | 2 +-
 drivers/macintosh/windfarm_pm112.c | 2 +-
 drivers/macintosh/windfarm_pm121.c | 2 +-
 drivers/macintosh/windfarm_pm81.c  | 2 +-
 drivers/macintosh/windfarm_pm91.c  | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/macintosh/rack-meter.c b/drivers/macintosh/rack-meter.c
index 6dc26b6..18cd177 100644
--- a/drivers/macintosh/rack-meter.c
+++ b/drivers/macintosh/rack-meter.c
@@ -588,7 +588,7 @@ static struct macio_driver rackmeter_driver = {
 		.of_match_table = rackmeter_match,
 	},
 	.probe = rackmeter_probe,
-	.remove = __devexit_p(rackmeter_remove),
+	.remove = rackmeter_remove,
 	.shutdown = rackmeter_shutdown,
 };
 
diff --git a/drivers/macintosh/windfarm_pm112.c b/drivers/macintosh/windfarm_pm112.c
index e0ee807..54ac434 100644
--- a/drivers/macintosh/windfarm_pm112.c
+++ b/drivers/macintosh/windfarm_pm112.c
@@ -665,7 +665,7 @@ static int __devexit wf_pm112_remove(struct platform_device *dev)
 
 static struct platform_driver wf_pm112_driver = {
 	.probe = wf_pm112_probe,
-	.remove = __devexit_p(wf_pm112_remove),
+	.remove = wf_pm112_remove,
 	.driver = {
 		.name = "windfarm",
 		.owner	= THIS_MODULE,
diff --git a/drivers/macintosh/windfarm_pm121.c b/drivers/macintosh/windfarm_pm121.c
index 04067e0..ec0ec67 100644
--- a/drivers/macintosh/windfarm_pm121.c
+++ b/drivers/macintosh/windfarm_pm121.c
@@ -995,7 +995,7 @@ static int __devexit pm121_remove(struct platform_device *ddev)
 
 static struct platform_driver pm121_driver = {
 	.probe = pm121_probe,
-	.remove = __devexit_p(pm121_remove),
+	.remove = pm121_remove,
 	.driver = {
 		.name = "windfarm",
 		.bus = &platform_bus_type,
diff --git a/drivers/macintosh/windfarm_pm81.c b/drivers/macintosh/windfarm_pm81.c
index 990c876..92ba8f5 100644
--- a/drivers/macintosh/windfarm_pm81.c
+++ b/drivers/macintosh/windfarm_pm81.c
@@ -763,7 +763,7 @@ static int __devexit wf_smu_remove(struct platform_device *ddev)
 
 static struct platform_driver wf_smu_driver = {
         .probe = wf_smu_probe,
-        .remove = __devexit_p(wf_smu_remove),
+	.remove = wf_smu_remove,
 	.driver = {
 		.name = "windfarm",
 		.owner	= THIS_MODULE,
diff --git a/drivers/macintosh/windfarm_pm91.c b/drivers/macintosh/windfarm_pm91.c
index 7653603..5be25b9 100644
--- a/drivers/macintosh/windfarm_pm91.c
+++ b/drivers/macintosh/windfarm_pm91.c
@@ -692,7 +692,7 @@ static int __devexit wf_smu_remove(struct platform_device *ddev)
 
 static struct platform_driver wf_smu_driver = {
         .probe = wf_smu_probe,
-        .remove = __devexit_p(wf_smu_remove),
+	.remove = wf_smu_remove,
 	.driver = {
 		.name = "windfarm",
 		.owner	= THIS_MODULE,
-- 
1.8.0
