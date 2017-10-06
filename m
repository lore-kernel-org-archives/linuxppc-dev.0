Return-Path: <helgaas@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y841j15L3zDqJ7
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Oct 2017 09:24:25 +1100 (AEDT)
Subject: [PATCH 0/2] vgaarb: Select fallback default VGA device
From: Bjorn Helgaas <helgaas@kernel.org>
To: Daniel Vetter <daniel.vetter@intel.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Gabriele Paoloni <gabriele.paoloni@huawei.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>, linux-pci@vger.kernel.org,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 dri-devel@lists.freedesktop.org, Xinliang Liu <z.liuxinliang@hisilicon.com>,
 Alex Williamson <alex.williamson@redhat.com>, Lukas Wunner <lukas@wunner.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Rongrong Zou <zourongrong@gmail.com>, Dave Airlie <airlied@redhat.com>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 Daniel Axtens <dja@axtens.net>
Date: Fri, 06 Oct 2017 17:24:20 -0500
Message-ID: <20171006221358.12211.42879.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

These patches are supposed to fix a problem Daniel Axtens found on the
HiSilicon D05 board.  The VGA device there is behind a bridge that doesn't
support PCI_BRIDGE_CTL_VGA, so the arbiter never selects the device as the
default.

The first patch extends the arbiter so that if it can't find an enabled VGA
device with legacy resources, it selects the first enabled device *without*
legacy resources (this is what fixes the D05).  If that fails, it selects
the first device that isn't enabled.  The combination of both changes
should make the current powerpc fixup_vga() quirk unnecessary.

N.B. It changes the powerpc behavior: if there are several enabled VGA
devices, the current quirk selects the last one, while this patch selects
the first one.  If this is a problem, I can drop that part of the patch and
keep the quirk.

The second patch pulls out this fallback device detection (and the EFI
override) from vga_arb_device_init() to make it easier to read.

---

Bjorn Helgaas (2):
      vgaarb: Select a default VGA device even if there's no legacy VGA
      vgaarb: Factor out EFI and fallback default device selection


 arch/powerpc/kernel/pci-common.c |   12 ------
 drivers/gpu/vga/vgaarb.c         |   72 +++++++++++++++++++++++++++++---------
 2 files changed, 55 insertions(+), 29 deletions(-)
