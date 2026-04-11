Return-Path: <linuxppc-dev+bounces-19625-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B024F36BA5
	for <linuxppc-dev@archiver.kernel.org>; Sat, 11 Apr 2026 08:02:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ft5jx3YDhz2ynZ;
	Sat, 11 Apr 2026 18:02:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775894533;
	cv=none; b=TyhF83lPtE8tDR7eA8HvJCeZJqbsLfpoJ14gO2+r0hOTRMAy3BHWNg2chGSEMotcYQX9+lQz1xgyTdqQkFddtlEHIjWlRPJhqRSKmKTJmLk9mPzJbscqPp7bWHl9xxHakc6b7TBeU4I7x2JPCqqAMsarcO4N+f9LFlxtlW9nxYBiaBmq9U6k23AyftjklRXMEIpcy5OdlhB63Yq4ZBjaacTbotgb8OSdrDleeHvaiHwAztVRQmWyqbYvRuH8rP6puIkCzaa2EXxHUz+YuQlTTrMRFP+yt0lRGEF6X9wtVuqDRZ7ZqDkACpzw6QVRF3JbPEtkMI5DFYmhsmZTMAuCkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775894533; c=relaxed/relaxed;
	bh=yR0dagUpafQq6IBa8FUHt9Th4B7BFsnHVbv1XXpWmi8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VJ52ki+5q5gw63FjlSE2M8o4XN/Sfx8+HyfyIWJL/KAg+m4L9pYzph8HoZoZ8whZuAmmDW3RQRZLBUjXrjIMtQvpVIZts2IigaLbBPTOs8J6Fj9F5ncvxrvRq0j2in/84Zb9NLVa7AqV07OeCcb8YXAU9GDvKS0UVYGUOqEJC+vadBpIBxMkwe4/5rPfbCKbttGnv5Dn2MrqdOrld/KBFfjEEZQtEQWZnVduq6ImV2k5Cj9JCPIc3UK4BSEYdjOEdc/qp5UZSmROq1iFiOz/LA8BjIn9lWXIlvidsVZhXMozMicqhdABZFWv6e6rM6UQm8Oo4I/j8wYNWcyOI4c7cg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=qo4iDtD7; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=qo4iDtD7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ft5jw6cpJz2ymg
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Apr 2026 18:02:12 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 3A2FC40903;
	Sat, 11 Apr 2026 08:02:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E89CBC2BCAF;
	Sat, 11 Apr 2026 08:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775894531;
	bh=u/k9TMeqaPQPWgW7ILWQ8kth1orOPivoorazdGxMwic=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qo4iDtD7qxZkSIZx9BdJoDCYqrdHWObNJT+r06FDnhUtIVeSN58tp+J4UJePTgazh
	 gl6j2mp9lnQnt6G4D/JWQqQ6wP/rnsDW4HighjI0AWdzlA7hmu/WmnpuL/OuNWT04O
	 Sl0m2hcBnuTg8iLnRBIPAuEpOt7swOZARRTu7LLrWO0Wcpl/0VGvU3MADeoAyfEv51
	 hEVZ/4qhRsRvy3AIWoR+7DzVeoiI2ugVcARF6NHRrAgnEbh/b4v2aOKGYGaWo53VEp
	 e3eoWPOaRSa2r9VJZqHoqMo52bGYgXXZZb/0ilimN8CtTZHvpN4BQQDCYxBj2Xt4xJ
	 vPciWrP8y34pA==
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
Subject: [PATCH v4 05/24] PCI/sysfs: Add CAP_SYS_ADMIN check to __resource_resize_store()
Date: Sat, 11 Apr 2026 08:01:29 +0000
Message-ID: <20260411080148.471335-6-kwilczynski@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260411080148.471335-1-kwilczynski@kernel.org>
References: <20260411080148.471335-1-kwilczynski@kernel.org>
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


