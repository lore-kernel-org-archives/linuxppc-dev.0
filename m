Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40qyzX1Gc8zDqgs
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 May 2018 00:42:32 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: greg@kroah.com
Cc: stable@vger.kernel.org,
	tglx@linutronix.de,
	linuxppc-dev@ozlabs.org
Subject: [PATCH stable 4.16 00/14] powerpc backports for 4.16
Date: Wed, 23 May 2018 00:41:11 +1000
Message-Id: <20180522144125.10345-1-mpe@ellerman.id.au>
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

Hi Greg,

Please queue up this series of patches for 4.16 if you have no objections.

These are mostly clean backports but one or two required some fixing up, hench
the backport.

cheers

Mauricio Faria de Oliveira (2):
  powerpc/pseries: Fix clearing of security feature flags
  powerpc: Move default security feature flags

Michael Ellerman (11):
  powerpc/rfi-flush: Always enable fallback flush on pseries
  powerpc: Add security feature flags for Spectre/Meltdown
  powerpc/pseries: Add new H_GET_CPU_CHARACTERISTICS flags
  powerpc/pseries: Set or clear security feature flags
  powerpc/powernv: Set or clear security feature flags
  powerpc/64s: Move cpu_show_meltdown()
  powerpc/64s: Enhance the information in cpu_show_meltdown()
  powerpc/powernv: Use the security flags in pnv_setup_rfi_flush()
  powerpc/pseries: Use the security flags in pseries_setup_rfi_flush()
  powerpc/64s: Wire up cpu_show_spectre_v1()
  powerpc/64s: Wire up cpu_show_spectre_v2()

Nicholas Piggin (1):
  powerpc/64s: Add support for a store forwarding barrier at kernel
    entry/exit

 arch/powerpc/include/asm/exception-64s.h     |  29 ++++
 arch/powerpc/include/asm/feature-fixups.h    |  19 +++
 arch/powerpc/include/asm/hvcall.h            |   3 +
 arch/powerpc/include/asm/security_features.h |  85 ++++++++++
 arch/powerpc/kernel/Makefile                 |   2 +-
 arch/powerpc/kernel/exceptions-64s.S         |  19 ++-
 arch/powerpc/kernel/security.c               | 237 +++++++++++++++++++++++++++
 arch/powerpc/kernel/setup_64.c               |   8 -
 arch/powerpc/kernel/vmlinux.lds.S            |  14 ++
 arch/powerpc/lib/feature-fixups.c            | 115 +++++++++++++
 arch/powerpc/platforms/powernv/setup.c       |  96 +++++++----
 arch/powerpc/platforms/pseries/setup.c       |  71 +++++---
 12 files changed, 638 insertions(+), 60 deletions(-)
 create mode 100644 arch/powerpc/include/asm/security_features.h
 create mode 100644 arch/powerpc/kernel/security.c

-- 
2.14.1
