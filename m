Return-Path: <kda@linux-powerpc.org>
Received: from mail-lf0-x244.google.com (mail-lf0-x244.google.com
 [IPv6:2a00:1450:4010:c07::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tC5bC68w5zDt0F
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Nov 2016 19:44:23 +1100 (AEDT)
Received: by mail-lf0-x244.google.com with SMTP id o141so7459304lff.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Nov 2016 00:44:23 -0800 (PST)
From: Denis Kirjanov <kda@linux-powerpc.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: ego@linux.vnet.ibm.com,
	Denis Kirjanov <kda@linux-powerpc.org>
Subject: [PATCH v3] ppc: cpufreq: disable preemption while checking CPU
 throttling state
Date: Mon,  7 Nov 2016 03:42:22 -0500
Message-Id: <1478508142-13467-1-git-send-email-kda@linux-powerpc.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

    [   67.700897] BUG: using smp_processor_id() in preemptible [00000000] code: cat/7343
    [   67.700988] caller is .powernv_cpufreq_throttle_check+0x2c/0x710
    [   67.700998] CPU: 13 PID: 7343 Comm: cat Not tainted 4.8.0-rc5-dirty #1
    [   67.701038] Call Trace:
    [   67.701066] [c0000007d25b75b0] [c000000000971378] .dump_stack+0xe4/0x150 (unreliable)
    [   67.701153] [c0000007d25b7640] [c0000000005162e4] .check_preemption_disabled+0x134/0x150
    [   67.701238] [c0000007d25b76e0] [c0000000007b63ac] .powernv_cpufreq_throttle_check+0x2c/0x710
    [   67.701322] [c0000007d25b7790] [c0000000007b6d18] .powernv_cpufreq_target_index+0x288/0x360
    [   67.701407] [c0000007d25b7870] [c0000000007acee4] .__cpufreq_driver_target+0x394/0x8c0
    [   67.701491] [c0000007d25b7920] [c0000000007b22ac] .cpufreq_set+0x7c/0xd0
    [   67.701565] [c0000007d25b79b0] [c0000000007adf50] .store_scaling_setspeed+0x80/0xc0
    [   67.701650] [c0000007d25b7a40] [c0000000007ae270] .store+0xa0/0x100
    [   67.701723] [c0000007d25b7ae0] [c0000000003566e8] .sysfs_kf_write+0x88/0xb0
    [   67.701796] [c0000007d25b7b70] [c0000000003553b8] .kernfs_fop_write+0x178/0x260
    [   67.701881] [c0000007d25b7c10] [c0000000002ac3cc] .__vfs_write+0x3c/0x1c0
    [   67.701954] [c0000007d25b7cf0] [c0000000002ad584] .vfs_write+0xc4/0x230
    [   67.702027] [c0000007d25b7d90] [c0000000002aeef8] .SyS_write+0x58/0x100
    [   67.702101] [c0000007d25b7e30] [c00000000000bfec] system_call+0x38/0xfc

Fixes: 09a972d ("cpufreq: powernv: Report cpu frequency throttling")
Signed-off-by: Denis Kirjanov <kda@linux-powerpc.org>
---
v2: v2:  wrap powernv_cpufreq_throttle_check()
as suggested by Gautham R Shenoy

v3: added Fix tag

drivers/cpufreq/powernv-cpufreq.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
index d3ffde8..a84724e 100644
--- a/drivers/cpufreq/powernv-cpufreq.c
+++ b/drivers/cpufreq/powernv-cpufreq.c
@@ -647,8 +647,14 @@ static int powernv_cpufreq_target_index(struct cpufreq_policy *policy,
 	if (unlikely(rebooting) && new_index != get_nominal_index())
 		return 0;
 
-	if (!throttled)
+	if (!throttled) {
+		/* we don't want to be preempted while
+		 * checking if the CPU frequency has been throttled
+		 */
+		preempt_disable();
 		powernv_cpufreq_throttle_check(NULL);
+		preempt_enable();
+	}
 
 	cur_msec = jiffies_to_msecs(get_jiffies_64());
 
-- 
1.8.3.1
