Return-Path: <geert@linux-m68k.org>
Received: from leibniz.telenet-ops.be (leibniz.telenet-ops.be
 [IPv6:2a02:1800:110:4::f00:d])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t6scq46FgzDt2L
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Oct 2016 22:31:07 +1100 (AEDT)
Received: from andre.telenet-ops.be (andre.telenet-ops.be
 [IPv6:2a02:1800:120:4::f00:15])
 by leibniz.telenet-ops.be (Postfix) with ESMTPS id 3t6scj4FydzMqwpk
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Oct 2016 12:31:01 +0100 (CET)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Yangbo Lu <yangbo.lu@nxp.com>, Simon Horman <horms@verge.net.au>,
 Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>
Cc: Dirk Behme <dirk.behme@de.bosch.com>, linux-renesas-soc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 0/7] soc: renesas: Identify SoC and register with the SoC
 bus
Date: Mon, 31 Oct 2016 12:30:48 +0100
Message-Id: <1477913455-5314-1-git-send-email-geert+renesas@glider.be>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

	Hi all,

Some Renesas SoCs may exist in different revisions, providing slightly
different functionalities (e.g. R-Car H3 ES1.x and ES2.0), and behavior
(errate and quirks).  This needs to be catered for by drivers and/or
platform code.  The recently proposed soc_device_match() API seems like
a good fit to handle this.

This patch series implements the core infrastructure to provide SoC and
revision information through the SoC bus for Renesas ARM SoCs. It
consists of 7 patches:
  - Patches 1-4 provide soc_device_match(), with some related fixes,
  - Patches 5-7 implement identification of Renesas SoCs and
    registration with the SoC bus,

Changes compared to v1:
  - Add Acked-by,
  - New patches:
      - "[4/7] base: soc: Provide a dummy implementation of
	       soc_device_match()",
      - "[5/7] ARM: shmobile: Document DT bindings for CCCR and PRR",
      - "[6/7] arm64: dts: r8a7795: Add device node for PRR"
        (more similar patches available, I'm not yet spamming you all
	 with them),
  - Drop SoC families and family names; use fixed "Renesas" instead,
  - Drop EMEV2, which doesn't have a chip ID register, and doesn't share
    devices with other SoCs,
  - Drop RZ/A1H and R-CAR M1A, which don't have chip ID registers (for
    M1A: not accessible from the ARM core?),
  - On arm, move "select SOC_BUS" from ARCH_RENESAS to Kconfig symbols
    for SoCs that provide a chip ID register,
  - Build renesas-soc only if SOC_BUS is enabled,
  - Use "renesas,prr" and "renesas,cccr" device nodes in DT if
    available, else fall back to hardcoded addresses for compatibility
    with existing DTBs,
  - Remove verification of product IDs; just print the ID instead,
  - Don't register the SoC bus if the chip ID register is missing,
  - Change R-Mobile APE6 fallback to use PRR instead of CCCR (it has
    both).

Merge strategy:
  - In theory, patches 1-4 should go through Greg's driver core tree.
    But it's a hard dependency for all users.
    If people agree, I can provide an immutable branch in my
    renesas-drivers repository, to be merged by all interested parties.
    So far I'm aware of Freescale/NXP, and Renesas.
  - Patches 5-7 obviously have to go through Simon's Renesas tree (after
    merging the soc_device_match() core), and arm-soc.

Tested on (machine, soc_id, optional revision):
    EMEV2 KZM9D Board, emev2
    Genmai, r7s72100
    APE6EVM, r8a73a4, ES1.0
    armadillo 800 eva, r8a7740, ES2.0
    bockw, r8a7778
    marzen, r8a7779, ES1.0
    Lager, r8a7790, ES1.0
    Koelsch, r8a7791, ES1.0
    Porter, r8a7791, ES3.0
    Blanche, r8a7792, ES1.1
    Gose, r8a7793, ES1.0
    Alt, r8a7794, ES1.0
    Renesas Salvator-X board based on r8a7795, r8a7795, ES1.0
    Renesas Salvator-X board based on r8a7795, r8a7795, ES1.1
    Renesas Salvator-X board based on r8a7796, r8a7796, ES1.0
    KZM-A9-GT, sh73a0, ES2.0

For your convenience, this series (incl. more DT updates to add device
nodes for CCCR and PRR to all other Renesas ARM SoCs) is also available
in the topic/renesas-soc-id-v2 branch of my renesas-drivers git
repository at
git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git
Its first user is support for R-Car H3 ES2.0 in branch
topic/r8a7795-es2-v1-rebased2.

Thanks for your comments!

Arnd Bergmann (1):
  base: soc: Introduce soc_device_match() interface

Geert Uytterhoeven (6):
  base: soc: Early register bus when needed
  base: soc: Check for NULL SoC device attributes
  base: soc: Provide a dummy implementation of soc_device_match()
  ARM: shmobile: Document DT bindings for CCCR and PRR
  arm64: dts: r8a7795: Add device node for PRR
  soc: renesas: Identify SoC and register with the SoC bus

 Documentation/devicetree/bindings/arm/shmobile.txt |  26 +++++
 arch/arm/mach-shmobile/Kconfig                     |   3 +
 arch/arm64/Kconfig.platforms                       |   1 +
 arch/arm64/boot/dts/renesas/r8a7795.dtsi           |   5 +
 drivers/base/Kconfig                               |   1 +
 drivers/base/soc.c                                 |  79 +++++++++++++
 drivers/soc/renesas/Makefile                       |   2 +
 drivers/soc/renesas/renesas-soc.c                  | 130 +++++++++++++++++++++
 include/linux/sys_soc.h                            |   9 ++
 9 files changed, 256 insertions(+)
 create mode 100644 drivers/soc/renesas/renesas-soc.c

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
