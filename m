Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qvyTR2x2tzDq5s
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Apr 2016 21:31:23 +1000 (AEST)
From: Arnd Bergmann <arnd@arndb.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Tony Luck <tony.luck@intel.com>,
 "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Rich Felker <dalias@libc.org>,
 David Howells <dhowells@redhat.com>,
 Koichi Yasutake <yasutake.koichi@jp.panasonic.com>,
 Richard Henderson <rth@twiddle.net>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
 alpha <linux-alpha@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>,
 Alessandro Zummo <a.zummo@towertech.it>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
 Parisc List <linux-parisc@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Linux-sh list <linux-sh@vger.kernel.org>,
 RTCLINUX <rtc-linux@googlegroups.com>, Linux-Arch <linux-arch@vger.kernel.org>
Subject: Re: char: legacy RTC cleanups
Date: Wed, 27 Apr 2016 13:30:05 +0200
Message-ID: <13390963.BOLfm8tOYx@wuerfel>
In-Reply-To: <CAMuHMdW6AODmVwB59uTvMydbTNiDDxQWB3p-Dp9Dka+GVyP_iw@mail.gmail.com>
References: <1461707052-1337718-1-git-send-email-arnd@arndb.de>
 <4937900.aITlOE9vLo@wuerfel>
 <CAMuHMdW6AODmVwB59uTvMydbTNiDDxQWB3p-Dp9Dka+GVyP_iw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wednesday 27 April 2016 12:19:59 Geert Uytterhoeven wrote:
> >
> > Right, so we could skip patches 5 and 6, and instead remove the two
> > headers as we remove the driver. Let's see what the architecture
> > maintainers think about it, at least powerpc actually enables gen_rtc
> > in its defconfig, so it might take a while to move it over.
> 
> FWIW, all PPC defconfigs (except tqm8xx.dts, which is a more recent platform)
> enabling it did that long before my old commit to enable rtc-generic support
> on PPC:
> 
> commit bcd68a70cb0eee556d86d93133aa150319bd9f53
> Author: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
> Date:   Thu Feb 19 16:50:46 2009 +0100
> 
>     powerpc: Hook up rtc-generic, and kill rtc-ppc

Ah, interesting. I have two observations about that patch:

- you were moving basically in the opposite direction that I am
  trying to bring it now. ;-)

- I see now that four defconfigs (gamecube, powernv, pseries and wii)
  do enable RTC_DRV_GENERIC. For some reason, ppc64_defconfig only
  enables RTC_DRV_DS1307, I assume that is not intentional.

	Arnd
