Return-Path: <segher@kernel.crashing.org>
In-Reply-To: <20070329003550.GB25652@localhost.localdomain>
References: <20070328011924.GA1586@mag.az.mvista.com>
	<20070328012206.GD1586@mag.az.mvista.com>
	<9696D7A991D0824DBA8DFAC74A9C5FA302BDAB3E@az33exm25.fsl.freescale.net>
	<20070329003550.GB25652@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <2cd6c2dd69700dd162e90f8b7a83a99d@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC 3/3] powerpc: Add DTS file for the Motorola PrPMC2800
	platform
Date: Thu, 29 Mar 2007 02:48:47 +0200
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>,
	Dale Farnsworth <dfarnsworth@mvista.com>,
	Yoder Stuart-B08248 <stuart.yoder@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> That does seem like a lot.  The only thing that should need
> virtual-reg properties is serial ports.  In fact, specifically, only
> serial ports that the zImage is actually expected to use.
>
> In fact, with Scott's addition of xlate_reg() to the bootwrapper,
> virtual-reg should only be needed on systems that enter the zImage
> with MMU on.

Even then, you can just query the MMU structures to
find out the currently set up translations for that
physical address.  Way more robust.

The only valid reason to use "virtual-reg" is as a
hack to map some device to get some debug output out.

If for normal usage you can't be bothered to parse
the current translations, you probably shouldn't be
doing anything as "advanced" as device I/O either --
just boot the kernel and let it handle it ;-)

That said, I sure hope the kernel isn't using this
property as well...


Segher
