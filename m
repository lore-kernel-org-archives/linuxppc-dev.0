Return-Path: <clg@kaod.org>
Received: from 15.mo3.mail-out.ovh.net (15.mo3.mail-out.ovh.net
 [87.98.150.177])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xRT3D6dhgzDqw8
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Aug 2017 19:03:52 +1000 (AEST)
Received: from player797.ha.ovh.net (b9.ovh.net [213.186.33.59])
 by mo3.mail-out.ovh.net (Postfix) with ESMTP id 1A14B12AE21
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Aug 2017 10:56:31 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH 00/10] guest exploitation of the XIVE interrupt controller
Date: Tue,  8 Aug 2017 10:56:10 +0200
Message-Id: <1502182579-990-1-git-send-email-clg@kaod.org>
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

Cédric Le Goater (10):
  powerpc/xive: fix OV5_XIVE_EXPLOIT bits
  powerpc/xive: guest exploitation of the XIVE interrupt controller
  powerpc/xive: rename xive_poke_esb in xive_esb_read
  powerpc/xive: introduce xive_esb_write
  powerpc/xive: add the HW IRQ number under xive_irq_data
  powerpc/xive: introduce H_INT_ESB hcall
  powerpc/xive: add XIVE exploitation mode to CAS
  powerpc/xive: take into account '/ibm,plat-res-int-priorities'
  powerpc/xive: improve debugging macros
  powerpc/xive: fix the size of the cpumask used in
    xive_find_target_in_mask()

 arch/powerpc/include/asm/hvcall.h            |  13 +-
 arch/powerpc/include/asm/prom.h              |   3 +-
 arch/powerpc/include/asm/xive.h              |   4 +
 arch/powerpc/kernel/prom_init.c              |  15 +-
 arch/powerpc/platforms/pseries/Kconfig       |   1 +
 arch/powerpc/platforms/pseries/hotplug-cpu.c |  10 +-
 arch/powerpc/platforms/pseries/kexec.c       |   6 +-
 arch/powerpc/platforms/pseries/setup.c       |   8 +-
 arch/powerpc/platforms/pseries/smp.c         |  32 +-
 arch/powerpc/sysdev/xive/Kconfig             |   5 +
 arch/powerpc/sysdev/xive/Makefile            |   1 +
 arch/powerpc/sysdev/xive/common.c            |  49 +-
 arch/powerpc/sysdev/xive/native.c            |   2 +
 arch/powerpc/sysdev/xive/spapr.c             | 658 +++++++++++++++++++++++++++
 arch/powerpc/sysdev/xive/xive-internal.h     |   1 +
 15 files changed, 778 insertions(+), 30 deletions(-)
 create mode 100644 arch/powerpc/sysdev/xive/spapr.c

-- 
2.7.5
