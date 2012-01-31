Return-Path: <robherring2@gmail.com>
Received: from mail-yw0-f42.google.com (mail-yw0-f42.google.com
 [209.85.213.42])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 55F30B6F62
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Feb 2012 06:47:06 +1100 (EST)
Received: by yhfq11 with SMTP id q11so267229yhf.15
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jan 2012 11:47:02 -0800 (PST)
Message-ID: <4F284532.90303@gmail.com>
Date: Tue, 31 Jan 2012 13:46:58 -0600
From: Rob Herring <robherring2@gmail.com>
MIME-Version: 1.0
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PULL] ARM mach/irqs.h cleanup for 3.4
Content-Type: text/plain; charset=ISO-8859-1
Cc: Aurelien Jacquiot <a-jacquiot@ti.com>, Paul Mackerras <paulus@samba.org>,
 "H. Peter Anvin" <hpa@zytor.com>, jamie@jamieiles.com,
 Robert Jarzmik <robert.jarzmik@free.fr>, Russell King <linux@arm.linux.org.uk>,
 linux-c6x-dev@linux-c6x.org, linux-sh@vger.kernel.org,
 Haojian Zhuang <haojian.zhuang@marvell.com>,
 Marek Vasut <marek.vasut@gmail.com>, Ingo Molnar <mingo@redhat.com>,
 Mark Salter <msalter@redhat.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 Eric Miao <eric.y.miao@gmail.com>, Nicolas Pitre <nico@fluxnic.net>,
 Paul Mundt <lethal@linux-sh.org>, Arnd Bergmann <arnd@arndb.de>,
 Olof Johansson <olof@lixom.net>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Russell,

Can you please pull mach/irqs.h clean-up for 3.4. I've gotten little to
no response from the affected platform maintainers. It's primarily
superh and shmobile that have any significant changes though.

Rob

The following changes since commit dcd6c92267155e70a94b3927bce681ce74b80d1f:

  Linux 3.3-rc1 (2012-01-19 15:04:48 -0800)

are available in the git repository at:
  git://sources.calxeda.com/kernel/linux.git sparse_irq

Jamie Iles (1):
      ARM: picoxcell: remove mach/irqs.h

