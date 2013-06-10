Return-Path: <glikely@secretlab.ca>
Received: from mail-ea0-x232.google.com (mail-ea0-x232.google.com
 [IPv6:2a00:1450:4013:c01::232])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 10F732C00AF
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Jun 2013 10:49:33 +1000 (EST)
Received: by mail-ea0-f178.google.com with SMTP id l15so2845486eak.37
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 09 Jun 2013 17:49:28 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@linaro.org>
To: linux-kernel@vger.kernel.org
Subject: [RFC 00/10] Refactor irqdomain
Date: Mon, 10 Jun 2013 01:49:12 +0100
Message-Id: <1370825362-11145-1-git-send-email-grant.likely@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org,
 Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I've done a bunch of refactoring work on the irq_domain infrastructure.
Some of these patches I've posted before, and some our brand new. The
goal of this is to greatly simplify how irq_domains work. With this
series, instead of there being multiple different types of irq domains,
each with different mapping rules, instead there is now only one time of
irq_domain that contains both kinds of map; the linear map for irqs
below a certain value, and the radix tree for large & sparse irq
controllers. As you can see from the following diffstat, the result is a
fair bit less code. It should make it easier to understand irqdomains
too.

 arch/powerpc/platforms/cell/beat_interrupt.c |   2 +-
 arch/powerpc/platforms/powermac/smp.c        |   2 +-
 drivers/irqchip/Kconfig                      |   1 +
 drivers/irqchip/irq-versatile-fpga.c         | 104 ++++------
 include/linux/irqdomain.h                    | 123 ++++++-----
 kernel/irq/generic-chip.c                    |   6 +-
 kernel/irq/irqdomain.c                       | 555
 ++++++++++++++++----------------------------------
 7 files changed, 282 insertions(+), 511 deletions(-)

I've pushed this series out to my git server at the following branch:

git://git.secretlab.ca/git/linux irqdomain/next

It depends on the tip tree's irq/for-arm branch and also Linus' mainline
(they need to be merged). The branch above includes both.

I've tested this on ARM qemu models, but not much else. I'll test on
real hardware before pushing out, but I would appreciate anybody doing
additional testing, particularly on PowerPC and other non-ARM platforms.

Cheers,
g.
