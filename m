Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qvcRx675yzDrPx
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Apr 2016 07:58:53 +1000 (AEST)
From: Arnd Bergmann <arnd@arndb.de>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: geert@linux-m68k.org, deller@gmx.de, benh@kernel.crashing.org,
 mpe@ellerman.id.au, dalias@libc.org, dhowells@redhat.com,
 linux-alpha@vger.kernel.org, a.zummo@towertech.it,
 linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, rtc-linux@googlegroups.com,
 linux-arch@vger.kernel.org
Subject: [PATCH v2 0/6] simplify rtc-generic driver
Date: Tue, 26 Apr 2016 23:52:25 +0200
Message-Id: <1461707551-1337971-1-git-send-email-arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a resend of an earlier series, to clean up the rtc-generic
driver by avoiding the dependency on the architecture specific
include/asm/rtc.h header that after this series is only used
for the deprecated "genrtc" driver. As I've shown in another
series, only three architectures (m68k, powerpc, parisc)
actually use the genrtc driver, and they all support rtc-generic
as a replacement as well.

The only missing piece appears to be the ioctl support for
the m68k q40 machine that I'm adding in patch 2 here.

	Arnd
