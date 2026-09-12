Return-Path: <linuxppc-dev+bounces-27177-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C57EEC88E59
	for <linuxppc-dev@archiver.kernel.org>; Sat, 12 Sep 2026 16:19:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hhxS868dwz2xqM;
	Sun, 13 Sep 2026 02:19:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789229944;
	cv=none; b=kpwKuTPoJv56dwpXXZv+IHvB/ExiDmZi90A0c5E/DdT0iWN1QEBmj4W4ZnBWj5N6suruRyFfHsXJnUWYhzcsJxUdpt7k3hZFOODTk1mkW5aKgEM1062dKPWrX4Z2KAWMjvPxpuH5F9lPT+/V6yxAJZ1fJnePFgvahugGEvuQzLtMpUyFvlxGzAdKHiC53JbmOs4bQqnjKccM0JqP46WkOWL7lBkL9l/ek3LUNHtc4xAeIWIYWwDPRWg4f9pZwl3lUZyq/esldtIlzQ8pQ1dHgN1E+30BXiUByaaYff94bha4DKxuduNkRNqBATKJ8XXfUO0fCez+E3mHyAzZVSz73g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789229944; c=relaxed/relaxed;
	bh=gplcZgkxSlNDRbDmgAzkFgcg1m+dKIxgJ0YQ05pTMIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nbd1G3gUuDwmgIy3020mbfFpamrUM4GpiFbT/b5HEIVFQMoCcHMZII8mQWxGCpbBf5u6AyUo7Y1s/GajygVfO/ZLQjhTCofcEfCuuB71WNuxlZGaKDMvh6CPWW04eAlK5IjHK3r24n14PYWWjzlu6T/2u5QUq77nrkF40/fEhCmiTnswVRYSUGkMfwS7Xk/uty/4oGt53nSe6COCaTOvv2UGxMCpwABLb4v5T0GoY753EZPEJlrFo+EGpLF7DFX/cBmLkxA5BBDBhE9uPXGZJp+bHMCyjuJ5WKXoV9nU5Q6/CKuFTFxwv7GuPxvkzdCx8pH2YbeBvxa8wWfDzNRmEw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=BwykMRqG; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=BwykMRqG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linuxfoundation.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hhxS76Y8Jz2xfj
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 13 Sep 2026 02:19:03 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 3037140AC7;
	Sat, 12 Sep 2026 16:18:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F41B01F000FF;
	Sat, 12 Sep 2026 16:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789229938;
	bh=gplcZgkxSlNDRbDmgAzkFgcg1m+dKIxgJ0YQ05pTMIM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BwykMRqGvZIdT9nxerBfR9UJDHN7wSKsoQuiQNugY0Uus6vx1W0k3yD+JHKUG6ArU
	 oNikayIX1XK+u7/tTYiDDcvlU9qHRb9E8fjpk5SCXYu9XyXIkyCRGCoKqoVjq37LhG
	 22shHV2BsIEirP6J10FB1ghtkRxhxXfb9HHJdT+g=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	linuxppc-dev@lists.ozlabs.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 0649/1191] tty: hvsi: remove an extra variable from hvsi_write()
Date: Sat, 12 Sep 2026 08:56:17 +0200
Message-ID: <20260912065602.833416537@linuxfoundation.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260912065548.086904252@linuxfoundation.org>
References: <20260912065548.086904252@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiri Slaby <jirislaby@kernel.org>

[ Upstream commit d3352ab0a9701a6d4c88b814815d7320c339f4a8 ]

'source' is the same as 'buf'. Rename the parameter ('buf') to
'source' and drop the local variable.

Likely, the two were introduced to have a different type. But 'char' and
'unsigned char' are the same in the kernel for a long time.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org
Link: https://lore.kernel.org/r/20230731080244.2698-4-jirislaby@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: b6b5d64cb161 ("ipack: ipoctal: fix UAF, null-ptr-deref, and use-after-free in cleanup on remove")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/hvc/hvsi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/hvc/hvsi.c b/drivers/tty/hvc/hvsi.c
index a200d01eceed6..c1b8a4fd8b1ee 100644
--- a/drivers/tty/hvc/hvsi.c
+++ b/drivers/tty/hvc/hvsi.c
@@ -905,10 +905,9 @@ static unsigned int hvsi_chars_in_buffer(struct tty_struct *tty)
 }
 
 static int hvsi_write(struct tty_struct *tty,
-		     const unsigned char *buf, int count)
+		     const unsigned char *source, int count)
 {
 	struct hvsi_struct *hp = tty->driver_data;
-	const char *source = buf;
 	unsigned long flags;
 	int total = 0;
 	int origcount = count;
-- 
2.53.0




