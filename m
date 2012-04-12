Return-Path: <glikely@secretlab.ca>
Received: from mail-ob0-f179.google.com (mail-ob0-f179.google.com
 [209.85.214.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CE6B7B702D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Apr 2012 16:43:28 +1000 (EST)
Received: by obbef5 with SMTP id ef5so2429643obb.38
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Apr 2012 23:43:25 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 12 Apr 2012 00:43:04 -0600
Message-ID: <CACxGe6uNFv3djyvZCKsPG4Ret=FWPKQ2QivZbUVYM9g6vLvg2A@mail.gmail.com>
Subject: [GIT PULL] irq_domain bug fixes against v3.4-rc2
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Linus,

Here are the irq_domain bug fixes that need to be merged into v3.4.
This branch fixes PowerPC and MIPS boot failures.  Please pull.

g.

The following changes since commit 0034102808e0dbbf3a2394b82b1bb40b5778de9e:

  Linux 3.4-rc2 (2012-04-07 18:30:41 -0700)

are available in the git repository at:

  git://git.secretlab.ca/git/linux-2.6 tags/irqdomain-for-linus

for you to fetch changes up to 6fa6c8e25e95bdc73e92e4c96b8e3299169b616e:

  irq_domain: Move irq_virq_count into NOMAP revmap (2012-04-12 00:37:48 -0600)

----------------------------------------------------------------
irqdomain bug fixes for v3.4-rc3

This branch fixes a bug in irq_create_mapping() where an error return
from irq_alloc_desc_from() gets ignored.  It also removes irq_virq_count
to fix a bug on powerpc where the irqdomain code does not find irqs
allocated above the CONFIG_NR_IRQS boundary.  The remaining patches get
rid of an completely pointless export and fix some minor bugs in the
irqdomain debug output.

----------------------------------------------------------------
David Daney (1):
      irq/irq_domain: Quit ignoring error returns from irq_alloc_desc_from().

Grant Likely (3):
      irq: Kill pointless irqd_to_hw export
      irqdomain: Fix debugfs formatting
      irq_domain: Move irq_virq_count into NOMAP revmap

Mika Westerberg (1):
      irq_domain: correct the debugfs file name

 arch/c6x/include/asm/irq.h                   |    4 --
 arch/c6x/kernel/irq.c                        |   13 -------
 arch/powerpc/include/asm/irq.h               |    2 -
 arch/powerpc/kernel/irq.c                    |    6 ---
 arch/powerpc/platforms/cell/axon_msi.c       |    2 +-
 arch/powerpc/platforms/cell/beat_interrupt.c |    2 +-
 arch/powerpc/platforms/powermac/smp.c        |    2 +-
 arch/powerpc/platforms/ps3/interrupt.c       |    3 +-
 include/linux/irq.h                          |    5 +++
 include/linux/irqdomain.h                    |   12 ++----
 include/linux/types.h                        |    6 +++
 kernel/irq/Kconfig                           |    2 +-
 kernel/irq/irqdomain.c                       |   46 +++++++++-----------------
 13 files changed, 36 insertions(+), 69 deletions(-)


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
