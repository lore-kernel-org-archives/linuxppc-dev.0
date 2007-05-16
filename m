Return-Path: <wfarnsworth@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id BFDE6DDEEE
	for <linuxppc-dev@ozlabs.org>; Thu, 17 May 2007 06:17:34 +1000 (EST)
Subject: Re: [PATCH 2/5] Add legacy devices to mpc8641_hpcn.dts
From: Wade Farnsworth <wfarnsworth@mvista.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <b77c4b3dd22795a73cd32a0623722e51@kernel.crashing.org>
References: <1179245829.8132.100.camel@rhino> <1179246470.8132.112.camel@rhino>
	<1179333421.7018.17.camel@ld0161-tx32>
	<b77c4b3dd22795a73cd32a0623722e51@kernel.crashing.org>
Content-Type: text/plain
Date: Wed, 16 May 2007 13:17:33 -0700
Message-Id: <1179346653.8132.223.camel@rhino>
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

On Wed, 2007-05-16 at 21:55 +0200, Segher Boessenkool wrote:
> >> +			isa@f0 {
> 
> isa@1e
> 
> >> +				8042@60 {
> >> +					device_type = "8042";
> 
> Drop the device_type.  A number as a name isn't
> all that great, either.

Currently in order for the i8042 devices to be initialized,
check_legacy_ioport() must find a node with device_type "8042".

> 
> >> +				rtc@70 {
> >> +					device_type = "rtc";
> >> +					reg = <1 70 2>;
> >> +				};
> >
> > Is "rtc" a standard OF device,
> 
> Yes, it is defined in the "Device Support Extensions"
> recommended practice.
> 
> > And is the plan to somehow use this entry in the future?
> 
> The platform code can use it to find the device.  If it
> would have a proper "compatible" property, the generic
> code could do that work, instead.

Is there a recommended "compatible" property for a standard PC-like CMOS
RTC?

--Wade
