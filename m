Return-Path: <g.liakhovetski@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 2FB8BDDECE
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  5 Oct 2007 05:52:02 +1000 (EST)
Date: Thu, 4 Oct 2007 21:52:19 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Bruce_Leonard@selinc.com
Subject: Re: Device tree and external RTC
In-Reply-To: <OF6E4972CE.0F54E43B-ON8825736A.00637A7C-8825736A.00646F2A@selinc.com>
Message-ID: <Pine.LNX.4.60.0710042118000.4537@poirot.grange>
References: <OF6E4972CE.0F54E43B-ON8825736A.00637A7C-8825736A.00646F2A@selinc.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, 4 Oct 2007 Bruce_Leonard@selinc.com wrote:

> Guennadi Liakhovetski <g.liakhovetski@gmx.de> wrote on 10/04/2007 02:29:06 
> AM:
> 
> > > CONFIG_SENSORS_M41T00=y
> > 
> > It shall not hurt, but do you really have this one?
> 
> I turned this on because my clock is a SMT M41T00.  Not sure why it's 
> called a sensor in the .config.

It is the deprecated driver for the same rtc chip. But maybe it is this 
one that makes your RTC work ATM, see below.

> > First, this might be either a userspace or a kernel problem. Do you have 
> 
> > the correct device nodes? Are you using udev? Should be something like 
> 
> Ultimatly it was my own stupididty that did me in.  You are absolutly 
> correct, I didn't have the right device nodes and because we're limited on 
> space we don't want to use udev.  Once I created the rtc0 device and 
> linked rtc to it, hwclock started working correctly.

It shouldn't. It probably does thanks to the m41t00 driver, but you don't 
want it, instead...

> > you need suitable entries in arch/powerpc/sysdev/fsl_soc.c in the 
> > i2c_devices array. I think, patch at 
> > http://patchwork.ozlabs.org/linuxppc/patch?id=13624 is exactly what you 
> > need. 
> 
> I'll give this a try.  I'd really prefer to be using the device tree for 
> this, but I guess as long as I have it working using configuration options 
> in the kernel it doesn't really matter.  Either way I don't have to write 
> any special board support code for the kernel.

you need this patch to get ds1307 attach to your rtc chip.

And, besides, linuxppc-embedded is deprecated, linuxppc-dev should be used 
instead:-)

Thanks
Guennadi
---
Guennadi Liakhovetski
