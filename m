Return-Path: <linuxppc-dev+bounces-18994-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27571FF494B
	for <linuxppc-dev@archiver.kernel.org>; Mon, 30 Mar 2026 06:29:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fkhDX61Ftz2xpt;
	Mon, 30 Mar 2026 17:29:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=159.226.251.25
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774852172;
	cv=none; b=URVbJaZM2UTAxo8dr8gRLxm67QvlHWVLEe+7iZjFAKxW2cYeuS4QoZN/baYqQ5HfmOc95Rj7zh/xT7/LZqrBdqo+zv8rkVRnk3TRw4IgJD5sOs1rFliTBppAW8of5U5omxhMZ0OM7Vg9YqRzBKXFcBpJcE0SJpfbYrdm7O5tOej8kKkQL2LZWGzJOTpdb0XDnRy5hLyMAxbNDLYiDRwV254qUrbDXrrmmoL8b2QA+XaW4VfDI1vME379S1+S0EdBy5HyKAN/OgH7lcE4YkvmfdDetQDriUyBVwHHmLEtvjoy4NqGBRmSAu6NM5bfqY0yZpNWgDtqHVHoAvpQKg0jbg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774852172; c=relaxed/relaxed;
	bh=o9izjZ9HKOkJquWTs4vNjqE50V7qNH1wbPuGZx69/Hs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m2Nv7aCWCWQQqIsIsJvEC/G0zWY5DwKW3+cuzAuBHLIzd02SAfnnrHIBk6CdOwIfaX1u4U8wQw7rDOV8bf5PxiO3wXN1yPwj5dNuMHsCBW92RtEXWQh/tVThSa5qAMZhYyCZ2IuPYfN5QgVEBWRUjSzX56YPf7oep0gL3WMzrE3Jyhse/iSk63azSGc4zHTU+FL+WeD11MkL/h8Hznwm8BAn78ll/Ju87GG6oSbEB90I0vMclkVZuetylQM9i1m81OSTa9u7ZZNdPSu06kLaBoD5stzb8sk5ZM8rTudq3fmemrk+Vk8U7w7DGecyxmGFuVWYDDVyLtl/ZMBY75686g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass (client-ip=159.226.251.25; helo=cstnet.cn; envelope-from=pengpeng@iscas.ac.cn; receiver=lists.ozlabs.org) smtp.mailfrom=iscas.ac.cn
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=iscas.ac.cn (client-ip=159.226.251.25; helo=cstnet.cn; envelope-from=pengpeng@iscas.ac.cn; receiver=lists.ozlabs.org)
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fkhDW5m3Xz2xT6
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Mar 2026 17:29:30 +1100 (AEDT)
Received: from localhost.localdomain (unknown [111.196.245.197])
	by APP-05 (Coremail) with SMTP id zQCowAC3Sw9BGMppNYTpCw--.28727S2;
	Mon, 30 Mar 2026 14:29:21 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: maddy@linux.ibm.com
Cc: mpe@ellerman.id.au,
	npiggin@gmail.com,
	chleroy@kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	pengpeng@iscas.ac.cn
Subject: [PATCH 3/4] powerpc/pseries/ibmebus: reject zero-length bus attribute writes
Date: Mon, 30 Mar 2026 14:29:21 +0800
Message-ID: <20260330062921.40805-1-pengpeng@iscas.ac.cn>
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
X-CM-TRANSID:zQCowAC3Sw9BGMppNYTpCw--.28727S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJr1DKry8uF15tF15KrW8Xrb_yoW8JFyfpF
	4vkFW3Jr48Xw17KF9Fya1UGw13t34ktryUWw42yas3Awn8Xr9rXFWUWF1rKrWrCrWxCr18
	ur10gas8ZF9xuw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkl14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r12
	6r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
	IxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbPl1PUUUU
	U==
X-Originating-IP: [111.196.245.197]
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

probe_store() and remove_store() pass count to ibmebus_chomp(), whose
newline stripping logic unconditionally inspects out[count - 1]. A
zero-length write therefore reads one byte before the allocated buffer.

Reject empty writes before calling ibmebus_chomp().

Fixes: 0727702a3a6a ("[POWERPC] ibmebus: change probe/remove interface from using loc-code to DT path")
Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 arch/powerpc/platforms/pseries/ibmebus.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/ibmebus.c b/arch/powerpc/platforms/pseries/ibmebus.c
index cad2deb7e70d..5faf1a5754de 100644
--- a/arch/powerpc/platforms/pseries/ibmebus.c
+++ b/arch/powerpc/platforms/pseries/ibmebus.c
@@ -276,6 +276,9 @@ static ssize_t probe_store(const struct bus_type *bus, const char *buf, size_t c
 	char *path;
 	ssize_t rc = 0;
 
+	if (!count)
+		return -EINVAL;
+
 	path = ibmebus_chomp(buf, count);
 	if (!path)
 		return -ENOMEM;
@@ -312,6 +315,9 @@ static ssize_t remove_store(const struct bus_type *bus, const char *buf, size_t
 	struct device *dev;
 	char *path;
 
+	if (!count)
+		return -EINVAL;
+
 	path = ibmebus_chomp(buf, count);
 	if (!path)
 		return -ENOMEM;
-- 
2.50.1 (Apple Git-155)


