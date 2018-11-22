Return-Path: <SRS0=R24o=OB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9DFCC43441
	for <linuxppc-dev@archiver.kernel.org>; Thu, 22 Nov 2018 14:08:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AB93206B2
	for <linuxppc-dev@archiver.kernel.org>; Thu, 22 Nov 2018 14:08:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Fkcia3qB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AB93206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4311Vs6h2kzDqPk
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Nov 2018 01:08:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="Fkcia3qB";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (helo)
 smtp.helo=wout2-smtp.messagingengine.com (client-ip=64.147.123.25;
 helo=wout2-smtp.messagingengine.com; envelope-from=ruscur@russell.cc;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=messagingengine.com header.i=@messagingengine.com
 header.b="Fkcia3qB"; dkim-atps=neutral
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com
 [64.147.123.25])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4311QW1pQqzDqP1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Nov 2018 01:04:16 +1100 (AEDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
 by mailout.west.internal (Postfix) with ESMTP id 47D0BD66;
 Thu, 22 Nov 2018 09:04:11 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
 by compute6.internal (MEProxy); Thu, 22 Nov 2018 09:04:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=8/xbp95vXWh23ncgO
 ZtcIvJ4G5GVZ1X1kYieM09w09g=; b=Fkcia3qB2DW/yt3dHEPoBw2APjLqM9peZ
 8brIt10aS81/5tEFbXF6Z1BUSobO1sGX5VsGVhx9lNhw1WRNDz5tv1LQTW4+Hfhp
 t9/vOrYRttIAiNfxrqwJAnM+p62ZWTB174DPJq5RuaII3YaSlCYyJ2Ydzztk6Usu
 gKkJnsaxn+UldWJQLZSayZeyA3OhqyIPhPwwnYj8XNbM9kvPXGBHBLNSdLUvWVBS
 YoF22TfziZuF7vayxRdjqeOZ/RQEcI8Yuis4jZZAZzHtMJfZSwwlfpOYcuOd0UgM
 RPEg/T6wH9PZNOX1m96Y0sJxS4Evs+QKB8OG0TyvtTTSbNHOu/SMA==
X-ME-Sender: <xms:WLf2Ww8a6L6nK2EGLlUuX_9nWTpakUk1_tug3tCkty8cp6PTzKE2VQ>
X-ME-Proxy: <xmx:WLf2W0mE5kIk-3kQ6HKHiUFrVT-EKPDE2cX8-IJDz_GQ_7lftFUczg>
 <xmx:WLf2W5BBVD-RAHmkAXjP4XTHMjIAa7hSmpPtf6qAgulpwmFZV0pF_A>
 <xmx:WLf2WzMh1JW6XQgWDhQlmzkKyFa217sDuINOlX7v87JDUe_fDnb8wA>
 <xmx:WLf2W7fsmwJKbU-CywGWUOjVfv-ibCUubWpo-fO-98Ayc_jmmFKHOw>
 <xmx:WLf2W4n0sGvi98-2XXnogBwKHmIbEqDudG8eq1V737FurFHeMFaVow>
 <xmx:Wrf2W7TqO3iQM5aWIVyGyl_u6rDfnY9_5c4iJKgBksGqOFpVx64T-w>
Received: from crackle.ozlabs.ibm.com.com (124-171-154-44.dyn.iinet.net.au
 [124.171.154.44])
 by mail.messagingengine.com (Postfix) with ESMTPA id 51A1A102E4;
 Thu, 22 Nov 2018 09:04:05 -0500 (EST)
From: Russell Currey <ruscur@russell.cc>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/4] Kernel Userspace Protection for Radix MMU
Date: Fri, 23 Nov 2018 01:04:12 +1100
Message-Id: <20181122140416.3447-1-ruscur@russell.cc>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
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
Cc: kernel-hardening@lists.openwall.com, Russell Currey <ruscur@russell.cc>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Back again, this time based on top of Christophe Leroy's series:
http://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=74541

With the magic perk of being the snowpatch maintainer I will try and get
the snowpatch results for this series to be applied on top of that series
so all the tests aren't failures.

There aren't really any major functional changes, just working what I
already did into Christophe's framework.  The biggest change is that
execution prevention is now optional, and all the radix-specific code
is now in the radix-specific place where it should be.

Russell Currey (4):
  powerpc: Track KUAP state in the PACA
  powerpc/64: Setup KUP before feature fixups
  powerpc/mm/radix: Use KUEP API for Radix MMU
  powerpc/64s: Implement KUAP for Radix MMU

 arch/powerpc/include/asm/book3s/64/radix.h   | 43 ++++++++++++++++++++
 arch/powerpc/include/asm/exception-64e.h     |  3 ++
 arch/powerpc/include/asm/exception-64s.h     | 19 ++++++++-
 arch/powerpc/include/asm/mmu.h               |  9 +++-
 arch/powerpc/include/asm/nohash/32/pte-8xx.h |  8 ++--
 arch/powerpc/include/asm/paca.h              |  3 ++
 arch/powerpc/include/asm/reg.h               |  1 +
 arch/powerpc/include/asm/uaccess.h           | 23 ++++++++++-
 arch/powerpc/kernel/asm-offsets.c            |  1 +
 arch/powerpc/kernel/entry_64.S               | 16 +++++++-
 arch/powerpc/kernel/setup_64.c               |  7 +++-
 arch/powerpc/mm/pgtable-radix.c              | 21 ++++++++--
 arch/powerpc/mm/pkeys.c                      |  7 +++-
 arch/powerpc/platforms/Kconfig.cputype       |  2 +
 14 files changed, 148 insertions(+), 15 deletions(-)

-- 
2.19.1

