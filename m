Subject: Re: [RFC] Simple ioremap cache
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <kumar.gala@freescale.com>
Cc: Eugene Surovegin <ebs@ebshome.net>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <2E7C06A3-B893-11D8-92B4-000393DBC2E8@freescale.com>
References: <20040605002915.GA17603@gate.ebshome.net>
	 <2E7C06A3-B893-11D8-92B4-000393DBC2E8@freescale.com>
Content-Type: text/plain
Message-Id: <1086622041.10517.59.camel@gaston>
Mime-Version: 1.0
Date: Mon, 07 Jun 2004 10:27:22 -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > 1) Should this feature be enabled for all ppc32 archs or only for 4xx?
> > I
> > made ioremap profile for 2.6.6 kernel running on my G4 Powerbook and
> > haven't noticed a lot of ioremap regions overlap (there was one
> > instance where
> > my patch would have helped if I've increased cache size to 32 entries).
>
> This may be due to use of BATs on PPC Classic.

I don't think I use a BAT anymore for IOs on pmac. But I also don't
declare overlapping regions. The only places where I may actually
have a few overlaps are some parts of the mac-io ASIC like the DBDMA
regs since they are offset by 0x400 and I ioremap them separately
in each driver.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
