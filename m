Return-Path: <SRS0=qhKb=K5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 552ABC47096
	for <linuxppc-dev@archiver.kernel.org>; Thu,  3 Jun 2021 19:18:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDE28613E4
	for <linuxppc-dev@archiver.kernel.org>; Thu,  3 Jun 2021 19:18:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDE28613E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FwwfC0Zs9z3cKK
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Jun 2021 05:18:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=merlin.20170209 header.b=WPZDlzaZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=infradead.org
 (client-ip=2001:8b0:10b:1234::107; helo=merlin.infradead.org;
 envelope-from=geoff@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256
 header.s=merlin.20170209 header.b=WPZDlzaZ; 
 dkim-atps=neutral
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:8b0:10b:1234::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Fwwcz1yGFz303h
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Jun 2021 05:17:06 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Date:Cc:To:Subject:From:References:
 In-Reply-To:Message-Id:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=IFxWJE7fU47a+4ZG4tBRUjT1oGbAbZyqh7vA/5HIj3k=; b=WPZDlzaZqbGfQpib38XVIh1+dU
 bKEnLrrArU+q3UmoHuWDUEFl6bqHBqdfKAtjpm09sacppCzvi+s7lyLUMDRrfq/ZOHKy3ZtUh4c7G
 KQjGHmr/rPzm5D2Zy2OHV6Qs3xhkmygzK4jlZr5h6Tk6ZlV1AUK2njnuMr2bkjkAOMRsjViAKo8kD
 AytnMnumrEK6pdgIwZCD1kKZsQ4ybt8sHo7TcPMSyZo4iWOQyGhWGFvwUH0/9d4PdUHOKPUaW71Ky
 Z9pSHKUrc+Apzierg1tJOipqUC2Lyf1oqEGfKFnw93gTsQmgudWJNXWEhmxFh7382HIrOVa1l+ybH
 /XYysVXw==;
Received: from geoff by merlin.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1lospx-001J3t-NK; Thu, 03 Jun 2021 19:17:01 +0000
Message-Id: <eb5c1c10da0bbdeb27c8b069187b4f58e429e837.1622746428.git.geoff@infradead.org>
In-Reply-To: <cover.1622746428.git.geoff@infradead.org>
References: <cover.1622746428.git.geoff@infradead.org>
From: Geoff Levand <geoff@infradead.org>
Patch-Date: Tue, 1 Jun 2021 12:27:43 -0700
Subject: [PATCH v2 2/3] powerpc/ps3: Warn on PS3 device errors
To: Michael Ellerman <mpe@ellerman.id.au>
Date: Thu, 03 Jun 2021 19:17:01 +0000
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
Cc: Jakub Kicinski <kuba@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

To aid debugging PS3 boot problems change the log level
of several PS3 device errors from pr_debug to pr_warn.

Signed-off-by: Geoff Levand <geoff@infradead.org>
---
 arch/powerpc/platforms/ps3/system-bus.c |  9 +++++----
 drivers/ps3/ps3-vuart.c                 |  2 +-
 drivers/ps3/ps3av.c                     | 22 +++++++++++-----------
 3 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/platforms/ps3/system-bus.c b/arch/powerpc/platforms/ps3/system-bus.c
index b431f41c6cb5..1a5665875165 100644
--- a/arch/powerpc/platforms/ps3/system-bus.c
+++ b/arch/powerpc/platforms/ps3/system-bus.c
@@ -64,9 +64,10 @@ static int ps3_open_hv_device_sb(struct ps3_system_bus_device *dev)
 	result = lv1_open_device(dev->bus_id, dev->dev_id, 0);
 
 	if (result) {
-		pr_debug("%s:%d: lv1_open_device failed: %s\n", __func__,
-			__LINE__, ps3_result(result));
-			result = -EPERM;
+		pr_warn("%s:%d: lv1_open_device dev=%u.%u(%s) failed: %s\n",
+			__func__, __LINE__, dev->match_id, dev->match_sub_id,
+			dev_name(&dev->core), ps3_result(result));
+		result = -EPERM;
 	}
 
 done:
@@ -120,7 +121,7 @@ static int ps3_open_hv_device_gpu(struct ps3_system_bus_device *dev)
 	result = lv1_gpu_open(0);
 
 	if (result) {
-		pr_debug("%s:%d: lv1_gpu_open failed: %s\n", __func__,
+		pr_warn("%s:%d: lv1_gpu_open failed: %s\n", __func__,
 			__LINE__, ps3_result(result));
 			result = -EPERM;
 	}
diff --git a/drivers/ps3/ps3-vuart.c b/drivers/ps3/ps3-vuart.c
index e34ae6a442c7..6328abd51ffa 100644
--- a/drivers/ps3/ps3-vuart.c
+++ b/drivers/ps3/ps3-vuart.c
@@ -358,7 +358,7 @@ static int ps3_vuart_raw_write(struct ps3_system_bus_device *dev,
 		ps3_mm_phys_to_lpar(__pa(buf)), bytes, bytes_written);
 
 	if (result) {
-		dev_dbg(&dev->core, "%s:%d: lv1_write_virtual_uart failed: "
+		dev_warn(&dev->core, "%s:%d: lv1_write_virtual_uart failed: "
 			"%s\n", __func__, __LINE__, ps3_result(result));
 		return result;
 	}
diff --git a/drivers/ps3/ps3av.c b/drivers/ps3/ps3av.c
index 9d66257e1da5..516e6d14d32e 100644
--- a/drivers/ps3/ps3av.c
+++ b/drivers/ps3/ps3av.c
@@ -217,9 +217,9 @@ static int ps3av_send_cmd_pkt(const struct ps3av_send_hdr *send_buf,
 	/* send pkt */
 	res = ps3av_vuart_write(ps3av->dev, send_buf, write_len);
 	if (res < 0) {
-		dev_dbg(&ps3av->dev->core,
-			"%s: ps3av_vuart_write() failed (result=%d)\n",
-			__func__, res);
+		dev_warn(&ps3av->dev->core,
+			"%s:%d: ps3av_vuart_write() failed: %s\n", __func__,
+			__LINE__, ps3_result(res));
 		return res;
 	}
 
@@ -230,9 +230,9 @@ static int ps3av_send_cmd_pkt(const struct ps3av_send_hdr *send_buf,
 		res = ps3av_vuart_read(ps3av->dev, recv_buf, PS3AV_HDR_SIZE,
 				       timeout);
 		if (res != PS3AV_HDR_SIZE) {
-			dev_dbg(&ps3av->dev->core,
-				"%s: ps3av_vuart_read() failed (result=%d)\n",
-				__func__, res);
+			dev_warn(&ps3av->dev->core,
+				"%s:%d: ps3av_vuart_read() failed: %s\n", __func__,
+				__LINE__, ps3_result(res));
 			return res;
 		}
 
@@ -240,9 +240,9 @@ static int ps3av_send_cmd_pkt(const struct ps3av_send_hdr *send_buf,
 		res = ps3av_vuart_read(ps3av->dev, &recv_buf->cid,
 				       recv_buf->size, timeout);
 		if (res < 0) {
-			dev_dbg(&ps3av->dev->core,
-				"%s: ps3av_vuart_read() failed (result=%d)\n",
-				__func__, res);
+			dev_warn(&ps3av->dev->core,
+				"%s:%d: ps3av_vuart_read() failed: %s\n", __func__,
+				__LINE__, ps3_result(res));
 			return res;
 		}
 		res += PS3AV_HDR_SIZE;	/* total len */
@@ -251,8 +251,8 @@ static int ps3av_send_cmd_pkt(const struct ps3av_send_hdr *send_buf,
 	} while (event);
 
 	if ((cmd | PS3AV_REPLY_BIT) != recv_buf->cid) {
-		dev_dbg(&ps3av->dev->core, "%s: reply err (result=%x)\n",
-			__func__, recv_buf->cid);
+		dev_warn(&ps3av->dev->core, "%s:%d: reply err: %x\n", __func__,
+			__LINE__, recv_buf->cid);
 		return -EINVAL;
 	}
 
-- 
2.25.1


