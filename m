Return-Path: <bhumirks@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vBKFb07FfzDq6X
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jan 2017 04:26:42 +1100 (AEDT)
Received: by mail-pf0-x242.google.com with SMTP id f144so21804922pfa.2
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Jan 2017 09:26:42 -0800 (PST)
From: Bhumika Goyal <bhumirks@gmail.com>
To: julia.lawall@lip6.fr, benh@kernel.crashing.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH] macintosh: windfarm_smu_sensors: constify wf_sensor_ops
 structures
Date: Sun, 29 Jan 2017 22:56:28 +0530
Message-Id: <1485710788-3662-1-git-send-email-bhumirks@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Declare wf_sensor_ops structures as const as they are only stored in the
ops field of a wf_sensor structure. This field is of type const, so
wf_sensor_ops structures having this property can be made const too.
Done using Coccinelle:

@r disable optional_qualifier@
identifier x;
position p;
@@
static struct wf_sensor_ops x@p={...};

@ok@
struct smu_ad_sensor ads;
struct smu_cpu_power_sensor pow;
identifier r.x;
position p;
@@
(
ads.sens.ops=&x@p;
|
pow.sens.ops=&x@p;
)

@bad@
position p != {r.p,ok.p};
identifier r.x;
@@
x@p

@depends on !bad disable optional_qualifier@
identifier r.x;
@@
+const
struct wf_sensor_ops x;

Size details after cross compiling the .o file for powerpc architecture.
File size before:
 text	   data	    bss	    dec	    hex	filename
   3700	    408	     48	   4156	   103c	macintosh/windfarm_smu_sensors.o

File size after:
 text	   data	    bss	    dec	    hex	filename
   3832	    288	     48	   4168	   1048	macintosh/windfarm_smu_sensors.o

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 drivers/macintosh/windfarm_smu_sensors.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/macintosh/windfarm_smu_sensors.c b/drivers/macintosh/windfarm_smu_sensors.c
index 1cc4e49..172fd26 100644
--- a/drivers/macintosh/windfarm_smu_sensors.c
+++ b/drivers/macintosh/windfarm_smu_sensors.c
@@ -172,22 +172,22 @@ static int smu_slotspow_get(struct wf_sensor *sr, s32 *value)
 }
 
 
-static struct wf_sensor_ops smu_cputemp_ops = {
+static const struct wf_sensor_ops smu_cputemp_ops = {
 	.get_value	= smu_cputemp_get,
 	.release	= smu_ads_release,
 	.owner		= THIS_MODULE,
 };
-static struct wf_sensor_ops smu_cpuamp_ops = {
+static const struct wf_sensor_ops smu_cpuamp_ops = {
 	.get_value	= smu_cpuamp_get,
 	.release	= smu_ads_release,
 	.owner		= THIS_MODULE,
 };
-static struct wf_sensor_ops smu_cpuvolt_ops = {
+static const struct wf_sensor_ops smu_cpuvolt_ops = {
 	.get_value	= smu_cpuvolt_get,
 	.release	= smu_ads_release,
 	.owner		= THIS_MODULE,
 };
-static struct wf_sensor_ops smu_slotspow_ops = {
+static const struct wf_sensor_ops smu_slotspow_ops = {
 	.get_value	= smu_slotspow_get,
 	.release	= smu_ads_release,
 	.owner		= THIS_MODULE,
@@ -327,7 +327,7 @@ static int smu_cpu_power_get(struct wf_sensor *sr, s32 *value)
 	return 0;
 }
 
-static struct wf_sensor_ops smu_cpu_power_ops = {
+static const struct wf_sensor_ops smu_cpu_power_ops = {
 	.get_value	= smu_cpu_power_get,
 	.release	= smu_cpu_power_release,
 	.owner		= THIS_MODULE,
-- 
2.7.4
