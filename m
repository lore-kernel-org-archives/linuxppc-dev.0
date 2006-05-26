Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 958AD67A70
	for <linuxppc-dev@ozlabs.org>; Fri, 26 May 2006 17:59:42 +1000 (EST)
Subject: Re: [snd] looking for layout-ids
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Johannes Berg <johannes@sipsolutions.net>
In-Reply-To: <1148628484.16989.3.camel@johannes.berg>
References: <1148553785.11759.12.camel@johannes.berg>
	<1148606268.8089.12.camel@localhost.localdomain>
	<1148628484.16989.3.camel@johannes.berg>
Content-Type: text/plain
Date: Fri, 26 May 2006 17:59:19 +1000
Message-Id: <1148630360.8089.128.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	debian-powerpc <debian-powerpc@lists.debian.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2006-05-26 at 09:28 +0200, Johannes Berg wrote:
> On Fri, 2006-05-26 at 11:17 +1000, Benjamin Herrenschmidt wrote:
> 
> > I think we need to be careful about a couple other things:
> > 
> >  - We need non-pmf GPIO. Some layout-id based machines do need that,
> > like the mac mini
> 
> Yeah, I saw that, but I need more insight into how that should work with
> a feature call or so...

Well, look at the tumbler code. The address you pass to the feature call
is the GPIO offset from the beginning of mac-io. Since Apple stuff isn't
always consistent, you have 2 ways of getting to it:

 - Use the "reg" property as normally expected... except that Apple has
bugs there where that property contains an offset that is either
relative to the beginning of the GPIO block (which itself is at 0x50 in
mac-io) or to the beginning of mac-io. It _seems_ however that they are
consistent with the bug in the sense that most GPIOs are relative to the
GPIO block except the audio ones that are relative to the beginning of
mac-io. The "trick" you can use is that since the GPIO block is less
than 0x50 bytes long, you can take the value of "reg" and do something
like:

	offset = (reg >= 0x50) ? reg : (reg + 0x50);

It's ugly but will work I think will all incarnations of mac-io

 - Specifically for audio-GPIOs it seems that they also have an
AAPL,address property that contains the physical address of the GPIO
within mac-io. For example, headphone-detect on the mac-mini contains:

	AAPL,address     80000067

In that case, what you can do is take that property and strip off the
top bits

	offset = aapl_addr & 0xff;

In both case, the resulting offset can then be passed to the feature
calls to access the GPIOs. Now there is the problem of the format of the
8 bits value you read/write. It's not exactly the same between keylargo
and k2/shasta (wether you have a G5 or not). However, since the later
always use platform functions afaik, it's a non-issue and thus you only
have to handle the old-style ones.

#define KEYLARGO_GPIO_OUTPUT_ENABLE     0x04
#define KEYLARGO_GPIO_OUTOUT_DATA       0x01
#define KEYLARGO_GPIO_INPUT_DATA        0x02

So to configure a GPIO as an input, make sure 0x04 is cleared. You can
read the input value then on bit 0x02. For some GPIOs, you want to leave
them as open collector (that is asserted to 0 or floating). In that
case, asserted to 0 is 0x04 (output enabled set to 1 and output data set
to 0) and floating (high-Z) is 0x00 (configurd as input). If you want to
always assert the GPIO, then use 0x04 and 0x05 as 0 and 1 values. (Look
what darwin does there).

You may want to have a look at the gpio code from Ben Collins too,
though it could be simplified now that we only deal with old-style ones.
On those old-style ones, there is a property "audio-gpio-active-state"
that gives you the polarity of the output.

In addition, look for "has-anded-reset" property (in the "sound" node).
Some platforms have that to tell you that setting both mutes at the same
time resets the codec. Thus you may have to be especially careful. Have
also a look at AppleMacRISC2PE since I think it adds or removes that
property on some machines.

> >  - I'm tempted to rename soundbus/i2sbus to snd-aoa-soundbus and
> > snd-aoa-i2sbus (at least the module names) for now. 
> 
> Yeah, I guess that ought to be done. Not just the module names, also the
> sysfs visible part (though that's easy).

Yup.

Ben.
