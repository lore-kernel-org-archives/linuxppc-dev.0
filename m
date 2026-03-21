Return-Path: <linuxppc-dev+bounces-18538-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A92D1099B54
	for <linuxppc-dev@archiver.kernel.org>; Sat, 21 Mar 2026 06:43:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fd8yb0Jtvz2yfl;
	Sat, 21 Mar 2026 17:43:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.113
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774075398;
	cv=none; b=hegkVn3nrjRX3foA6jlCrSP6QEJwHzq6eNR0D9tnPXdXgH3k5dTu/7gC3QB87j4oQmliHaNBTHTM3UXnRMgVhKwg+7hKM7L4k146Ho9uwkzcYUMAVgdTDUWFy8OrToVexswocEJbGP2HQSex/AOdC9DsNrPR3Ah160kQaIXICIyoi1/Wl0atQP0mDtvt1opyJZ3+Jlnq6HQOazADwxyEwa94uQ90SFJoH4rnLFZrkkF7eOBSDjqitl42j0sxYegPJANXNgf9c8cfNbSTxszB5wld13UZ4XogQSv/NGJIyDa3lSmGBb4w8rQFqaq43836Lc4ZmUteQujyZzVhKeHHUw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774075398; c=relaxed/relaxed;
	bh=CFe5F2qNF94aRecR5rQidH10sMhxbLDMuB5Obisunh4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lYDTdvzWm0D6oVH9hBeuVmJD1zs0eR9pC13B8s4nDdgktCpO7T9Ec4BWhnkHMhqsqjEFb7e04ZQ/b6xS6+9lZpW3yjv4UNfY5msvXmaX+ClByWgneLrIN+rKC7KDTObcwfMZlOaVW30BmQZ9Vtj/37wg8OiN0TMPzM5UJ27ByXqhrkY0T7On0dPiSH90Kv5/GXuOuxhst7G/cRgSF1bApagtmTp0l75AihnuXdImadBHoMezg0CtEG9NWf3CbfqJ/leb6aoH7YzbMeQUNmGOLy1OaTRbnr4S7E3BqbgmXMSA0Cv8Tc72/wWximvO+YNYTRpLVRXDpwN4IajqwqGIcw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=F1na841L; dkim-atps=neutral; spf=pass (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=baolin.wang@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=F1na841L;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=baolin.wang@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fd8yX2C4Mz2yWy
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Mar 2026 17:43:13 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1774075388; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=CFe5F2qNF94aRecR5rQidH10sMhxbLDMuB5Obisunh4=;
	b=F1na841Lsy6irh/ZRaajnAfMVPZeTUcAvJjJsk9+1tLHr8+iU/yWaVIeezT1KpNbdZhEqFpJhs2Obj88fneSwgFjRT8pan5+8P3C81yvRawZ1zgtLWRIIE8h4i6j9d7p+OKXFohIhyQYWGUVZVTRCDJ0zO+X5I4eMUeHBRxObl4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R841e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0X.O7gUx_1774075385;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0X.O7gUx_1774075385 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 21 Mar 2026 14:43:06 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: akpm@linux-foundation.org,
	david@kernel.org
Cc: ljs@kernel.org,
	Liam.Howlett@oracle.com,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	baolin.wang@linux.alibaba.com,
	linux-arm-kernel@lists.infradead.org,
	x86@kernel.org,
	linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-mm@kvack.org (open),
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/6] change young flag check functions to return bool
Date: Sat, 21 Mar 2026 14:42:48 +0800
Message-ID: <cover.1774075004.git.baolin.wang@linux.alibaba.com>
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

This is a cleanup patchset to change all young flag check functions to
return bool, as discussed with David in the previous thread[1]. Since
callers only care about whether the young flag was set, returning bool
makes the intention clearer. No functional changes intended.

Ran mm selftests on Arm64 and x86 machines, and no issues were found.

Note that I only CC'd the arch mailing lists to avoid disturbing too
many people.

[1] https://lore.kernel.org/all/d172d6bf-c60c-4cf5-9da9-f30de38cdfed@kernel.org/

Changes from v1:
 - Add reviewed tag from Lorenzo and Ritesh. Thanks.
 - Drop extern and use 2 tabs indentation, per Lorenzo.
 - Fix the incorrect conversion of the 'id' variable.

Baolin Wang (6):
  mm: change to return bool for ptep_test_and_clear_young()
  mm: change to return bool for
    ptep_clear_flush_young()/clear_flush_young_ptes()
  mm: change to return bool for pmdp_test_and_clear_young()
  mm: change to return bool for pmdp_clear_flush_young()
  mm: change to return bool for pudp_test_and_clear_young()
  mm: change to return bool for the MMU notifier's young flag check

 arch/arm64/include/asm/pgtable.h             | 38 +++++-----
 arch/arm64/mm/contpte.c                      | 14 ++--
 arch/microblaze/include/asm/pgtable.h        |  2 +-
 arch/parisc/include/asm/pgtable.h            |  9 +--
 arch/parisc/kernel/cache.c                   |  8 +--
 arch/powerpc/include/asm/book3s/32/pgtable.h |  4 +-
 arch/powerpc/include/asm/book3s/64/pgtable.h | 26 +++----
 arch/powerpc/include/asm/nohash/64/pgtable.h |  2 +-
 arch/powerpc/include/asm/nohash/pgtable.h    |  4 +-
 arch/powerpc/mm/book3s64/pgtable.c           |  8 +--
 arch/riscv/include/asm/pgtable.h             | 16 ++---
 arch/riscv/mm/pgtable.c                      |  7 +-
 arch/s390/include/asm/pgtable.h              | 16 ++---
 arch/x86/include/asm/pgtable.h               | 20 +++---
 arch/x86/mm/pgtable.c                        | 28 ++++----
 arch/xtensa/include/asm/pgtable.h            |  9 ++-
 include/linux/mmu_notifier.h                 | 76 +++++++++-----------
 include/linux/pgtable.h                      | 53 +++++++-------
 mm/internal.h                                | 16 ++---
 mm/mmu_notifier.c                            | 23 +++---
 mm/pgtable-generic.c                         | 14 ++--
 virt/kvm/kvm_main.c                          | 31 +++-----
 22 files changed, 202 insertions(+), 222 deletions(-)

-- 
2.47.3


