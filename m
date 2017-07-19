Return-Path: <dja@axtens.net>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xBzvz535rzDrK8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jul 2017 11:29:19 +1000 (AEST)
Received: by mail-pg0-x243.google.com with SMTP id y129so4854295pgy.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jul 2017 18:29:19 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
Cc: benh@kernel.crashing.org, z.liuxinliang@hisilicon.com,
 zourongrong@gmail.com, catalin.marinas@arm.com, will.deacon@arm.com,
 gabriele.paoloni@huawei.com, helgass@kernel.org, airlied@linux.ie,
 daniel.vetter@intel.com, alex.williamson@redhat.com,
 Daniel Axtens <dja@axtens.net>
Subject: [PATCH 0/4] Allow non-legacy cards to be vgaarb default
Date: Wed, 19 Jul 2017 11:28:33 +1000
Message-Id: <20170719012839.20124-1-dja@axtens.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi all,

Previously I posted a patch that provided a quirk for a hibmc card
behind a particular Huawei bridge that allowed it to be marked as the
default device in the VGA arbiter.[0] This lead to some discussion.[1]
It was broadly suggested that a more generic solution would be better,
something in the style of powerpc's fixup_vga() quirk.

Here is my suggested solution:

 - Create a Kconfig option ARCH_WANT_VGA_ARB_FALLBACK
 
 - if an arch selects that option, install PCI_FIXUP_CLASS_ENABLE
   hook. This hook fires when a card is enabled, which will require
   that a driver has been bound.

 - if there is no default device when the hook fires, and the device
   can control memory and I/O, mark it as default.

The patches are as follows:

 (1) powerpc: simplify and fix VGA default device behaviour

     This cleans up some quirks in the powerpc implementation of the
     vga_fixup. It should make the behaviour match the original
     intention.

 (2) vgaarb: allow non-legacy cards to be marked as default

     Add the Kconfig option, and create the fixup in vgaarb.c gated
     behind the option. Nothing happens at this stage because no arch
     has selected the option yet.

 (3) powerpc: replace vga_fixup() with generic code

     Select the option on powerpc and remove the old code. The only
     change is that it moves from being a final fixup to an enable
     fixup.
 
 (4) arm64: allow non-legacy VGA devices to be default

     Select the option on arm64. This solves my problem with the D05,
     but may cause other cards to be marked as default on other
     boards. This shouldn't cause any real issues but is worth being
     aware of.

Regards,
Daniel

[0]: https://patchwork.ozlabs.org/patch/787003/
[1]: https://www.spinics.net/lists/arm-kernel/msg593656.html

Daniel Axtens (4):
  powerpc: simplify and fix VGA default device behaviour
  vgaarb: allow non-legacy cards to be marked as default
  powerpc: replace vga_fixup() with generic code
  arm64: allow non-legacy VGA devices to be default

 arch/arm64/Kconfig               |  1 +
 arch/powerpc/Kconfig             |  1 +
 arch/powerpc/kernel/pci-common.c | 12 ------------
 drivers/gpu/vga/Kconfig          |  7 +++++++
 drivers/gpu/vga/vgaarb.c         | 21 +++++++++++++++++++++
 5 files changed, 30 insertions(+), 12 deletions(-)

-- 
2.11.0
