Return-Path: <dwg@au1.ibm.com>
Received: from ausmtp06.au.ibm.com (ausmtp06.au.ibm.com [202.81.18.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ausmtp06.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 102B5DDE43
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 11:44:39 +1000 (EST)
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by ausmtp06.au.ibm.com (8.13.8/8.13.8) with ESMTP id l4F1k5Ou8769732
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 11:46:05 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.250.242])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l4F1m6iS122406
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 11:48:06 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l4F1iY45018884
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 11:44:35 +1000
Date: Tue, 15 May 2007 11:44:31 +1000
From: David Gibson <dwg@au1.ibm.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH 0/3] Initial AMCC Bamboo support
Message-ID: <20070515014431.GF565@localhost.localdomain>
References: <1179154608.3420.21.camel@zod.rchland.ibm.com>
	<20070515012629.GC565@localhost.localdomain>
	<1179193113.3420.95.camel@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1179193113.3420.95.camel@zod.rchland.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, May 14, 2007 at 08:38:33PM -0500, Josh Boyer wrote:
> On Tue, 2007-05-15 at 11:26 +1000, David Gibson wrote:
> > On Mon, May 14, 2007 at 09:56:48AM -0500, Josh Boyer wrote:
> > > Hi All,
> > > 
> > > The following patches add the initial AMCC Bamboo eval board support.  
> > > 
> > > The support for peripheral devices at the moment is rather limited as
> > > the board is quite complicated in it's muxing of I/O lines.  Until the
> > > bootwrapper can figure out how to setup the EBC peripherals based on the
> > > dip switch settings, the DTS will lack any EBC devices.
> > 
> > Ick.  Can you describe roughly the setup here?  It might be that the
> > simplest approach is to include all options in the DTS, and delete
> > ones that aren't selected from the bootwrapper.
> 
> There's 3 switches that directly control the EBC memory map, and a
> handful of other pin strap registers add to that.  To further complicate
> things, there are two passes of the Bamboo board and the settings mean
> different things to the individual board revisions.
> 
> By comparison, there's about 350 lines of code in U-Boot to do the setup
> of the EBC.  It's not horrible, but I'm not sure it wants to be
> duplicated in the wrapper either.
> 
> > I have a patch which might help here, which fills in the ebc's
> > 'ranges' property based on the contents of the EBC bridge registers.
> > I'm using it as part of the code necessary to get the right address
> > for the Ebony flash depending on DIP switch settings.
> 
> Ooh... that's actually what I was thinking of doing.  Though I was
> planning on poking individual nodes' regs properties instead.

You may need to do both.  At least if you use the same format for the
ebc binding as I have on Ebony: in the reg properties of the
individual nodes I directly encode the ebc chip select value and
offset within the peripheral bank.  The ebc node's 'ranges' gives the
mappings into the OPB space.  So, in practice, the low 20 bits of
address are determined by the individual peripheral's reg properties,
and the upper 12 bits are determined by the ranges property at the EBC
node.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
