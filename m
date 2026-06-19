Return-Path: <linuxppc-dev+bounces-22795-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17899CD98F8
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Jun 2026 08:52:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ghWZ20c4Tz3bps;
	Fri, 19 Jun 2026 18:52:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781859145;
	cv=none; b=BZ+edYWRsMf6Z25rwMADX2VofWwn/tSPsAEAf5GXKrBND4XuGTp+o7O2v5qNqs6cRn1JX4MPdyYFegquZof7HTLCPsOeIX9z9COdguS7Z4JLEPdwPMOXaWguXIeotdfNOh904wWVBQrR49p2WvmE9+j17HG+eUEcM4xghJQsxKIN7y4n9/cWGkX7SJfWZP+zvIdaCL1zjvAJiwOr570kxHeGaFvtBy8x3DSGo+hcYAVRnEoLw3q81BiCntzzEnTptXDc/06trZWGh9i8ozbJkHgC+HXcIfHjSDJmO2X528t9AWWzznunfpWSXE8CHsSTDQnosqUnc/RpYIh1D91ycQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781859145; c=relaxed/relaxed;
	bh=5ptdizEpjuYqeg2f+U9wBoigKTE1I9tlh/xOEI1cGXU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NThwQpetQ/g+38XqB2ge9YeJ5OAOAh4mkbHmVF1VnkgsX4blgODsYSjuUpUMCu8+wS5paondQozOUjsVjJ5a2GTuMY75iZC4ESpGf1MJ0KyL3PEnD6SvhmDqTOi6yaRublMdnBnxzG4U+cuOt9QiXUbchVHCiKBdQpMyrsCoEPud+16tyU0Zv5Q19LmvIuvDmjloPigpkhFaK5wRrs973r6aBsarUnDljNlk7IztNxz9hib3f9bIpQp0DUdp0Q+esid/u56Cd7w8wCy++p0cXLc9HUfKUkwi1ZdoOkR4IF2tMzVfJoia1240esUoPlZT6CC2BfaP0pD9j+GuXlBJ3Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DvxGXdYR; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DvxGXdYR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ghWZ12xHBz3bpP
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jun 2026 18:52:25 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 7B030423C1;
	Fri, 19 Jun 2026 08:52:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F9AA1F00A3E;
	Fri, 19 Jun 2026 08:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781859143;
	bh=5ptdizEpjuYqeg2f+U9wBoigKTE1I9tlh/xOEI1cGXU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DvxGXdYRZjBwhtVt/XLBkqSTeCA0na6LMV/FEykjBxTTXIpdpGWpDMbt2Qr1JrFaI
	 9zcMQqINYRYbFYbOmCk6uxlrR59Z8oUF0zMZSjA0744Nf+0q7c1kRxUBd0+JfO5cD8
	 NrVGqhiifnFMswHAo/XCr9a7q3fquugELxBQPQ+G7Qkq1qOdKcWQjegvhtw3G3G8HT
	 zbzGY/4+qv7mltC2Fkjnw8lxtrPI5WDMg42QqMasw8hXkQPko5gmTa6n5PssupNK2I
	 NYl3sFq0q0Wvm+drBSR/10OAwxFsSLJOyB2aHRQICMf58Su3BVUDBklbC9A5qz48x7
	 vp6ayPc+xT4Rg==
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
Subject: [PATCH v8 05/25] PCI/sysfs: Add CAP_SYS_ADMIN check to __resource_resize_store()
Date: Fri, 19 Jun 2026 08:51:40 +0000
Message-ID: <20260619085200.3729431-6-kwilczynski@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260619085200.3729431-1-kwilczynski@kernel.org>
References: <20260619085200.3729431-1-kwilczynski@kernel.org>
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


