Return-Path: <paul.gortmaker@windriver.com>
Received: from mail.windriver.com (unknown [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0CB6A2C00A7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Jan 2013 07:14:03 +1100 (EST)
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/4] powerpc: update sbc8548 flash/mtd settings
Date: Wed, 23 Jan 2013 15:13:29 -0500
Message-Id: <1358972013-5271-1-git-send-email-paul.gortmaker@windriver.com>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The sbc8548 dts information for flash was out of date with respect
to u-boot configuration changes made just over a year ago.  However
MTD support wasn't enabled by default, so the stale information
wasn't really an issue.

Here we update that information, split the dts file to allow
sharing the common blocks between the two possible flash
mappings, add the second mapping for when the jumpers are
configured for booting off alternate flash, and add the
necessary MTD settings to the defconfig, so that ease of
use out of the box is improved.

Thanks,
Paul

---

The following changes since commit 7d1f9aeff1ee4a20b1aeb377dd0f579fe9647619:

  Linux 3.8-rc4 (2013-01-17 19:25:45 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/paulg/linux.git sbc8548-flash

for you to fetch changes up to e43fbd09e84ad455f84bfd9c317c94d9dac84e31:

  powerpc: enable MTD options in sbc8548 defconfig (2013-01-23 14:49:10 -0500)

----------------------------------------------------------------
Paul Gortmaker (4):
      powerpc: split sbc8548 dts file into pre and post chunks
      powerpc: update sbc8548 flash information to match recent u-boot
      powerpc: add alternate dts file for sbc8548 boot via SODIMM
      powerpc: enable MTD options in sbc8548 defconfig

 arch/powerpc/boot/dts/sbc8548-altflash.dts  | 115 +++++++++
 arch/powerpc/boot/dts/sbc8548-post.dtsi     | 295 +++++++++++++++++++++++
 arch/powerpc/boot/dts/sbc8548-pre.dtsi      |  52 ++++
 arch/powerpc/boot/dts/sbc8548.dts           | 356 ++--------------------------
 arch/powerpc/configs/85xx/sbc8548_defconfig |  19 ++
 5 files changed, 500 insertions(+), 337 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/sbc8548-altflash.dts
 create mode 100644 arch/powerpc/boot/dts/sbc8548-post.dtsi
 create mode 100644 arch/powerpc/boot/dts/sbc8548-pre.dtsi
