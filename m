Return-Path: <clg@kaod.org>
Received: from 8.mo2.mail-out.ovh.net (8.mo2.mail-out.ovh.net [188.165.52.147])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wtcDW73BjzDr1m
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jun 2017 19:46:51 +1000 (AEST)
Received: from player796.ha.ovh.net (b6.ovh.net [213.186.33.56])
 by mo2.mail-out.ovh.net (Postfix) with ESMTP id 6BBC4944E6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jun 2017 11:30:11 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [RFC PATCH 0/2] guest exploitation of the XIVE interrupt controller
Date: Thu, 22 Jun 2017 11:29:15 +0200
Message-Id: <1498123757-18427-1-git-send-email-clg@kaod.org>
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

I am currently working on a XIVE model for the pseries QEMU machine
and I started hacking Linux to have something to test with. 

Here's a first draft of XIVE support for the guest. This is work in
progress, only tested with the QEMU XIVE model I am working
on. Feedback most welcome. 

Thanks,

C.

Cédric Le Goater (2):
  powerpc/xive: guest exploitation of the XIVE interrupt controller
  powerpc/xive: add XIVE exploitation mode to CAS

 arch/powerpc/include/asm/hvcall.h      |  13 +-
 arch/powerpc/include/asm/xive.h        |   1 +
 arch/powerpc/kernel/prom_init.c        |  15 +-
 arch/powerpc/platforms/pseries/Kconfig |   1 +
 arch/powerpc/platforms/pseries/setup.c |   8 +-
 arch/powerpc/platforms/pseries/smp.c   |  18 +-
 arch/powerpc/sysdev/xive/Kconfig       |   5 +
 arch/powerpc/sysdev/xive/Makefile      |   1 +
 arch/powerpc/sysdev/xive/xive-hv.c     | 523 +++++++++++++++++++++++++++++++++
 9 files changed, 580 insertions(+), 5 deletions(-)
 create mode 100644 arch/powerpc/sysdev/xive/xive-hv.c

-- 
2.7.5
