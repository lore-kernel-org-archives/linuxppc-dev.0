Return-Path: <linuxppc-dev+bounces-6244-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27C83C021A4
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Feb 2025 04:23:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Yx8fC2hGRz303B;
	Mon, 17 Feb 2025 15:23:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1739766195;
	cv=none; b=V7jBmKQ2CgLevX2qOvB+drwA0Az89Iu1Z5s2L3QhHU+SoSAs93uLwe2pGme7ayLGIpvGgZ2uZUBK+YWJ5AmC9rDJIfquyjjeCcM0PFM2vVJc6gYiZW3mzJb3optmvsQVJefIEjdivav6sTGWkOa/fEaJ0A3vmjKZYGi9v2y2wkuCCaGitQfOpc680MwMcHN4EbwnARLC7T/OEILBTE5Y0D81w6LFkd1dxQeq7mRWfGMcTO3PBZo5D4fZX7i5pJE6bXg8OuhVtqTtledRo0Ep5pDBIUgGxsADkIS6ZmI5/Wej/OUy7HQ6hCWBW1aTeEB6uVGkjeKsndpI0hAGyp2ROg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1739766195; c=relaxed/relaxed;
	bh=9mxtOTKYXM9++EznKJFw0LH+ZQbbA0koCKCRQD8Qu+g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ekq2E6RHQlZ/AbVqs6RKzN0+NwTBaVxV3tl5nt2QkoXJtrpsAuu7vSVFGQ24LnPSRp4T9MZF0xNcFH1jD9WfIw4J316XQrJXRNBubUL9SHtCwTLAOrJgske4rVPjZjzFo0tGlbfVQgCv39QxMnH506pXicjF6dYAiywqLlSRkpgPiWqG0q1DMYpHGWMidwyavLatOVoO8cMWW5IPX1L/v+sE7+xqw+WvuI3xl5h8SpKDq2Blics6XFHnHjhpTescFfzurzi2WJ6V2koMbmFVqC/C9ZhheozPNqSDimoSZsbD/D2LIqrQsRUV2w2wO4LnKUwAifZHEBHnL4asH5LTxw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=anshuman.khandual@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=anshuman.khandual@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Yx8fB6273z2ykx
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Feb 2025 15:23:14 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 40B401CE2;
	Sun, 16 Feb 2025 20:23:03 -0800 (PST)
Received: from a077893.blr.arm.com (unknown [10.162.16.135])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4192C3F59E;
	Sun, 16 Feb 2025 20:22:39 -0800 (PST)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-mm@kvack.org
Cc: steven.price@arm.com,
	christophe.leroy@csgroup.eu,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mark Rutland <mark.rutland@arm.com>,
	kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH V2 3/5] docs: arm64: Drop PTDUMP config options from ptdump.rst
Date: Mon, 17 Feb 2025 09:52:18 +0530
Message-Id: <20250217042220.32920-4-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250217042220.32920-1-anshuman.khandual@arm.com>
References: <20250217042220.32920-1-anshuman.khandual@arm.com>
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
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both GENERIC_PTDUMP and PTDUMP_CORE are not user selectable config options.
Just drop these from documentation.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Suggested-by: Steven Price <steven.price@arm.com>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 Documentation/arch/arm64/ptdump.rst | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/arch/arm64/ptdump.rst b/Documentation/arch/arm64/ptdump.rst
index 5dcfc5d7cddf..51eb902ba41a 100644
--- a/Documentation/arch/arm64/ptdump.rst
+++ b/Documentation/arch/arm64/ptdump.rst
@@ -22,8 +22,6 @@ offlining of memory being accessed by the ptdump code.
 In order to dump the kernel page tables, enable the following
 configurations and mount debugfs::
 
- CONFIG_GENERIC_PTDUMP=y
- CONFIG_PTDUMP_CORE=y
  CONFIG_PTDUMP_DEBUGFS=y
 
  mount -t debugfs nodev /sys/kernel/debug
-- 
2.25.1


