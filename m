Return-Path: <bhumirks@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xTXL91KVzzDr2M
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Aug 2017 03:38:57 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id j68so4009871pfc.2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Aug 2017 10:38:57 -0700 (PDT)
From: Bhumika Goyal <bhumirks@gmail.com>
To: julia.lawall@lip6.fr, benh@kernel.crashing.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH] drivers/macintosh: make wf_control_ops and wf_pid_param const
Date: Fri, 11 Aug 2017 23:08:45 +0530
Message-Id: <1502473125-4849-1-git-send-email-bhumirks@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Make wf_control_ops const as they are only stored in the ops field of a
wf_control structure, which is const.
Make wf_pid_param const as they are only used during a copy operation.
Done using Coccinelle.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
Cross compiled windfarm_smu_controls.o and windfarm_rm31.o for powerpc.

 drivers/macintosh/windfarm_cpufreq_clamp.c | 2 +-
 drivers/macintosh/windfarm_rm31.c          | 4 ++--
 drivers/macintosh/windfarm_smu_controls.c  | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/macintosh/windfarm_cpufreq_clamp.c b/drivers/macintosh/windfarm_cpufreq_clamp.c
index 72d1fdf..2626990 100644
--- a/drivers/macintosh/windfarm_cpufreq_clamp.c
+++ b/drivers/macintosh/windfarm_cpufreq_clamp.c
@@ -63,7 +63,7 @@ static s32 clamp_max(struct wf_control *ct)
 	return 1;
 }
 
-static struct wf_control_ops clamp_ops = {
+static const struct wf_control_ops clamp_ops = {
 	.set_value	= clamp_set,
 	.get_value	= clamp_get,
 	.get_min	= clamp_min,
diff --git a/drivers/macintosh/windfarm_rm31.c b/drivers/macintosh/windfarm_rm31.c
index bdfcb8a..a0cd9c7 100644
--- a/drivers/macintosh/windfarm_rm31.c
+++ b/drivers/macintosh/windfarm_rm31.c
@@ -338,7 +338,7 @@ static int cpu_setup_pid(int cpu)
 }
 
 /* Backside/U3 fan */
-static struct wf_pid_param backside_param = {
+static const struct wf_pid_param backside_param = {
 	.interval	= 1,
 	.history_len	= 2,
 	.gd		= 0x00500000,
@@ -351,7 +351,7 @@ static int cpu_setup_pid(int cpu)
 };
 
 /* DIMMs temperature (clamp the backside fan) */
-static struct wf_pid_param dimms_param = {
+static const struct wf_pid_param dimms_param = {
 	.interval	= 1,
 	.history_len	= 20,
 	.gd		= 0,
diff --git a/drivers/macintosh/windfarm_smu_controls.c b/drivers/macintosh/windfarm_smu_controls.c
index c155a54..d174c74 100644
--- a/drivers/macintosh/windfarm_smu_controls.c
+++ b/drivers/macintosh/windfarm_smu_controls.c
@@ -145,7 +145,7 @@ static s32 smu_fan_max(struct wf_control *ct)
 	return fct->max;
 }
 
-static struct wf_control_ops smu_fan_ops = {
+static const struct wf_control_ops smu_fan_ops = {
 	.set_value	= smu_fan_set,
 	.get_value	= smu_fan_get,
 	.get_min	= smu_fan_min,
-- 
1.9.1
