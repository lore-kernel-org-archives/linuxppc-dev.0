Return-Path: <Bruce_Leonard@selinc.com>
Received: from tesla.selinc.com (tesla.selinc.com [12.110.71.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "tesla.selinc.com", Issuer "RSA Data Security,
	Inc." (verified OK)) by ozlabs.org (Postfix) with ESMTP id 14797DDE0A
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  5 Oct 2007 04:17:06 +1000 (EST)
In-Reply-To: <Pine.LNX.4.60.0710041046040.4537@poirot.grange>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: Device tree and external RTC
MIME-Version: 1.0
Message-ID: <OF6E4972CE.0F54E43B-ON8825736A.00637A7C-8825736A.00646F2A@selinc.com>
From: Bruce_Leonard@selinc.com
Date: Thu, 4 Oct 2007 11:17:00 -0700
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Guennadi Liakhovetski <g.liakhovetski@gmx.de> wrote on 10/04/2007 02:29:06 
AM:

> > CONFIG_SENSORS_M41T00=y
> 
> It shall not hurt, but do you really have this one?

I turned this on because my clock is a SMT M41T00.  Not sure why it's 
called a sensor in the .config.
 
> First, this might be either a userspace or a kernel problem. Do you have 

> the correct device nodes? Are you using udev? Should be something like 

Ultimatly it was my own stupididty that did me in.  You are absolutly 
correct, I didn't have the right device nodes and because we're limited on 
space we don't want to use udev.  Once I created the rtc0 device and 
linked rtc to it, hwclock started working correctly.

> > When I dump out ppc_md, all the RTC functions (i.e., get_rtc_time, 
> > read_rtc_val, etc.) are all NULL.
> 
> Don't think you need those. Those are for powerpc platforms not using 
> the generic rtc driver. 

Right.

> you need suitable entries in arch/powerpc/sysdev/fsl_soc.c in the 
> i2c_devices array. I think, patch at 
> http://patchwork.ozlabs.org/linuxppc/patch?id=13624 is exactly what you 
> need. 

I'll give this a try.  I'd really prefer to be using the device tree for 
this, but I guess as long as I have it working using configuration options 
in the kernel it doesn't really matter.  Either way I don't have to write 
any special board support code for the kernel.

Thanks for all the information and pointers.  It's been a big help!

Bruce
