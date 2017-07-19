Return-Path: <dja@axtens.net>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xC0yT2N2PzDrLs
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jul 2017 12:16:33 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id a11so4680401pfj.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jul 2017 19:16:33 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
Cc: benh@kernel.crashing.org, z.liuxinliang@hisilicon.com,
 zourongrong@gmail.com, catalin.marinas@arm.com, will.deacon@arm.com,
 gabriele.paoloni@huawei.com, bhelgaas@google.com, airlied@linux.ie,
 daniel.vetter@intel.com, alex.williamson@redhat.com,
 Daniel Axtens <dja@axtens.net>
Subject: [PATCH v2 4/4] arm64: allow non-legacy VGA devices to be default
Date: Wed, 19 Jul 2017 12:15:16 +1000
Message-Id: <20170719021516.24718-5-dja@axtens.net>
In-Reply-To: <20170719021516.24718-1-dja@axtens.net>
References: <20170719021516.24718-1-dja@axtens.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The VGA arbiter only marks a device as default if it can decode
legacy I/O and memory ranges. This is often not the case on arm64,
which doesn't use the legacy ranges.

Enable the VGA arbiter to mark the first enabled VGA card as
default.

Signed-off-by: Daniel Axtens <dja@axtens.net>

---

Tested on a D05 using the hibmc card.
---
 arch/arm64/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index dfd908630631..cefcbd442e4f 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -28,6 +28,7 @@ config ARM64
 	select ARCH_SUPPORTS_NUMA_BALANCING
 	select ARCH_WANT_COMPAT_IPC_PARSE_VERSION
 	select ARCH_WANT_FRAME_POINTERS
+	select ARCH_WANT_VGA_ARB_FALLBACK
 	select ARCH_HAS_UBSAN_SANITIZE_ALL
 	select ARM_AMBA
 	select ARM_ARCH_TIMER
-- 
2.11.0
