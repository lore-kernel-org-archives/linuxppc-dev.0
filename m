Return-Path: <linuxppc-dev+bounces-374-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12B56C3DA4A
	for <linuxppc-dev@archiver.kernel.org>; Thu, 22 Aug 2024 15:13:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WqRXH3cGqz2yjg;
	Fri, 23 Aug 2024 01:12:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1724339567;
	cv=none; b=M2CWHDkKduuJuZM7AyPdf7F7gMo+4P/mSRI467MdmhR28CkWnP8qUxQRQjkgFJWO/LZPORVNLwbYnv1BQT+45ITcxyq0JUOjY1MlmKwGMw332fmqlxu/3OSb/ei6y1kCsEF/KP6HiGM5vsyGwfMnnOjaJ3BIqOXsX8tERbPK++7f74gwMYnCQ39twj2doi9PzclaGE7mx+g6Qdtox0KF2OrwJqz7I4kcXJHKDKHshMXLnnQOmNZSdV48xmm+8RF4WQh+snk/A1H/kAjzhq/oiv7K+GMODm+Z8XZhU/rNW53eW/ekjsNlE+JKP47OubZcJzd0e5+oIyOHAGp2OY1I2w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1724339567; c=relaxed/relaxed;
	bh=ypJJJaKGYD4Ov7M2/l/WjUT/Qty4LPf9GxDEXpk7WH8=;
	h=Received:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding; b=JvIucaJ/HymjwwG/acTYnoadjPhmnQHfwDw6uTXOhvH2nj3XSJTjPSj12m267mWnUFboma+AEqudx2m1CVDPIZz8eJvJ0815aMPEkDg96R8j5tVdyabpy+5AHbPNQQToyE1v8YSXp1fnSM6iDY0f5lfyGWLyueK+LeE08xi0DjsSJ0QfHWABWTHJM2omgZv/5AfElVjlYVjpI5BvF5RVEmzgdAcO7by1E1EmRywVuJICIAiLYW7NYJa7kLeE5Z2CTAdwa+kZde95mdgNuAljVNWFvmF9iPqE18u0edITWu7bCQwu19ef0sBU3YxLNGwYkxC0Ls/AtpnLUKhv9sZPwg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=joey.gouly@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=joey.gouly@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WqRXH1yrCz2ygZ
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Aug 2024 01:12:47 +1000 (AEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4CCD31595;
	Thu, 22 Aug 2024 08:12:42 -0700 (PDT)
Received: from e124191.cambridge.arm.com (e124191.cambridge.arm.com [10.1.197.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 167F53F58B;
	Thu, 22 Aug 2024 08:12:11 -0700 (PDT)
From: Joey Gouly <joey.gouly@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: nd@arm.com,
	akpm@linux-foundation.org,
	aneesh.kumar@kernel.org,
	aneesh.kumar@linux.ibm.com,
	anshuman.khandual@arm.com,
	bp@alien8.de,
	broonie@kernel.org,
	catalin.marinas@arm.com,
	christophe.leroy@csgroup.eu,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	joey.gouly@arm.com,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	maz@kernel.org,
	mingo@redhat.com,
	mpe@ellerman.id.au,
	naveen.n.rao@linux.ibm.com,
	npiggin@gmail.com,
	oliver.upton@linux.dev,
	shuah@kernel.org,
	skhan@linuxfoundation.org,
	szabolcs.nagy@arm.com,
	tglx@linutronix.de,
	will@kernel.org,
	x86@kernel.org,
	kvmarm@lists.linux.dev,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v5 12/30] arm64: re-order MTE VM_ flags
Date: Thu, 22 Aug 2024 16:10:55 +0100
Message-Id: <20240822151113.1479789-13-joey.gouly@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240822151113.1479789-1-joey.gouly@arm.com>
References: <20240822151113.1479789-1-joey.gouly@arm.com>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

VM_PKEY_BIT[012] will use VM_HIGH_ARCH_[012], move the MTE VM flags to
accommodate this.

Signed-off-by: Joey Gouly <joey.gouly@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
---
 include/linux/mm.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git include/linux/mm.h include/linux/mm.h
index 56dc2481cc0f..39e6234e2365 100644
--- include/linux/mm.h
+++ include/linux/mm.h
@@ -378,8 +378,8 @@ extern unsigned int kobjsize(const void *objp);
 #endif
 
 #if defined(CONFIG_ARM64_MTE)
-# define VM_MTE		VM_HIGH_ARCH_0	/* Use Tagged memory for access control */
-# define VM_MTE_ALLOWED	VM_HIGH_ARCH_1	/* Tagged memory permitted */
+# define VM_MTE		VM_HIGH_ARCH_4	/* Use Tagged memory for access control */
+# define VM_MTE_ALLOWED	VM_HIGH_ARCH_5	/* Tagged memory permitted */
 #else
 # define VM_MTE		VM_NONE
 # define VM_MTE_ALLOWED	VM_NONE
-- 
2.25.1


