Return-Path: <dgibson@ozlabs.org>
Date: Wed, 14 Feb 2007 16:24:40 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] powerpc: delete boot-cpu and chosen nodes from all DTS
	files
Message-ID: <20070214052440.GB12609@localhost.localdomain>
References: <11713852392294-git-send-email-timur@freescale.com>
	<20070214003119.GF11491@localhost.localdomain>
	<45D29BBA.7090401@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <45D29BBA.7090401@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Feb 13, 2007 at 11:18:50PM -0600, Timur Tabi wrote:
> David Gibson wrote:
> 
> >> -       chosen {
> >> -               name = "chosen";
> >> -               linux,platform = <0>;
> >> -               interrupt-controller = <10c00>;
> >> -               linux,phandle = <400>;
> >> -       };
> >> -
> > 
> > Um.. at least the interrupt-controller property here should be fixed,
> > and thus should probably remain in the dts.
> 
> Can you be more specific?  I'm not familiar with this board, so I don't 
> really know what you're talking about.

The interrupt-controller property in /chosen just points to the
system's top-level interrupt controller to make it easier for the
kernel to find in the tree.  I think most platforms don't actually
need or use it at present, but booting-without-of does recommend it.

As such it's a property of the board, not something which will change
from boot to boot.  It would therefore be rather strange for the
bootloader to poke this property.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
