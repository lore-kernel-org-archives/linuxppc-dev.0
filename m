Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BAFFBDDF31
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Sep 2007 06:57:37 +1000 (EST)
In-Reply-To: <20070906195614.GA23333@ld0162-tx32.am.freescale.net>
References: <20070905192820.GG32398@ld0162-tx32.am.freescale.net>
	<85281ec227e35a9e466e68e3fdc7e6ef@kernel.crashing.org>
	<20070906141620.GB16353@ld0162-tx32.am.freescale.net>
	<f26578467468e38345e795ea5f1f7c42@kernel.crashing.org>
	<20070906180922.GA18750@ld0162-tx32.am.freescale.net>
	<598e0baf0dc1ca63b91f2a80ec8abe19@kernel.crashing.org>
	<20070906191255.GA22663@ld0162-tx32.am.freescale.net>
	<20070906192025.GA22775@ld0162-tx32.am.freescale.net>
	<43ad9218d498e2d01922a57ebfee2327@kernel.crashing.org>
	<20070906195614.GA23333@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <143f0a1c76539260fd41fe953e6d1bdf@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 8/9] 8xx: Adder 875 support
Date: Thu, 6 Sep 2007 22:57:28 +0200
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> BTW, IEEE1275 seems to disagree:
>>
>> No it doesn't.
>
> "...in conventional usage the string begins with the name of the 
> device's
> manufacturer".

You cut that sentence short here, it continues: "as with the name
property."

> Even if you want to quibble about the manner in which the
> manufacturer is specified, that's quite different from leaving it out.

The text of the standard says that often people start the model
property contents with an "XYZ,".  It doesn't say that is required
(though it hints it might be a good idea to do so).  It doesn't say
it is okay to just put some arbitrary text there.

>> That would be "0ABCDEF,Adder MPC875" or "VWXYZ,Adder MPC875" --
>> not "some random string without a comma Adder MPC875".
>
> "the text string is arbitrary" and "conventional usage".

It doesn't say that.  It says _the format_ is arbitrary, it is
quite specific about the contents: model name and number.

> That "random string" is more useful for the intended purpose than the
> first half of a MAC address.

What, an OUI isn't useful for uniquely identifying a manufacturer?
That's news to me.

>> i.e., it is machine readable.
>
> No, it *can* be machine usable in certain circumstances.  I'm 100% sure
> that there is no code out there that cares what's in the model field of
> this board's device tree,

Why would that matter?

> other than to pass it to /proc/cpuinfo (i.e.
> human consumption).

It's not my fault that /proc/cpuinfo uses strings that are meant
for machine consumption by directly showing them to the user,
without some level of massaging by the platform code first.  It
definitely is no argument for doing bad things in your device
tree now, instead of fixing the kernel code.

Anyway, I've said enough about this, I think I've made my point --
and this is very minor stuff after all.


Segher
