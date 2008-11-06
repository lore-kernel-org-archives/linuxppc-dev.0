Return-Path: <tmorrison@empirix.com>
Received: from empbedex1.empirix.com (empbedex1.empirix.com [12.38.203.54])
	by ozlabs.org (Postfix) with ESMTP id C14F4DDDFB
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Nov 2008 00:56:03 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Patch to fix problem? was: PCI Express between MPC8572 & PLX8616
Date: Thu, 6 Nov 2008 08:55:56 -0500
Message-ID: <BD261180E6D35F4D9D32F3E44FD3D9010EEBF5E1@EMPBEDEX.empirix.com>
References: <16691A8B34B5D9458EA3A1C37A11555A0137F866@tanisys-ex2.Tanisys.Local>
From: "Morrison, Tom" <tmorrison@empirix.com>
To: <galak@kernel.crashing.org>,
	<linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Sorry for such a wide query...but I did some searching of the linux =
trees...
and I am at a loss to find what the below email refers to in terms of a =
fix=20
for pci express....and I am having a hard time finding it in all of the =
commits?
=20
any pointers to the right tree and/or the specific fix would be greatly =
appreciated!

________________________________

=20
=3D=3D> a friend respond to the original subjectline..
=20
> Has anybody every used this chip in their design??

No, but I have 2 other PLX PCI-E switches that would not behave.

> FYI, we have a custom board that I am bringing up right now
> that has a
> MPC8572E that has its PCIE1 connected to the subject line PLX8616
> PCI Express Switch...

So you have the cpu as root-complex attached to the PLX upstream port
and the PLX downstream ports going somewhere else.

> As part of the boot, we successfully discover config the
> internal bridge
> (its in root complex mode) inside the MPC8572E, and from 'many'
> view points (hardware LED's and status registers) - there seems to
> be 4 lanes in between the Switch and the CPU...

Are you doing this by using a PCI-E analyzer, or by what you see U-boot
doing.  BTW, in my case, the LEDs always worked but nothing else did.
So the lane good LEDs would light up, but the whole interface was
hopelessly broken.

> But, at the first external config cycle - something goes very wrong -
> the response (or lack of that =E8 0xffff) is returned, as well as
> and the associated CCSR's PCIE1 interface is completely
> reset (we implement and attempt to recover this interface
> via Freescale's CPU Errata #4) - but beyond that - it
> never recovers and re-sync's these 4 lanes up....

By external configuration cycle, do you mean when the cpu goes out to
configure the items on the secondary bus side of the plx switch?  or
the secondary side of the internal pci-e bridge.  In either case, this
could be the same problem I just went through.  A workaround was =
recently
(like maybe 2 weeks ago) put into the kernel to address this on powerpc
systems, so you might try pulling down a recent kernel via git and see
if that helps.  I would have copied the mailing list, but for some
reason it is rejecting my mail at the moment.

I can say that I tested this fix and it definately fixed all the
secondary ports on my system.  I used a pci-e analyzer so it was a
little easier to see what was going on, but in the end it was clear that
there was something wrong in the powerpc ports, b/c I did not see this
with the same parts on an x86 host.



=20
