Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qwWzF6GsszDqHg
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Apr 2016 19:40:41 +1000 (AEST)
From: Arnd Bergmann <arnd@arndb.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 Helge Deller <deller@gmx.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Rich Felker <dalias@libc.org>,
 David Howells <dhowells@redhat.com>, alpha <linux-alpha@vger.kernel.org>,
 Alessandro Zummo <a.zummo@towertech.it>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Parisc List <linux-parisc@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Linux-sh list <linux-sh@vger.kernel.org>,
 linux-m68k <linux-m68k@lists.linux-m68k.org>,
 RTCLINUX <rtc-linux@googlegroups.com>, Linux-Arch <linux-arch@vger.kernel.org>
Subject: Re: [PATCH v3 13/16] char/genrtc: remove powerpc support
Date: Thu, 28 Apr 2016 11:39:56 +0200
Message-ID: <2182936.7ADRRgWoa5@wuerfel>
In-Reply-To: <CAMuHMdUhydMDeQ=ciVFgjBcjnCD_q2qU0F0gUP28U9=EcH2ZRQ@mail.gmail.com>
References: <1461796470-1291527-1-git-send-email-arnd@arndb.de>
 <1461796470-1291527-14-git-send-email-arnd@arndb.de>
 <CAMuHMdUhydMDeQ=ciVFgjBcjnCD_q2qU0F0gUP28U9=EcH2ZRQ@mail.gmail.com>
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

On Thursday 28 April 2016 09:25:25 Geert Uytterhoeven wrote:
> On Thu, Apr 28, 2016 at 12:34 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> > --- a/arch/powerpc/platforms/Kconfig
> > +++ b/arch/powerpc/platforms/Kconfig
> > @@ -321,6 +321,17 @@ config OF_RTC
> >           Uses information from the OF or flattened device tree to instantiate
> >           platform devices for direct mapped RTC chips like the DS1742 or DS1743.
> >
> > +config GEN_RTC
> > +       bool "Use the platform RTC operations from user space"
> > +       select RTC_CLASS
> > +       select RTC_DRV_GENERIC
> > +       help
> > +         This option provides backwards compatibility with the old gen_rtc.ko
> > +         module that was traditionally used for old PowerPC machines.
> > +         Platforms should migrate to enabling the RTC_DRV_GENERIC by hand
> > +         replacing changing their get_rtc_time/set_rtc_time callbacks with
> 
> Drop "changing".
> 
> 

done, thanks!

	Arnd
