Return-Path: <linuxppc-dev+bounces-3866-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CC33E7717D
	for <linuxppc-dev@archiver.kernel.org>; Mon,  9 Dec 2024 09:48:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Y6H9S4VDtz2yXY;
	Mon,  9 Dec 2024 20:48:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1733737692;
	cv=none; b=Ad7bqO3ESeeY+PBWwDuOwCZACDkOIMRw4QpZwCiKGFIzzvv1EyphXlFP9hNGY23fg0dWrfXfzD04wBSUHbYLvKEAjRIExKOJBWHcHPMa3j255NWMFqWXdAVnXS2mJYw0lPvGPChvpYy9mB0CBH/o7O2FI7cwTK4b4G+yfZO4fI1RKSbes/FEAvMbNECW4SkBg2FGxxeT+xKie+wg+B1DtgR37dMjosWWj440AePemsWITLkpBAmZGQEQXzbGsJpCkfqq8ZHV4FqhatOE0fzOeM2YuvWgOhVJ5jPP0frMwbwoRUPyiA1+5Ke5Sc0tM86n/Ax+uK/VXTvhI5Wb2iaZdg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1733737692; c=relaxed/relaxed;
	bh=ni769i74TSTMc2HCIR8rv+ryIDdcPChPeu1Bt8O/pdw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VS/zIyD3n7WTIVBJfiU1XDAIvKsffKWEoIizBTA6HFdRKegrxI6gfJ/LXpVL5UUjxhlYDTmpqtREIB3k4y93eG2yktE9/XA24dbdPGkrZyehmD+m8ITzb6eaHWiYxP3HGwYXeTO97LhAsxsLOPB5xPqWGNS8nCQtchIWAnE7w4EiKK3CxeMBywok2ZE4p8BTucZQWfWmpNLYKpnLQZhv2Ip2T4pppRrSJReCInu0rkzbWc9Yd3AXEACKa4WMfYL8/bOrBkGFG0xIXHElycpM1sQj/WzMGCdxQIPG3A3QjR8R1D+hDKXo32jZZh5TcvTvu3CCLwkAtIAGZkGyVrT3Rg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=yury.khrustalev@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=yury.khrustalev@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Y6H9S0Z2Vz2xHF
	for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Dec 2024 20:48:11 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 25E9A143D;
	Mon,  9 Dec 2024 01:48:09 -0800 (PST)
Received: from udebian.localdomain (unknown [10.1.35.36])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A5B7D3F720;
	Mon,  9 Dec 2024 01:47:38 -0800 (PST)
From: Yury Khrustalev <yury.khrustalev@arm.com>
To: linux-arch@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Sandipan Das <sandipan@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Catalin Marinas <catalin.marinas@arm.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	x86@kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	nd@arm.com,
	Yury Khrustalev <yury.khrustalev@arm.com>
Subject: [RESEND v4 1/3] mm/pkey: Add PKEY_UNRESTRICTED macro
Date: Mon,  9 Dec 2024 09:47:17 +0000
Message-Id: <20241209094719.2431126-2-yury.khrustalev@arm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241209094719.2431126-1-yury.khrustalev@arm.com>
References: <20241209094719.2431126-1-yury.khrustalev@arm.com>
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

Memory protection keys (pkeys) uapi has two macros for pkeys restrictions:

 - PKEY_DISABLE_ACCESS 0x1
 - PKEY_DISABLE_WRITE  0x2

with implicit literal value of 0x0 that means "unrestricted". Code that
works with pkeys has to use this literal value when implying that a pkey
imposes no restrictions. This may reduce readability because 0 can be
written in various ways (e.g. 0x0 or 0) and also because 0 in the context
of pkeys can be mistaken for "no permissions" (akin PROT_NONE) while it
actually means "no restrictions". This is important because pkeys are
oftentimes used near mprotect() that uses PROT_ macros.

This patch adds PKEY_UNRESTRICTED macro defined as 0x0.

Signed-off-by: Yury Khrustalev <yury.khrustalev@arm.com>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
---
 include/uapi/asm-generic/mman-common.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/asm-generic/mman-common.h b/include/uapi/asm-generic/mman-common.h
index 1ea2c4c33b86..ef1c27fa3c57 100644
--- a/include/uapi/asm-generic/mman-common.h
+++ b/include/uapi/asm-generic/mman-common.h
@@ -85,6 +85,7 @@
 /* compatibility flags */
 #define MAP_FILE	0
 
+#define PKEY_UNRESTRICTED	0x0
 #define PKEY_DISABLE_ACCESS	0x1
 #define PKEY_DISABLE_WRITE	0x2
 #define PKEY_ACCESS_MASK	(PKEY_DISABLE_ACCESS |\
-- 
2.39.5


