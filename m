Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A250EEB57A
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 Sep 2023 00:34:37 +0000 (UTC)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=acC+tlFp;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RjDWc0gzYz3cMW
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 Sep 2023 10:34:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=acC+tlFp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4601:e00::1; helo=ams.source.kernel.org; envelope-from=sashal@kernel.org; receiver=lists.ozlabs.org)
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RjDVg31XFz3c4l
	for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Sep 2023 10:33:47 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 4882FB82318;
	Sat,  9 Sep 2023 00:23:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D34FDC433BF;
	Sat,  9 Sep 2023 00:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694219027;
	bh=8J9hRYNf7upHLZbItTZLhd+AJxvmGOp7ECPoQEvTU0g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=acC+tlFpRMkbtL6XcezkSMz+eqP08n8DuKZpXNXVZzr21OnunXqd+xbq2WGB4Serb
	 Z2ZyRzHqKAy2e2EgcMvuTzgghAmFlxuvBsopCzjA70yXdZxkUoObV+F3fCEHbtTKVW
	 yThUxCSVFmrJ2kN0qo5qJIHDqw2irByhJMG88d3pJDw2a2BAXFJB105NPUYpoO+0Pu
	 PnjA10YL6DrDA0s9mAmXG/aPxS5y/u4wmGx4fL798KM/yqnVFW+y2gjmgo7iZq6xXN
	 mCaqCWwfr0F239UdKVr/g/8ft7WiKEwumaV/Zw9pqqikDm2b4RJ2673FMf32Qgpoi2
	 yOJaUgllVguXQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 6/7] powerpc/pseries: fix possible memory leak in ibmebus_bus_init()
Date: Fri,  8 Sep 2023 20:23:25 -0400
Message-Id: <20230909002329.3578534-6-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230909002329.3578534-1-sashal@kernel.org>
References: <20230909002329.3578534-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.131
Content-Transfer-Encoding: 8bit
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
Cc: Sasha Levin <sashal@kernel.org>, robh@kernel.org, iwona.winiarska@intel.com, ruanjinjie <ruanjinjie@huawei.com>, linuxppc-dev@lists.ozlabs.org, gregkh@linuxfoundation.org, sfr@canb.auug.org.au, ira.weiny@intel.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: ruanjinjie <ruanjinjie@huawei.com>

[ Upstream commit afda85b963c12947e298ad85d757e333aa40fd74 ]

If device_register() returns error in ibmebus_bus_init(), name of kobject
which is allocated in dev_set_name() called in device_add() is leaked.

As comment of device_add() says, it should call put_device() to drop
the reference count that was set in device_initialize() when it fails,
so the name can be freed in kobject_cleanup().

Signed-off-by: ruanjinjie <ruanjinjie@huawei.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://msgid.link/20221110011929.3709774-1-ruanjinjie@huawei.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/platforms/pseries/ibmebus.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/platforms/pseries/ibmebus.c b/arch/powerpc/platforms/pseries/ibmebus.c
index 7ee3ed7d6cc21..6936ffee253b2 100644
--- a/arch/powerpc/platforms/pseries/ibmebus.c
+++ b/arch/powerpc/platforms/pseries/ibmebus.c
@@ -451,6 +451,7 @@ static int __init ibmebus_bus_init(void)
 	if (err) {
 		printk(KERN_WARNING "%s: device_register returned %i\n",
 		       __func__, err);
+		put_device(&ibmebus_bus_device);
 		bus_unregister(&ibmebus_bus_type);
 
 		return err;
-- 
2.40.1

