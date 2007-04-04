Return-Path: <mgreer@mvista.com>
Date: Wed, 4 Apr 2007 09:27:18 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC 3/3] powerpc: Add DTS file for the Motorola PrPMC2800
	platform
Message-ID: <20070404162718.GC21314@mag.az.mvista.com>
References: <20070328011924.GA1586@mag.az.mvista.com>
	<20070328012206.GD1586@mag.az.mvista.com>
	<9696D7A991D0824DBA8DFAC74A9C5FA302BDAB3E@az33exm25.fsl.freescale.net>
	<20070329003550.GB25652@localhost.localdomain>
	<2cd6c2dd69700dd162e90f8b7a83a99d@kernel.crashing.org>
	<20070402182632.GI2132@mag.az.mvista.com>
	<2feac74905bf1d4fd11725f430cb4078@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2feac74905bf1d4fd11725f430cb4078@kernel.crashing.org>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>,
	David Gibson <david@gibson.dropbear.id.au>,
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

On Wed, Apr 04, 2007 at 01:28:08PM +0200, Segher Boessenkool wrote:
> >>Even then, you can just query the MMU structures to
> >>find out the currently set up translations for that
> >>physical address.  Way more robust.
> >
> >Yes, that is the most robust but its also more complicated.
> 
> Sure.  But if what you want to do is more complicated *anyway*
> (e.g., doing a bunch of device initialisations/configurations),

'***' BEGIN
I'm not doing "device" init as in an I/O device.  I'm doing some bridge
init (e.g, allowing pci devices to access system mem) plus getting VPD
so I know what variant of the board I'm on.  With that info, I can
determine the amount of memory, bus freq, etc.  Those properties
should be correct in the dt before being passed to the kernel, IMHO.
'***' END

Regarding "what you want to do is more complicated *anyway*",
what I'm doing is in *addition* to however I get access to the regs.
So adding page table groking code doesn't eliminate the need for what
I'm doing.

> misusing the quick evil hack that was meant to get debug output
> out originally isn't really warranted.

While virtual-reg may be an evil hack, its also very a simple/small
hack that saves us from adding a whole lot of code to the bootwrapper
(i.e., either ioremap code or page table groking code).

> >>The only valid reason to use "virtual-reg" is as a
> >>hack to map some device to get some debug output out.
> >
> >Not true, its for more than just output.
> >See my response to David's email.
> 
> I said only _valid_ reason.

And I respectfully disagree.  IMHO, my usage is entirely valid.

> I know you're using it for more
> things, that's what I'm complaining about :-)

Understood (but disagreed :).

> >>If for normal usage you can't be bothered to parse
> >>the current translations, you probably shouldn't be
> >>doing anything as "advanced" as device I/O either --
> >>just boot the kernel and let it handle it ;-)
> >
> >Well, the overall idea is that we remove boot/init related code from 
> >the
> >kernel and leave it to the firmware or the bootwrapper (if the firmware
> >doesn't provide the required functionality).
> 
> Some init belongs in the kernel, and some belongs in
> the firmware; if the latter doesn't provide it, it's
> a good idea to do it in the bootwrapper, yes.

Agreed and that's what I'm doing.  I'm configuring things that the fw
really should have but didn't.

> >For example, the VPD code
> >in .../boot/prpmc2800.c in my patches.
> 
> I cannot find those patches right now, but in general,
> that kind of code belongs in the kernel (or in a run-time
> firmware).

See '***' BEGIN -> END above.

> >Also, at one time there was code
> >to get the MAC addr from i2c prom and stick it in the dt.  I can see
> >that being fairly common for non-OF/uboot platforms.
> 
> That's useful, yes, if that I2C PROM sits somewhere away
> from the enet itself (so its access cannot be put in the
> driver for the enet itself).

Agreed and this is my situation.  The prom is not associated with the
enet ctlr and doesn't read it during its init procedure.  It would be
wrong to put code in a kernel driver to run off somewhere else to get
the MAC addrs.

> >>That said, I sure hope the kernel isn't using this
> >>property as well...
> >
> >It certainly shouldn't be.  Its a bootwrapper-only hack.
> 
> Good, that makes all this less severe :-)

;)

Mark
