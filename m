Return-Path: <wfarnsworth@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id 2AA72DDDFA
	for <linuxppc-dev@ozlabs.org>; Tue, 22 May 2007 02:51:23 +1000 (EST)
Subject: Re: [PATCH 2/5] Add legacy devices to mpc8641_hpcn.dts
From: Wade Farnsworth <wfarnsworth@mvista.com>
To: Jon Loeliger <jdl@freescale.com>
In-Reply-To: <1179763854.13019.8.camel@ld0161-tx32>
References: <1179245829.8132.100.camel@rhino> <1179246470.8132.112.camel@rhino>
	<1179333421.7018.17.camel@ld0161-tx32>
	<b77c4b3dd22795a73cd32a0623722e51@kernel.crashing.org>
	<1179346653.8132.223.camel@rhino>
	<0c3907573f12a0731d03335fe3334363@kernel.crashing.org>
	<1179506692.19188.2.camel@ld0161-tx32>
	<1179763484.8132.293.camel@rhino>
	<1179763854.13019.8.camel@ld0161-tx32>
Content-Type: text/plain
Date: Mon, 21 May 2007 09:51:21 -0700
Message-Id: <1179766281.8132.321.camel@rhino>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2007-05-21 at 11:10 -0500, Jon Loeliger wrote:
> On Mon, 2007-05-21 at 11:04, Wade Farnsworth wrote:
> 
> > I wonder if you're running into the locked RTC problem on the m1575.
> > The version of u-boot that I'm using (recent pull from
> > opensource.freescale.com)
> 
> Which repository?  I ask because it is highly likely that
> I placed it there...

http://opensource.freescale.com/pub/scm/u-boot-jdl.git

> 
> >  has a workaround for that.  Can you verify if
> > this is the problem?
> 
> Can you point to "the workaround" to which you refer?

commit a59a76edd7c475329c083d5c21f6bca8bb5b8476

Re-enable a PCIE hack access for RTC on 8641HPCN.

> 
> > For the benefit of those who aren't aware of the problem, the RTC on the
> > m1575 is locked on boot until PCI memory space is read.
> 
> Hmmm.  I'm pretty sure this is being done already.

If you're sure your u-boot is doing this, then maybe it is a
configuration problem after all.

> 
> > Maybe we should put the workaround in the kernel instead.  Any opinions?
> 
> How are you getting it to work now as it is, then?

In addition to the u-boot hack, I have the following config options
enabled:

CONFIG_PCI=y
CONFIG_RTC_LIB=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_HCTOSYS=y
CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
CONFIG_RTC_INTF_SYSFS=y
CONFIG_RTC_INTF_PROC=y
CONFIG_RTC_INTF_DEV=y
CONFIG_RTC_DRV_CMOS=y

I believe this is all you should need to enable the RTC.  You should
then see a boot message indicating that the system clock has been set:

rtc_cmos rtc_cmos: setting the system clock to 2007-05-21 21:29:13
(1179782953)

In order to use hwclock to access the RTC you have to make a symlink
from /dev/rtc0 to /dev/rtc.

--Wade
