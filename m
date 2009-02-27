Return-Path: <rdzidlic@googlemail.com>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.153])
	by ozlabs.org (Postfix) with ESMTP id 65596DDD0B
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Feb 2009 08:58:53 +1100 (EST)
Received: by fg-out-1718.google.com with SMTP id l26so720234fgb.39
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Feb 2009 13:58:50 -0800 (PST)
Sender: Richard Zidlicky <rdzidlic@googlemail.com>
Date: Fri, 27 Feb 2009 19:55:14 +0100
From: Richard Zidlicky <rz@linux-m68k.org>
To: Alessandro Zummo <alessandro.zummo@towertech.it>
Subject: Re: [rtc-linux] Re: [PATCH/RFC 0/5] Generic RTC class driver
Message-ID: <20090227185514.GA1071@linux-m68k.org>
References: <1235144809-32468-1-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<20090220170454.04382e9e@i1501.lan.towertech.it>
	<alpine.LRH.2.00.0902231319170.22762@vixen.sonytel.be>
	<1235511327.18632.73.camel@macbook.infradead.org>
	<20090224231154.60ba18d6@i1501.lan.towertech.it>
	<1235514727.18632.93.camel@macbook.infradead.org>
	<alpine.LRH.2.00.0902251059110.4063@vixen.sonytel.be>
	<20090225111836.621412c1@i1501.lan.towertech.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20090225111836.621412c1@i1501.lan.towertech.it>
Cc: Linux/m68k <linux-m68k@vger.kernel.org>, rtc-linux@googlegroups.com,
	linux-parisc@vger.kernel.org, David@ozlabs.org,
	Linux Kernel Development <linux-kernel@vger.kernel.org>,
	Kyle McMartin <kyle@mcmartin.ca>,
	Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	Geert.Uytterhoeven@sonycom.com, David Woodhouse <dwmw2@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Feb 25, 2009 at 11:18:36AM +0100, Alessandro Zummo wrote:
> On Wed, 25 Feb 2009 11:00:13 +0100 (CET)
> Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com> wrote:
> 
> > I didn't know NTP was broken with RTC class drivers?
> > 
> > So we should actually keep on using genrtc instead of rtc-ppc/rtc-generic for
> > now? ;-)
> 
>  broken here means that the kernel won't save the time to the hardware
>  rtc every 11 minutes as it used to do. normal NTP operations are unaffected.

seems like so far ppc is the only architecture attempting to implement it
correctly, all others either have it unimplemented or use the broken
by design set_rtc_mmss method. 
Also note that in most cases hwclock has much better possibilities
to do a good job.

Regarding genrtc vs rtc-ppc/rtc-generic it is worth noting that genrtc
provides RTC_UIE emulation which is of some use for exotic programs like 
"chrony".
Afaics this is also the only situation without a good userspace workaround 
and chrony never worked well for me so I have nothing against junking the 
code.

Regarding a possible reorganisation from the generic to all separate drivers
I agree that the habit of putting rtc-chip specific code in asm-generic is 
confusing at best. 
In many cases such code might be better placed in drivers/rtc or 
include/linux/rtc/chipname.

Imho this does not preclude the possibility to use a generic framework. While
there certainly are valid reasons to have separate drivers in some cases 
I do not see much value in rewriting everything as separate drivers where 
the generic framework works well.

Richard
