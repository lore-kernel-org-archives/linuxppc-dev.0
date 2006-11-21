Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-08.arcor-online.net (mail-in-08.arcor-online.net
	[151.189.21.48])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id CEBF667C9B
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Nov 2006 21:18:04 +1100 (EST)
In-Reply-To: <1164090827.5597.14.camel@localhost.localdomain>
References: <1164090827.5597.14.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <D60CE257-48C1-4837-ADA9-B0D3722A16BA@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC] making phandle's mandatory for of_platform_device
Date: Tue, 21 Nov 2006 11:17:37 +0100
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>  1 - Stick to my current hairy stuff and plaster on possible new
> problems popping up with it, and live with the uglyness on 64 bits
> platforms
>  2 - Make it mandatory for all nodes to have a phandle (all of them)
>  3 - Make it mandatory for nodes that can be declared as
> of_platform_device to have a phandle
>  4 - Make it mandatory for nodes that can be declared as any child of
> of_device to have a phandle (and use a consistent naming accross all
> childs of of_device, like macio_device, of_platform_device, etc...)
>  5 - Make it mandatory for nodes using the new automatic generation of
> of_platform_devices from the device-tree to have phandles.

I don't see any reason to change the status quo; i.e., Linux only
requires a phandle in the device tree if Linux uses that phandle
in some way.

That would be any of your 2..5, people can choose what to use
depending on how future-proof they want to be.

Another option is for Linux to generate unique phandles for all
nodes that don't have one yet.  To make this simpler, you could
require flat device trees that don't have phandles on all modes,
to not use any phandle > 0x0fffffff (say), so Linux _knows_ there
is a certain range it can use at will.  I haven't seen any flat
device trees that used high numbers for phandles, so this change
should be really easy on people.


Segher
