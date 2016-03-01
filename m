Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AD98F1A06C2
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Mar 2016 04:00:58 +1100 (AEDT)
From: Arnd Bergmann <arnd@arndb.de>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: linux-arm-kernel@lists.infradead.org, Kyle McMartin <kyle@mcmartin.ca>,
 rtc-linux@googlegroups.com, Alessandro Zummo <a.zummo@towertech.it>,
 linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
 linux-parisc@vger.kernel.org, linux-m68k@lists.linux-m68k.org
Subject: [PATCH 0/6] rtc: generic: follow up for COMPILE_TEST
Date: Tue,  1 Mar 2016 17:59:56 +0100
Message-Id: <1456851608-3374907-1-git-send-email-arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Today's linux-next kernel allowed building the rtc-generic
driver (and most other rtc drivers) on all architectures,
but this caused some errors on architectures without asm/rtc.h.

This series reworks that driver to avoid the dependency,
and simplifies all four implementations. My first approach
was to split the driver into four separate drivers, but
that didn't feel right when three of them have their own
multiplexors.

The first five patches can be applied independent of one other,
while patch 6 is optional and can be applied when all others
are merged. Alternatively, they can all go in through the
rtc tree. I compile-tested only the powerpc and sh targets for
which I happened to have cross-compilers installed.

	Arnd
