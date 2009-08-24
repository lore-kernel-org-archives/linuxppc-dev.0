Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 1E96AB70BA
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 24 Aug 2009 18:53:22 +1000 (EST)
Date: Mon, 24 Aug 2009 10:53:16 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: 2.6.31-rc7 : kernel BUG at drivers/rtc/rtc-ps3.c:36!
In-Reply-To: <1251099552.19818.4.camel@concordia>
Message-ID: <alpine.LRH.2.00.0908241052550.31587@vixen.sonytel.be>
References: <4A923AD3.1020507@in.ibm.com> <1251099552.19818.4.camel@concordia>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 24 Aug 2009, Michael Ellerman wrote:
> On Mon, 2009-08-24 at 12:31 +0530, Sachin Sant wrote:
> > While trying to boot 2.6.31-rc7 on a power6 machine came
> > across the following Bug. 
> > 
> > Starting udev: ------------[ cut here ]------------
> > kernel BUG at drivers/rtc/rtc-ps3.c:36!
> > cpu 0x0: Vector: 700 (Program Check) at [c0000000f70f3570]
> >     pc: c00000000059a020: .ps3_get_time+0x3c/0x84
> >     lr: c00000000059a018: .ps3_get_time+0x34/0x84
> >     sp: c0000000f70f37f0
> >    msr: 8000000000029032
> >   current = 0xc0000000f8d14ee0
> >   paca    = 0xc0000000012cc300
> >     pid   = 159, comm = hwclock
> > kernel BUG at drivers/rtc/rtc-ps3.c:36!
> 
> > static u64 read_rtc(void)
> > {
> > ....
> > result = lv1_get_rtc(&rtc_val, &tb_val);
> > BUG_ON(result);
> > 
> > I had never tried enabling CONFIG_RTC_DRV_PS3 option before
> > so not sure if this is a new problem or an old one. 
> 
> Looks like an old one, or at least as long as the driver has existed.
> 
> The code needs to cope with being called on something other than a PS3.
> Either the platform driver is only registered if the machine is a PS3,
> or ps3_rtc_probe() actually does something to check it's on a PS3 before
> registering the rtc_device.

Bummer, how could we have missed that one?
Cooking a patch...

With kind regards,

Geert Uytterhoeven
Software Architect
Techsoft Centre

Technology and Software Centre Europe
The Corporate Village · Da Vincilaan 7-D1 · B-1935 Zaventem · Belgium

Phone:    +32 (0)2 700 8453
Fax:      +32 (0)2 700 8622
E-mail:   Geert.Uytterhoeven@sonycom.com
Internet: http://www.sony-europe.com/

A division of Sony Europe (Belgium) N.V.
VAT BE 0413.825.160 · RPR Brussels
Fortis · BIC GEBABEBB · IBAN BE41293037680010
