Return-Path: <Johannes.Thumshirn@men.de>
Received: from mail1.bemta14.messagelabs.com (mail1.bemta14.messagelabs.com
 [193.109.254.111])
 (using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CE0BC1A050D
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Nov 2014 03:19:07 +1100 (AEDT)
From: Johannes Thumshirn <johannes.thumshirn@men.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Scott Wood
 <scottwood@freescale.com>, Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 0/2] Support multiple MSI interrupts on FSL-MPIC
Date: Mon, 3 Nov 2014 17:18:32 +0100
Message-ID: <1415031514-27284-1-git-send-email-johannes.thumshirn@men.de>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Johannes Thumshirn <johannes.thumshirn@men.de>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This series adds support for multiple MSI interrupts on FSL's MPIC.  The patch
series was originally done by Sebastian Andrzej Siewior <bigeasy@linutronix.de>
and re-applied and tested by me.

I dodn't know whether it is OK to put my name on it or not. So if Sebastian has
a problem with it I'll of cause change it immediately. It was just convenient to
use my name in the git commit but I don't want to do any kind of copyright
infrigement.

Johannes Thumshirn (2):
  irqdomain: add support for creating a continous mapping
  powerpc: msi: fsl: add support for multiple MSI interrupts

 arch/powerpc/kernel/msi.c              |  4 --
 arch/powerpc/platforms/cell/axon_msi.c |  3 ++
 arch/powerpc/platforms/powernv/pci.c   |  3 ++
 arch/powerpc/platforms/pseries/msi.c   |  3 ++
 arch/powerpc/sysdev/fsl_msi.c          | 22 ++++++---
 arch/powerpc/sysdev/mpic_pasemi_msi.c  |  3 ++
 arch/powerpc/sysdev/mpic_u3msi.c       |  3 ++
 arch/powerpc/sysdev/ppc4xx_msi.c       |  2 +
 include/linux/irqdomain.h              | 10 +++-
 kernel/irq/irqdomain.c                 | 85 ++++++++++++++++++++++++++--------
 10 files changed, 106 insertions(+), 32 deletions(-)

--
1.9.1
