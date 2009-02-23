Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (vervifontaine.sonytel.be
	[80.88.33.193]) by ozlabs.org (Postfix) with ESMTP id EE59ADDE2A
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Feb 2009 23:34:51 +1100 (EST)
Date: Mon, 23 Feb 2009 13:34:49 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Alessandro Zummo <alessandro.zummo@towertech.it>
Subject: Re: [rtc-linux] [PATCH/RFC 0/5] Generic RTC class driver
In-Reply-To: <20090220170454.04382e9e@i1501.lan.towertech.it>
Message-ID: <alpine.LRH.2.00.0902231319170.22762@vixen.sonytel.be>
References: <1235144809-32468-1-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<20090220170454.04382e9e@i1501.lan.towertech.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Cc: Richard Zidlicky <rz@linux-m68k.org>, rtc-linux@googlegroups.com,
	linux-parisc@vger.kernel.org, David@ozlabs.org,
	Linux Kernel Development <linux-kernel@vger.kernel.org>,
	Kyle McMartin <kyle@mcmartin.ca>,
	Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	Linux/m68k <linux-m68k@lists.linux-m68k.org>,
	Woodhouse <dwmw2@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 20 Feb 2009, Alessandro Zummo wrote:
> On Fri, 20 Feb 2009 16:46:44 +0100
> Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com> wrote:
> > Fortunately there already exists a generic RTC class driver: "rtc-parisc".
> > Despite it's name, it's platform-independent, as it's build on top of the RTC
> > abstraction used by "genrtc".
> > 
> > This patch series
> >   - adds a missing module alias to rtc-parisc,
> >   - renames rtc-parisc to rtc-generic,
> >   - converts the architectures that currently have CONFIG_GEN_RTC enabled in
> >     their defconfig (m68k, parisc, powerpc) to rtc-generic,
> >   - removes the obsolete rtc-ppc driver,
> >   - removes the old genrtc driver.
> >   
> > Note that genrtc may be used on other archictectures as well: at least alpha
> > has the required infrastructure ([gs]et_rtc_time()). The Kconfig rules allow
> > genrtc to be enabled on several others (cris, h8300, mn10300, um, x86, xtensa).
> > 
> > Furthermore genrtc and rtc-generic are not 100% userspace compatible:
> >   - /dev/rtc provided by genrtc uses a misc character device (10:135),
> >   - /dev/rtc provided by rtc-generic uses a dynamic character device.
> 
>  Hello,
> 
>    my opinion on this kind of stuff is that I want to avoid the layering
>  of implementations under the rtc subsystem. I'd rather prefer that each
>  rtc device had its own driver. 
>  
>   I've made error in the past, by accepting such kind of drivers, and
>  would like to avoid that it happens again.

So you want us to kill the ppc_md.[gs]et_rtc_time() [ppc], mach_hwclk() [m68k],
mach_gettod() [m68knommu] (and probably a few other) abstractions, and move all
RTC code out of arch/ into seperate drivers under drivers/rtc/ instead?

What about ppc_md.get_boot_time() [ppc]?
Please note that the functions above may also be used for very early clock
setting (e.g. time_init()) and in read_persistent_clock().
How should we handle these?

Even on x86 there seems to be way too much RTC logic in arch/x86/kernel/rtc.c
(e.g. mach_get_cmos_time()), which is duplicated in drivers/rtc/rtc-cmos.c
through the inline function __get_rtc_time() in include/asm-generic/rtc.h
(clever, hardware-specific stuff in asm-generic ;-)

>   Regarding the user space, the assumption that a device has
>  a fixed major:minor number should be dropped as well.

I know. But it's a userland-visible change, so I wanted to explicit point to
it.

With kind regards,

Geert Uytterhoeven
Software Architect

Sony Techsoft Centre Europe
The Corporate Village · Da Vincilaan 7-D1 · B-1935 Zaventem · Belgium

Phone:    +32 (0)2 700 8453
Fax:      +32 (0)2 700 8622
E-mail:   Geert.Uytterhoeven@sonycom.com
Internet: http://www.sony-europe.com/

A division of Sony Europe (Belgium) N.V.
VAT BE 0413.825.160 · RPR Brussels
Fortis · BIC GEBABEBB · IBAN BE41293037680010
