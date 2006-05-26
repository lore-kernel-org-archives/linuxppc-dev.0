Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2E1BD67AC7
	for <linuxppc-dev@ozlabs.org>; Sat, 27 May 2006 07:45:24 +1000 (EST)
Subject: Re: [RFC] snd-aoa and interrupts (headphone detection etc)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Johannes Berg <johannes@sipsolutions.net>
In-Reply-To: <1148055359.6228.20.camel@johannes.berg>
References: <1148055359.6228.20.camel@johannes.berg>
Content-Type: text/plain
Date: Sat, 27 May 2006 07:45:17 +1000
Message-Id: <1148679918.8089.166.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> The problematic part is things that the codec must control. Say we want
> line-in detection to automatically switch to line-in if microphone is
> selected (does anyone ever want this?). Then the problem is that the
> interrupt arrives at the GPIO layer, and I can easily make it seen in
> the fabric too. However, then propagating it to the codec is a bit
> harder. Or we don't have it in the fabric but have the codec register
> for that interrupt (through our GPIO layer). This is the first option.

No. I don't think the codecs should mess with the GPIOs directly. The
policy should be implemented in the fabric. If in some case you need to
change some codec settings, then the codec shall provide an accessor for
doing so.

> The second option is changing the whole in-/output control code that we
> have and moving it from the codec to the fabric layer. The fabric
> already knows what in- and outputs a codec has (in order to know what is
> connected), hence if we added a codec driver function to turn on/off any
> in- or output we could have the fabric control this. But then we'd also
> have to make known to the codec which of those are mutually exclusive,
> and generally make it more complicated.

We don't have to make known to the codec, we just turn on/off the right
ones.

> I currently favour the first option, the codec driver can know when it
> makes sense to try registering the interrupt (if it isn't present it
> fails anyway) and then do the appropriate stuff (possibly giving the
> user a choice).

I disagree :) But then, it's your code :)

Ben.
