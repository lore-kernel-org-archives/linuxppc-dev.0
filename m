Return-Path: <dgibson@ozlabs.org>
Date: Mon, 24 Sep 2007 13:09:37 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH 5/15] bootwrapper: occuppied memory ranges
Message-ID: <20070924030937.GF8058@localhost.localdomain>
References: <boot-8-00.miltonm@bga.com> <boot-8-05.miltonm@bga.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <boot-8-05.miltonm@bga.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Rob Landley <rob@landley.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Sep 21, 2007 at 06:04:18PM -0500, Milton Miller wrote:
> Add a set of library routines to manage gross memory allocations.
> 
> This code uses an array in bss to store upto 32 entrys with merging
> representing a range of memory below rma_end (aka end of real mode
> memory at 0).
> 
> To use this code, a platform would set rma_end (find_rma_end), mark
> memory ranges occupied (add_known_ranges et al), initialize malloc in
> the spaces between (ranges_init_malloc), and optionally use the supplied
> vmlinux_alloc may be used.
> 
> Signed-off-by: Milton Miller <miltonm@bga.com>
> --- 
> vs 12172
> rename rmo_end to rma_end (real mode area, as used in papr)
> removed section labels (now in ops.h)
> rediff ops.h, Makefile
> moved find_rma_end here (from kexec.c in a later patch)
> find_rma_end searches by node type for "memory", checks that
> 	the parent is the root node, then looks for a reg property
> 	with the first address/size pair starting at 0.

Urg.  It's an awful lot of code for the bootwrapper.  Am I right in
understanding that the only reason to use the ranges code is for the
ranges based malloc() and vmlinux_alloc() you get out of it?

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
