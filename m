Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 43209DDE2E
	for <linuxppc-dev@ozlabs.org>; Sun,  4 Nov 2007 20:24:48 +1100 (EST)
In-Reply-To: <DD2A9B2C-5D35-4F53-8542-3470C6FA5265@kernel.crashing.org>
References: <DD2A9B2C-5D35-4F53-8542-3470C6FA5265@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <6eabf485a3aae685b1847bbb3d5a2dd0@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: use of aliases in device trees
Date: Sun, 4 Nov 2007 10:24:37 +0100
To: Kumar Gala <galak@kernel.crashing.org>
Cc: linux-ppc list <linuxppc-dev@ozlabs.org>,
	U-Boot Users List <u-boot-users@lists.sourceforge.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> In some discussion on the u-boot dev list it became clear that having
> aliases in the device tree might be useful as a common way to deal
> with finding specific nodes that need fixing up by the firmware.

> One common solution would be having a top level aliases like the pmac
> tree's have:
>
> aliases {
> 	enet0 = "...";
> 	enet1 = "...";
> 	pci0 = "...";
> 	pci1 = "...";
> };

It's not just Apple that uses this; this is standard OF stuff.

> I wanted to see what people think of this idea and about trying to
> use common names for the aliases?

I'm obviously all for it, having suggested it myself a few times.

For common names, I think a good starting point would be to use
the generic names (as defined in the "generic names" recommended
practice; this should be the name of the nodes pointed to as well),
followed by a number; and/or a generic name without any suffix,
which points to the "main" device of that type.

This is a lot like your example, except that "enet" isn't a generic
name (that would be "network" I believe).  It is perfectly fine to
have to or more aliases pointing to the same node though.

This won't solve all identification problems of course, it only gives
an ordering per class of devices, but in most cases this will be enough,
esp. when platform code uses this.  We'll likely need a few extra names
for special cases, but let's use some restraint there, and esp. not
define something as a generic solution when it isn't.


Segher
