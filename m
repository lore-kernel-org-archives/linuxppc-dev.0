Return-Path: <linuxppc-dev+bounces-19953-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A37DAFA1FC5
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Apr 2026 16:14:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g14701r1bz2yrM;
	Thu, 23 Apr 2026 02:14:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776874476;
	cv=none; b=Cs3uOBzTcX3T6WDfbek6DlC7PoX1n6cJLJtD3Sl+Xs7s6D7q/0Lm0kZ2zLhnQODksJUtprRQsU0pTeIRBdDc0DzBCpdfUTboadaAvV/DUR+tdul2X7XwufhXvb4xAJ82Ga9sX7tnmGGfrfiragBBgIZl+QbI9YFeTYyU9vs0pbpqs5HT5GaqlnoXxkQiM7SDIxnohEc50zQBrPQZt8YAYKf9oaUPYyfkBLv0G24YOwP4NNdydV82C6BP2yJ0ASlhczX0BLpmWeX60W+U3bSL9IrSEHatSROZULsM7zJ35ZWG85DKyGwl7csuEZ7PkZuzi+Nd9z/aessUjtx8DsP09Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776874476; c=relaxed/relaxed;
	bh=zPxWSUT2w4O5Z7GXYGfWF2BXV0zO6EZB3wLWTJELucM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QWCvV1xdynV9kO8zjkLPKaZ2LeHbkpuE+/ktTJTHzvJqcd0zsRJUq3uQSkDAgdX/HjdbTJwxitDAaHLhRHtleMNpmvgYtsgTe2Iz2lxyT48O4UZMl31F30tm6fLGeXVDqCPWvAu9GQDiGKBvi74rHYPCWBWZZrnNgTbycirmrU8RiRZQh3mWb/5njm4G79zrUxVJ6CfNpGmAwde37J2R8b4M8pe9ZBs3pc6758iMpAUnNtr/D5MkCFJA5JwC4LO+sJeLFoi3cnibm9TdIJzGori7HGLp67gk0MajoTt64/+8Cdh18xiC8c5VPprd2OB5Zs2DoKrR7jDErkjDmI3JFQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=rJSKsA75; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=rJSKsA75;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g146v1c67z2yr9
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Apr 2026 02:14:31 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 88A6444311;
	Wed, 22 Apr 2026 16:14:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4894CC2BCB4;
	Wed, 22 Apr 2026 16:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776874469;
	bh=vxvZ/JB/94PIgSzvTadnmUwd1Mvfl/S43tmZJ955zdQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rJSKsA75DyyNHGFajpmAKfspkDX7UL9PaNh58TVV/uGGfjHiltihkeVxgJymRpO8W
	 thmgSvS7XPmEmwu9/jFctCf/jblS0GTWX4hK5XfPQgyUUPUM2r8XfxoMZty10+0+Z5
	 f5izG16JVHMImHyIz+sYv9+9neuvaK6QsME4auMoVw4dJYw0iCak6Zu63VJ59iZcW0
	 gOoBOBxK5wd+cvbUMgWmcuO9t8tE5hV/bZ8JI81wjsO95J5bfec18sgTaUu0bROq83
	 QfKRfeWDy98NXkyKvNZ4JEcaiXpMqGLypTMe2PmN7JYY1M0LaqaVtsFoteLBL7cqho
	 6/f8ghz7xTq3g==
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
Subject: [PATCH v6 05/24] PCI/sysfs: Add CAP_SYS_ADMIN check to __resource_resize_store()
Date: Wed, 22 Apr 2026 16:13:48 +0000
Message-ID: <20260422161407.118748-6-kwilczynski@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260422161407.118748-1-kwilczynski@kernel.org>
References: <20260422161407.118748-1-kwilczynski@kernel.org>
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
2.54.0


