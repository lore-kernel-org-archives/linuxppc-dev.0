Return-Path: <dgibson@ozlabs.org>
Date: Tue, 13 Feb 2007 15:29:37 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 15/19] bootwrapper: Add initrd information to the device
	tree in ft_finalize().
Message-ID: <20070213042937.GC5345@localhost.localdomain>
References: <20070207230017.GA3758@ld0162-tx32.am.freescale.net>
	<20070207230140.GO3849@ld0162-tx32.am.freescale.net>
	<20070209230207.GA12035@mag.az.mvista.com>
	<45D098E5.3090109@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <45D098E5.3090109@freescale.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Feb 12, 2007 at 10:42:13AM -0600, Scott Wood wrote:
> Mark A. Greer wrote:
> >>diff --git a/arch/powerpc/boot/flatdevtree_misc.c b/arch/powerpc/boot/flatdevtree_misc.c
> >>index 04da38f..39fa010 100644
> >>--- a/arch/powerpc/boot/flatdevtree_misc.c
> >>+++ b/arch/powerpc/boot/flatdevtree_misc.c
> >>@@ -33,8 +33,20 @@ static int ft_setprop(const void *phandl
> >> 	return ft_set_prop(&cxt, phandle, propname, buf, buflen);
> >> }
> >> 
> >>-static unsigned long ft_finalize(void)
> >>+unsigned long ft_finalize(void)
> > 
> > 
> > This is unnecessary.  There is already global access from
> > dt_ops.finalize.
> 
> cuboot has its own dt_ops.finalize, which calls ft_finalize, and 
> relocates the tree to someplace that won't get overwritten by the kernel 
> relocation.

Why is cuboot's malloc() allocating the flat tree in a place that's in
danger of being clobbered by the kernel in the first place?

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
