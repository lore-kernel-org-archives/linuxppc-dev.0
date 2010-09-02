Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 63E6DB717A
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  3 Sep 2010 06:17:57 +1000 (EST)
Subject: Re: Where to put board-specific drivers
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20100902200434.GC24861@ovro.caltech.edu>
Date: Thu, 2 Sep 2010 15:17:52 -0500
Message-Id: <320E0907-436B-42B8-9E85-EABF481FE04C@kernel.crashing.org>
References: <20100902200434.GC24861@ovro.caltech.edu>
To: "Ira W. Snyder" <iws@ovro.caltech.edu>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Sep 2, 2010, at 3:04 PM, Ira W. Snyder wrote:

> Hello all,
>=20
> I've written several drivers for a custom board. The board is =
basically
> an mpc8349_mds board with some extra FPGAs for data processing.
>=20
> All of the drivers were written to interface with a custom system
> controller FPGA, which handles things like LED control, FPGA
> programming, and fast data dumping from the data processing FPGAs.
>=20
> I'd like to start pushing some of these drivers into mainline, but I
> don't know where to put them. I don't think drivers/ is appropriate:
> these are highly board specific. Does arch/powerpc/ have a recommended
> place for board-specific drivers? I was thinking about
> arch/powerpc/drivers/, however that doesn't exist.

If we decide to put them under arch/powerpc I'd suggest =
arch/powerpc/platform/83xx/BOARDNAME/

However I'm not sure I think this is a good idea.  We specifically moved =
drivers out of arch/ppc land so they would get proper review via the =
proper subsystem maintainers.  So if its truly unique / simple board =
drivers than the location I suggested is probably fine.  If its =
something that a subsystem exists than I do think it should be down in =
the subsystem driver dir.

- k=
