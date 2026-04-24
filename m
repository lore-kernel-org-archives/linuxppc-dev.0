Return-Path: <linuxppc-dev+bounces-20066-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25A6FFE5206
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Apr 2026 10:36:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g28Wm5X8Yz2yks;
	Fri, 24 Apr 2026 20:36:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777026980;
	cv=none; b=oT8ZiA++PUBnKeGXxdhipZhwbLOyx9g2w+fnkEQgCvQQFDnTeewRrL5TNyAn3nQz15pIvYxvD5A/PchDbCbSJTL2KntEx/nNGadHw80qNRKORa9adrNumCUV4KdmOJGAMh9QVlmgIBPSnagooCkaMkInvrhQrMlsgDN1KH1B6CjWt7Z/tfLxvQNK5PvBNZVTgMKQmqiRy2If9P51/Jb/kWjrcxazrEck5pKAscOHNo5GBc086Y4slzjLLKgayy3RC/jpcpeBxjNnWjeD1GdsKSe8xph3UcYrx7rNw5uoA+a3INuXM8F0E+86xBfzZ0fghFrSggxunEZ2jFA7eyFbgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777026980; c=relaxed/relaxed;
	bh=P1nJG/WlxpA7oGG2+Q8e3ef+sd4zfXvCwzoI+e/Kg3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QRcDhO91Z2LMGAqukYEaZwGwO+ndG+uFo1wrXIPMF5TMBWc+tEDXzz4eUZzmTveNT7hkKxe583qFKPnVGsuvwv7gzLCmIbA9d5S3WNwW7xQAf+9nm/kDHc3ShyhZyw0Xl3q3CvS0+Nh+GJLIJZh2GJWYG7cnf84zNh1tRUzTkmtT9ERihODYm6VUbUnJV/vS0U5tsv9/v7Oym+HU1Hte9gGxm44z189fI/aBROgq6LRNhNP+mNuprRyeixT1sqioD6IwSqbxoTk7LNjbFKcxh/jSgtKqIothndC5BQrUVxneSrkhOdsCufRI7H0HnjSlIJVydqX2dKIB0IkXtnXJwA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=sL16H7ey; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=johan@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=sL16H7ey;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=johan@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g28Wl4jFJz2xnl
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Apr 2026 20:36:19 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id A7AE1600CB;
	Fri, 24 Apr 2026 10:36:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59B25C4AF09;
	Fri, 24 Apr 2026 10:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777026977;
	bh=OpjYnvUINC0m/fERNUlL4a3+lpA8IFC0Re5p9y/suRY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sL16H7ey7V/GQEHl49RxmPmxt0qMuYIyx0svxOyJm+9h1kOYKKLw9BM5O/tJcdefi
	 TywbChtKKDhRwkerWWpcn4wDAoi283d5Vbu5HLmkM+GOLJpVBih2esZPHSK/48tx5C
	 CGAO4rl9o3e5dV9+QbsLQA2tGNFzPydSEK+9OBhFMXrl6VPZjUeawlsAPaOv/SJZ/E
	 8Lrw85IlKNzhwxRAByN9iZPVt349gQ3RROklPaMr1HtwhXzqWVWOWzc2pqZI55PuXh
	 3l8o/F/VS4cOddU52Qeo3PFccE23xjwXqGEwhXbhgeKSBtTZHqZhFH+4VbIaR+kJVW
	 98jdb1H3VGMuw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wGDtP-0000000AyiZ-0pJG;
	Fri, 24 Apr 2026 12:36:15 +0200
From: Johan Hovold <johan@kernel.org>
To: Geoff Levand <geoff@infradead.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 1/3] powerpc/ps3: switch to dynamic system bus root device
Date: Fri, 24 Apr 2026 12:36:02 +0200
Message-ID: <20260424103604.2616657-2-johan@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424103604.2616657-1-johan@kernel.org>
References: <20260424103604.2616657-1-johan@kernel.org>
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

Driver core expects devices to be dynamically allocated and will, for
example, complain loudly if a device that lacks a release function
is ever freed.

Use root_device_register() to allocate and register the root device
instead of open coding using a static device.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 arch/powerpc/platforms/ps3/system-bus.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/platforms/ps3/system-bus.c b/arch/powerpc/platforms/ps3/system-bus.c
index 0537a678a32f..4ead6ccea259 100644
--- a/arch/powerpc/platforms/ps3/system-bus.c
+++ b/arch/powerpc/platforms/ps3/system-bus.c
@@ -20,9 +20,7 @@
 
 #include "platform.h"
 
-static struct device ps3_system_bus = {
-	.init_name = "ps3_system",
-};
+static struct device *ps3_system_bus;
 
 /* FIXME: need device usage counters! */
 static struct {
@@ -486,8 +484,8 @@ static int __init ps3_system_bus_init(void)
 
 	mutex_init(&usage_hack.mutex);
 
-	result = device_register(&ps3_system_bus);
-	BUG_ON(result);
+	ps3_system_bus = root_device_register("ps3_system");
+	BUG_ON(IS_ERR(ps3_system_bus));
 
 	result = bus_register(&ps3_system_bus_type);
 	BUG_ON(result);
@@ -744,7 +742,7 @@ int ps3_system_bus_device_register(struct ps3_system_bus_device *dev)
 	static unsigned int dev_lpm_count;
 
 	if (!dev->core.parent)
-		dev->core.parent = &ps3_system_bus;
+		dev->core.parent = ps3_system_bus;
 	dev->core.bus = &ps3_system_bus_type;
 	dev->core.release = ps3_system_bus_release_device;
 
-- 
2.53.0


