Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (vervifontaine.sonytel.be
	[80.88.33.193]) by ozlabs.org (Postfix) with ESMTP id 5A19DDDF4A
	for <linuxppc-dev@ozlabs.org>; Mon,  2 Mar 2009 20:54:18 +1100 (EST)
Date: Mon, 2 Mar 2009 10:54:14 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Richard Zidlicky <rz@linux-m68k.org>
Subject: Re: [rtc-linux] Re: [PATCH/RFC 0/5] Generic RTC class driver
In-Reply-To: <20090227185514.GA1071@linux-m68k.org>
Message-ID: <alpine.LRH.2.00.0903021051040.25117@vixen.sonytel.be>
References: <1235144809-32468-1-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<20090220170454.04382e9e@i1501.lan.towertech.it>
	<alpine.LRH.2.00.0902231319170.22762@vixen.sonytel.be>
	<1235511327.18632.73.camel@macbook.infradead.org>
	<20090224231154.60ba18d6@i1501.lan.towertech.it>
	<1235514727.18632.93.camel@macbook.infradead.org>
	<alpine.LRH.2.00.0902251059110.4063@vixen.sonytel.be>
	<20090225111836.621412c1@i1501.lan.towertech.it>
	<20090227185514.GA1071@linux-m68k.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=utf-8
Cc: Linux/m68k <linux-m68k@vger.kernel.org>,
	Alessandro Zummo <alessandro.zummo@towertech.it>,
	rtc-linux@googlegroups.com, linux-parisc@vger.kernel.org, David@ozlabs.org,
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

On Fri, 27 Feb 2009, Richard Zidlicky wrote:
> On Wed, Feb 25, 2009 at 11:18:36AM +0100, Alessandro Zummo wrote:
> > On Wed, 25 Feb 2009 11:00:13 +0100 (CET)
> > Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com> wrote:
> > 
> > > I didn't know NTP was broken with RTC class drivers?
> > > 
> > > So we should actually keep on using genrtc instead of rtc-ppc/rtc-generic for
> > > now? ;-)
> > 
> >  broken here means that the kernel won't save the time to the hardware
> >  rtc every 11 minutes as it used to do. normal NTP operations are unaffected.
> 
> seems like so far ppc is the only architecture attempting to implement it
> correctly, all others either have it unimplemented or use the broken
> by design set_rtc_mmss method. 
> Also note that in most cases hwclock has much better possibilities
> to do a good job.
> 
> Regarding genrtc vs rtc-ppc/rtc-generic it is worth noting that genrtc
> provides RTC_UIE emulation which is of some use for exotic programs like 
> "chrony".
> Afaics this is also the only situation without a good userspace workaround 
> and chrony never worked well for me so I have nothing against junking the 
> code.

What about CONFIG_RTC_INTF_DEV_UIE_EMUL for RTC class devices?

> Regarding a possible reorganisation from the generic to all separate drivers
> I agree that the habit of putting rtc-chip specific code in asm-generic is 
> confusing at best. 
> In many cases such code might be better placed in drivers/rtc or 
> include/linux/rtc/chipname.
> 
> Imho this does not preclude the possibility to use a generic framework. While
> there certainly are valid reasons to have separate drivers in some cases 
> I do not see much value in rewriting everything as separate drivers where 
> the generic framework works well.

Indeed. You can have a working RTC class driver for lots of hardware by just
writing ca. 100 lines of code on top of the generic framework.

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
