Return-Path: <clg@kaod.org>
Received: from 6.mo4.mail-out.ovh.net (6.mo4.mail-out.ovh.net [188.165.36.253])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xTSPD2QLLzDr0Y
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Aug 2017 00:41:20 +1000 (AEST)
Received: from player772.ha.ovh.net (b6.ovh.net [213.186.33.56])
 by mo4.mail-out.ovh.net (Postfix) with ESMTP id A2E3F8C935
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Aug 2017 16:24:05 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v2 0/8] guest exploitation of the XIVE interrupt controller
Date: Fri, 11 Aug 2017 16:23:33 +0200
Message-Id: <20170811142341.22715-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

On a POWER9 sPAPR machine, the Client Architecture Support (CAS)
negotiation process determines whether the guest operates with an
interrupt controller using the legacy model, as found on POWER8, or in
XIVE exploitation mode, the newer POWER9 interrupt model. This
patchset is a first proposal to add XIVE support in the sPAPR machine.

Tested with a QEMU XIVE model for sPAPR machine and with the Power
hypervisor.

Code is here:

  https://github.com/legoater/linux/commits/xive
  https://github.com/legoater/qemu/commits/xive       

Thanks,

C.

Changes since v1 :

 - introduced a common subroutine xive_queue_page_alloc()
 - introduced a xive_teardown_cpu() routine
 - removed P9 doorbell support when xive is enabled.
 - fixed xive_esb_read() naming
 - fixed XIVE mode parsing in CAS (just got the final specs)

Changes since RFC :

 - renamed backend to 'spapr'
 - fixed hotplug support
 - fixed kexec support
 - fixed src_chip value (XIVE_INVALID_CHIP_ID)
 - added doorbell support
 - added some debug logs
 - added  H_INT_ESB hcall
 - took into account '/ibm,plat-res-int-priorities'
 - fixed WARNING in xive_find_target_in_mask()

Cédric Le Goater (8):
  powerpc/xive: introduce a common routine xive_queue_page_alloc()
  powerpc/xive: guest exploitation of the XIVE interrupt controller
  powerpc/xive: rename xive_poke_esb() in xive_esb_read()
  powerpc/xive: introduce xive_esb_write()
  powerpc/xive: add the HW IRQ number under xive_irq_data
  powerpc/xive: introduce H_INT_ESB hcall
  powerpc/xive: add XIVE Exploitation Mode to CAS
  powerpc/xive: improve debugging macros

 arch/powerpc/include/asm/hvcall.h            |  13 +-
 arch/powerpc/include/asm/prom.h              |   5 +-
 arch/powerpc/include/asm/xive.h              |   5 +
 arch/powerpc/kernel/prom_init.c              |  34 +-
 arch/powerpc/platforms/pseries/Kconfig       |   1 +
 arch/powerpc/platforms/pseries/hotplug-cpu.c |  11 +-
 arch/powerpc/platforms/pseries/kexec.c       |   6 +-
 arch/powerpc/platforms/pseries/setup.c       |   8 +-
 arch/powerpc/platforms/pseries/smp.c         |  27 +-
 arch/powerpc/sysdev/xive/Kconfig             |   5 +
 arch/powerpc/sysdev/xive/Makefile            |   1 +
 arch/powerpc/sysdev/xive/common.c            |  76 ++-
 arch/powerpc/sysdev/xive/native.c            |  18 +-
 arch/powerpc/sysdev/xive/spapr.c             | 661 +++++++++++++++++++++++++++
 arch/powerpc/sysdev/xive/xive-internal.h     |   7 +
 15 files changed, 843 insertions(+), 35 deletions(-)
 create mode 100644 arch/powerpc/sysdev/xive/spapr.c

-- 
2.13.4
