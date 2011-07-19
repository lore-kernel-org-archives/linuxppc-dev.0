Return-Path: <dbaryshkov@gmail.com>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9B8D1B6F80
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 19 Jul 2011 18:54:48 +1000 (EST)
Received: by ewy6 with SMTP id 6so1840080ewy.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 19 Jul 2011 01:54:43 -0700 (PDT)
From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
To: Linux PPC Development <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 00/14] Consolidation of 83xx/85xx board files
Date: Tue, 19 Jul 2011 12:53:37 +0400
Message-Id: <1311065631-3429-1-git-send-email-dbaryshkov@gmail.com>
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I think it's already too late for this merge window, so this should stay
for 3.2 merge window. Board files for mpc83xx platforms show lots of common
code. Same goes for mpc85xx boards. This patchset is an initial attempt
to merge some (most) of the common code. Based on the tree by Kumar Gala.

The following changes since commit 6471fc6630a507fd54fdaceceee1ddaf3c917cde:

  powerpc: Dont require a dma_ops struct to set dma mask (2011-07-08 00:21:36 -0500)

Dmitry Eremin-Solenikov (14):
      83xx: consolidate init_IRQ functions
      83xx: consolidate of_platform_bus_probe calls
      mpc8349emitx: mark localbus as compatible with simple-bus
      83xx/mpc834x_itx: drop pq2pro-localbus-specific code
      83xx: headers cleanup
      85xx/sbc8560: correct compilation if CONFIG_PHYS_ADDR_T_64BIT is set
      85xx/ksi8560: declare that localbus is compatbile with simple-bus
      85xx/sbc8560: declare that localbus is compatbile with simple-bus
      85xx/sbc8548: read hardware revision when it's required for first time
      85xx/mpc85xx_rdb: merge p1020_rdb and p2020_rdb machine entries
      85xx: merge 32-bit QorIQ with DPA boards support
      85xx/mpc85xx_ds,ads,cds: move .pci_exclude_device setting to machine definitions
      85xx: consolidate of_platform_bus_probe calls
      85xx: separate cpm2 pic init

 arch/powerpc/boot/dts/ksi8560.dts                  |    2 +-
 arch/powerpc/boot/dts/mpc8349emitx.dts             |    3 +-
 arch/powerpc/boot/dts/sbc8560.dts                  |    2 +-
 arch/powerpc/platforms/83xx/asp834x.c              |   37 +--------
 arch/powerpc/platforms/83xx/km83xx.c               |   77 +----------------
 arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c     |    5 -
 arch/powerpc/platforms/83xx/misc.c                 |   64 ++++++++++++++-
 arch/powerpc/platforms/83xx/mpc830x_rdb.c          |   36 +-------
 arch/powerpc/platforms/83xx/mpc831x_rdb.c          |   34 +-------
 arch/powerpc/platforms/83xx/mpc832x_mds.c          |   80 +-----------------
 arch/powerpc/platforms/83xx/mpc832x_rdb.c          |   60 +-------------
 arch/powerpc/platforms/83xx/mpc834x_itx.c          |   51 +-----------
 arch/powerpc/platforms/83xx/mpc834x_mds.c          |   53 +-----------
 arch/powerpc/platforms/83xx/mpc836x_mds.c          |   79 +-----------------
 arch/powerpc/platforms/83xx/mpc836x_rdk.c          |   47 +----------
 arch/powerpc/platforms/83xx/mpc837x_mds.c          |   39 +--------
 arch/powerpc/platforms/83xx/mpc837x_rdb.c          |   38 +--------
 arch/powerpc/platforms/83xx/mpc83xx.h              |   10 ++
 arch/powerpc/platforms/83xx/sbc834x.c              |   55 +------------
 arch/powerpc/platforms/83xx/suspend.c              |    8 --
 arch/powerpc/platforms/83xx/usb.c                  |    8 --
 arch/powerpc/platforms/85xx/Kconfig                |   32 +------
 arch/powerpc/platforms/85xx/Makefile               |    6 +-
 arch/powerpc/platforms/85xx/ksi8560.c              |   46 +----------
 arch/powerpc/platforms/85xx/mpc8536_ds.c           |   16 +---
 arch/powerpc/platforms/85xx/mpc85xx.h              |   11 +++
 arch/powerpc/platforms/85xx/mpc85xx_ads.c          |   57 ++-----------
 arch/powerpc/platforms/85xx/mpc85xx_cds.c          |   21 +----
 arch/powerpc/platforms/85xx/mpc85xx_common.c       |   65 ++++++++++++++
 arch/powerpc/platforms/85xx/mpc85xx_ds.c           |   25 ++----
 arch/powerpc/platforms/85xx/mpc85xx_mds.c          |   46 +---------
 arch/powerpc/platforms/85xx/mpc85xx_rdb.c          |   54 +++----------
 arch/powerpc/platforms/85xx/p1022_ds.c             |    7 +-
 arch/powerpc/platforms/85xx/p2040_rdb.c            |   88 --------------------
 arch/powerpc/platforms/85xx/p4080_ds.c             |   88 --------------------
 .../platforms/85xx/{p3041_ds.c => qoriq_dpa_ds.c}  |   26 +++---
 arch/powerpc/platforms/85xx/sbc8548.c              |   26 ++----
 arch/powerpc/platforms/85xx/sbc8560.c              |   52 +-----------
 arch/powerpc/platforms/85xx/socrates.c             |   13 +---
 arch/powerpc/platforms/85xx/stx_gp3.c              |   16 +---
 arch/powerpc/platforms/85xx/tqm85xx.c              |   51 +-----------
 arch/powerpc/platforms/85xx/xes_mpc85xx.c          |   20 +----
 42 files changed, 278 insertions(+), 1276 deletions(-)
 create mode 100644 arch/powerpc/platforms/85xx/mpc85xx.h
 create mode 100644 arch/powerpc/platforms/85xx/mpc85xx_common.c
 delete mode 100644 arch/powerpc/platforms/85xx/p2040_rdb.c
 delete mode 100644 arch/powerpc/platforms/85xx/p4080_ds.c
 rename arch/powerpc/platforms/85xx/{p3041_ds.c => qoriq_dpa_ds.c} (72%)
