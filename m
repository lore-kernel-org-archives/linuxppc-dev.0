Return-Path: <linuxppc-dev+bounces-20589-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C1B1CD3436
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 May 2026 04:36:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gBbsj4sZbz2xwH;
	Fri, 08 May 2026 14:36:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778214969;
	cv=none; b=X7DAFUry5k/f9Lc4R7I2wYknxExfmVT6werD7qGbPD3bHzO6UjiaOmGACLji2EEUd4Lq4kUXCqUOYFreTCzd/9/Ik0zORk7FvqTp3M+Za6qYDs8ZFtJevVGsIMrQ6ckynwUvLCmrP7ce8OLsX7n7la9K9r3mEKY2U3D2utXsA0//M8qvjaZOZurMOiCchH4CcS/EqTzWXA2ktmEz6cQKl4D9bVopV5aGaCaB82/cbC/HbEt4bF1Cic+u7Fg3b/ChOMviPkOcf2xMbEUpEyJrDyjtwA+vV2R+oLwXqo1BfUXEvv6Cc4UlKEW7zkR4HciNooplQPA2AuLpreUf8b//rw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778214969; c=relaxed/relaxed;
	bh=5ptdizEpjuYqeg2f+U9wBoigKTE1I9tlh/xOEI1cGXU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mYDente/43QSjyW7iKmIWF6YKh8TzelFKI4KYW9HJze6TPhr3nR2NIsSW8FkUj8Q8jgH0oUBjB7NOGNV3+pwi0jktpuqOyDYMl3jLcwDoR1NhMQs1FMvTQ1Y7sycsU42R+n0ByK6iz8PmPS/AyvpbxWzxKcsuUOHArozk6PSi7Lx8svdcq/lzNAPIPQz+AqnffhdF+kbTVQ52jvM0F0UAkkVRoP3SgDte2WODzxVWG0j3Jcrc5+hIqcHXOS86QhR2gTWc7/0WzLVuQjiU7cejhYHuQw9l0hVBrw6Eedhf19UboXA8VgqFZhg3JEqxRuI77p3aXKPC3136hB6/euBNA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=c6YrOJEL; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=c6YrOJEL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gBbsj0TC7z2xPb
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 08 May 2026 14:36:09 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 1FAC643C68;
	Fri,  8 May 2026 04:36:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B03F2C2BCB4;
	Fri,  8 May 2026 04:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778214967;
	bh=9KXLrBNGT0ToNu4fHZqX/w3XLpky3ur23Tmkqe8TgNA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c6YrOJELe42YPhzYmdxA2+pDGLb/lIIe88nH1uFnMhkVo6O/4Hmt77NyiEHQiaOz/
	 3lW3I9GpoGve5tNp1zxXkM7MW2Kuxd1dHEpoDZ41L0vuQk1iqISSLe3A8us/fJtd7d
	 o0Bx1t5t02a6uc6MTVhdP7hlvzstCojKjCNiMYJD2QuET9VC2eHdq7NswApXbkusrk
	 Kr1zOzU+p7Y+pLwWxcrDqxahePyzuZJ59CaQPJXVyW3sDqGFLaCRDaEPUB3/qJ1svY
	 rGbmmWFcH7osNf2BlaJa+N0ZAj3Rh7vG5kKKDreZfWwhWdE8mx5dlKTDGf2ScSJIN+
	 Ur8pxP9rFDk4A==
From: =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Alex Williamson <alex@shazbot.org>,
	Magnus Lindholm <linmag7@gmail.com>,
	Matt Turner <mattst88@gmail.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Christophe Leroy <chleroy@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Dexuan Cui <decui@microsoft.com>,
	=?UTF-8?q?Krzysztof=20Ha=C5=82asa?= <khalasa@piap.pl>,
	Lukas Wunner <lukas@wunner.de>,
	"Oliver O'Halloran" <oohall@gmail.com>,
	Saurabh Singh Sengar <ssengar@microsoft.com>,
	Shuan He <heshuan@bytedance.com>,
	Srivatsa Bhat <srivatsabhat@microsoft.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-pci@vger.kernel.org,
	linux-alpha@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v7 05/24] PCI/sysfs: Add CAP_SYS_ADMIN check to __resource_resize_store()
Date: Fri,  8 May 2026 04:35:24 +0000
Message-ID: <20260508043543.217179-6-kwilczynski@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260508043543.217179-1-kwilczynski@kernel.org>
References: <20260508043543.217179-1-kwilczynski@kernel.org>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently, the __resource_resize_store() allows writing to the
resourceN_resize sysfs attribute to change a BAR's size without
checking for capabilities, currently relying only on the file
access check.

Resizing a BAR modifies PCI device configuration and can disrupt
active drivers.  After the upcoming conversion to static attributes,
it will also trigger resource file updates via sysfs_update_groups().

Thus, add a CAP_SYS_ADMIN check to prevent unprivileged users from
performing BAR resize operations.

Tested-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 drivers/pci/pci-sysfs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 2280b7edb41f..dac780597727 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1596,6 +1596,9 @@ static ssize_t __resource_resize_store(struct device *dev, int n,
 	int ret;
 	u16 cmd;
 
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
 	if (kstrtoul(buf, 0, &size) < 0)
 		return -EINVAL;
 
-- 
2.54.0


