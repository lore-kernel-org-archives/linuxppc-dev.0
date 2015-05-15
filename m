Return-Path: <apopple@au1.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2A7FA1A048D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 May 2015 14:07:50 +1000 (AEST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <apopple@au1.ibm.com>;
 Fri, 15 May 2015 14:07:48 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 67CD22CE8040
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 May 2015 14:07:45 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4F47b6n19005518
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 May 2015 14:07:45 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4F47Cjn025230
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 May 2015 14:07:13 +1000
From: Alistair Popple <alistair@popple.id.au>
To: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au
Subject: [PATCH v4 0/9] Convert OPAL notifier events to an irqchip
Date: Fri, 15 May 2015 14:06:35 +1000
Message-Id: <1431662804-16851-1-git-send-email-alistair@popple.id.au>
Cc: Alistair Popple <alistair@popple.id.au>,
 openipmi-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 Corey Minyard <minyard@acm.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Whenever an interrupt is received for opal the linux kernel gets a
bitfield indicating certain events that have occurred and need handling
by the various device drivers. Currently this is handled using a
notifier interface where we call every device driver that has
registered to receive opal events.

This approach has several drawbacks. For example each driver has to do
its own checking to see if the event is relevant as well as event
masking. There is also no easy method of recording the number of times
we receive particular events.

This series solves these issues by exposing opal events via the
standard interrupt APIs by adding a new interrupt chip and
domain. Drivers can then register for the appropriate events using
standard kernel calls such as irq_of_parse_and_map().

Patches 2-8 of this series are the same as for v3.

Changes from v3:
 - Changed initialisation sequence to solve the following errors on
   some machines:

   irq: XICS didn't like hwirq-0xb to VIRQ17 mapping (rc=-22)
   opal: opal_message_init: Can't register OPAL event irq (0)

 - Added a poller to the OPAL heartbeat to support machines where OPAL
   can't generate an interrupt for the host (eg. mambo)

Changes from v2:
 - Addressed comments by Neelesh Gupta
 - Fixed soft-lockup bug reported by Neelesh in the opal-dump driver
 - Rebased on v4.1-rc1

Alistair Popple (9):
  powerpc/powernv: Reorder OPAL subsystem initialisation
  powerpc/powernv: Add a virtual irqchip for opal events
  ipmi/powernv: Convert to irq event interface
  hvc: Convert to using interrupts instead of opal events
  powernv/eeh: Update the EEH code to use the opal irq domain
  powernv/opal: Convert opal message events to opal irq domain
  powernv/elog: Convert elog to opal irq domain
  powernv/opal-dump: Convert to irq domain
  opal: Remove events notifier

 arch/powerpc/include/asm/opal.h                    |   6 +
 arch/powerpc/platforms/powernv/Makefile            |   2 +-
 arch/powerpc/platforms/powernv/eeh-powernv.c       |  58 ++---
 arch/powerpc/platforms/powernv/opal-async.c        |   3 +-
 arch/powerpc/platforms/powernv/opal-dump.c         |  56 ++---
 arch/powerpc/platforms/powernv/opal-elog.c         |  32 +--
 arch/powerpc/platforms/powernv/opal-hmi.c          |   3 +-
 arch/powerpc/platforms/powernv/opal-irqchip.c      | 249 +++++++++++++++++++++
 .../powerpc/platforms/powernv/opal-memory-errors.c |   2 +-
 arch/powerpc/platforms/powernv/opal-sensor.c       |   3 +-
 arch/powerpc/platforms/powernv/opal.c              | 196 +++-------------
 arch/powerpc/platforms/powernv/powernv.h           |   3 +
 arch/powerpc/platforms/powernv/setup.c             |   2 +-
 drivers/char/ipmi/ipmi_powernv.c                   |  39 ++--
 drivers/tty/hvc/hvc_opal.c                         |  33 +--
 15 files changed, 396 insertions(+), 291 deletions(-)
 create mode 100644 arch/powerpc/platforms/powernv/opal-irqchip.c

--
1.8.3.2
