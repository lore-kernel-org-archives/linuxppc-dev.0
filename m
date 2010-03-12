Return-Path: <Ian.Campbell@eu.citrix.com>
Received: from SMTP02.CITRIX.COM (smtp02.citrix.com [66.165.176.63])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "*.citrix.com",
	Issuer "VeriSign Class 3 Secure Server CA - G2" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 986D5B7D46
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Mar 2010 20:44:57 +1100 (EST)
Subject: [GITPULL+PATCH 0/2] irq: move some interrupt arch_* functions into
	struct irq_chip.
From: Ian Campbell <Ian.Campbell@citrix.com>
To: <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 12 Mar 2010 09:44:51 +0000
Message-ID: <1268387091.10129.5973.camel@zakaz.uk.xensource.com>
MIME-Version: 1.0
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, "x86@kernel.org" <x86@kernel.org>,
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

There is an outstanding issue wrt when/how the chip_data field is
initialised. I am continuing to investigate this but the solution is not
turning out as easy/low-impact as expected.

Since last time I've dropped the renaming portion of the series since it
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

 arch/powerpc/kernel/irq.c      |    2 +-
 arch/x86/include/asm/hw_irq.h  |   11 ++++++-
 arch/x86/kernel/apic/io_apic.c |   61 ++++++++++++++++++++++++++++++++++-----
 arch/x86/kernel/uv_irq.c       |    5 +++
 include/linux/interrupt.h      |    2 +-
 include/linux/irq.h            |   12 +++++--
 kernel/irq/handle.c            |    2 +-
 kernel/irq/numa_migrate.c      |   12 ++++++-
 kernel/softirq.c               |    3 +-
 9 files changed, 90 insertions(+), 20 deletions(-)
