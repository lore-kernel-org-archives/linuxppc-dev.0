Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.179]) by ozlabs.org (Postfix) with ESMTP id 5096EDDE44
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 09:39:51 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC/PATCH] powerpc: Rewrite IO allocation & mapping on powerpc64
Date: Tue, 15 May 2007 01:39:41 +0200
References: <20070514075415.7999BDDEC8@ozlabs.org>
	<200705141637.19572.arnd@arndb.de>
	<1179176381.32247.98.camel@localhost.localdomain>
In-Reply-To: <1179176381.32247.98.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200705150139.41722.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 14 May 2007, Benjamin Herrenschmidt wrote:
> > Can we make this depend on CONFIG_ISA? Most platforms don't actually want
> > to build in ISA support.
> 
> I'm not too sure about that. CONFIG_ISA means you have legacy devices or
> ISA slots ? or both ?
> 

Good point, it means ISA slots, so it's probably not the right option here:

config ISA
        bool "Support for ISA-bus hardware"
        depends on PPC_PREP || PPC_CHRP
        select PPC_I8259
	help
	  Find out whether you have ISA slots on your motherboard.  ISA is the
	  name of a bus system, i.e. the way the CPU talks to the other stuff
	  inside your box.  If you have an Apple machine, say N here; if you
	  have an IBM RS/6000 or pSeries machine or a PReP machine, say Y.  If
	  you have an embedded board, consult your board documentation.

(side note: funny how it recommends to say Y for pSeries, but doesn't allow it ;-).

Maybe we should instead build the new file depending on a new option and make
the Kconfig read as

config ISA
	def_bool y
	depends on PPC_PREP || PPC_CHRP
	select PPC_I8259
	select LEGACY_IOPORT
	help
	  This option is for actual ISA slots

config LEGACY_IOPORT
	bool
	# maybe convert some of these into select statements
	default y if PPC_UDBG_16550
	default y if SERIO_I8042  || PPC_I8259 || PARPORT_PC 
	default y if MAPLE || MPC8641_HPCN
	default y if BLK_DEV_FD || PATA_LEGACY || IDE
	default y if VGA_CONSOLE || FB
	help
          This option enables the use of hardcoded PIO port numbers
	  in device drivers.

An interesting case is the frame buffer, most fb drivers use hardcoded
register numbers for the VGA ports, without calling check_legacy_ioport,
but rely on PCI probing to detect the presence of the device.
Some IDE drivers do the same, but libata does not. Apparently, these
are already broken if you plug such hardware into a secondary PCI bus.

	Arnd <><
