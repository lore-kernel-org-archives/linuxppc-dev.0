Return-Path: <paul.gortmaker@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4BD12B6F6F
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Dec 2011 10:47:47 +1100 (EST)
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: gregkh@suse.de, alan@linux.intel.com, galak@kernel.crashing.org,
 scottwood@freescale.com
Subject: [PATCH 0/3] RFC Fix Fsl 8250 BRK bug via letting plat code set bugs
Date: Thu,  1 Dec 2011 18:47:35 -0500
Message-Id: <1322783258-20443-1-git-send-email-paul.gortmaker@windriver.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a respin of an earlier patch[1] that enabled a workaround
via Kconfig for an errata issue when using BRK on FSL 16550 UARTs.

In this version, the 8250 specific bug field is moved to the generic
uart_port struct, since hardware bugs aren't the unique domain of 
just the 8250 class of uarts.

Then the ability to set a known bugs value via the platform_device entry
point is added, so that it can be set externally vs. requiring some sort
of autodetection from the actual driver(s).

Then, the FSL errata fix is added to 8250.c by using the above support.
An entry in a DTS file is used to flag boards/platforms with the issue.
It is also added in a way that is optimized away for other architectures.

Kumar has a patch pending[2] that updates all the dts files.  I've not
included it here, so that review focus can be on the implementation.

I've re-tested it on an sbc8641D, where sysrq was useless before; with
this fix, it works as expected.

Thanks,
Paul.

[1] http://patchwork.ozlabs.org/patch/46609/
[2] http://patchwork.ozlabs.org/patch/128070/

--------

Paul Gortmaker (3):
  serial: make bugs field not specific to 8250 type uarts.
  serial: allow passing in hardware bug info via platform device
  8250: add workaround for MPC8[356]xx UART break IRQ storm

 arch/powerpc/kernel/legacy_serial.c |   11 ++++++++++
 drivers/tty/serial/8250.c           |   37 +++++++++++++++++++++-------------
 drivers/tty/serial/8250.h           |    5 ----
 include/linux/serial_8250.h         |   11 ++++++++++
 include/linux/serial_core.h         |    1 +
 5 files changed, 46 insertions(+), 19 deletions(-)

-- 
1.7.7
