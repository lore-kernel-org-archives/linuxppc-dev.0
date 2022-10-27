Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C37FC38A2D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 27 Oct 2022 01:36:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MySvm3My8z3cMl
	for <linuxppc-dev@archiver.kernel.org>; Thu, 27 Oct 2022 12:36:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.187; helo=szxga01-in.huawei.com; envelope-from=yangyingliang@huawei.com; receiver=<UNKNOWN>)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MySv55nsfz2xGk
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Oct 2022 12:36:12 +1100 (AEDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.57])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MySmd5z88zmVNY;
	Thu, 27 Oct 2022 09:30:41 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 27 Oct 2022 09:35:35 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 27 Oct
 2022 09:35:35 +0800
From: Yang Yingliang <yangyingliang@huawei.com>
To: <alsa-devel@alsa-project.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] ALSA: aoa: i2sbus: fix possible memory leak in i2sbus_add_dev()
Date: Thu, 27 Oct 2022 09:34:38 +0800
Message-ID: <20221027013438.991920-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: johannes@sipsolutions.net, yangyingliang@huawei.com, tiwai@suse.com, perex@perex.cz
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

dev_set_name() in soundbus_add_one() allocates memory for name, it need be
freed when of_device_register() fails, call soundbus_dev_put() to give up
the reference that hold in device_initialize(), so that it can be freed in
kobject_cleanup() when the refcount hit to 0. And other resources are also
freed in i2sbus_release_dev(), so it can return 0 directly.

Fixes: f3d9478b2ce4 ("[ALSA] snd-aoa: add snd-aoa")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 sound/aoa/soundbus/i2sbus/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/aoa/soundbus/i2sbus/core.c b/sound/aoa/soundbus/i2sbus/core.c
index faf6b03131ee..f6841daf9e3b 100644
--- a/sound/aoa/soundbus/i2sbus/core.c
+++ b/sound/aoa/soundbus/i2sbus/core.c
@@ -302,6 +302,10 @@ static int i2sbus_add_dev(struct macio_dev *macio,
 
 	if (soundbus_add_one(&dev->sound)) {
 		printk(KERN_DEBUG "i2sbus: device registration error!\n");
+		if (dev->sound.ofdev.dev.kobj.state_initialized) {
+			soundbus_dev_put(&dev->sound);
+			return 0;
+		}
 		goto err;
 	}
 
-- 
2.25.1

