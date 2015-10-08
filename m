Return-Path: <robherring2@gmail.com>
Received: from mail-ob0-x244.google.com (mail-ob0-x244.google.com
 [IPv6:2607:f8b0:4003:c01::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 126851A0372
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Oct 2015 04:54:01 +1100 (AEDT)
Received: by obbbh8 with SMTP id bh8so4300978obb.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Oct 2015 10:53:58 -0700 (PDT)
Sender: Rob Herring <robherring2@gmail.com>
From: Rob Herring <robh@kernel.org>
To: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Grant Likely <grant.likely@linaro.org>,
 Frank Rowand <frowand.list@gmail.com>,
 Ian Campbell <ijc+devicetree@hellion.org.uk>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Olof Johansson <olof@lixom.net>,
 Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>,
 linux-xtensa@linux-xtensa.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org, Ley Foon Tan <lftan@altera.com>,
 nios2-dev@lists.rocketboards.org, Ralf Baechle <ralf@linux-mips.org>,
 linux-mips@linux-mips.org, James Hogan <james.hogan@imgtec.com>,
 linux-metag@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>,
 uclinux-h8-devel@lists.sourceforge.jp,
 Russell King <linux@arm.linux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, linux-arm-kernel@lists.infradead.org,
 Vineet Gupta <vgupta@synopsys.com>, arm@kernel.org
Subject: [PATCH v2 00/13] Enable building all dtb files
Date: Thu,  8 Oct 2015 12:53:34 -0500
Message-Id: <1444326827-3565-1-git-send-email-robh@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This series enables building all the dtb files in the kernel mostly 
independent of the kernel config. The option is only dependent on 
COMPILE_TEST, OF, and the new OF_ALL_DTBS options. This ensures that 
allyesconfig builds can build all dtb files although most arches have to 
build "dtbs" target explicitly. Some arches like ARM include dtbs in the 
default target.

Arch/arm-soc maintainers, Please ack and I will take this series via the DT 
tree.

v2:
- Add OF_ALL_DTBS option hidden behind COMPILE_TEST
- Expand to all architectures (with more than 1 dtb)

Rob


Rob Herring (13):
  of: add config option to enable building of all dtbs
  arc: use common make variables for dtb builds
  arc: enable building of all dtbs
  arm: enable building of all dtbs
  arm64: enable building of all dtbs
  h8300: enable building of all dtbs
  metag: use common make variables for dtb builds
  metag: enable building of all dtbs
  mips: enable building of all dtbs
  nios2: use common make variables for dtb builds
  nios2: enable building of all dtbs
  powerpc: enable building of all dtbs
  xtensa: enable building of all dtbs

 arch/arc/Makefile              |  2 +-
 arch/arc/boot/dts/Makefile     |  6 ++++--
 arch/arm/boot/dts/Makefile     |  3 +++
 arch/arm64/boot/dts/Makefile   |  6 ++++++
 arch/h8300/boot/dts/Makefile   |  3 +++
 arch/metag/Makefile            |  2 +-
 arch/metag/boot/dts/Makefile   |  7 +++----
 arch/mips/boot/dts/Makefile    |  3 +++
 arch/nios2/Makefile            | 10 +++++-----
 arch/nios2/boot/Makefile       | 13 +++----------
 arch/nios2/boot/dts/Makefile   |  6 ++++++
 arch/powerpc/Makefile          |  6 ++++++
 arch/powerpc/boot/Makefile     |  5 ++++-
 arch/powerpc/boot/dts/Makefile |  5 +++++
 arch/xtensa/Makefile           |  4 ++++
 arch/xtensa/boot/dts/Makefile  |  7 ++++++-
 drivers/of/Kconfig             | 10 ++++++++++
 17 files changed, 73 insertions(+), 25 deletions(-)
 create mode 100644 arch/nios2/boot/dts/Makefile
 create mode 100644 arch/powerpc/boot/dts/Makefile

-- 
2.1.4
