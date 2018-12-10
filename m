Return-Path: <SRS0=HYLD=OT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0C9AC04EB8
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Dec 2018 07:07:57 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8656205C9
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Dec 2018 07:07:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O2WqoRtH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8656205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43CvKk3qQrzDqS9
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Dec 2018 18:07:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="O2WqoRtH";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (helo)
 smtp.helo=out1-smtp.messagingengine.com (client-ip=66.111.4.25;
 helo=out1-smtp.messagingengine.com; envelope-from=ruscur@russell.cc;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=messagingengine.com header.i=@messagingengine.com
 header.b="O2WqoRtH"; dkim-atps=neutral
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43Cv9F6S6CzDqsQ
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Dec 2018 18:00:33 +1100 (AEDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
 by mailout.nyi.internal (Postfix) with ESMTP id 84EE321B13;
 Mon, 10 Dec 2018 02:00:27 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
 by compute6.internal (MEProxy); Mon, 10 Dec 2018 02:00:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=5ffOq37dciL64SqFc
 Q5frnHjPrCplznF8cLUyzPY30w=; b=O2WqoRtHKkHzTRn6VOSaVIM8N4/vijcvK
 DkyGfX7AFPETXocOhXN2530TQ+E+lFWvd3DpaTSWNu9fczEB/n0nHDmflSBnMPhY
 xHtgR4vmv1hsFA16xD2GW0b3R4G4GSK24ooY+LNbjqINu5+7F6ymbCyimvBFOuDv
 viWLzAuiAuW6pV8VWLLdG8mSabq28bJoHFaK/BcAbWocK964EulSvW+TWS4u6wAG
 DfONHuj/vjbprDwy+yITf9DiMp5ce1nizXG8/Zfo+kY8ULLCO7Q2j9/dG9fdv4zJ
 7ekzUj8bJB6KVHyZH8K2hmcQxaGEXR7VHTMDKratPUtOhXNrbyZBQ==
X-ME-Sender: <xms:CQ8OXGZtDqjOU-3XQ7UUTOz-kzyFAFn5St3KrhN6HqOzlZsFLE_oDQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtkedrudeggedguddtiecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfhuthenuceurghilhhouhhtmecu
 fedttdenucgfrhhlucfvnfffucdluddtmdenucfjughrpefhvffufffkofgggfestdekre
 dtredttdenucfhrhhomheptfhushhsvghllhcuvehurhhrvgihuceorhhushgtuhhrsehr
 uhhsshgvlhhlrdgttgeqnecuffhomhgrihhnpehgihhthhhusgdrtghomhdpohiilhgrsg
 hsrdhorhhgnecukfhppeduvddvrdelledrkedvrddutdenucfrrghrrghmpehmrghilhhf
 rhhomheprhhushgtuhhrsehruhhsshgvlhhlrdgttgenucevlhhushhtvghrufhiiigvpe
 dt
X-ME-Proxy: <xmx:CQ8OXJZzDnyR2BZKIe0VGpp18P2F9bK7EBZx7ygag9f1VK8tS4gYzw>
 <xmx:CQ8OXPX_cgQdFNZioIVh-7zIQ9o8lvatMOHSu2pO4ZYRx6-TjuTo8g>
 <xmx:CQ8OXICMc9ZbCXn2jNyTTtgMtV15MvnVU2DX9Yn3NeOTFyPbjxPrKA>
 <xmx:CQ8OXLJCUQZ7iUq7F0uztG6rVkTsUk32GBf4YA2Pn_TXp69zPxfFzQ>
 <xmx:CQ8OXGshL-GUgkB8R0ZhHY65XoP5jl1NqfTJTn6PuDQNx7uiWgijNg>
 <xmx:Cw8OXCEQaGfLoVojSQRIr1Q6isdaXEkzz2ThfOHOM6HEV5MlIudXbQ>
Received: from crackle.ozlabs.ibm.com (unknown [122.99.82.10])
 by mail.messagingengine.com (Postfix) with ESMTPA id 1A8CDE469F;
 Mon, 10 Dec 2018 02:00:21 -0500 (EST)
From: Russell Currey <ruscur@russell.cc>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 0/3] [PATCH v2 0/3] Kernel Userspace Protection for Radix
 MMU
Date: Mon, 10 Dec 2018 18:00:41 +1100
Message-Id: <20181210070044.27503-1-ruscur@russell.cc>
X-Mailer: git-send-email 2.19.2
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
Cc: mikey@neuling.org, kernel-hardening@lists.openwall.com,
 Russell Currey <ruscur@russell.cc>, npiggin@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This series is based on Christophe's series:
http://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=78469
with some minor changes.

I wanted to move my patches to apply at the tail of his series to make it
easier for the two of us to work on independent parts, so I'm resending my
part of the series with the intent that it applies at the end.  There are
two required changes to his series to make this work:

In patch 04/11, the #ifdef around the paca_struct flag user_access_allowed
needs to be dropped.

With my patches removed, patch 11/11 needs to not reference
asm/book3s/64/kup-radix.h in asm/book3s/64/kup.h (so below the kup.h chunk
in that patch).

Sorry for being a pain, I'd rather not send a gigantic series full of
patches that aren't mine.

This branch shows how I'd imagine it would be pulled together:
https://github.com/ruscur/linux/commits/kuap2

Since the last version of this series:

      - fixed issues booting on hash, and the series now fully bisects
      - dropped some parts which are now part of Christophe's series
      - Fix __patch_instruction() in early boot
      - save three instructions in LOCK_USER_ACCESS()

Russell Currey (3):
  powerpc/mm/radix: Use KUEP API for Radix MMU
  powerpc/lib: Refactor __patch_instruction() to use __put_user_asm()
  powerpc/64s: Implement KUAP for Radix MMU

 .../powerpc/include/asm/book3s/64/kup-radix.h | 36 +++++++++++++++++++
 arch/powerpc/include/asm/exception-64s.h      | 15 ++++++--
 arch/powerpc/include/asm/kup.h                |  3 ++
 arch/powerpc/include/asm/mmu.h                |  9 ++++-
 arch/powerpc/include/asm/reg.h                |  1 +
 arch/powerpc/lib/code-patching.c              |  4 +--
 arch/powerpc/mm/pgtable-radix.c               | 25 +++++++++++--
 arch/powerpc/mm/pkeys.c                       |  7 ++--
 arch/powerpc/platforms/Kconfig.cputype        |  2 ++
 9 files changed, 92 insertions(+), 10 deletions(-)
 create mode 100644 arch/powerpc/include/asm/book3s/64/kup-radix.h

-- 
2.19.2

