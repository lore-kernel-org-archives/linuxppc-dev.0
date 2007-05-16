Return-Path: <wfarnsworth@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id B87E4DDE9E
	for <linuxppc-dev@ozlabs.org>; Thu, 17 May 2007 03:59:09 +1000 (EST)
Subject: Re: [PATCH 2/5] Add legacy devices to mpc8641_hpcn.dts
From: Wade Farnsworth <wfarnsworth@mvista.com>
To: Jon Loeliger <jdl@freescale.com>
In-Reply-To: <1179333421.7018.17.camel@ld0161-tx32>
References: <1179245829.8132.100.camel@rhino> <1179246470.8132.112.camel@rhino>
	<1179333421.7018.17.camel@ld0161-tx32>
Content-Type: text/plain
Date: Wed, 16 May 2007 10:59:06 -0700
Message-Id: <1179338347.8132.200.camel@rhino>
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

On Wed, 2007-05-16 at 11:37 -0500, Jon Loeliger wrote:
> On Tue, 2007-05-15 at 11:27, Wade Farnsworth wrote:

<snip>

> > +			isa@f0 {
> > +				device_type = "isa";
> >  				#interrupt-cells = <2>;
> 
> Yea, thanks.  BTW, will this be sufficient to now identify the
> primary controller and not doink with the legacy IO ports now?
> Or is that being handled differently somehow?

I'm not sure what you're referring to here.  Can you clarify this a
little?

> 
> > +				#size-cells = <1>;
> > +				#address-cells = <2>;
> > +				reg = <f000 0 0 0 0>;
> > +				ranges = <1 0 01000000 0 0 00001000>;
> > +				interrupt-parent = <4d0>;
> 
> That 4d0 should likely be &i8259.
> 
> > +				8042@60 {
> > +					device_type = "8042";
> > +					reg = <1 60 1 1 64 1>;
> > +					interrupts = <1 3 c 3>;
> > +					interrupt-parent = <4d0>;
> > +				};
> 
> Ditto.

Yes, of course.  Thanks.

> 
> > +				rtc@70 {
> > +					device_type = "rtc";
> > +					reg = <1 70 2>;
> > +				};
> 
> Is "rtc" a standard OF device, or are we making up a
> new thing that should be documented in booting-with-OF.txt ?
> And is the plan to somehow use this entry in the future?

It is my understanding that "rtc" is a standard OF device.  Can anybody
confirm this?

This could be used in the platform-specific RTC code to get the ports
from the device tree.  Currently, however, I simply use RTC_PORT(x) from
asm/mc146818rtc.h.  Is it preferable to use the device tree here?

--Wade

> 
> Thanks,
> jdl
> 
> 
