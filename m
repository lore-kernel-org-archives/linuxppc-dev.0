Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (vervifontaine.sonytel.be
	[80.88.33.193]) by ozlabs.org (Postfix) with ESMTP id EED05DDF03
	for <linuxppc-dev@ozlabs.org>; Mon,  2 Mar 2009 21:28:03 +1100 (EST)
Date: Mon, 2 Mar 2009 11:28:01 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Alessandro Zummo <alessandro.zummo@towertech.it>
Subject: Re: [rtc-linux] Re: [PATCH/RFC 0/5] Generic RTC class driver
In-Reply-To: <20090302110310.35af50ea@i1501.lan.towertech.it>
Message-ID: <alpine.LRH.2.00.0903021116450.25117@vixen.sonytel.be>
References: <1235144809-32468-1-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<20090220170454.04382e9e@i1501.lan.towertech.it>
	<alpine.LRH.2.00.0902231319170.22762@vixen.sonytel.be>
	<1235511327.18632.73.camel@macbook.infradead.org>
	<20090224231154.60ba18d6@i1501.lan.towertech.it>
	<1235514727.18632.93.camel@macbook.infradead.org>
	<alpine.LRH.2.00.0902251059110.4063@vixen.sonytel.be>
	<20090225111836.621412c1@i1501.lan.towertech.it>
	<20090227185514.GA1071@linux-m68k.org>
	<alpine.LRH.2.00.0903021051040.25117@vixen.sonytel.be>
	<20090302110310.35af50ea@i1501.lan.towertech.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Cc: Linux/m68k <linux-m68k@vger.kernel.org>,
	Richard Zidlicky <rz@linux-m68k.org>, rtc-linux@googlegroups.com,
	linux-parisc@vger.kernel.org, David@ozlabs.org,
	Linux Kernel Development <linux-kernel@vger.kernel.org>,
	Kyle McMartin <kyle@mcmartin.ca>,
	Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	David Woodhouse <dwmw2@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2 Mar 2009, Alessandro Zummo wrote:
> On Mon, 2 Mar 2009 10:54:14 +0100 (CET)
> Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com> wrote:
> > Indeed. You can have a working RTC class driver for lots of hardware by just
> > writing ca. 100 lines of code on top of the generic framework.
> 
>  That's true, but we would then have two generic frameworks. And one
>  of them will have its code scattered all around the kernel.
> 
>  So you either use the old rtc framework, which is perfectly functional,
>  or you move to the new rtc lass and write the drivers.

So I can solve my problem (autoloading the RTC driver on PS3 by udev) by
converting the old genrtc driver into a platform device driver and creating
platform devices where appropriate.

However, this doesn't solve the distro's problem: as the old RTC framework
depends on RTC_LIB=n, you cannot have both old and new RTC drivers in your
(single) distro kernel. That's why dmwm2 created drivers/rtc/rtc-ppc.c: Fedora
had to support machines with both old and new RTC drivers. As all of the old
drivers are actually behind the ppc_md.[sg]et_rtc_time() abstraction, this was
very easy.

Hence it's all or nothing, and we have to convert all of them.

drivers/rtc/rtc-generic.c would allow to have a working system without old
RTC drivers, until all low-level code has been converted to individual RTC
drivers.

>  Layering a generic framework over another generic framework
>  is quite a nonsense . 

IMHO these two generic frameworks are quite different: [sg]et_rtc_time()
abstracts the low-level RTC hardware interface, while RTC class handles the
interaction with userspace.

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
