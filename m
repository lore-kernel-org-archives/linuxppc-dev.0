Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC7E0C6FD1F
	for <linuxppc-dev@archiver.kernel.org>; Sat, 25 Mar 2023 06:20:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Pk8872Tfbz3ftW
	for <linuxppc-dev@archiver.kernel.org>; Sat, 25 Mar 2023 17:20:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Q/Q2rpIW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=rppt@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Q/Q2rpIW;
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Pk7wP6hwjz3fWd
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Mar 2023 17:10:13 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 40516601D7;
	Sat, 25 Mar 2023 06:10:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B036C433A4;
	Sat, 25 Mar 2023 06:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1679724611;
	bh=n18lZ0S+0CZ2uvlkMluZxgCv0qlCJBiO8N8JH7KoZ1g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q/Q2rpIWZ2cFYZzyaItyJiN5f6EP/GSImQhED2G1vH7rlwhPXyJEMpQxGKZ4uZQCC
	 qitWtuJpknN31DG18FRDt/12qs/q7U50AzyQBPL7xtX81WEuD5O9mkCSWTye2JsQ5b
	 o2oehB+7FaaHIEILJpt4cpuWMCavNkq2xs7TyeSewFL4tUWGajA9JtHwOYUvb+VUZH
	 CGC5F+pZ10eARFG7ZR+xt2zgWBT6Wr0f9MktXpfvvQtUeEw79cK5v9aCS4M1Bfvv6/
	 UK1YnbIXGDs1gGS899x7h0os6Pe6lyyOXAXEEmys4HQs9lh4YKu8GQ3pCQP2W+FIrQ
	 gsw3SBBnzyEhQ==
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v3 12/14] sh: drop ranges for definition of ARCH_FORCE_MAX_ORDER
Date: Sat, 25 Mar 2023 09:08:26 +0300
Message-Id: <20230325060828.2662773-13-rppt@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230325060828.2662773-1-rppt@kernel.org>
References: <20230325060828.2662773-1-rppt@kernel.org>
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
Cc: Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Max Filippov <jcmvbkbc@gmail.com>, Guo Ren <guoren@kernel.org>, linux-csky@vger.kernel.org, sparclinux@vger.kernel.org, Will Deacon <will@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Russell King <linux@armlinux.org.uk>, Geert Uytterhoeven <geert@linux-m68k.org>, Zi Yan <ziy@nvidia.com>, linux-xtensa@linux-xtensa.org, Arnd Bergmann <arnd@arndb.de>, linux-m68k@lists.linux-m68k.org, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, Dinh Nguyen <dinguyen@kernel.org>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>, Mike Rapoport <rppt@kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: "Mike Rapoport (IBM)" <rppt@kernel.org>

sh defines insane ranges for ARCH_FORCE_MAX_ORDER allowing MAX_ORDER
up to 63, which implies maximal contiguous allocation size of 2^63
pages.

Drop bogus definitions of ranges for ARCH_FORCE_MAX_ORDER and leave it a
simple integer with sensible defaults.

Users that *really* need to change the value of ARCH_FORCE_MAX_ORDER
will be able to do so but they won't be mislead by the bogus ranges.

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Zi Yan <ziy@nvidia.com>
Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 arch/sh/mm/Kconfig | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/sh/mm/Kconfig b/arch/sh/mm/Kconfig
index 238b2772751e..511c17aede4a 100644
--- a/arch/sh/mm/Kconfig
+++ b/arch/sh/mm/Kconfig
@@ -20,11 +20,8 @@ config PAGE_OFFSET
 
 config ARCH_FORCE_MAX_ORDER
 	int "Order of maximal physically contiguous allocations"
-	range 8 63 if PAGE_SIZE_16KB
 	default "8" if PAGE_SIZE_16KB
-	range 6 63 if PAGE_SIZE_64KB
 	default "6" if PAGE_SIZE_64KB
-	range 10 63
 	default "13" if !MMU
 	default "10"
 	help
-- 
2.35.1

