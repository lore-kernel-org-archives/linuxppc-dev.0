Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-04.arcor-online.net (mail-in-04.arcor-online.net
	[151.189.21.44])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0CE92DDE03
	for <linuxppc-dev@ozlabs.org>; Sun, 20 May 2007 02:25:45 +1000 (EST)
In-Reply-To: <464EFE96.3000801@genesi-usa.com>
References: <20070517143846.GC29795@ld0162-tx32.am.freescale.net>	<FB8DD3C1-A095-4ABB-9E74-7EC66A43D983@kernel.crashing.org>	<464C800C.20400@freescale.com>	<FFBD3A3A-ADBE-4DC8-A1A1-4163367244D5@kernel.crashing.org>	<464C871C.4090300@freescale.com>	<5B363A90-5528-4441-BBF9-9C6D8833D938@kernel.crashing.org>	<20070518171555.543f9bdc@hyperion.delvare>	<D50C4D36-CEA5-4F7F-8A4C-CC747DF85865@kernel.crashing.org>	<464DD5E3.1060301@freescale.com>
	<6F8D3143-423D-45FA-9F40-00BF770831F2@kernel.crashing.org>
	<464E3F18.5010700@genesi-usa.com>
	<2087d135c4139e94e0b2c8826d808292@kernel.crashing.org>
	<464EFE96.3000801@genesi-usa.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <94e1abed8781f279d2d4c7cddbc25ba2@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [i2c] [PATCH 3/5] powerpc: Document device nodes for I2C devices.
Date: Sat, 19 May 2007 18:25:38 +0200
To: Matt Sealey <matt@genesi-usa.com>
Cc: Jean Delvare <khali@linux-fr.org>, linuxppc-dev@ozlabs.org,
	i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> Actually, you can, and should.  All this information is
>> contained in the "compatible" and "model" properties.
>> "Quirks of board design" can be described too, on a case-
>> by-case basis.
>>
>> All the knowledge about how to drive the device resides
>> in the kernel, but the device tree describes exactly what
>> device this is, so the kernel can match a driver to it
>> uniquely, and the driver can know exactly what revision
>> chip this is and what quirks to apply.
>
> That's what I said wasn't it?

Not at all, no.

> If you have a buggy i2c controller or one that has a strange
> quirk, but it's present as fsl-i2c in those device trees,
> would you specify that it is fsl-i2c-less-bugs later?
> Would you add property after property to describe errata,
> quirks in the nodes themselves?

No.  All this can be easily derived from the "model"
properties in the relevant nodes.

> I'll take an example of putting useless information in
> the device tree - how about the CPU node? It has all the
> information for cache sizes etc. but does Linux use it?

It *should* use it though.  But it cannot really do that,
since many/most device trees are broken in this respect.

Linux *does* use some of the "cpu" properties though.
Maybe in the future it will use more.

> This is what I mean by 'describing exactly what the device
> is' being rather a tedious and time-wasting concept.

This is equivalent to stating the device tree is a useless
concept.  You are free to your opinion of course.

> I might be a little less noisy about it if there was
> some kind of edict for devices never to wander outside
> of their own node in the device tree, but there isn't.

I'm not sure what you mean here.  It is best practice
for device nodes to be reasonably self-contained though.
Of course not completely; every node always has to refer
to its parent bus, etc.  Device drivers will sometimes
have to refer to board model for board-specific workarounds.

> I don't think the device tree has much use beyond the
> advertisement and authorisation of use of system devices,
> and as the most basic and essential automatic driver
> processes (probe and initialisation).

Again, you are free to your own opinion.

> It is quite another
> matter to make it a kind of Linux-programmers errata
> replacement framework and artificially recreate already
> easily-accessible information.

No one is proposing that I hope.  This information indeed
is already easily available in most cases -- namely, in
the device tree.


Segher
