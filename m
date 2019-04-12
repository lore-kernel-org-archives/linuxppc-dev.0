Return-Path: <SRS0=dpXp=SO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37600C10F0E
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Apr 2019 18:59:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D04FC2063F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Apr 2019 18:59:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D04FC2063F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44gnHS49wyzDqT7
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Apr 2019 04:59:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=arm.com
 (client-ip=217.140.101.70; helo=foss.arm.com;
 envelope-from=robin.murphy@arm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arm.com
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 44gnFf1c94zDqT7
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Apr 2019 04:57:24 +1000 (AEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4A06A374;
 Fri, 12 Apr 2019 11:57:21 -0700 (PDT)
Received: from e110467-lin.cambridge.arm.com (e110467-lin.cambridge.arm.com
 [10.1.196.75])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9D0473F718;
 Fri, 12 Apr 2019 11:57:19 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: linux-mm@kvack.org
Subject: [PATCH 0/3] Device-memory-related cleanups
Date: Fri, 12 Apr 2019 19:55:59 +0100
Message-Id: <cover.1555093412.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.21.0.dirty
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
Cc: anshuman.khandual@arm.com, linuxppc-dev@lists.ozlabs.org, ohall@gmail.com,
 x86@kernel.org, linux-kernel@vger.kernel.org, jglisse@redhat.com,
 dan.j.williams@intel.com, ira.weiny@intel.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi,

As promised, these are my preparatory cleanup patches that have so far
fallen out of pmem DAX work for arm64. Patch #1 has already been out for
a ride in Anshuman's hot-remove series, so I've collected the acks
already given.

Since we have various things in flight at the moment touching arm64
pagetable code, I'm wary of conflicts and cross-tree dependencies for
our actual ARCH_HAS_PTE_DEVMAP implementation. Thus it would be nice if
these could be picked up for 5.2 via mm or nvdimm as appropriate, such
that we can then handle the devmap patch itself via arm64 next cycle.

Robin.


Robin Murphy (3):
  mm/memremap: Rename and consolidate SECTION_SIZE
  mm: clean up is_device_*_page() definitions
  mm: introduce ARCH_HAS_PTE_DEVMAP

 arch/powerpc/Kconfig                         |  2 +-
 arch/powerpc/include/asm/book3s/64/pgtable.h |  1 -
 arch/x86/Kconfig                             |  2 +-
 arch/x86/include/asm/pgtable.h               |  4 +-
 arch/x86/include/asm/pgtable_types.h         |  1 -
 include/linux/mm.h                           | 47 +++++++-------------
 include/linux/mmzone.h                       |  1 +
 include/linux/pfn_t.h                        |  4 +-
 kernel/memremap.c                            | 10 ++---
 mm/Kconfig                                   |  5 +--
 mm/gup.c                                     |  2 +-
 mm/hmm.c                                     |  2 -
 12 files changed, 29 insertions(+), 52 deletions(-)

-- 
2.21.0.dirty

