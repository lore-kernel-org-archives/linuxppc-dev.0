Return-Path: <benh@kernel.crashing.org>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp07.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D18BAB703B
 for <linuxppc-dev@ozlabs.org>; Thu, 19 Apr 2012 19:03:52 +1000 (EST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <benh@kernel.crashing.org>;
 Thu, 19 Apr 2012 08:14:50 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q3J8DFdA2154602
 for <linuxppc-dev@ozlabs.org>; Thu, 19 Apr 2012 18:13:15 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q3J8Jmmp004478
 for <linuxppc-dev@ozlabs.org>; Thu, 19 Apr 2012 18:19:50 +1000
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 08/15] powerpc/windfarm: Remove spurrious sysfs_attr_init()
Date: Thu, 19 Apr 2012 18:16:49 +1000
Message-Id: <1334823416-9138-9-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1334823416-9138-1-git-send-email-benh@kernel.crashing.org>
References: <1334823416-9138-1-git-send-email-benh@kernel.crashing.org>
Cc: khali@linux-fr.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The windfarm core will do it, so this is a duplicate.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 drivers/macintosh/windfarm_smu_controls.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/macintosh/windfarm_smu_controls.c b/drivers/macintosh/windfarm_smu_controls.c
index 3c2be51..c155a54 100644
--- a/drivers/macintosh/windfarm_smu_controls.c
+++ b/drivers/macintosh/windfarm_smu_controls.c
@@ -172,7 +172,6 @@ static struct smu_fan_control *smu_fan_create(struct device_node *node,
 
 	fct->fan_type = pwm_fan;
 	fct->ctrl.type = pwm_fan ? WF_CONTROL_PWM_FAN : WF_CONTROL_RPM_FAN;
-	sysfs_attr_init(&fct->ctrl.attr.attr);
 
 	/* We use the name & location here the same way we do for SMU sensors,
 	 * see the comment in windfarm_smu_sensors.c. The locations are a bit
-- 
1.7.9.5
