Return-Path: <glikely@secretlab.ca>
Received: from mail-yw0-f203.google.com (mail-yw0-f203.google.com
	[209.85.211.203]) by ozlabs.org (Postfix) with ESMTP id EE81AB7D1D
	for <linuxppc-dev@ozlabs.org>; Sat,  5 Jun 2010 07:25:16 +1000 (EST)
Received: by ywh41 with SMTP id 41so1656880ywh.9
	for <linuxppc-dev@ozlabs.org>; Fri, 04 Jun 2010 14:25:14 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 4 Jun 2010 15:24:54 -0600
Message-ID: <AANLkTil1-afn4-qCEAza53taNamu-agigv09VSdyB0sB@mail.gmail.com>
Subject: [PATCH 0/5] Consolidate OF IRQ handling code
To: Grant Likely <grant.likely@secretlab.ca>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Michal Simek <monstr@monstr.eu>,
	devicetree-discuss@lists.ozlabs.org, linuxppc-dev@ozlabs.org,
	microblaze-uclinux@itee.uq.edu.au, sparclinux@vger.kernel.org,
	Jeremy Kerr <jeremy.kerr@canonical.com>,
	"David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This series merges the common IRQ handling code between Microblaze and Powerpc.

I'll be adding these patches to linux-next next week unless there are
objections.

Cheers,
g.

Grant Likely (5):
      of/irq: Move irq_of_parse_and_map() to common code
      of/microblaze: strip out of_irq_workarounds code
      of/irq: merge of_irq_find_parent()
      of/irq: Merge of_irq_map_raw()
      of/irq: merge of_irq_map_one()

 arch/microblaze/include/asm/irq.h   |   13 --
 arch/microblaze/include/asm/prom.h  |   63 +-------
 arch/microblaze/kernel/irq.c        |   14 +--
 arch/microblaze/kernel/prom_parse.c |  321 +---------------------------------
 arch/powerpc/include/asm/irq.h      |   13 --
 arch/powerpc/include/asm/prom.h     |   51 +-----
 arch/powerpc/kernel/irq.c           |   14 +--
 arch/powerpc/kernel/prom_parse.c    |  254 +--------------------------
 arch/sparc/include/asm/prom.h       |    1 -
 drivers/of/Kconfig                  |    4 +
 drivers/of/Makefile                 |    1 +
 drivers/of/irq.c                    |  336 +++++++++++++++++++++++++++++++++++
 drivers/of/of_mdio.c                |    1 +
 include/linux/of_irq.h              |   49 +++++
 14 files changed, 405 insertions(+), 730 deletions(-)
 create mode 100644 drivers/of/irq.c
 create mode 100644 include/linux/of_irq.h
