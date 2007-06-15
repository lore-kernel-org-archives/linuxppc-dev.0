Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-06.arcor-online.net (mail-in-06.arcor-online.net
	[151.189.21.46])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2FD1FDDF77
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Jun 2007 20:54:17 +1000 (EST)
In-Reply-To: <4671AB2B.8000008@genesi-usa.com>
References: <4671AB2B.8000008@genesi-usa.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <ff25e225fd11b8189ea922a33b71f164@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: PowerPC boot wrapper and seperate initrd images
Date: Fri, 15 Jun 2007 12:54:10 +0200
To: Matt Sealey <matt@genesi-usa.com>
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> However what I
> am looking to do is have it so that a first stage bootloader (Forth
> script or binary like Yaboot) loads in the initrd into memory via the
> client interface or whatever other method, then just fires up the
> kernel.

Reasonable.

> This is simply because.. yaboot doesn't work here yet (Pegasos/Efika).

Yeah yaboot is a royal pain.

> This is causing problems with distributions as they like to ship a
> kernel and seperate initrd - and expect a boot loader like BootX or
> Yaboot or Quick (pick one) to do all it's heavy lifting.
>
> However we CAN get the data into the right place, with a tiny Forth
> script, and there are some standard properties to reference it.
>
> The linux,initrd-size and linux,initrd-start properties would
> be set in the device tree by this tiny forth boot loader.
>
> That means of.c needs to pick them up, and main.c needs not to trash
> them.

Yes.

> What I am asking, then, if all that information is correct, is if it
> would be acceptable in any terms to add this code to the boot wrapper;
> in platform_init, it would get the properties out of the tree and
> assign them in the loader_info structure (maybe only if the r3 and
> r4 values are invalid).
>
> Then in main.c perhaps NOT set those values if they are already in
> the device tree.. but I am not sure if any manipulation of the
> values is going on. I assume they're absolute, real-mode addresses
> and not being weirdly relocated or as an offset to the kernel
> (I didn't look to hard).
>
> Is it an insane or stupid idea, that everyone hates and thinks
> we should just fix our broken firmware, or do you think it would
> come in handy? I'm considering it's a 20-line patch that wouldn't
> harm anyone..
>
> Any comments?

It's not a bad plan, but show us the code so we can see
if it turns out nasty or not :-)


Segher
