Return-Path: <dgibson@ozlabs.org>
Date: Fri, 13 Apr 2007 21:48:18 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 0/7] Kconfig cleanup part II
Message-ID: <20070413114818.GC17568@localhost.localdomain>
References: <Pine.LNX.4.64.0704121806330.28324@localhost.localdomain>
	<200704131337.08029.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <200704131337.08029.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Apr 13, 2007 at 01:37:07PM +0200, Arnd Bergmann wrote:
> On Friday 13 April 2007, Kumar Gala wrote:
> > Here the second part of the Kconfig cleanup to move all the
> > platform/*/Kconfig to be sourced by platform/Kconfig.  Plus some other
> > minor cleanups.
> 
> Nice patches, I had thought about doing these as well after
> I have cleaned up the CPU selection.
> 
> Two questions though:
> - Is there a technical reason why we want to disallow building
>   a kernel that contains a combination of 6xx, 83xx, 86xx and
>   embedded6xx platforms, or are there only bugs that make it
>   impossible?
> 
> - I'm still not sure whether platform selection or cpu selection
>   should come first, three options I can think of are:
>   1. CPU first, then platform:
>      you might choose to build a kernel for 970 exclusively, which
>      would allow you to select powermac, pseries and maple but no
>      other platforms.
>   2. Platform first, the CPU:
>      You might select pseries as the only platform, and then get
>      presented with the choice between power3 to power6, rs64
>      and 970, but not cell or pa6t.
>   3. platform and CPU depend on instruction set, but not on each other,
>      You only choose between powerpc64, 4xx, 6xx, e200, e500 or 8xx.
>      This would allow nonworking setups though, like a 83xx platform
>      with a 601 cpu or a ps3 with power5 cpu.

I would suggest CPU family first (where "family" mostly corresponds to
MMU design: 4xx, 44x, classic32, ppc64 etc.).  Then platforms, with
any combination allowable from the selected CPU family.  Specific CPU
models would usually be implied by platform selection.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
