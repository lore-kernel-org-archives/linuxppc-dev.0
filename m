Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qvc951PnZzDqBW
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Apr 2016 07:46:00 +1000 (AEST)
From: Arnd Bergmann <arnd@arndb.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: tony.luck@intel.com, geert@linux-m68k.org, jejb@parisc-linux.org,
 deller@gmx.de, benh@kernel.crashing.org, mpe@ellerman.id.au,
 dalias@libc.org, dhowells@redhat.com, yasutake.koichi@jp.panasonic.com,
 rth@twiddle.net, ink@jurassic.park.msu.ru, linux-alpha@vger.kernel.org,
 x86@kernel.org, a.zummo@towertech.it, alexandre.belloni@free-electrons.com,
 linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-sh@vger.kernel.org, rtc-linux@googlegroups.com,
 linux-arch@vger.kernel.org
Subject: char: legacy RTC cleanups
Date: Tue, 26 Apr 2016 23:44:04 +0200
Message-Id: <1461707052-1337718-1-git-send-email-arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I've had these patches in my tree for a while, after the first one
had a few issues that are fixed in this new version. The old-style
PC RTC driver is now also disabled on m68k (as pointed out by
Geert), ppc (it was also blacklisted), and m32r (I showed that
it did not build).

For the genrtc driver, rearranging the headers makes it simpler
to use and reduces duplication. In case of alpha and mn10300,
I've shown that the genrtc and rtc drivers are doing the same
thing, so we don't need them both. The remaining three
architectures (m68k, parisc, powerpc) actually all support
the newer rtc-generic driver, so we could remove genrtc completely
if we want to.

	Arnd
