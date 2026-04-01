Return-Path: <linuxppc-dev+bounces-19167-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98E8010F6FBF
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Apr 2026 16:03:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fm8st4mf6z2yhv;
	Thu, 02 Apr 2026 03:03:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=159.226.251.21
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775059410;
	cv=none; b=Uxu+vcbAZ9WcnYesOZyo5b+M8TtFoXr2KbR6KnkAEIKhC5zNW+as/h9jfZJJeMKVMM4MNvdIyqmBloqHkh0dI+W34R9SZPPSyHYNI13cnBZlHqoDPfSv5PQqSjOaXponT1xS8KTdFVjoHT8zXRAuUElITufGcgahfJjNkeW2l5q+0XVXwrLAGBvbiAa6/norRUg1e7euwK6YFAO26Q912IgAlPnPX4KRQMsjbQ546C9aIdgHD6vm4BpEtmlKgEcpbY7DYa4aQPz2uoElBGJHrR0otPyZn+jgF6JK63dyu6gxUus3m1XjoIQo9Q/uju59Ki9v7QpohDSqgkxv2HODHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775059410; c=relaxed/relaxed;
	bh=nPCEGTxZ+m1tRn/A+hclNQmdEnm7BiqbwZab6IOrFlY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RA6VPeNhx1VAkGoHU0OXKz/NheqhIuj3i/LRNp++RYeq+2tXzhQi16z8aTxI70Bv0ctr9Vysy6yH1JmCP4m7Ai0Flz3yNe9/od7GbBEPWpbTNIMiI5sacbwzm6tu/WnSKLZ76NQ1GdB8LL7P2qnXcDsIdGAKmVuAWecpcLAaCv6WYohkTWH8Z/j7OdY5foObxpNs4pwgo1FEogyTQntwEXCGfAZouSp+QfgGG+a2YWG/6pu5XxeNOq9EqvMgA/sR9QyH/mZdDnLtqvoyAQchg0dm/wzPqBo8pdtbeF/TA5RmrklEU7zPRAkBA0jozwox5/xaq30QZr8PJa3P1CZJ5Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass (client-ip=159.226.251.21; helo=cstnet.cn; envelope-from=pengpeng@iscas.ac.cn; receiver=lists.ozlabs.org) smtp.mailfrom=iscas.ac.cn
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=iscas.ac.cn (client-ip=159.226.251.21; helo=cstnet.cn; envelope-from=pengpeng@iscas.ac.cn; receiver=lists.ozlabs.org)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fm8sp6bVtz2yj1
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Apr 2026 03:03:23 +1100 (AEDT)
Received: from localhost.localdomain (unknown [111.196.245.197])
	by APP-01 (Coremail) with SMTP id qwCowAB3IGzDQc1psRThCw--.44119S2;
	Thu, 02 Apr 2026 00:03:15 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: maddy@linux.ibm.com
Cc: mpe@ellerman.id.au,
	npiggin@gmail.com,
	chleroy@kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	pengpeng@iscas.ac.cn
Subject: [PATCH] powerpc/boot: reject oversized path properties before string lookups
Date: Thu,  2 Apr 2026 00:03:14 +0800
Message-ID: <20260401160314.88502-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
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
X-CM-TRANSID:qwCowAB3IGzDQc1psRThCw--.44119S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tFWrXrWDZF43JrWkXFy5urg_yoW5JF4fpF
	95KF4ku3ykKrWxGFySyF13X3y5uF4Iyr4UGwsrJa4qyFy3X3yvgFZxKFy5tw13Jr4ruFy0
	y3y3AF98Cr47Jw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
	4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	AVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUQo7NUUU
	UU=
X-Originating-IP: [111.196.245.197]
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

The boot wrapper reads alias, stdout-path, and device_type properties
with getprop() and then passes them to finddevice() and strcmp() as C
strings. getprop() reports a length but does not append a trailing NUL,
so these lookups can run past the fixed stack buffers.

Introduce a small boot-side string helper and make it reject properties
that do not fit in their destination buffers.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 arch/powerpc/boot/ops.h    | 25 ++++++++++++++++++++++++-
 arch/powerpc/boot/serial.c |  7 ++++---
 2 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/boot/ops.h b/arch/powerpc/boot/ops.h
index a40c2162a4e9..06149b4f2555 100644
--- a/arch/powerpc/boot/ops.h
+++ b/arch/powerpc/boot/ops.h
@@ -106,6 +106,29 @@ static inline int getprop(void *devp, const char *name, void *buf, int buflen)
 	return (dt_ops.getprop) ? dt_ops.getprop(devp, name, buf, buflen) : -1;
 }
 
+static inline int getprop_str(void *devp, const char *name, char *buf,
+			      int buflen)
+{
+	int len;
+
+	if (buflen <= 0)
+		return -1;
+
+	len = getprop(devp, name, buf, buflen);
+	if (len <= 0) {
+		buf[0] = '\0';
+		return len;
+	}
+
+	if (len >= buflen) {
+		buf[buflen - 1] = '\0';
+		return -1;
+	}
+	buf[len] = '\0';
+
+	return len;
+}
+
 static inline int setprop(void *devp, const char *name,
                           const void *buf, int buflen)
 {
@@ -172,7 +195,7 @@ static inline void *find_node_by_alias(const char *alias)
 
 	if (devp) {
 		char path[MAX_PATH_LEN];
-		if (getprop(devp, alias, path, MAX_PATH_LEN) > 0)
+		if (getprop_str(devp, alias, path, MAX_PATH_LEN) > 0)
 			return finddevice(path);
 	}
 
diff --git a/arch/powerpc/boot/serial.c b/arch/powerpc/boot/serial.c
index c6d32a8c3612..074e69d66974 100644
--- a/arch/powerpc/boot/serial.c
+++ b/arch/powerpc/boot/serial.c
@@ -90,13 +90,14 @@ static void *serial_get_stdout_devp(void)
 	if (devp == NULL)
 		goto err_out;
 
-	if (getprop(devp, "linux,stdout-path", path, MAX_PATH_LEN) > 0 ||
-		getprop(devp, "stdout-path", path, MAX_PATH_LEN) > 0) {
+	if (getprop_str(devp, "linux,stdout-path", path, MAX_PATH_LEN) > 0 ||
+	    getprop_str(devp, "stdout-path", path, MAX_PATH_LEN) > 0) {
 		devp = finddevice(path);
 		if (devp == NULL)
 			goto err_out;
 
-		if ((getprop(devp, "device_type", devtype, sizeof(devtype)) > 0)
+		if ((getprop_str(devp, "device_type", devtype,
+				 sizeof(devtype)) > 0)
 				&& !strcmp(devtype, "serial"))
 			return devp;
 	}
-- 
2.50.1 (Apple Git-155)


