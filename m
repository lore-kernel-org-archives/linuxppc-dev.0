Return-Path: <linuxppc-dev+bounces-28415-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11391CA5FA2
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Sep 2026 16:39:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4htn831WJ7z2yMK;
	Tue, 29 Sep 2026 02:39:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.254.49.197
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790603241;
	cv=none; b=nWRjFJJFASN0UolNkBQg8yZh62AElso/DXnOVZbWeq/NFav8tBNWNoIU1FzlZAiJznE7ogcbX+xfiAV2YmuI5v2HS5CciGRpMJ8pE2XCWVkbvESN2/tOYaD/g+zWHVtBpwpaFEhaTf6g+TV13CiXARooudZg1vjvcuxTua7SuDg04wWlYUsx3VOAT3qiGm6mxkZdWCpzLcPVEErkzTOnytdpzbTIGhVJURvBE6P6DcIo/2b6vBRU2KqT2d6+/CUUQ7w3Iy5EiRkuYP5F+CwvJjWczgQuQKYjpHDP3j1ealXf1MEu3HniTHYyzqBGL2/vXo+/1lNDJHl32uK1o4EbzA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790603241; c=relaxed/relaxed;
	bh=WpuPXXwYLspgMxJce0coNH0SvQ6W/DJKv68dWucdqPA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gzDRgc4/rGXkAmnAAVSl7el35KNKE24cgX5RajCG+bRmxcJaBTsHb07IiGIG8vmBUVKkBKT7lBaTqxJ788b0sEPYiHO/wRZJWNZDV/y9RY9r9PWGkMLEEx8AKdifBlh1nzmYCMXoe9aSC5wSh8gKDpfGQy17E4tCuLB1aa3H+g+5CDNQwshfhhHFOiuLUYo3/ZW03aQXd3QtidNGoBQ9CYtnONJRAg4T30SruNGXGbxFEgnIZ8kCdXO41qx3QokOBpC+IGbST35jVH6k6Cqoqs6N4OKah0gu5ovpk0frdPazN2U8qxEkHjQzO/OqX2PE8EFLiyYNCUZ/JxSM20yXWA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; dkim=pass (1024-bit key; unprotected) header.d=seu.edu.cn header.i=@seu.edu.cn header.a=rsa-sha256 header.s=default header.b=jWDbdQe4; dkim-atps=neutral; spf=pass (client-ip=45.254.49.197; helo=mail-m49197.qiye.163.com; envelope-from=getshell@seu.edu.cn; receiver=lists.ozlabs.org) smtp.mailfrom=seu.edu.cn
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=seu.edu.cn header.i=@seu.edu.cn header.a=rsa-sha256 header.s=default header.b=jWDbdQe4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=seu.edu.cn (client-ip=45.254.49.197; helo=mail-m49197.qiye.163.com; envelope-from=getshell@seu.edu.cn; receiver=lists.ozlabs.org)
X-Greylist: delayed 316 seconds by postgrey-1.37 at boromir; Mon, 28 Sep 2026 23:47:19 AEST
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4htjKg1B8dz2y25
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2026 23:47:10 +1000 (AEST)
Received: from LAPTOP-99KJFSET (unknown [36.153.54.109])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4f5d6f439;
	Mon, 28 Sep 2026 21:41:44 +0800 (GMT+08:00)
From: Hongyan Xu <getshell@seu.edu.cn>
To: maddy@linux.ibm.com,
	mpe@ellerman.id.au
Cc: npiggin@gmail.com,
	chleroy@kernel.org,
	ritesh.list@gmail.com,
	sshegde@linux.ibm.com,
	kees@kernel.org,
	thorsten.blum@linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	Hongyan Xu <getshell@seu.edu.cn>
Subject: [PATCH] powerpc/fsl: drain MPIC wakeup work before replacing timer
Date: Mon, 28 Sep 2026 21:41:41 +0800
Message-ID: <20260928134141.452-1-getshell@seu.edu.cn>
X-Mailer: git-send-email 2.50.1.windows.1
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa0e84000e303a1kunmfdfc7f6e2001fd
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaSE1MVh5ISh5CS0sdS0MfTlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlITVVKTkhVTk9VSktCWVdZFhoPEhUdFFlBWU9LSFVKS0hKT0
	hMVUpLS1VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
	b=jWDbdQe4b4KDrrysDoN4qA8dv7vYAqE5gmjZ8GIfWOzN3OsIorRYFJjM/Y2c9Qtc6n0miYwlYN9oiEWfoiSKm0rckGmlLXpvSVsPf3+SRzzVRnBWc6dQacpw/bfykAgL6mefNR/Gb3BwMcdcLcv4vIKuXtlws8OHjHXOsQauKGA=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=WpuPXXwYLspgMxJce0coNH0SvQ6W/DJKv68dWucdqPA=;
	h=date:mime-version:subject:message-id:from;

