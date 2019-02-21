Return-Path: <SRS0=ZoyS=Q4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11616C43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 09:38:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47ED0214AF
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 09:38:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=russell.cc header.i=@russell.cc header.b="FP1edbOd";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MhXyh1ca"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47ED0214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 444qCM0l98zDqPf
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 20:38:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=russell.cc
 (client-ip=66.111.4.26; helo=out2-smtp.messagingengine.com;
 envelope-from=ruscur@russell.cc; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=russell.cc header.i=@russell.cc header.b="FP1edbOd"; 
 dkim=pass (2048-bit key;
 unprotected) header.d=messagingengine.com header.i=@messagingengine.com
 header.b="MhXyh1ca"; dkim-atps=neutral
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 444q9V1g85zDqPB
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Feb 2019 20:36:29 +1100 (AEDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
 by mailout.nyi.internal (Postfix) with ESMTP id CAE8521F44;
 Thu, 21 Feb 2019 04:36:26 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
 by compute6.internal (MEProxy); Thu, 21 Feb 2019 04:36:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=russell.cc; h=
 from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding; s=fm1; bh=A9LrUcA7yUDfQQxa0iYRFrWBmX
 V/uacj86aXiqZP6l0=; b=FP1edbOdhIhtkpX1w8vIkLOsOhx3WyMTUwjm4sU9+u
 MArWoyHKvURKIy56R1TlkbQsxkRa/3XqMZxxWpv69SZj0RGoehngoOOvEHAKtayN
 MfZOhzXq+tJF3dOSM7G96fAvaI3KVHzAGxl/u06VWEtEUiJbwqxT8AkVbwCZAgTz
 7W8+VZPu0fei086W4u6igRqJ2rq2qvbr2D3B3G3RPWPtGizXAbNiQkxNnvZF5CMn
 lCKcMz3/XErbPQDpm1w6MnJsrGN1BxKIHc4fuY+tkCOuMvjED3rRzKpDHK1kksD8
 4so4cI5FSFEIYgOBFQkGpIKxr+GLP1Mg1bctfdTyL2Dg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=A9LrUcA7yUDfQQxa0
 iYRFrWBmXV/uacj86aXiqZP6l0=; b=MhXyh1ca2BMVkh69Qk1mgSjBqzHG+/maj
 ZGjqR4in83dp2S2ZG+Xby58F5xJHpvXys0nDAk6Iy1/y9I5o7836hH3Gt/owx3aA
 xMwTaWPVWLutAgr7ZgW+dxq85OukNsh5m6TeTyaqX10QvLctjSA7G9gUr0i4L46D
 E7mY4QQOjnwvs2U4zxrdIYIIYN/NPABu8pe6yXk5n3I9/B3sHG2A6IWMF4zQFElv
 5F7oEIxZ9qO9latXCWEwm+kKhKtUZL4IE7ZrPQV6jCLLzeukajHkDWgsNGBgqEAF
 B4lkvPXTScmMLp8O9ud7jdyE+r9tGOAkbSAhJK+NLkCWUr6YrB9CQ==
X-ME-Sender: <xms:GHFuXI2vXIHMO9-x5XeJHc5Npy-2Brc_XTPAJK-y9Q-kFRnF9ydVNQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrtdekgddtjeculddtuddrgedtledrtddtmd
 cutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfhuthen
 uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdludehmdenucfjughrpefhvf
 fufffkofgggfestdekredtredttdenucfhrhhomheptfhushhsvghllhcuvehurhhrvgih
 uceorhhushgtuhhrsehruhhsshgvlhhlrdgttgeqnecuffhomhgrihhnpehoiihlrggssh
 drohhrghenucfkphepuddvvddrleelrdekvddruddtnecurfgrrhgrmhepmhgrihhlfhhr
 ohhmpehruhhstghurhesrhhushhsvghllhdrtggtnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:GXFuXNksXLmecDGFU_IbPivKlFb3sjMBjIkqOBDeFatPDGRhWp12_A>
 <xmx:GXFuXOuRnMQLpDZKvua1sObidzc011qdU1tUK44v8B5goiVjby0ZtA>
 <xmx:GXFuXO3Z78gOH-CeezsPwpZqj-38HPgjHhBr199F3nbg6x0X6GINXQ>
 <xmx:GnFuXDnuGYDlLNVISMMxaiHw2FkcsanUu6lPIGK9xBdfEfghZFEPaA>
Received: from crackle.ozlabs.ibm.com (unknown [122.99.82.10])
 by mail.messagingengine.com (Postfix) with ESMTPA id 7EF7010312;
 Thu, 21 Feb 2019 04:36:22 -0500 (EST)
From: Russell Currey <ruscur@russell.cc>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/7] Kernel Userspace Protection for radix
Date: Thu, 21 Feb 2019 20:35:54 +1100
Message-Id: <20190221093601.27920-1-ruscur@russell.cc>
X-Mailer: git-send-email 2.20.1
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
Cc: Russell Currey <ruscur@russell.cc>, npiggin@gmail.com,
 kernel-hardening@lists.openwall.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The first three patches of these series are from Christophe's work and are
the bare minimum framework needed to implement the support for radix.

In patch 3, I have removed from Christophe's patch my implementation of
the 64-bit exception handling code, since we don't have an answer for
making nested exceptions work yet.  This is mentioned in the final KUAP
patch.  Regardless, this is still a significant security improvement
and greatly narrows the attack surface.

Here are patches you will want if you want this to work:

http://patchwork.ozlabs.org/patch/1045215/
http://patchwork.ozlabs.org/patch/1045049/
http://patchwork.ozlabs.org/patch/1038568/

(or subsequent revisions, which the latter two will need)

I wouldn't expect this series to be merged without those fixes.

Thanks to Christophe for his great work and to Michael Ellerman for a
ton of feedback as I've worked on this.

Christophe Leroy (3):
  powerpc: Add framework for Kernel Userspace Protection
  powerpc: Add skeleton for Kernel Userspace Execution Prevention
  powerpc/mm: Add a framework for Kernel Userspace Access Protection

Russell Currey (4):
  powerpc/64: Setup KUP on secondary CPUs
  powerpc/mm/radix: Use KUEP API for Radix MMU
  powerpc/lib: Refactor __patch_instruction() to use __put_user_asm()
  powerpc/64s: Implement KUAP for Radix MMU

 .../admin-guide/kernel-parameters.txt         |  4 +-
 .../powerpc/include/asm/book3s/64/kup-radix.h | 36 ++++++++++++++++
 arch/powerpc/include/asm/exception-64e.h      |  3 ++
 arch/powerpc/include/asm/exception-64s.h      |  3 ++
 arch/powerpc/include/asm/futex.h              |  4 ++
 arch/powerpc/include/asm/kup.h                | 42 +++++++++++++++++++
 arch/powerpc/include/asm/mmu.h                |  9 +++-
 arch/powerpc/include/asm/paca.h               |  3 ++
 arch/powerpc/include/asm/processor.h          |  3 ++
 arch/powerpc/include/asm/ptrace.h             |  3 ++
 arch/powerpc/include/asm/reg.h                |  1 +
 arch/powerpc/include/asm/uaccess.h            | 38 +++++++++++++----
 arch/powerpc/kernel/asm-offsets.c             |  7 ++++
 arch/powerpc/kernel/entry_32.S                |  8 +++-
 arch/powerpc/kernel/process.c                 |  3 ++
 arch/powerpc/kernel/setup_64.c                | 10 +++++
 arch/powerpc/lib/checksum_wrappers.c          |  4 ++
 arch/powerpc/lib/code-patching.c              |  4 +-
 arch/powerpc/mm/fault.c                       | 20 ++++++---
 arch/powerpc/mm/init-common.c                 | 26 ++++++++++++
 arch/powerpc/mm/init_32.c                     |  3 ++
 arch/powerpc/mm/pgtable-radix.c               | 28 +++++++++++--
 arch/powerpc/mm/pkeys.c                       |  7 +++-
 arch/powerpc/platforms/Kconfig.cputype        | 26 ++++++++++++
 24 files changed, 271 insertions(+), 24 deletions(-)
 create mode 100644 arch/powerpc/include/asm/book3s/64/kup-radix.h
 create mode 100644 arch/powerpc/include/asm/kup.h

-- 
2.20.1

