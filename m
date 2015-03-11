Return-Path: <ard.biesheuvel@linaro.org>
Received: from mail-wg0-f53.google.com (mail-wg0-f53.google.com [74.125.82.53])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5B9301A0A0E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Mar 2015 03:00:31 +1100 (AEDT)
Received: by wggx12 with SMTP id x12so10225321wgg.13
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2015 09:00:27 -0700 (PDT)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org, robh@kernel.org,
 mark.rutland@arm.com, catalin.marinas@arm.com, will.deacon@arm.com,
 linux@arm.linux.org.uk, linuxppc-dev@lists.ozlabs.org,
 devicetree@vger.kernel.org
Subject: [PATCH v2 0/5] arm64: update/clarify/relax Image and FDT placement
 rules
Date: Wed, 11 Mar 2015 17:00:15 +0100
Message-Id: <1426089620-9459-1-git-send-email-ard.biesheuvel@linaro.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This series came about after Mark Rutland brought up the fact that the current
FDT placement logic used by the EFI stub is flawed. But actually, it turned out
that the documentation for both the Image and FDT placement was incorrect as
well, or confusing at the very least.

So this series does two things:
- It relaxes the FDT placement requirements, and updates the documentation and
  EFI stub FDT placement logic accordingly.
- It clarifies the Image placement requirements in the documentation, and brings
  the EFI stub Image placement logic in line with it

Changes since v1:
- patch #1: split off reservation of the FDT binary itself from the memreserve
  processing, since the former assumes the FDT is accessed via the linear
  mapping, which we are about to change
- patch #2: mention the older, stricter FDT placement rules in booting.txt,
  get rid of early_print,
  use correct format specifier for phys_addr_t,
  use R/O mapping for FDT,
- patches #3 .. #5: add R-b, minor style and grammar tweaks 
  
Ard Biesheuvel (5):
  of/fdt: split off FDT self reservation from memreserve processing
  arm64: use fixmap region for permanent FDT mapping
  arm64: Documentation: clarify Image placement in physical RAM
  arm64/efi: ensure that Image does not cross a 512 MB boundary
  arm64/efi: adapt to relaxed FDT placement requirements

 Documentation/arm64/booting.txt         | 15 ++++---
 arch/arm/mm/init.c                      |  1 +
 arch/arm64/include/asm/efi.h            |  8 ++--
 arch/arm64/include/asm/fixmap.h         |  9 +++++
 arch/arm64/kernel/Makefile              |  1 +
 arch/arm64/kernel/efi-stub.c            | 41 +++++++++++++++----
 arch/arm64/kernel/head.S                | 38 +----------------
 arch/arm64/kernel/setup.c               | 72 ++++++++++++++++++++++++---------
 arch/powerpc/kernel/prom.c              |  1 +
 drivers/firmware/efi/libstub/arm-stub.c |  5 +--
 drivers/firmware/efi/libstub/efistub.h  |  1 -
 drivers/firmware/efi/libstub/fdt.c      | 10 ++---
 drivers/of/fdt.c                        | 19 ++++++---
 include/linux/of_fdt.h                  |  2 +
 14 files changed, 131 insertions(+), 92 deletions(-)

-- 
1.8.3.2
