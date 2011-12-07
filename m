Return-Path: <Paul.Gortmaker@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3EA841007D5
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Dec 2011 14:40:05 +1100 (EST)
Date: Tue, 6 Dec 2011 22:39:57 -0500
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: <gregkh@suse.de>
Subject: [GIT PULL] tty-next: Fix Fsl 8250 BRK bug
Message-ID: <20111207033957.GB20556@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-serial@vger.kernel.org, alan@linux.intel.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Greg,

This is the Freescale hardware bug fix which turned into a
six-pack of 8250 updates.  This is exactly what was posted
in the v2 review, with just Alan's ack added[1].  Since nobody
else has had any follow-on comments since then, I'm assuming
that it is now good to go.

[1] https://lkml.org/lkml/2011/12/5/156

Thanks,
Paul.
---

Please pull for tty-next to get:

The following changes since commit 5611cc4572e889b62a7b4c72a413536bf6a9c416:

  Linux 3.2-rc4 (2011-12-01 14:56:01 -0800)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/paulg/linux fsl-uart-fix

Paul Gortmaker (6):
      serial: move struct uart_8250_port from 8250.c to 8250.h
      serial: clean up parameter passing for 8250 Rx IRQ handling
      serial: export the key functions for an 8250 IRQ handler
      serial: make 8250 timeout use the specified IRQ handler
      serial: manually inline serial8250_handle_port
      serial: add irq handler for Freescale 16550 errata.

 arch/powerpc/kernel/legacy_serial.c |    3 +
 drivers/tty/serial/8250.c           |   92 ++++++++++++-----------------------
 drivers/tty/serial/8250.h           |   26 ++++++++++
 drivers/tty/serial/8250_fsl.c       |   63 ++++++++++++++++++++++++
 drivers/tty/serial/Kconfig          |    5 ++
 drivers/tty/serial/Makefile         |    1 +
 include/linux/serial_8250.h         |    5 ++
 7 files changed, 134 insertions(+), 61 deletions(-)
 create mode 100644 drivers/tty/serial/8250_fsl.c
