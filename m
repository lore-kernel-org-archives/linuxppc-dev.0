Return-Path: <linuxppc-dev+bounces-16934-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3017EE9A049
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Feb 2026 13:52:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fGHxr2Bk2z3brv;
	Thu, 19 Feb 2026 00:52:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1771422736;
	cv=none; b=W+GE4jQTdZCxnP4f5Rr7KiUlra0OTNtlpulLYVDlkhVbic96b2FFBRTZDAu0G84MmWOB88idERPBe3lRnhiDlHBsGpRV0/OVQB3u8/bEL46hSHdyCagqHf+eXBi93agqdjTwUTE/bghvvtdOJhXquFL0JExbzxQKBog8rLaQ5Hph1hbFbyHGK20t5UpuAIxmDzkeqPhDpWA0zAaD1hfQUGrO7XuWZ6OkKUIaZUWHhhMgZt5nUtgw/HUgyTNlEmCMHHBYmSzdSvE6cGMb9SVtZ4/sn0pgnz/g+05g9/N/26tsnLIemkWJFzRaHbImG69nDizGqMxqmUpBjgSSi9kHkA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1771422736; c=relaxed/relaxed;
	bh=kurWLclCU1p6CObL3Fr6bH3QHzP1TichbnZiIf7g35w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kzwkf9LIAYue6BKeqFp9WjfN2bsBTCyl9GIeDIiiRfLIxzG+OpjbhLsEaA6oZow4ZvH9f4bAoLunJgEk2Yfx06ZmwswOKYtVxdlRX8FPn3VDtQFKAMzyJ6mVJ72mtHRTOx/JOWaW8wr7jU9H8PNek/AQUIeIK+Tmxn66+A5qGwrxNeWbhQ7JjeVbnrbgVoWQKhnDd4rGaQsVfIA5gCLeatpqXGhvAqXeSmu6noJHxRqSorES2rFUQBf3dqwHsMc2nexsH432lOVHniECs3wIXxxOUYikjsiu7/L7QmG0JINvMMh553DR6xWMoAhp1G6dDpcawlTu4im1ATzITsU60Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=JEI/nWjo; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=maz@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=JEI/nWjo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=maz@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fGHxm1dt5z3bnq
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Feb 2026 00:52:11 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 23F76600AE;
	Wed, 18 Feb 2026 13:52:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7141C116D0;
	Wed, 18 Feb 2026 13:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771422728;
	bh=w4EKK/R480qSeLevM8joRM/MvxRl22C1On+/P+fDFn0=;
	h=From:To:Cc:Subject:Date:From;
	b=JEI/nWjoAYErKmbf5xhGmzXnRXgp/Y5A5qRkYOJ91Z8T03wm+J4uX4Eqz1Pv3qGhE
	 lTak/thcVjyvClUlD4q46Z9JrlyR3wTbRlNA1+lpgIJIr+EDoM0zBPINYpJaO/2hM2
	 Sr6u5DqTmi3EUL3gGS5K92iNgjM/A/BWuRqBhVTpv3/Z5iCRT6FkPiO0rSaJR/AgBy
	 7TO9wwB0DginuYOJvJVJHbUN8zm0rp2eJdgEkk50UENjYvVQAN/cP6RR9wy1Aj0Akb
	 dNsuQNn3k8wEOWTah9dSwLH3FK33bTDiJF6NLsYJe46JDKxGft3FJlRoabJE3GitUI
	 0jKmoiZlsCNNQ==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1vshyI-0000000Bu02-33K3;
	Wed, 18 Feb 2026 13:52:06 +0000
From: Marc Zyngier <maz@kernel.org>
To: Ioana Ciornei <ioana.ciornei@nxp.com>,
	Thomas Gleixner <tglx@kernel.org>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/6] fsl-mc: Move fsl_over to device MSI
Date: Wed, 18 Feb 2026 13:51:57 +0000
Message-ID: <20260218135203.2267907-1-maz@kernel.org>
X-Mailer: git-send-email 2.47.3
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
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: ioana.ciornei@nxp.com, tglx@kernel.org, chleroy@kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

Over the past few years, I have become increasingly annoyed by this
sort of messages in my boot log:

[    0.067861] fsl-mc MSI: ITS@0x100100040000 domain created
[    0.073352] fsl-mc MSI: ITS@0x100100060000 domain created
[    0.078841] fsl-mc MSI: ITS@0x100100080000 domain created
[    0.084328] fsl-mc MSI: ITS@0x1001000a0000 domain created
[    0.089815] fsl-mc MSI: ITS@0x1001000c0000 domain created
[    0.095303] fsl-mc MSI: ITS@0x1001000e0000 domain created
[    0.100792] fsl-mc MSI: ITS@0x100100100000 domain created
[    0.106281] fsl-mc MSI: ITS@0x100100120000 domain created

While this is useful on fsl-mc systems, this is completely irrelevant
on 99.99999% of the arm64 machines, which know nothing about the
Freescale stuff. Including all of my machine -- bar *one*.

Global MSI domains such as the above have been obsoleted for the past
two years, but nobody at NXP seems to have got the message.

The obvious solution is to delete some code! While my first port of
call would be to just 'git rm -r drivers/bus/fsl-mc' (only kidding!),
a less invasive solution is to drag that code into the present times.
Which is what this series is doing by converting the whole thing to
device MSI, reusing the platform MSI infrastructure instead of
duplicating it.

This results in the expected cleanup, and kills the last user of the
non-device-MSI stuff on arm64. You're welcome.

Marc Zyngier (6):
  fsl-mc: Remove MSI domain propagation to sub-devices
  fsl_mc: Add minimal infrastructure to use platform MSI
  irqchip/gic-v3-its: Add fsl_mc device plumbing to the msi-parent
    handling
  fsl_mc: Switch over to per-device platform MSI
  fsl_mc: Remove legacy MSI implementation
  platform-msi: Remove stale comment

 drivers/base/platform-msi.c                 |   4 -
 drivers/bus/fsl-mc/dprc-driver.c            |  14 +-
 drivers/bus/fsl-mc/fsl-mc-bus.c             |   4 +-
 drivers/bus/fsl-mc/fsl-mc-msi.c             | 142 +++--------------
 drivers/bus/fsl-mc/fsl-mc-private.h         |   2 +-
 drivers/irqchip/Kconfig                     |   6 -
 drivers/irqchip/Makefile                    |   1 -
 drivers/irqchip/irq-gic-its-msi-parent.c    |   7 +-
 drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c | 168 --------------------
 include/linux/fsl/mc.h                      |   6 +-
 10 files changed, 33 insertions(+), 321 deletions(-)
 delete mode 100644 drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c

-- 
2.47.3


