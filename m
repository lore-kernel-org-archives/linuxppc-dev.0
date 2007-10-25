Return-Path: <matt@genesi-usa.com>
Received: from mail.genesi-usa.com (mithrandir.softwarenexus.net
	[66.98.186.96])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 218C3DDE3C
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Oct 2007 04:12:56 +1000 (EST)
Message-ID: <4720DD18.9000603@genesi-usa.com>
Date: Thu, 25 Oct 2007 19:14:48 +0100
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Valentine Barshak <vbarshak@ru.mvista.com>
Subject: Re: [linux-usb-devel] [PATCH 1/2] USB: Rework OHCI PPC OF for new
	bindings
References: <20071024163412.GA17785@ru.mvista.com>	
	<471FC191.6020704@genesi-usa.com>	
	<200710241850.05467.david-b@pacbell.net>	
	<fa686aa40710241941w16fe3e75hb8ede9f9c8464e94@mail.gmail.com>	
	<47208273.8050601@ru.mvista.com>
	<fa686aa40710250721m54dda956qe7c8986416d0dfa2@mail.gmail.com>
	<4720CE3E.5030204@ru.mvista.com>
In-Reply-To: <4720CE3E.5030204@ru.mvista.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: David Brownell <david-b@pacbell.net>, linux-usb-devel@lists.sourceforge.net,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Valentine,

Please do the very minimal required to keep supporting the Efika.

As for an little endian OHCI controller on an OF bus, I would not
consider it an impossibility. But, not having the big-endian
property fixes this; OHCI is little-endian by default. You need
only report "difference" in device trees, overzealous naming of
a billion kinds of 99.99999% compatible controllers is just a
waste of space.

I prefer the new binding to a degree. I like the big-endian property
and I like the reporting of a standard controller type (usb-ohci
rather than building in chip names). However by making the driver
support only the recommending binding, we break old platforms for
the sake of making new ones cleaner.

I wish someone would have sat down and defined the 5200 device
tree in a design committee rather than a peer review post-commit
system. In fact, that is a great idea, we can start this off with
the MPC5121E right now, and get the damn thing RIGHT.

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations

Valentine Barshak wrote:
> Grant Likely wrote:
>> On 10/25/07, Valentine Barshak <vbarshak@ru.mvista.com> wrote:
>>> Grant Likely wrote:
>>>> On 10/24/07, David Brownell <david-b@pacbell.net> wrote:
>>>>> On Wednesday 24 October 2007, Matt Sealey wrote:
>>>>>> Can we just make sure real quickly that the changing of compatibles
>>>>>> doesn't break existing, not-easily-flashable firmwares?
>>>>> Yeah, I'm not keen on such breakage either...
>>>> Add my voice to the chorus.  It's okay to change the binding, but make
>>>> sure the old binding is still supported.
>>>>
>>>> Cheers,
>>>> g.
>>>>
>>> Actually, I thought that changing the DTS stuff for mpc52xx boards would
>>> suffice. Sorry, I was unaware of Efika firmware here. I'll keep old
>>> bindings as well.
>>
>> Even if that were the case; I'm nervous about breaking compatibility
>> with old device trees.
> 
> If we keep the old bindings intact in the driver code then the old dts 
> files should work fine. But I'm starting to doubt we really need any new 
> bindings for this if we still have to keep the old ones.
> BTW, does anybody know of any ohci-le devices on OF bus?
> Thanks,
> Valentine.
> 
>>
>> We probably need a formal guideline here.  ie. When is it okay to drop
>> compatibility with old dts files?
>>
>>> Does the device tree have "ohci-bigendian" or "ohci-be" compatible
>>> property on Efika?
>>
>> If it doesn't, it can be added during prom_init.c  We're already doing
>> a bunch of efika fixups there anyway.
>>
>> Cheers,
>> g.
>>
> 
