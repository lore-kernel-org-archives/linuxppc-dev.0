Return-Path: <helgaas@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rQYWL0blwzDqGs
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jun 2016 04:20:13 +1000 (AEST)
Subject: [PATCH v1 0/3] PCI: Clean up write combining usage for user mmap
To: Yinghai Lu <yinghai@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michal Simek <monstr@monstr.eu>, Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Date: Thu, 09 Jun 2016 13:20:08 -0500
Message-ID: <20160609181102.13455.33593.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

These patches:

  - Enforce a "no write combining on I/O port space mapping" policy.
    This seems like an obviously good thing but was previously
    enforced only by powerpc.

  - Stop giving powerpc users write combining mappings of prefetchable
    memory they ask for write combining with the procfs
    PCIIOC_WRITE_COMBINE ioctl or a sysfs "resourceN_wc" file.

  - Clean up arch-specific code that related to the above.

Ben, I'm particularly interested in your thoughts about the powerpc
change.  It should "only" affect performance of users who aren't
actually requesting write combining.  I don't know how many of those
users there might be.

Yinghai, I added your sign-off to the powerpc part, since you posted
that exact patch.  Let me know if you don't want that.

These are on my pci/resource branch.

---

Bjorn Helgaas (2):
      PCI: Ignore write combining when mapping I/O port space
      microblaze/PCI: Remove useless __pci_mmap_set_pgprot()

Yinghai Lu (1):
      powerpc/pci: Remove __pci_mmap_set_pgprot()


 arch/microblaze/pci/pci-common.c |   31 +------------------------------
 arch/powerpc/kernel/pci-common.c |   37 ++++---------------------------------
 drivers/pci/proc.c               |    9 ++++++---
 3 files changed, 11 insertions(+), 66 deletions(-)
