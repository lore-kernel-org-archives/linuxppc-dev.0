Return-Path: <linuxppc-dev+bounces-6497-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D0DDC021B8
	for <linuxppc-dev@archiver.kernel.org>; Wed, 26 Feb 2025 12:25:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z2tvx20fTz30TZ;
	Wed, 26 Feb 2025 23:25:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1740572701;
	cv=none; b=h0b4K+G623oXC2kGVS6nClzCYLM598BMeML5rYjCNnhN+NwIEExhGjfilAmUk3YDzzTsrRkowA26jUzX1GoOl/Gm2mCakKHHA2Ks8oaiNQQKY5P0DFT3JCRsuVftcbzSS7gFhL2G63U0wDfiams5tIHRAsSRoXB99Qs7nOb044XHdYeCSel6wxjnWZ9UHtttfBW1Lyp6um1yDQI1Yi4DilBPqOY3Dpq6sY8t9p6lgBCCWGAjpwDn2ZBl1rdhBIZT3Pvc14NcqGQkFQIx5choWmQ0BAa/cWinh9sW9/GZO9bxN2IcoG2w5KOxwlMcXWCqzfAEd4H+h4zL+gYfOdveGA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1740572701; c=relaxed/relaxed;
	bh=E214jS2EGCcF3/4nPKRtjJQAG5BCKqN8zuqIaa3wNnU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VL3BN7BLSEXeZtpnU7TJB4gbDTiMx7UPx9HxzFaA6Nju6VgfU4SjZ32xph/mFJlE+udHfwr7y7sboLDXgEbaC8EMFGvpNZ2gCf/S+4SFZkMyz3J5qhwTktqHXgzYbLjLgfUIVga1EaLnKLr+fumpCObCi0MfRNw7X+1afsHZDu+gHGAlwdXnDrMbblNUOXYBwzRHAh49XEyhfJNLyntm70QjxccNw36Bzr5gJRZqhIFMsoU4Cwr/e4N6DmJoaioQaWhEUB3hul5JfEOhY2iO7i4h33suPfiIMVLc+LFxSo7kfvHkRYy7j53aS3qN/+ZbBDGFnmnIN1DUiXVBnd2eyQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=anshuman.khandual@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=anshuman.khandual@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z2tvw54cTz3blg
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Feb 2025 23:24:59 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9CB9C16F3;
	Wed, 26 Feb 2025 04:24:44 -0800 (PST)
Received: from a077893.arm.com (unknown [10.163.40.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A1DC13F5A1;
	Wed, 26 Feb 2025 04:24:24 -0800 (PST)
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
	linux-s390@vger.kernel.org,
	Steven Price <steven.price@arm.com>
Subject: [PATCH V3 1/5] configs: Drop GENERIC_PTDUMP from debug.config
Date: Wed, 26 Feb 2025 17:54:00 +0530
Message-Id: <20250226122404.1927473-2-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250226122404.1927473-1-anshuman.khandual@arm.com>
References: <20250226122404.1927473-1-anshuman.khandual@arm.com>
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

The platforms that support GENERIC_PTDUMP select the config explicitly. But
enabling this feature on platforms that don't really support - does nothing
or might cause a build failure. Hence just drop GENERIC_PTDUMP from generic
debug.config

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Reviewed-by: Steven Price <steven.price@arm.com>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 kernel/configs/debug.config | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/configs/debug.config b/kernel/configs/debug.config
index 20552f163930..8aafd050b754 100644
--- a/kernel/configs/debug.config
+++ b/kernel/configs/debug.config
@@ -73,7 +73,6 @@ CONFIG_DEBUG_VM=y
 CONFIG_DEBUG_VM_PGFLAGS=y
 CONFIG_DEBUG_VM_RB=y
 CONFIG_DEBUG_VM_VMACACHE=y
-CONFIG_GENERIC_PTDUMP=y
 CONFIG_KASAN=y
 CONFIG_KASAN_GENERIC=y
 CONFIG_KASAN_INLINE=y
-- 
2.25.1


