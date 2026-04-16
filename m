Return-Path: <linuxppc-dev+bounces-19796-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE780F8D763
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Apr 2026 18:01:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fxQn80s5hz30TY;
	Fri, 17 Apr 2026 04:01:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776362492;
	cv=none; b=E6735RPCqQraNhuL9aHqF4HU4+bQhGPJalrmaPsY/zU/6+tM1ai9WHxd+Gf8ajMnd5vAVO5xVWO6hruF7Cde5lEBxC0Znw+TR8ABydMGc5oiWFJkSVVi7TC3lE6S3S/LR+ZO6oUr+6JmxsmnI4lB0+ipkQKwTRXOkPoybvhQ9jJtl/z1ZNUVW/MEs7gTn9TIusvnfpaNl5CKycouZP8KXW4+PERbDwFfayT0Ad5+OXGZpks8tMsVr1xsZtBVncseOij3fkPurNlrPC5B42mOcdDk1IYp1zaIw9sZq4KuQ5uyiygws7UhsOH5bJ4geFx5DexWvImMp7AIBuczedkaJA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776362492; c=relaxed/relaxed;
	bh=yR0dagUpafQq6IBa8FUHt9Th4B7BFsnHVbv1XXpWmi8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W+BC8C7Y1nmCRYXrYbaZN4KkWQS+ZQ0qwSMZqkB/bHW+OhbqkWQJP4NLZ5JKx0oogyb1LSxpRNPL6VhuPBq3hNEzDrxB86VHDXjaIEBFQZIFo8GZH9bw7lZOM81fwtYSnqrpfIhyArslf/quEL7gsjs4PuWPG1M0qblGfRqLOX6txjkw1PL3tQ1ykSzjx3aut/EktlECZFQfvrwfy7Iaef5viOnuVE8fumY1yNdeZh5hXw2YzTl/vyE4RZZI5O6tHURPoDwyz4D2rzpyP9JKS6IoCmEsv84N6RkEj0IhIhan8YBtwHbsL0LLWxWmMqWMV62Dd7ay1o2CNQ72QMq3KA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=GNzaUOlO; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=GNzaUOlO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fxQn73B47z2yvR
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Apr 2026 04:01:31 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id C5CE540135;
	Thu, 16 Apr 2026 18:01:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A97AC2BCB5;
	Thu, 16 Apr 2026 18:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776362489;
	bh=u/k9TMeqaPQPWgW7ILWQ8kth1orOPivoorazdGxMwic=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GNzaUOlOxZWEgLbDs808/Oq3wDidFRb5nqJauRfHZ90l18YrYeKlEoChUM8QgraAz
	 oreTnPAqoCd0iLRCrSAlVLLiNPzFq20CJoC/Iq+cmUxWe7h5z2T0rwGqLIpnXqtHdC
	 xZJz7DYMXdM2amhZXAy5y9A/1f4FGDFl8j5nb0HPEZ+0xDa8/y+gX2M9fRfvDMiJfk
	 lSQYfbpIAe2Iqhb1LnGqDvn579zIWLUWvhkp0LnB0sCbLuaI0zQ+BsHGFMW0UXgQXE
	 di5s/47rwYqehx34VPcP3qlETFcKZ/54zFsaWGxzcD5uuRraX3FlZabm13M3jCdw/x
	 Ph+agkyZNjW3A==
From: =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
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
Subject: [PATCH v5 05/23] PCI/sysfs: Add CAP_SYS_ADMIN check to __resource_resize_store()
Date: Thu, 16 Apr 2026 18:00:49 +0000
Message-ID: <20260416180107.777065-6-kwilczynski@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260416180107.777065-1-kwilczynski@kernel.org>
References: <20260416180107.777065-1-kwilczynski@kernel.org>
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

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 drivers/pci/pci-sysfs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 73a9ae9d289b..4f95b336cc34 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1619,6 +1619,9 @@ static ssize_t __resource_resize_store(struct device *dev, int n,
 	int ret;
 	u16 cmd;
 
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
 	if (kstrtoul(buf, 0, &size) < 0)
 		return -EINVAL;
 
-- 
2.53.0


