Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C72E3DDE01
	for <linuxppc-dev@ozlabs.org>; Fri,  2 Nov 2007 00:11:06 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id lA1DB1xO013019
	for <linuxppc-dev@ozlabs.org>; Thu, 1 Nov 2007 09:11:01 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	lA1DB0Xe078070
	for <linuxppc-dev@ozlabs.org>; Thu, 1 Nov 2007 07:11:01 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lA1DB0TI005824
	for <linuxppc-dev@ozlabs.org>; Thu, 1 Nov 2007 07:11:00 -0600
Date: Thu, 1 Nov 2007 08:10:57 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: paulus@samba.org
Subject: Please pull from 'for-2.6.24' branch of 4xx tree
Message-ID: <20071101081057.46a9bfdd@weaponx.rchland.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Paul,

Please pull from:

 master.kernel.org:/pub/scm/linux/kernel/git/jwboyer/powerpc-4xx.git for-2.6.24

to pick up a few items for 2.6.24.  Mostly bugfixes, but also some
documentation updates and a few bootwrapper changes.  Particularly important
is the TLB flushing fix from Ben.

josh

Benjamin Herrenschmidt (2):
      [POWERPC] 4xx: Fix 4xx flush_tlb_page()
      [POWERPC] 4xx: Deal with 44x virtually tagged icache

Grant Likely (5):
      [POWERPC] bootwrapper: Allow wrapper script to execute verbosely
      [POWERPC] bootwrapper: Bail from script if any command fails
      [POWERPC] Device tree bindings for Xilinx devices
      [POWERPC] Uartlite: speed up console output
      [POWERPC] ppc405 Fix arithmatic rollover bug when memory size under 16M

Roel Kluin (1):
      [POWERPC] allocation fix in ppc/platforms/4xx/luan.c

Steven A. Falco (1):
      [POWERPC] 4xx: Fix Walnut DTS interrupt property

Valentine Barshak (1):
      [POWERPC] 4xx: Workaround for the 440EP(x)/GR(x) processors identical PVR 

 Documentation/powerpc/booting-without-of.txt |  261 ++++++++++++++++++++++++++
 arch/powerpc/boot/dts/walnut.dts             |    4 +-
 arch/powerpc/boot/wrapper                    |   32 ++--
 arch/powerpc/kernel/cputable.c               |   36 +++-
 arch/powerpc/kernel/entry_32.S               |   23 +++
 arch/powerpc/kernel/misc_32.S                |   32 +++-
 arch/powerpc/kernel/prom.c                   |   12 ++
 arch/powerpc/mm/40x_mmu.c                    |   17 +-
 arch/powerpc/mm/44x_mmu.c                    |    1 +
 arch/powerpc/mm/fault.c                      |    2 +-
 arch/powerpc/mm/mmu_decl.h                   |    4 +-
 arch/ppc/kernel/entry.S                      |   23 +++
 arch/ppc/kernel/misc.S                       |   31 +++-
 arch/ppc/mm/44x_mmu.c                        |    1 +
 arch/ppc/mm/4xx_mmu.c                        |   17 +-
 arch/ppc/mm/fault.c                          |    2 +-
 arch/ppc/mm/mmu_decl.h                       |    4 +-
 arch/ppc/platforms/4xx/ebony.c               |    2 +-
 arch/ppc/platforms/4xx/luan.c                |    7 +-
 arch/ppc/platforms/4xx/ocotea.c              |    2 +-
 arch/ppc/platforms/4xx/taishan.c             |    2 +-
 drivers/serial/uartlite.c                    |   10 +-
 include/asm-powerpc/pgtable-ppc32.h          |   13 ++
 include/asm-powerpc/tlbflush.h               |   12 +-
 24 files changed, 472 insertions(+), 78 deletions(-)