The timer interrupt queues free_work. mpic_free_timer() synchronizes the
interrupt, but it does not drain work queued before the IRQ was freed.
Module exit can therefore free fsl_wakeup before the worker uses it.

The same race exists when a sysfs write replaces the timer. A stale
worker can wait on sysfs_lock while the store path frees the old timer
and publishes a new one, then wake and free the new timer instead.

Serialize stores and exit with timer_store_lock. Clear the old timer under
sysfs_lock, drop that lock, drain free_work, and only then publish a new
timer. Dropping sysfs_lock before cancel_work_sync() avoids deadlocking a
worker already waiting for that lock.

Fixes: a63b3bc7db32 ("powerpc/fsl: add MPIC timer wakeup support")
Signed-off-by: Hongyan Xu <getshell@seu.edu.cn>
---
 arch/powerpc/sysdev/fsl_mpic_timer_wakeup.c | 28 +++++++++++++++------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_mpic_timer_wakeup.c b/arch/powerpc/sysdev/fsl_mpic_timer_wakeup.c
index f63b89adf9f3..51710c7cdaf5 100644
--- a/arch/powerpc/sysdev/fsl_mpic_timer_wakeup.c
+++ b/arch/powerpc/sysdev/fsl_mpic_timer_wakeup.c
@@ -23,6 +23,7 @@ struct fsl_mpic_timer_wakeup {
 
 static struct fsl_mpic_timer_wakeup *fsl_wakeup;
 static DEFINE_MUTEX(sysfs_lock);
+static DEFINE_MUTEX(timer_store_lock);
 
 static void fsl_free_resource(struct work_struct *ws)
 {
@@ -76,32 +77,43 @@ static ssize_t fsl_timer_wakeup_store(struct device *dev,
 	if (kstrtoll(buf, 0, &interval))
 		return -EINVAL;
 
-	guard(mutex)(&sysfs_lock);
+	guard(mutex)(&timer_store_lock);
+
+	mutex_lock(&sysfs_lock);
 
 	if (fsl_wakeup->timer) {
 		disable_irq_wake(fsl_wakeup->timer->irq);
 		mpic_free_timer(fsl_wakeup->timer);
 		fsl_wakeup->timer = NULL;
 	}
+	mutex_unlock(&sysfs_lock);
+
+	cancel_work_sync(&fsl_wakeup->free_work);
 
 	if (!interval)
 		return count;
 
+	mutex_lock(&sysfs_lock);
 	fsl_wakeup->timer = mpic_request_timer(fsl_mpic_timer_irq,
 						fsl_wakeup, interval);
-	if (!fsl_wakeup->timer)
-		return -EINVAL;
+	if (!fsl_wakeup->timer) {
+		ret = -EINVAL;
+		goto unlock;
+	}
 
 	ret = enable_irq_wake(fsl_wakeup->timer->irq);
 	if (ret) {
 		mpic_free_timer(fsl_wakeup->timer);
 		fsl_wakeup->timer = NULL;
-		return ret;
+		goto unlock;
 	}
 
 	mpic_start_timer(fsl_wakeup->timer);
+	ret = count;
 
-	return count;
+unlock:
+	mutex_unlock(&sysfs_lock);
+	return ret;
 }
 
 static struct device_attribute mpic_attributes = __ATTR(timer_wakeup, 0644,
@@ -139,16 +151,18 @@ static void __exit fsl_wakeup_sys_exit(void)
 		put_device(dev_root);
 	}
 
+	guard(mutex)(&timer_store_lock);
 	mutex_lock(&sysfs_lock);
 
 	if (fsl_wakeup->timer) {
 		disable_irq_wake(fsl_wakeup->timer->irq);
 		mpic_free_timer(fsl_wakeup->timer);
+		fsl_wakeup->timer = NULL;
 	}
 
-	kfree(fsl_wakeup);
-
 	mutex_unlock(&sysfs_lock);
+	cancel_work_sync(&fsl_wakeup->free_work);
+	kfree(fsl_wakeup);
 }
 
 module_init(fsl_wakeup_sys_init);
-- 
2.50.1.windows.1


