Return-Path: <SHorton@kodiaknetworks.com>
Received: from cowboy.inovate.inovate.com (planomail.kodiaknetworks.com
	[76.203.108.6]) by ozlabs.org (Postfix) with ESMTP id 8BC98DE3B7
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 30 Jul 2008 23:56:21 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: mpc744x, Marvell mv6446x kernel guidance please
Date: Wed, 30 Jul 2008 08:56:18 -0500
Message-ID: <295C5089A56CE143B316E5F67CA99CB001D06956@cowboy.inovate.inovate.com>
In-Reply-To: <20080728165108.GA22621@mag.az.mvista.com>
References: <295C5089A56CE143B316E5F67CA99CB001C9E4BD@cowboy.inovate.inovate.com>
	<20080728165108.GA22621@mag.az.mvista.com>
From: "Stephen Horton" <SHorton@kodiaknetworks.com>
To: "Mark A. Greer" <mgreer@mvista.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello Mark,

Thanks for your kind encouragement. I now have a mostly booting kernel.
I have just a few remaining issues to resolve; perhaps you (or others)
can give me some tips regarding these:

1. In your prpmc2800 .dts configuration, in the PCI bus configuration
section, you lay-out the IRQ mappings like this:
	interrupt-map =3D <
                /* IDSEL 0x0a */
                5000 0 0 1 &/mv64x60/pic 50
                5000 0 0 2 &/mv64x60/pic 51
I've read the Open Firmware document on Interrupt Mapping, but I still
don't really understand the first 3 columns (5000 0 0), especially where
the first column comes from. Is this just some arbitrarily selected
offset address for that device on the pci bus?

2. I've also grabbed some of the recent katana750i .dts examples that
you were working on from one of the git trees (as well as Remi Machet's
GEFanuc C2k board .dts code which is also based on your prpmc2800). Like
your katana750i example, my board also has 2 PMC sites. In your
cuboot-katana.c file, where you are setting up the PCI devices in
'katana750i_bridge_setup', I'm having trouble understanding how you
selected the bitmask values to Disable and Enable cpu->pci windows?
	enables =3D in_le32((u32 *)(bridge_base +
MV64x60_CPU_BAR_ENABLE));
	enables |=3D 0x0007fe00; /* Disable all cpu->pci windows */
	out_le32((u32 *)(bridge_base + MV64x60_CPU_BAR_ENABLE),
enables);
and here:
	enables &=3D ~0x0000c000; /* Enable cpu->pci1 i/o, cpu->pci1 mem0
*/
	out_le32((u32 *)(bridge_base + MV64x60_CPU_BAR_ENABLE),
enables);
Can you point me in the right direction to understand this? I have
MPC7450 processor family docs for my processor as well as access to
Marvell docs.

3. My Marvell chip is a MV64462. Unlike the MV64460, it only has a
single Gig Ethernet interface, which on my board connects to an 8-port
Broadcom BCM5388 Ethernet Switch. This switch additionally has 2 Gig E
interfaces for each PMC site, 2 PICMG 2.16 connected interfaces, and 1
faceplate connected port. I am successful in getting the Marvell to
setup a Mac-to-Mac connection to the switch via its connected port, but
I'm unsure how to tell Linux about the other ports on the switch,
primarily the 2 PICMG 2.16 ports and the faceplate port.  I have access
to the switch in my platform .c file, where I am configuring and
verifying that I have the mac-mac connection setup.  Can you speculate
on how I can get the other interfaces to configure? Do I need to a
section in my .dts for the Broadcom switch? My .dts currently only has 1
ethernet and 1 PHY defined... Or, should I setup multiple Ethernet
sections all on the same PHY, or something like that? Or, should I just
do something in my platform file to get Linux to add the other
interfaces?

I appreciate any other addition thoughts you can give,
Regards,
Stephen

-----Original Message-----
From: Mark A. Greer [mailto:mgreer@mvista.com]=20
Sent: Monday, July 28, 2008 11:51 AM
To: Stephen Horton
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: mpc744x, Marvell mv6446x kernel guidance please

On Thu, Jul 10, 2008 at 10:46:49PM -0500, Stephen Horton wrote:
> Hello folks,
>=20
> In a current work project, I have inherited a compactPCI board that
has
> an mpc7447/7448 powerpc processor as well as a Marvell system
> controller, model mv64462 (stripped down mv64460). The board has a
> somewhat working Gentoo Linux port running on it from long ago and a
> company far far away (kernel version 2.6.9 built using arch/ppc). To
> prepare for an upcoming deployment, I would like to bring the OS
> up-to-date on this board with a newer kernel (targeting Gentoo 2008),
> but I am unsure of the approach to take. I am a software developer,
but
> normally do not work on kernel porting / board integration. I have
> researched the arch/ppc to arch/powerpc migration, but I'm a bit
> intimidated by the 'new' device tree symantics and other changes to
the
> stream. Here are some questions:
>=20
> 1.	Is it possible with the 2.6.24 (Gentoo 2008) kernel to still use
> arch/ppc for this platform architecture?  I've tried to get this to
> compile, but am having trouble with files from arch/powerpc getting
> pulled in; then I read some comments (from I believe this forum) that
> indicated that arch/ppc is not longer supposed to compile

arch/ppc is gone now.  You should spend you effort working in
arch/powerpc.

> 2.	Does anyone have example code for this platform architecture?
> Any freebees I could use for creating my device tree?

You can use prpmc2800 as an example.

> 3.	Any advice of any kind?

Its not as bad as it looks.  Just dig into it and don't give up.

Mark
