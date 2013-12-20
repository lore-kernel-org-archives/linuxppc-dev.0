Return-Path: <b.zolnierkie@samsung.com>
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
 (using TLSv1 with cipher RC4-MD5 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id B40122C03D9
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Dec 2013 05:58:19 +1100 (EST)
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MY4003KAC8EZGC0@mailout1.samsung.com> for
 linuxppc-dev@lists.ozlabs.org; Sat, 21 Dec 2013 03:48:14 +0900 (KST)
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: rjw@rjwysocki.net
Subject: [PATCH v2 5/9] ACPI / cpuidle: remove dev->state_count setting
Date: Fri, 20 Dec 2013 19:47:27 +0100
Message-id: <1387565251-7051-6-git-send-email-b.zolnierkie@samsung.com>
In-reply-to: <1387565251-7051-1-git-send-email-b.zolnierkie@samsung.com>
References: <1387565251-7051-1-git-send-email-b.zolnierkie@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
 b.zolnierkie@samsung.com, daniel.lezcano@linaro.org,
 linux-kernel@vger.kernel.org, kyungmin.park@samsung.com,
 linuxppc-dev@lists.ozlabs.org, lenb@kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

dev->state_count is now always equal to drv->state_count and
drv->state_count no longer can change during driver's lifetime so
the default dev->state_count initialization in cpuidle_enable_device()
(called from cpuidle_register_device()) can be used instead.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Cc: Len Brown <lenb@kernel.org>
---
 drivers/acpi/processor_idle.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index c080c99..da8ce91 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -951,8 +951,6 @@ static int acpi_processor_setup_cpuidle_cx(struct acpi_processor *pr,
 			break;
 	}
 
-	dev->state_count = count;
-
 	if (!count)
 		return -EINVAL;
 
-- 
1.8.2.3
