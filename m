Return-Path: <abounine@idt.com>
Received: from mxout1.idt.com (mxout1.idt.com [157.165.5.25])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mxout1.idt.com", Issuer "idt.com" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6470A2C0098
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Jun 2013 05:30:55 +1000 (EST)
From: Alexandre Bounine <alexandre.bounine@idt.com>
To: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/7] rapidio: modularize rapidio subsystem
Date: Fri, 28 Jun 2013 15:18:49 -0400
Message-Id: <1372447136-5751-1-git-send-email-alexandre.bounine@idt.com>
Cc: Stef van Os <stef.van.os@Prodrive.nl>,
 Micha Nelissen <micha.nelissen@Prodrive.nl>,
 Andre van Herk <andre.van.herk@Prodrive.nl>,
 Alexandre Bounine <alexandre.bounine@idt.com>, Jean Delvare <jdelvare@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The following set of patches modifies kernel RapidIO subsystem to enable build
and use of its components as loadable kernel modules. Combinations of statically
linked and modular components are also supported.

For this release full RapidIO subsystem modularization is implemented for
x86-based platforms. For PowerPC platforms (mostly MPC85xx) RapidIO core and
the mport driver (fsl_rio.c) still have only statically linked build option
while other components (enumerator and switch drivers) can be built as kernel
modules. This is not a significant limitation for embedded PowerPC platforms
because they use on-chip RapidIO controllers. For PowerPC platforms that may use
an external PCIe RapidIO controller (e.g. Tsi721) an additional patch will be
provided later.

This set of patches is based on the current linux-next code tree that contains
previously submitted patches for modularized enumeration/discovery method.

Cc: Matt Porter <mporter@kernel.crashing.org>
Cc: Li Yang <leoli@freescale.com>
Cc: Kumar Gala <galak@kernel.crashing.org>
Cc: Andre van Herk <andre.van.herk@Prodrive.nl>
Cc: Micha Nelissen <micha.nelissen@Prodrive.nl>
Cc: Stef van Os <stef.van.os@Prodrive.nl>
Cc: Jean Delvare <jdelvare@suse.de>

Alexandre Bounine (7):
  rapidio: convert switch drivers to modules
  rapidio/rionet: rework driver initialization and removal
  rapidio: update enumerator registration mechanism
  rapidio/tsi721: convert to modular mport driver
  rapidio: add modular build option for the subsystem core
  rapidio: add udev notification
  rapidio: documentation update

 Documentation/rapidio/rapidio.txt   |   98 ++++++-
 Documentation/rapidio/sysfs.txt     |    1 +
 arch/x86/Kconfig                    |    4 +-
 drivers/net/rionet.c                |  103 ++++++--
 drivers/rapidio/Kconfig             |    5 +
 drivers/rapidio/Makefile            |    4 +-
 drivers/rapidio/devices/Kconfig     |    2 +-
 drivers/rapidio/devices/Makefile    |    7 +-
 drivers/rapidio/devices/tsi721.c    |    9 +-
 drivers/rapidio/rio-driver.c        |   18 ++
 drivers/rapidio/rio-scan.c          |  172 +------------
 drivers/rapidio/rio-sysfs.c         |   31 +--
 drivers/rapidio/rio.c               |  490 ++++++++++++++++++++++++++++-------
 drivers/rapidio/rio.h               |   44 +---
 drivers/rapidio/switches/Kconfig    |   12 +-
 drivers/rapidio/switches/idt_gen2.c |   98 ++++++--
 drivers/rapidio/switches/idtcps.c   |   86 +++++--
 drivers/rapidio/switches/tsi568.c   |   71 +++++-
 drivers/rapidio/switches/tsi57x.c   |   81 +++++-
 include/asm-generic/vmlinux.lds.h   |    7 -
 include/linux/mod_devicetable.h     |   19 ++
 include/linux/rio.h                 |   82 +++---
 include/linux/rio_ids.h             |    2 -
 scripts/mod/devicetable-offsets.c   |    6 +
 scripts/mod/file2alias.c            |   20 ++
 25 files changed, 998 insertions(+), 474 deletions(-)

-- 
1.7.8.4
