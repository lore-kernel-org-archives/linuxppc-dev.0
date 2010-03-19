Return-Path: <Ian.Campbell@eu.citrix.com>
Received: from SMTP.CITRIX.COM (smtp.citrix.com [66.165.176.89])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "*.citrix.com",
	Issuer "VeriSign Class 3 Secure Server CA - G2" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id D4EF3B7CB6
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Mar 2010 22:27:19 +1100 (EST)
Subject: [GITPULL+PATCH 0/2 v3] irq: move some interrupt arch_* functions
	into struct irq_chip.
From: Ian Campbell <Ian.Campbell@citrix.com>
To: <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 19 Mar 2010 11:27:12 +0000
Message-ID: <1268998032.10129.44653.camel@zakaz.uk.xensource.com>
MIME-Version: 1.0
Cc: Jeremy Fitzhardinge <jeremy@goop.org>,
	Ian Campbell <Ian.Campbell@citrix.com>,
	Paul Mundt <lethal@linux-sh.org>, linux-sh@vger.kernel.org,
	"x86@kernel.org" <x86@kernel.org>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>,
	"H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>,
	Yinghai Lu <yinghai@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This small series ensures that struct irq_desc->chip_data is available
for alternative irq_chip implementations.

Since v2: pass x86_init_chip_data as a argument to
irq_to_desc_alloc_node instead of calling in the arch code in order to
get correct locking wrt the core code. Small impact on the SH arch code
which is the only other user outside x86 and powerpc.

Since v1: dropped the renaming portion of the series since it
was basically wrong, the functions I'd implicated as ioapic specific are
not at all.

Ian.

The following changes since commit 1ebbdcc83e75697c0d75eb091df172b7d93c84c1:
  Ingo Molnar (1):
        Merge branch 'perf/urgent'

are available in the git repository at:

  git://xenbits.xensource.com/people/ianc/linux-2.6.git for-x86/irq

Ian Campbell (2):
      irq: move some interrupt arch_* functions into struct irq_chip.
      x86: irq_desc->chip_data is always correct whether or not SPARSE_IRQ is enabled.

 arch/powerpc/kernel/irq.c      |    4 +-
 arch/sh/kernel/cpu/irq/ipr.c   |    2 +-
 arch/x86/include/asm/hw_irq.h  |   11 ++++++-
 arch/x86/kernel/apic/io_apic.c |   67 ++++++++++++++++++++++++++++++++--------
 arch/x86/kernel/uv_irq.c       |    5 +++
 arch/x86/lguest/boot.c         |    2 +-
 drivers/sh/intc.c              |    7 ++--
 drivers/xen/events.c           |    2 +-
 include/linux/interrupt.h      |    2 +-
 include/linux/irq.h            |   16 ++++++---
 kernel/irq/handle.c            |   15 ++++++---
 kernel/irq/numa_migrate.c      |   12 ++++++-
 kernel/softirq.c               |    3 +-
 13 files changed, 111 insertions(+), 37 deletions(-)
