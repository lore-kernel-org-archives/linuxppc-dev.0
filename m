Return-Path: <SRS0+2987a99b877e5b3de0fb+2011+infradead.org+dwmw2@casper.srs.infradead.org>
Received: from casper.infradead.org (casper.infradead.org [85.118.1.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 147F8DDDA1
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Feb 2009 09:32:28 +1100 (EST)
Subject: Re: [rtc-linux] [PATCH/RFC 0/5] Generic RTC class driver
From: David Woodhouse <dwmw2@infradead.org>
To: Alessandro Zummo <alessandro.zummo@towertech.it>
In-Reply-To: <20090224231154.60ba18d6@i1501.lan.towertech.it>
References: <1235144809-32468-1-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<20090220170454.04382e9e@i1501.lan.towertech.it>
	<alpine.LRH.2.00.0902231319170.22762@vixen.sonytel.be>
	<1235511327.18632.73.camel@macbook.infradead.org>
	<20090224231154.60ba18d6@i1501.lan.towertech.it>
Content-Type: text/plain
Date: Wed, 25 Feb 2009 07:32:07 +0900
Message-Id: <1235514727.18632.93.camel@macbook.infradead.org>
Mime-Version: 1.0
Cc: Richard Zidlicky <rz@linux-m68k.org>, rtc-linux@googlegroups.com,
	linux-parisc@vger.kernel.org, David@ozlabs.org,
	Linux Kernel Development <linux-kernel@vger.kernel.org>,
	Kyle McMartin <kyle@mcmartin.ca>,
	Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	Linux/m68k <linux-m68k@lists.linux-m68k.org>,
	Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2009-02-24 at 23:11 +0100, Alessandro Zummo wrote:
> On Wed, 25 Feb 2009 06:35:27 +0900
> David Woodhouse <dwmw2@infradead.org> wrote:
> 
> > > So you want us to kill the ppc_md.[gs]et_rtc_time() [ppc], mach_hwclk() [m68k],
> > > mach_gettod() [m68knommu] (and probably a few other) abstractions, and move all
> > > RTC code out of arch/ into seperate drivers under drivers/rtc/ instead?
> > 
> > That's the ideal... although did we get NTP sync working again yet?
> 
>  not yet. we're close but I've been very busy :(

I know the feeling.

Once that's working, we can convert individual PPC platforms over,
removing the routines from the ppc_md and creating a generic RTC driver
instead. PA Electra is already like that -- because it wasn't a
regression there to have broken NTP sync. But the others need to wait.

Eventually, we ought to be able to drop the RTC functions from the
ppc_md -- and presumably the equivalent for other architectures too.

-- 
David Woodhouse                            Open Source Technology Centre
David.Woodhouse@intel.com                              Intel Corporation
