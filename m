Return-Path: <bhelgaas@google.com>
Received: from mail-gg0-f201.google.com (mail-gg0-f201.google.com
 [209.85.161.201])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B1AFCB6FBD
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 May 2012 08:36:58 +1000 (EST)
Received: by ggmi2 with SMTP id i2so950700ggm.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 May 2012 15:36:56 -0700 (PDT)
Subject: [PATCH v3 0/2] archdata init in device_add() notifier
To: Hiroo Matsumoto <matsumoto.hiroo@jp.fujitsu.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 23 May 2012 16:36:55 -0600
Message-ID: <20120523222635.24276.80023.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Michal Simek <monstr@monstr.eu>, microblaze-uclinux@itee.uq.edu.au,
 Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
 Jesse Larrew <jlarrew@linux.vnet.ibm.com>, jbarnes@virtuousgeek.org,
 linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Here's what I put in my "for-3.6" branch for now.  We can still change
it, so let me know if you see any problems.

I reworked the changelogs, changed the notification function name per
Jesse, folded the one-line pcibios_setup_bus_notifier() into the only
caller (on microblaze), and changed it from __devinit to __init (on
powerpc) since it now has nothing to do with hotplug.

Thank you very much for doing this work, Matsumoto-san.  I hope to
eventually get rid of pcibios_fixup_bus() altogether, and this is a
significant step in that direction.

Bjorn
---

Hiroo Matsumoto (2):
      powerpc/PCI: move DMA & IRQ init to device_add() notification path
      microblaze/PCI: move DMA & IRQ init to device_add() notification path


 arch/microblaze/include/asm/pci.h          |    1 
 arch/microblaze/pci/pci-common.c           |   62 +++++++++++---------
 arch/powerpc/include/asm/pci.h             |    2 -
 arch/powerpc/kernel/pci-common.c           |   87 ++++++++++++++--------------
 arch/powerpc/kernel/pci_32.c               |    2 +
 arch/powerpc/kernel/pci_64.c               |    2 +
 arch/powerpc/kernel/pci_of_scan.c          |    1 
 arch/powerpc/platforms/pseries/pci_dlpar.c |    1 
 drivers/pci/pci.c                          |    5 --
 drivers/pcmcia/cardbus.c                   |    3 -
 include/linux/pci.h                        |    3 -
 11 files changed, 83 insertions(+), 86 deletions(-)
