Return-Path: <mgreer@mvista.com>
Date: Mon, 2 Apr 2007 11:26:32 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC 3/3] powerpc: Add DTS file for the Motorola PrPMC2800
	platform
Message-ID: <20070402182632.GI2132@mag.az.mvista.com>
References: <20070328011924.GA1586@mag.az.mvista.com>
	<20070328012206.GD1586@mag.az.mvista.com>
	<9696D7A991D0824DBA8DFAC74A9C5FA302BDAB3E@az33exm25.fsl.freescale.net>
	<20070329003550.GB25652@localhost.localdomain>
	<2cd6c2dd69700dd162e90f8b7a83a99d@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2cd6c2dd69700dd162e90f8b7a83a99d@kernel.crashing.org>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>,
	Yoder Stuart-B08248 <stuart.yoder@freescale.com>,
	Dale Farnsworth <dfarnsworth@mvista.com>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Mar 29, 2007 at 02:48:47AM +0200, Segher Boessenkool wrote:
> > That does seem like a lot.  The only thing that should need
> > virtual-reg properties is serial ports.  In fact, specifically, only
> > serial ports that the zImage is actually expected to use.
> >
> > In fact, with Scott's addition of xlate_reg() to the bootwrapper,
> > virtual-reg should only be needed on systems that enter the zImage
> > with MMU on.
> 
> Even then, you can just query the MMU structures to
> find out the currently set up translations for that
> physical address.  Way more robust.

Yes, that is the most robust but its also more complicated.
A higher authority will have to make that call.  In the meantime,
a patch would be useful to see just what it would take.

> The only valid reason to use "virtual-reg" is as a
> hack to map some device to get some debug output out.

Not true, its for more than just output.
See my response to David's email.

> If for normal usage you can't be bothered to parse
> the current translations, you probably shouldn't be
> doing anything as "advanced" as device I/O either --
> just boot the kernel and let it handle it ;-)

Well, the overall idea is that we remove boot/init related code from the
kernel and leave it to the firmware or the bootwrapper (if the firmware
doesn't provide the required functionality).  For example, the VPD code
in .../boot/prpmc2800.c in my patches.  Also, at one time there was code
to get the MAC addr from i2c prom and stick it in the dt.  I can see
that being fairly common for non-OF/uboot platforms.

> That said, I sure hope the kernel isn't using this
> property as well...

It certainly shouldn't be.  Its a bootwrapper-only hack.

Mark
