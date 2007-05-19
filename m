Return-Path: <matt@genesi-usa.com>
Received: from mail.genesi-usa.com (mithrandir.softwarenexus.net
	[66.98.186.96])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D43BADDEF5
	for <linuxppc-dev@ozlabs.org>; Sat, 19 May 2007 23:41:20 +1000 (EST)
Message-ID: <464EFE96.3000801@genesi-usa.com>
Date: Sat, 19 May 2007 14:41:42 +0100
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [i2c] [PATCH 3/5] powerpc: Document device nodes for I2C devices.
References: <20070517143846.GC29795@ld0162-tx32.am.freescale.net>	<FB8DD3C1-A095-4ABB-9E74-7EC66A43D983@kernel.crashing.org>	<464C800C.20400@freescale.com>	<FFBD3A3A-ADBE-4DC8-A1A1-4163367244D5@kernel.crashing.org>	<464C871C.4090300@freescale.com>	<5B363A90-5528-4441-BBF9-9C6D8833D938@kernel.crashing.org>	<20070518171555.543f9bdc@hyperion.delvare>	<D50C4D36-CEA5-4F7F-8A4C-CC747DF85865@kernel.crashing.org>	<464DD5E3.1060301@freescale.com>
	<6F8D3143-423D-45FA-9F40-00BF770831F2@kernel.crashing.org>
	<464E3F18.5010700@genesi-usa.com>
	<2087d135c4139e94e0b2c8826d808292@kernel.crashing.org>
In-Reply-To: <2087d135c4139e94e0b2c8826d808292@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8
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


Segher Boessenkool wrote:
> 
> Yes, all devices should be in the device tree.  That's
> what it's for.
> 
>> You're not ever going to be able to specify in the device tree
>> exactly how to handle a driver, encompassing both implementation,
>> bugs in revisions, quirks of board design, but you can specify
>> for a driver a very accurate, very educated guess on it (any
>> quirks, bugs or implementation differences would be board/chip
>> specific, and are easily derived from the other device nodes
>> like the cpu node, soc node, and so on)
> 
> Actually, you can, and should.  All this information is
> contained in the "compatible" and "model" properties.
> "Quirks of board design" can be described too, on a case-
> by-case basis.
>
> All the knowledge about how to drive the device resides
> in the kernel, but the device tree describes exactly what
> device this is, so the kernel can match a driver to it
> uniquely, and the driver can know exactly what revision
> chip this is and what quirks to apply.

That's what I said wasn't it?

If you have a buggy i2c controller or one that has a strange
quirk, but it's present as fsl-i2c in those device trees,
would you specify that it is fsl-i2c-less-bugs later?
Would you add property after property to describe errata,
quirks in the nodes themselves?

I don't see the point in that, when such information is
nearly always derivable from other parts of the device
tree. An ATA node does not contain the timings for devices
on that bus. The driver usually has to work that out. If
there is a quirk to be implemented, this will be described
by the PVR/SVR and other system information already in the
device tree. The clock distribution module in the MPC52xx
changed some bit settings between the original and B versions,
I don't see any benefit in having a property or a name
change (from mpc5200-cdm or so in this example) when the
differences are well documented and also easy to work out
from the device tree without additional properties, or
name changes. If the register location changes, the register
property handles it. If the operation changes this is defined
by both the soc svr, possibly a board model, and also
possibly by the pvr (cache sizes etc.).

I'll take an example of putting useless information in
the device tree - how about the CPU node? It has all the
information for cache sizes etc. but does Linux use it?
No.. the only ONLY chip I have seen this information be
relevant on is the MPC7447/MPC7457 where it is impossible
to determine by PVR which chip you have, and even then
impossible to determine the L3 cache size. And Linux
does not even handle this; the firmware sets it up and
the L3 registers are already there for Linux to pick up
on.

This is what I mean by 'describing exactly what the device
is' being rather a tedious and time-wasting concept.

I might be a little less noisy about it if there was
some kind of edict for devices never to wander outside
of their own node in the device tree, but there isn't.
You have the entire board description available and when
that information doesn't exist, it is usually in the
chip or board itself.

I don't think the device tree has much use beyond the
advertisement and authorisation of use of system devices,
and as the most basic and essential automatic driver
processes (probe and initialisation). It is quite another
matter to make it a kind of Linux-programmers errata
replacement framework and artificially recreate already
easily-accessible information.

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations
