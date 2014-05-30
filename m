Return-Path: <a.hajda@samsung.com>
Received: from mailout3.w1.samsung.com (mailout3.w1.samsung.com
 [210.118.77.13]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 39FC51A06DA
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 May 2014 20:21:39 +1000 (EST)
Received: from eucpsbgm2.samsung.com (unknown [203.254.199.245])
 by mailout3.w1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0N6D00LDVTN97W60@mailout3.w1.samsung.com> for
 linuxppc-dev@lists.ozlabs.org; Fri, 30 May 2014 11:11:33 +0100 (BST)
From: Andrzej Hajda <a.hajda@samsung.com>
To: Lee Jones <lee.jones@linaro.org>, Jingoo Han <jg1.han@samsung.com>,
 Bryan Wu <cooloney@gmail.com>
Subject: [PATCH 1/2] backlight: show brightness even if get_brightness is not
 implemented
Date: Fri, 30 May 2014 12:10:49 +0200
Message-id: <1401444650-12267-2-git-send-email-a.hajda@samsung.com>
In-reply-to: <1401444650-12267-1-git-send-email-a.hajda@samsung.com>
References: <1401444650-12267-1-git-send-email-a.hajda@samsung.com>
Cc: Milo Kim <milo.kim@ti.com>,
 "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>,
 "open list:X86 PLATFORM DRIVERS" <platform-driver-x86@vger.kernel.org>,
 Andrzej Hajda <a.hajda@samsung.com>, Thierry Reding <thierry.reding@gmail.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Yijing Wang <wangyijing@huawei.com>,
 Matthew Garrett <matthew.garrett@nebula.com>,
 Kukjin Kim <kgene.kim@samsung.com>, Sachin Kamat <sachin.kamat@linaro.org>,
 Tomi Valkeinen <tomi.valkeinen@ti.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
 Dan Carpenter <dan.carpenter@oracle.com>,
 "open list:PWM SUBSYSTEM" <linux-pwm@vger.kernel.org>,
 "moderated list:ARM/S5P EXYNOS AR..." <linux-samsung-soc@vger.kernel.org>,
 Mikulas Patocka <mpatocka@redhat.com>,
 "moderated list:ARM/S5P EXYNOS AR..." <linux-arm-kernel@lists.infradead.org>,
 Randy Dunlap <rdunlap@infradead.org>, open list <linux-kernel@vger.kernel.org>,
 Rob Clark <robdclark@gmail.com>, Jon Mason <jdmason@kudzu.us>,
 Joe Perches <joe@perches.com>,
 "open list:LINUX FOR POWER M..." <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Many implementations of get_brightness operation returns only value
of props.brightness field. This change makes such implementations
unnecessary.

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
---
 drivers/video/backlight/backlight.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backlight/backlight.c
index 19b170d..0ce8823 100644
--- a/drivers/video/backlight/backlight.c
+++ b/drivers/video/backlight/backlight.c
@@ -221,6 +221,8 @@ static ssize_t actual_brightness_show(struct device *dev,
 	mutex_lock(&bd->ops_lock);
 	if (bd->ops && bd->ops->get_brightness)
 		rc = sprintf(buf, "%d\n", bd->ops->get_brightness(bd));
+	else
+		rc = sprintf(buf, "%d\n", bd->props.brightness);
 	mutex_unlock(&bd->ops_lock);
 
 	return rc;
-- 
1.9.1
