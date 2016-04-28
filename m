Return-Path: <cov@codeaurora.org>
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.29.96])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qwgWd5LsKzDqB5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Apr 2016 01:20:45 +1000 (AEST)
From: Christopher Covington <cov@codeaurora.org>
To: Catalin Marinas <catalin.marinas@arm.com>, criu@openvz.org,
 Laurent Dufour <ldufour@linux.vnet.ibm.com>,
 Will Deacon <Will.Deacon@arm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arch@vger.kernel.org, linux-mm@kvack.org
Cc: Christopher Covington <cov@codeaurora.org>
Subject: [RFC 5/5] arm64: Gain VDSO unmap and remap powers
Date: Thu, 28 Apr 2016 11:18:57 -0400
Message-Id: <1461856737-17071-6-git-send-email-cov@codeaurora.org>
In-Reply-To: <1461856737-17071-1-git-send-email-cov@codeaurora.org>
References: <20151202121918.GA4523@arm.com>
 <1461856737-17071-1-git-send-email-cov@codeaurora.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Checkpoint/Restore In Userspace (CRIU) must be able to remap and unmap the
Virtual Dynamic Shared Object (VDSO) to be able to handle the changing
addresses that result from address space layout randomization. Now that the
support for this originally written for PowerPC has been moved to a generic
location and arm64 has adopted unsigned long for the type of mm->context.vdso,
simply opt-in to VDSO unmap and remap support.

Signed-off-by: Christopher Covington <cov@codeaurora.org>
---
 arch/arm64/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 4f43622..cbdce39 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -14,6 +14,7 @@ config ARM64
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARCH_WANT_COMPAT_IPC_PARSE_VERSION
 	select ARCH_WANT_FRAME_POINTERS
+	select ARCH_WANT_VDSO_MAP
 	select ARCH_HAS_UBSAN_SANITIZE_ALL
 	select ARM_AMBA
 	select ARM_ARCH_TIMER
-- 
Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
