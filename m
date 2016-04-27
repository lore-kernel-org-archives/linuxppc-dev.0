Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qvtYK20NszDq5s
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Apr 2016 18:34:28 +1000 (AEST)
From: Arnd Bergmann <arnd@arndb.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
 Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
 Parisc List <linux-parisc@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Linux-sh list <linux-sh@vger.kernel.org>,
 RTCLINUX <rtc-linux@googlegroups.com>, Linux-Arch <linux-arch@vger.kernel.org>
Subject: Re: char: legacy RTC cleanups
Date: Wed, 27 Apr 2016 10:33:04 +0200
Message-ID: <6883809.SRgmlLMdyd@wuerfel>
In-Reply-To: <CAMuHMdV=R3ad33vPdMZNvZZ8A_DF+F2C8nyAmXOmFiiP50D_UQ@mail.gmail.com>
References: <1461707052-1337718-1-git-send-email-arnd@arndb.de>
 <CAMuHMdV=R3ad33vPdMZNvZZ8A_DF+F2C8nyAmXOmFiiP50D_UQ@mail.gmail.com>
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

On Wednesday 27 April 2016 09:54:41 Geert Uytterhoeven wrote:
> Hi Arnd,
> 
> On Tue, Apr 26, 2016 at 11:44 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > For the genrtc driver, rearranging the headers makes it simpler
> > to use and reduces duplication. In case of alpha and mn10300,
> > I've shown that the genrtc and rtc drivers are doing the same
> > thing, so we don't need them both. The remaining three
> > architectures (m68k, parisc, powerpc) actually all support
> > the newer rtc-generic driver, so we could remove genrtc completely
> > if we want to.
> 
> CONFIG_GEN_RTC is not enabled in any of the m68k defconfigs, so I think genrtc
> has been unused for a while.
> All defconfigs either use CONFIG_RTC_DRV_GENERIC, or enable a more specific
> RTC driver.

Ok, good to know. I'm guessing the same is true for parisc, but there are
also very few users.

Regarding the Q40 specific ioctls, what do you think this means, is it

a) nobody uses Q40 with modern kernels,
b) nobody calls RTC_PLL_GET/RTC_PLL_SET on q40, or
c) Q40 users have their own configurations and enable GEN_RTC?

On powerpc, a quarter of the defconfigs (mostly for really old hardware)
still use GEN_RTC, but I guess we can either bulk-convert them to RTC_GENERIC,
or convert the five implementations of .get_rtc_time/.set_rtc_time
(8xx, rtas, chrp, powermac, maple) into five regular RTC class drivers.

	Arnd
