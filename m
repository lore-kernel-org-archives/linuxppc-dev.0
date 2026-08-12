Return-Path: <linuxppc-dev+bounces-25777-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67421C5B572
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Aug 2026 14:20:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hKrHn24cvz3bvL;
	Thu, 13 Aug 2026 00:20:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786544437;
	cv=none; b=oaxLVZ33r7ZhHgTvAt9DVXBodr3Yn8CBj+z6Opeq/q2BI9gcerY56ikkbpVV/jnNtCQHVI73/jNNKTm0BAYmUaQJzXL6fJ/0vgnrFzj4pJfE756D9VEino8QpQ3YtHNq4kceFwr/ZRFE5oGRGgacvtYi7GAqLWkXgVe7Im6UlrwvbD0uqgqAKxYijpYjpICfV5CXhHwP8wjGd8esbz0N2C9YlniN1K1tibxC4ItBSGidRpAHlTkdPLZ12O8E/gx+0Z6DnT25LRBstOaC86HTjdkZ+vEBIHGpsglyTqr/dzsI+pEbqwFWTELOvibxn8oY0PTov7rT6b4BCS30APty7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786544437; c=relaxed/relaxed;
	bh=CDLz+Mc42aHxy/v7Uem4HL7pasWmvjBSSIEq0pceeCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JZRYkLvXGISDPUrPuP2embsZMNES8fXvPPR9Rl3t2IR6hALSomm79/gF5i9lLOHQycLjI5MnPPIa3L0JpXr2m87+aBnvA+3CZGhRVN406jFpoT5vEydwENpbo687JZqoUajYtvKFQq+eHo9oC9fee7DkGXqAtM8hbOJJdPL+2wbnHQ3KWEzttOefIHDjGiN/7l3SHYWrv0svqqU+ljFn/0Xc1Biq8bgkAoz6VfQun8knKaYGwQHjBsvKoWI86WMvFbDhwZaAaQBuTutWsq2MaHQ1U1NB+hbqdTlIRedSAwtF/g43l0fegNOQhc61G6MUJ3rg3xYLoAZGPMduTQvp8A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eQ4YzCSs; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=johan@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eQ4YzCSs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=johan@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hKrHm0YDFz3bs5
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Aug 2026 00:20:35 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 0626543C77;
	Wed, 12 Aug 2026 14:20:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8DB61F00ADE;
	Wed, 12 Aug 2026 14:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786544428;
	bh=CDLz+Mc42aHxy/v7Uem4HL7pasWmvjBSSIEq0pceeCI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eQ4YzCSs3LRL46v83L7Rn44ToT3bZ0x/2CTe3cwSdvODDVqtlPFfc+4/ju6K5iOsY
	 w9TIs1LOEQyFej+iPRsEkitMVYBt+iajLfPm94f5hoiukWZOzUtCL6k4n9H/f4qfMi
	 OjHt2KvN4UIFlp8lr3J1QDii+mC7eVEKnjGqNyyPlGezLTn1DXDgTeEk3U17liAC3+
	 4shZtpU/YI4dq2KJVKNL1aYDA6IT76cTttpjgWHR2Ei2fBTttLex4Gu6/TZMQK4laO
	 B5WPGTgV9i20VKrXqhYxsZscHbHZ6KFSovst7EY2P8skZmsOXPnKPR1zYxTGoAMSIU
	 gmaQkTpc0NqZg==
Received: from johan by xi.lan with local (Exim 4.99.4)
	(envelope-from <johan@kernel.org>)
	id 1wu9og-00000000ELh-26Rr;
	Wed, 12 Aug 2026 16:20:26 +0200
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
Subject: [PATCH v2 RESEND 1/3] powerpc/ps3: switch to dynamic system bus root device
Date: Wed, 12 Aug 2026 16:20:14 +0200
Message-ID: <20260812142016.55136-2-johan@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260812142016.55136-1-johan@kernel.org>
References: <20260812142016.55136-1-johan@kernel.org>
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
2.54.0


