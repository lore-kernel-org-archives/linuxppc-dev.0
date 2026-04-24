Return-Path: <linuxppc-dev+bounces-20085-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE1F0FED3EF
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Apr 2026 16:03:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g2Hnl6lzYz2ybQ;
	Sat, 25 Apr 2026 02:03:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777046635;
	cv=none; b=i8hc7JEKSNfGv4IlLDrdyb/u5UMfw12rlp6iCyE2fE3vPREgzIHS94fnb4MaWm1BbXuyYxD5HXglbt4xEoGvGYu5KO6KgqG+pSLfSQipColRG3FgIRBGPVqAe1U1UXKbL3fEV/Vohnir4Xop38DECPeGO82nWCMKNs6F6flbUjSkSoz0YfPJVX5RiQHl6CHjydPMk93OhYWltwNM9CuheshbvzNZ5AkwtUDsmjmZ5bWxhg3YFckgObZQN7d27VxktHSb6/KBS4pD6cHtQezRvMupnXFqvhxVJv0xyGuGILqiADb8TfzHBWcgvfzVmrgqmruMx17FLlIQjJPUiacOXw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777046635; c=relaxed/relaxed;
	bh=P1nJG/WlxpA7oGG2+Q8e3ef+sd4zfXvCwzoI+e/Kg3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AMsghu19jD53h/lEMJvs/FsfD6NrEa29mao2y/OsQdwGSId7ymXfCMPkqseiL02jueNesEpkBZCTvZd3tlsbCsCCsrDXu9pzZUWd3dH7QOrYitwys4yd6WjD7Ta9TiB3bh1CYYLZbuJMF8aWMfPqZYOtfzsfdTH6527L/hLxDGKrA89QLhYfUBkHC88Dl07dOOVscnoX6DdOZW+TsWA4Sj6I7J1YJG2Q06DfjIebOrKdIaJb9khLQLE+hafxuEDUvM8HMPjFOxqDViySYE8lyeheQIVtfiQE0A21kDMF6naHKhRt+usiR+x63xxIDQR8K/EbcvHkwjCa7rsiz7/1DA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=kHPx5zDe; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=johan@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=kHPx5zDe;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=johan@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g2Hnl0Lb1z2yC9
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Apr 2026 02:03:55 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 1FA334096E;
	Fri, 24 Apr 2026 16:03:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAF7CC19425;
	Fri, 24 Apr 2026 16:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777046632;
	bh=OpjYnvUINC0m/fERNUlL4a3+lpA8IFC0Re5p9y/suRY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kHPx5zDeAWeJIGcgZA6QqcJE9toft/blPMdaDaFKnu4DQf+K7B8fuF1ef4m2JhmKb
	 9t2l4/TtcsBjz+6bsUaSGseDixTCFT3GOqugf+F7o9a7Oy7EWNkJQ2eSuy5v/eHeco
	 a0Xm4Dfzos6CG+I9ttnvmRpAluFfu+zIxB9kA8hvrn6WRlHMB+Y8risu8KQMznvdfj
	 obiDYVOKkAbBlUJjhpqk+qbGwF50onmRd1MvmeOdj+7fKoG7OG0PL8F28aIcOOCG2x
	 WC6NeRazMriMZ7eREcgtG+C/AMlxpbGbstDeaV8oXVU1nSvZD2pZeN67z65FrHXayE
	 kts7z/a9NB3iQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wGJ0P-0000000BDJd-3H6m;
	Fri, 24 Apr 2026 18:03:49 +0200
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
Subject: [PATCH v2 1/3] powerpc/ps3: switch to dynamic system bus root device
Date: Fri, 24 Apr 2026 18:02:57 +0200
Message-ID: <20260424160259.2672722-2-johan@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424160259.2672722-1-johan@kernel.org>
References: <20260424160259.2672722-1-johan@kernel.org>
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


