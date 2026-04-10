Return-Path: <linuxppc-dev+bounces-19537-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5AFFE99046
	for <linuxppc-dev@archiver.kernel.org>; Fri, 10 Apr 2026 07:14:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fsShv408Nz2yhY;
	Fri, 10 Apr 2026 17:14:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775800261;
	cv=none; b=SonXgiyg+DwmoYqX9+MxJCddAMSGyw4i8lf9DJN8IDWK0929uEu4YdIrf9+nRPlJyK4IS6pf4lZrjwfMcPrNtf3DOn5rpEt+UDN6fkK3fwcxARVQsZczQr3qGvRmvCVEdHi+5SbEk/qi8MCHNO/amiUdybKr57oqEyMsFEKIv0n+Rb6zDQAkVB09r6wRz5lswm2JVZugrJpZovQDUaPlPyGzcxwBZETn/WjUqU1ZnG27qDWoZsCn/GvaCigsg4lP/lUfZ6k/Ts4MIrz/nGQelOt6WvNTsWrwHWE1gzR/1Y7aibYhtj/A6D4xAlifqtERfWNJtocUdu6OYDHIMvuMgA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775800261; c=relaxed/relaxed;
	bh=ysD8K23LHB0BTmxbzGNFdfOIxZhJ0vrLMxkwZTsqprk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lc2S7ExyVVkA6C1cwre9GFHxW5b/vcJ5iB0frroFiI4QJTJSSEpLEPIdFnYagCksDJu187mp8XCs+WuZCNKdGayV6VcjUvCeez9IEBeW6oQx0QkkenHj4qMOBwJ0OvfV4TuXWujK79n6L9hOG/f+gpvVTNxaCcqRqFRpk8R9Gl+SAR6KbaWMj8CevkH9Jat8HklEqvdDN2svuuQP9ZeWWaxlwDxNRVY6+eSf3Eyb5b+9yJ183mAn51TCm7dKSh54h5SVl4Tdkg+uzth5pezgdnCbMseey1vafru5Sfp7bfHi4Ep8J/1k7+Af+kOi63cjRaE2OISHKz+EYfORwDcSQg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=fFgo48Kh; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=fFgo48Kh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fsQs10yFkz2yRl
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2026 15:51:01 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 4BF8D6013E;
	Fri, 10 Apr 2026 05:50:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFB7FC2BC9E;
	Fri, 10 Apr 2026 05:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775800259;
	bh=SoGJBLsBAedU3UkQnFKz0LBvzv23roF9wHFr+0WZ14I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fFgo48KhP2UwDP+v7nBAAQpFvOcYKzZLYUpNrDbkMijA1CB/EOL/wf0hnZlc+76nA
	 QsgNEHBftINlrHeVEVCM5cfdhpaa2UA20qtkNr3ImV/HC/36UrrDrZu1vqo3Q8KvHH
	 8igsFPxntEMEia0YELY/E2uyNxICaOnxIC5jIi1ROZv8KDzNFgIncJy6+XVY/KlGVt
	 hBUfxONpEMROdiKXuWSdcPvqOrOEmz5Tlvi5RZ7lP8ZW+WbtPwfj6HZ7o+ZSkR2k5I
	 lKraDdD1mdbrwxowYEuiId6ylp90u/2drCdw7XYpIg3MuyfilzxfGOPlCH6FY0sPJl
	 GaMDcCMe1ufsA==
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
Subject: [PATCH 04/20] PCI/sysfs: Add CAP_SYS_ADMIN check to __resource_resize_store()
Date: Fri, 10 Apr 2026 05:50:24 +0000
Message-ID: <20260410055040.39233-5-kwilczynski@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410055040.39233-1-kwilczynski@kernel.org>
References: <20260410055040.39233-1-kwilczynski@kernel.org>
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

Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 drivers/pci/pci-sysfs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index ac4e7c516e78..6b8c8e62f68a 100644
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


