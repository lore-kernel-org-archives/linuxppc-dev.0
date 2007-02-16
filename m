Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17877.1576.405941.835140@cargo.ozlabs.ibm.com>
Date: Fri, 16 Feb 2007 12:17:28 +1100
From: Paul Mackerras <paulus@samba.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 15/16] Add device tree for Ebony
In-Reply-To: <65b693652fa034ed521e132a6142b3b7@kernel.crashing.org>
References: <20070213060904.GA6214@localhost.localdomain>
	<20070213061026.5837FDDDE9@ozlabs.org>
	<9696D7A991D0824DBA8DFAC74A9C5FA302A1B705@az33exm25.fsl.freescale.net>
	<1171470754.4003.101.camel@zod.rchland.ibm.com>
	<6206de08b7f12175bebe669291c66334@kernel.crashing.org>
	<9696D7A991D0824DBA8DFAC74A9C5FA302A1B86F@az33exm25.fsl.freescale.net>
	<9df9bf3adf511f4c1a7945e022fdd447@kernel.crashing.org>
	<9696D7A991D0824DBA8DFAC74A9C5FA302A1B8EF@az33exm25.fsl.freescale.net>
	<1171489360.20192.184.camel@localhost.localdomain>
	<122a66d49480520cf87cd748bbfc50bb@kernel.crashing.org>
	<17875.49565.444870.924729@cargo.ozlabs.ibm.com>
	<6c90a73251f09d619498c77264a15fef@kernel.crashing.org>
	<17875.53329.662052.612956@cargo.ozlabs.ibm.com>
	<65b693652fa034ed521e132a6142b3b7@kernel.crashing.org>
Cc: David Gibson <david@gibson.dropbear.id.au>,
	Yoder Stuart-B08248 <stuart.yoder@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Segher Boessenkool writes:

> > We don't require an OF device tree;
> 
> When booting on real OF you do.

No, the kernel requires a flattened tree, which is created by glue
code from the OF device tree.  Currently everything in the OF tree
goes across into the flattened tree, but in future there may not be a
1-1 correspondence.

> > what we require is something that
> > provides a way to express what the kernel needs to know about the
> > hierarchy, interconnections and characteristics of the devices in the
> > system.
> 
> Sure.  You could have chosen a structure that is closer to the
> internal Linux structures.

What internal Linux structures?  In any case it's a mistake to tie
internal and external structures together because it creates future
compatibility headaches.

> > That it looks strangely familiar to you is just a
> > coincidence. :)
> 
> Heh suuuuuuuure :-)

The device tree is basically a generalization of the list of tags +
values that ppc and other architectures use.  The tags are strings
rather than numbers, because that makes sense, and you can group sets
of tags + values that relate to a particular device together, and you
can link devices together in a hierarchical arrangement.

The last thing I want to do is to put unnecessary burdens on embedded
platforms just to comply with OF requirements.  We have the device
tree because it makes sense both for embedded and for desktop/server
machines, not because OF is some sort of holy writ.

Paul.
