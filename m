Return-Path: <linuxppc-dev+bounces-6496-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D300C021BF
	for <linuxppc-dev@archiver.kernel.org>; Wed, 26 Feb 2025 12:25:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z2tvw3lgSz3bkb;
	Wed, 26 Feb 2025 23:25:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1740572700;
	cv=none; b=YV5Lv654H7uCAl+kDwnCcE6B7u+gXQEp1gZGf3S5lc87Za8QB4q3T6s/Gd9sKDgueYnIHRpbxJFRAuZIud4ngwQMxSvpldZxXHqfzkysnaYUUf8AOmEsDgQC9EV8a1BuYV0xnSWqWIQ0DoG6FWXe547S+TfzatbZYENxofgz4CQUW8ptMRcF2RstZVNF3E+kc5F708rYtmpcpe+3gLFWeq2WRG6FZ5pUiN+YEAFm3Arv3VMkDhARx/539JVf2mz7tEKdGtohWSbfd+sl9VA9EdUTdzmPz0JkhZ+j7jT6UNlOW/EWjHy+xtxYb84xWWK8A4ufrTGQwG6gk1xScoWC8A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1740572700; c=relaxed/relaxed;
	bh=i3XaPcIWkt+IVY+CR48PjoV1JT/M2HBsBsMt+K2gCQI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kbsBNBsfHIULzWwIcSsp1xfwi5oBvBUJV8ggw2cWeBgCJg0eQau9b5zUbKW/r/3xEqF7nMvi46mpjqxG0v37Lc/y/T9JmOq5YsxiG9FXoSHKT1D9NDHYdqMDgcNBtknbSqiPfOt2pVVFCAXZH69Vhj/qO3MnFCD4IzVu+fJ9FnLJ8oUGjrDbLl9D5ljyr4bQ20P3ZDqifvrVhYUNZeAiohWQsA2/mqUXA1AaBfA25wLKz7E0RaV+aOC74VPbXwL79/UYrU69o/3bA1D931E1sCO0aTR3ty48mzlbDZjYSbENnN3YiRHe6Xlv0c4EDutT2BSAd4kg//kk8lwWK61SIA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=anshuman.khandual@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=anshuman.khandual@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z2tvt4g7zz30TZ
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Feb 2025 23:24:56 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4B55113D5;
	Wed, 26 Feb 2025 04:24:40 -0800 (PST)
Received: from a077893.arm.com (unknown [10.163.40.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 646443F5A1;
	Wed, 26 Feb 2025 04:24:20 -0800 (PST)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-mm@kvack.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org
Subject: [PATCH V3 0/5] mm: Rework generic PTDUMP configs
Date: Wed, 26 Feb 2025 17:53:59 +0530
Message-Id: <20250226122404.1927473-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
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

The series reworks generic PTDUMP configs before eventually renaming them
after some basic clean ups first. This is derived after splitting changes
from the following patch.

https://lore.kernel.org/all/20250205050039.1506377-1-anshuman.khandual@arm.com/

This series applies on v6.14-rc3 and has been tested on arm64. Although it
also builds on other platforms as well.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: kvmarm@lists.linux.dev
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-riscv@lists.infradead.org
Cc: linux-s390@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org

Changes in V3:

- Added CONFIG_PTDUMP_DEBUGFS in mpc885_ads_defconfig per Christophe
- Added back MMU dependency for CONFIG_ARCH_HAS_PTDUMP on riscv platform

Changes in V2:

https://lore.kernel.org/all/20250217042220.32920-1-anshuman.khandual@arm.com/

- Dropped the patch "mm: Make GENERIC_PTDUMP dependent on MMU"
- Dropped GENERIC_PTDUMP from mpc885_ads_defconfig
- Dropped PTDUMP config options from ptdump.rst

Changes in V1:

https://lore.kernel.org/all/20250213040934.3245750-1-anshuman.khandual@arm.com/

Anshuman Khandual (5):
  configs: Drop GENERIC_PTDUMP from debug.config
  arch/powerpc: Drop GENERIC_PTDUMP from mpc885_ads_defconfig
  docs: arm64: Drop PTDUMP config options from ptdump.rst
  mm: Make DEBUG_WX depdendent on GENERIC_PTDUMP
  mm: Rename GENERIC_PTDUMP and PTDUMP_CORE

 Documentation/arch/arm64/ptdump.rst       |  2 --
 arch/arm64/Kconfig                        |  2 +-
 arch/arm64/include/asm/ptdump.h           |  4 ++--
 arch/arm64/kvm/Kconfig                    |  4 ++--
 arch/arm64/mm/Makefile                    |  2 +-
 arch/powerpc/Kconfig                      |  2 +-
 arch/powerpc/configs/mpc885_ads_defconfig |  2 +-
 arch/powerpc/mm/Makefile                  |  2 +-
 arch/riscv/Kconfig                        |  2 +-
 arch/riscv/mm/Makefile                    |  2 +-
 arch/s390/Kconfig                         |  2 +-
 arch/s390/mm/Makefile                     |  2 +-
 arch/x86/Kconfig                          |  2 +-
 arch/x86/Kconfig.debug                    |  2 +-
 arch/x86/mm/Makefile                      |  2 +-
 kernel/configs/debug.config               |  1 -
 mm/Kconfig.debug                          | 11 ++++++-----
 mm/Makefile                               |  2 +-
 18 files changed, 23 insertions(+), 25 deletions(-)

-- 
2.25.1


