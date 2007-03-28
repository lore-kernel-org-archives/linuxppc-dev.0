Return-Path: <jwboyer@linux.vnet.ibm.com>
Subject: RE: [RFC 3/3] powerpc: Add DTS file for the Motorola PrPMC2800
	platform
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Yoder Stuart-B08248 <stuart.yoder@freescale.com>
In-Reply-To: <9696D7A991D0824DBA8DFAC74A9C5FA302BDAB3E@az33exm25.fsl.freescale.net>
References: <20070328011924.GA1586@mag.az.mvista.com>
	<20070328012206.GD1586@mag.az.mvista.com>
	<9696D7A991D0824DBA8DFAC74A9C5FA302BDAB3E@az33exm25.fsl.freescale.net>
Content-Type: text/plain
Date: Wed, 28 Mar 2007 13:11:19 -0500
Message-Id: <1175105479.7553.75.camel@zod.rchland.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>,
	Dale Farnsworth <dfarnsworth@mvista.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-03-28 at 09:43 -0700, Yoder Stuart-B08248 wrote:
> Biggest concern is that I see a lot of undocumented device
> types and properties...

Yes, but that is a problem in general.

> > +		virtual-reg = <f1000000>;
> 
> What is virtual-reg for?  I gather it is related to the bootwrapper
> needed virtual addresses for devices reg blocks.  But, I counted
> 12 instances of the property in this file.  Are all needed by the
> bootwrapper??
> 
> Does anyone where this property came from historically?  If it's
> specifically for a Linux bootwrapper the name should reflect 
> that-- linux,bootwrapper-reg-vaddr -- or something...

It came from a discussion Mark, I, and a few others had on this list a
few months ago about the requirement for reusing the virtual address set
up by the firmware for the bootwrapper.  You cannot assume a 1:1
physical to virtual mapping for things, so the bootwrapper console code
looks for virtual-reg first and uses that address for it's operations.

> Based on some offline dicussions I think I know what block-index
> is, but I'd like to see this property documented in
> booting-without-of.txt.

As an aside, there's a lot of stuff that needs updating in
booting-without-of.txt.  The interrupt mapping it suggests is incorrect,
some of the entry point stuff is invalid, etc.  There's now several
properties that are being introduced that aren't in there as well.

josh
