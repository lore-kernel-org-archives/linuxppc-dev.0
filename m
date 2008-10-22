Return-Path: <miltonm@sullivan.realtime.net>
Received: from sullivan.realtime.net (sullivan.realtime.net [205.238.132.226])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A4EE4DDE0A
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Oct 2008 07:39:13 +1100 (EST)
Date: Wed, 22 Oct 2008 15:38:59 -0500 (CDT)
Message-Id: <200810222038.m9MKcxMK020513@sullivan.realtime.net>
From: Milton Miller <miltonm@bga.com>
Sender: Milton Miller <miltonm@realtime.net>
To: Matt Sealey <matt@genesi-usa.com>
Subject: Re: [PATCH] powerpc: Remove device_type = "rtc" properties in .dts
	files
In-Reply-To: <C3C48FF2CBB.7060605@genesi-usa.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Matt Sealey wrote:
> Anton Vorontsov wrote:
>> We don't want to encourage the device_type usage. It isn't used in the
>> code, so we can simply remove it from the dts files.
> 
> I'm extremely troubled that it is "not used in the code", 
> surely device_type is checked as a legacy for Open Firmware 
> (otherwise a lot of devices may never be detected!), or does 
> device tree parsing/checking follow a different path for FDT?
> 
> (absolutely fine with it being removed from new DTS but, just 
> concerned about your comment and it's impact...)

device_type is used by Open Firmware itself to specify the binding
that a node implements.   That includes both properties and
methods or words.

Since a flat tree doesn't have words to operate, we are activly
discouraging flat trees from specifiying device_type with a few
exceptions that are well defined -- main memory nodes for one.
For most nodes the binding that firmware uses is not relevent
to the kernel, and we don't want bindings that only exist in
flat trees to result in an unusable OF binding.

The i2c binding used by sparc vs flat trees is an example of
what can happen without the proper review.

milton
