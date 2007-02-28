Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-02.arcor-online.net (mail-in-02.arcor-online.net
	[151.189.21.42])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C400ADDE33
	for <linuxppc-dev@ozlabs.org>; Thu,  1 Mar 2007 05:54:56 +1100 (EST)
In-Reply-To: <9696D7A991D0824DBA8DFAC74A9C5FA302AA071F@az33exm25.fsl.freescale.net>
References: <200702272254.l1RMsjt2030709@ld0164-tx32.am.freescale.net>
	<20070228005615.GE11775@localhost.localdomain>
	<9696D7A991D0824DBA8DFAC74A9C5FA302AA071F@az33exm25.fsl.freescale.net>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <6687f608d80f1f82105c38bbb56c6628@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC] powerpc: Document new property called interrupt-parents
Date: Wed, 28 Feb 2007 19:54:31 +0100
To: "Yoder Stuart-B08248" <stuart.yoder@freescale.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> Well, whatever Segher says, I'm still very concerned about the
>> potential for extra difficulty in debugging with this approach.
>
> The issue, as I understand it, is the potential for an old
> kernel parser to silently misparse a new dev tree with this
> new property.

Exactly.  Note that such such an old parser will misparse
the "interrupt-array" property as well, namely, not at all.
Debugging *could* be a bit easier though, who knows.

> Do the version and last_comp_version in the blob header
> help here?

That's not what those version fields are for.

The real solution is to just not use too old kernels with
too new a firmware/bootloader/device tree.  This issue
has existed for since forever and is in no way specific
to adding new OF bindings, or specific to Linux, or
anything like that.

> It's more of a general problem.

Quite so.

It might be worthwhile to add a device tree property
"minimum-linux-version" (in the tree root) that the kernel
will parse and complain about loudly if it doesn't match;
at a minimum it will make it super-duper clear to users
of a DTS with that property which combos work.  Documentation
rules ;-)


Segher