Rob Herring (13):
      irq: make SPARSE_IRQ an optionally hidden option
      sound: pxa2xx-ac97: include mach/irqs.h directly
      gpio: pxa: explicitly include mach/irqs.h
      ARM: remove mc146818rtc.h from time.c
      ARM: mc146818rtc: remove unnecessary include of mach/irqs.h
      ARM: it8152: explicitly include mach/irqs.h
      sh: intc: unify evt2irq/irq2evt macros for sh and arm
      sh: intc: remove dependency on NR_IRQS
      ARM: mmp: remove NR_IRQS
      ARM: pxa: remove NR_IRQS
      ARM: shmobile: remove NR_IRQS
      ARM: only include mach/irqs.h for !SPARSE_IRQ
      ARM: highbank: select SPARSE_IRQ and remove irqs.h

 arch/arm/Kconfig                            |    2 +-
 arch/arm/include/asm/hardware/it8152.h      |    3 +++
 arch/arm/include/asm/irq.h                  |    8 ++++++--
 arch/arm/include/asm/mc146818rtc.h          |    4 +++-
 arch/arm/kernel/time.c                      |    2 --
 arch/arm/mach-highbank/highbank.c           |    1 -
 arch/arm/mach-highbank/include/mach/irqs.h  |    6 ------
 arch/arm/mach-mmp/aspenite.c                |    5 +++--
 arch/arm/mach-mmp/avengers_lite.c           |    1 +
 arch/arm/mach-mmp/brownstone.c              |    4 ++--
 arch/arm/mach-mmp/flint.c                   |    3 ++-
 arch/arm/mach-mmp/gplugd.c                  |    2 +-
 arch/arm/mach-mmp/include/mach/irqs.h       |    3 +--
 arch/arm/mach-mmp/irq-mmp2.c                |    1 +
 arch/arm/mach-mmp/jasper.c                  |    5 +++--
 arch/arm/mach-mmp/tavorevb.c                |    1 +
 arch/arm/mach-mmp/teton_bga.c               |    3 ++-
 arch/arm/mach-mmp/ttc_dkb.c                 |    4 ++--
 arch/arm/mach-picoxcell/include/mach/irqs.h |   20 --------------------
 arch/arm/mach-pxa/capc7117.c                |    1 +
 arch/arm/mach-pxa/cm-x300.c                 |    1 +
 arch/arm/mach-pxa/colibri-pxa270.c          |    2 ++
 arch/arm/mach-pxa/colibri-pxa300.c          |    1 +
 arch/arm/mach-pxa/colibri-pxa320.c          |    1 +
 arch/arm/mach-pxa/corgi.c                   |    3 +++
 arch/arm/mach-pxa/csb726.c                  |    1 +
 arch/arm/mach-pxa/devices.c                 |    1 +
 arch/arm/mach-pxa/em-x270.c                 |    2 ++
 arch/arm/mach-pxa/gumstix.c                 |    1 +
 arch/arm/mach-pxa/h5000.c                   |    1 +
 arch/arm/mach-pxa/himalaya.c                |    1 +
 arch/arm/mach-pxa/icontrol.c                |    1 +
 arch/arm/mach-pxa/idp.c                     |    1 +
 arch/arm/mach-pxa/include/mach/irqs.h       |    2 +-
 arch/arm/mach-pxa/mioa701.c                 |    1 +
 arch/arm/mach-pxa/mp900.c                   |    1 +
 arch/arm/mach-pxa/palmld.c                  |    1 +
 arch/arm/mach-pxa/palmt5.c                  |    1 +
 arch/arm/mach-pxa/palmtc.c                  |    1 +
 arch/arm/mach-pxa/palmte2.c                 |    1 +
 arch/arm/mach-pxa/palmtreo.c                |    2 ++
 arch/arm/mach-pxa/palmtx.c                  |    1 +
 arch/arm/mach-pxa/palmz72.c                 |    1 +
 arch/arm/mach-pxa/pxa3xx.c                  |    1 +
 arch/arm/mach-pxa/raumfeld.c                |    3 +++
 arch/arm/mach-pxa/saar.c                    |    1 +
 arch/arm/mach-pxa/spitz.c                   |    3 +++
 arch/arm/mach-pxa/stargate2.c               |    1 +
 arch/arm/mach-pxa/tavorevb.c                |    1 +
 arch/arm/mach-pxa/time.c                    |    1 +
 arch/arm/mach-pxa/trizeps4.c                |    2 ++
 arch/arm/mach-pxa/viper.c                   |    1 +
 arch/arm/mach-pxa/vpac270.c                 |    1 +
 arch/arm/mach-pxa/xcep.c                    |    1 +
 arch/arm/mach-pxa/z2.c                      |    1 +
 arch/arm/mach-shmobile/Kconfig              |    4 ++++
 arch/arm/mach-shmobile/board-ag5evm.c       |    1 +
 arch/arm/mach-shmobile/board-bonito.c       |    1 +
 arch/arm/mach-shmobile/board-g3evm.c        |    1 +
 arch/arm/mach-shmobile/board-g4evm.c        |    1 +
 arch/arm/mach-shmobile/board-kota2.c        |    1 +
 arch/arm/mach-shmobile/board-mackerel.c     |    1 +
 arch/arm/mach-shmobile/board-marzen.c       |    1 +
 arch/arm/mach-shmobile/include/mach/irqs.h  |    6 +-----
 arch/arm/mach-shmobile/intc-r8a7740.c       |    1 +
 arch/arm/mach-shmobile/intc-sh7367.c        |    1 +
 arch/arm/mach-shmobile/intc-sh7372.c        |    1 +
 arch/arm/mach-shmobile/intc-sh7377.c        |    1 +
 arch/arm/mach-shmobile/intc-sh73a0.c        |    1 +
 arch/arm/mach-shmobile/setup-r8a7740.c      |    1 +
 arch/arm/mach-shmobile/setup-r8a7779.c      |    1 +
 arch/arm/mach-shmobile/setup-sh7367.c       |    1 +
 arch/arm/mach-shmobile/setup-sh7372.c       |    1 +
 arch/arm/mach-shmobile/setup-sh7377.c       |    1 +
 arch/arm/mach-shmobile/setup-sh73a0.c       |    1 +
 arch/c6x/Kconfig                            |    2 +-
 arch/powerpc/Kconfig                        |    2 +-
 arch/sh/Kconfig                             |    2 +-
 arch/sh/include/asm/irq.h                   |   11 -----------
 arch/x86/Kconfig                            |    1 -
 drivers/gpio/gpio-pxa.c                     |    2 ++
 drivers/sh/intc/balancing.c                 |    2 +-
 drivers/sh/intc/core.c                      |    2 +-
 drivers/sh/intc/handle.c                    |    2 +-
 drivers/sh/intc/virq.c                      |    2 +-
 include/linux/sh_intc.h                     |   17 +++++++++++++++++
 kernel/irq/Kconfig                          |    5 ++---
 sound/arm/pxa2xx-ac97-lib.c                 |    2 +-
 88 files changed, 130 insertions(+), 75 deletions(-)
 delete mode 100644 arch/arm/mach-highbank/include/mach/irqs.h
 delete mode 100644 arch/arm/mach-picoxcell/include/mach/irqs.h
