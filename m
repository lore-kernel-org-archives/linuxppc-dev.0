Return-Path: <dgibson@ozlabs.org>
Date: Thu, 15 Feb 2007 10:33:48 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] powerpc: delete boot-cpu and chosen nodes from all DTS
	files
Message-ID: <20070214233348.GH16279@localhost.localdomain>
References: <11713852392294-git-send-email-timur@freescale.com>
	<20070214003119.GF11491@localhost.localdomain>
	<45D29BBA.7090401@freescale.com>
	<20070214052440.GB12609@localhost.localdomain>
	<45D31734.7030808@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <45D31734.7030808@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Feb 14, 2007 at 08:05:40AM -0600, Timur Tabi wrote:
> David Gibson wrote:
> 
> > The interrupt-controller property in /chosen just points to the
> > system's top-level interrupt controller to make it easier for the
> > kernel to find in the tree.  I think most platforms don't actually
> > need or use it at present, but booting-without-of does recommend it.
> > 
> > As such it's a property of the board, not something which will change
> > from boot to boot.  It would therefore be rather strange for the
> > bootloader to poke this property.
> 
> That's all the more reason to delete the 'chosen' section, isn't it? 
> Sicne it's wrong, deleting the entire section will just make the problem 
> go away.  Or am I missing something?

Er.. I think you're missing something.

My point is that the interrupt-controller property in /chosen *should*
be there, but it doesn't make a lot of sense for it to be set by the
bootloader (because it's a fixed property of the board).  Therefore it
should be in the dts, therefore the /chosen node needs to be there to
contain it.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
