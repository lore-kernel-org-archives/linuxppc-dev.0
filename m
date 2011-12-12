Return-Path: <glikely@secretlab.ca>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
 [209.85.212.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 6CF4B1007D3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Dec 2011 07:14:24 +1100 (EST)
Received: by vbbfp1 with SMTP id fp1so4183008vbb.38
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Dec 2011 12:14:20 -0800 (PST)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 devicetree-discuss@lists.olzabs.org
Subject: Rework gpio phandle parsing
Date: Mon, 12 Dec 2011 13:14:08 -0700
Message-Id: <1323720852-26311-1-git-send-email-grant.likely@secretlab.ca>
Cc: microblaze-uclinux@itee.uq.edu.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I originally posted this as part of the DT clock bindings.  I'm reposting
now since I've fixed up some bugs and I'm planning to put them into
linux-next.

The DT clock binding patches will be posted separately.

Cheers,
g.


 arch/arm/boot/dts/testcases/tests-phandle.dtsi |   37 ++++++
 arch/arm/boot/dts/testcases/tests.dtsi         |    1 +
 arch/arm/boot/dts/versatile-pb.dts             |    2 +
 arch/microblaze/kernel/reset.c                 |   43 +-------
 arch/powerpc/sysdev/qe_lib/gpio.c              |   42 ++------
 drivers/gpio/gpiolib.c                         |    2 +-
 drivers/of/Kconfig                             |    9 ++
 drivers/of/Makefile                            |    1 +
 drivers/of/base.c                              |  146 ++++++++++++------------
 drivers/of/gpio.c                              |   43 +++----
 drivers/of/selftest.c                          |  139 ++++++++++++++++++++++
 include/asm-generic/gpio.h                     |    6 +-
 include/linux/of.h                             |   11 ++-
 include/linux/of_gpio.h                        |   10 +-
 14 files changed, 313 insertions(+), 179 deletions(-)
