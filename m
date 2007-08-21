Return-Path: <dgibson@ozlabs.org>
Date: Tue, 21 Aug 2007 15:00:39 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 1/4] [POWERPC] Move iSeries startup code out of head_64.S
Message-ID: <20070821050039.GB21169@localhost.localdomain>
References: <20070821144222.e240bbf0.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070821144222.e240bbf0.sfr@canb.auug.org.au>
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Aug 21, 2007 at 02:42:22PM +1000, Stephen Rothwell wrote:
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  arch/powerpc/kernel/head_64.S           |   86 +-----------------------
>  arch/powerpc/platforms/iseries/Makefile |    1 +
>  arch/powerpc/platforms/iseries/head.S   |  114 +++++++++++++++++++++++++++++++

Hrm...  could we call it something other than head.S?

For me, "head" kind of implies that it's actually at the head/bottom
of the kernel binary, and should therefore only contain things which
require a fixed offset address.  And the whole point here is that
you're removing things that don't in fact have such constraints.

Perhaps exceptions.S, or os_entry.S?

>  include/asm-powerpc/ppc_asm.h           |   14 ++++
>  4 files changed, 131 insertions(+), 84 deletions(-)
>  create mode 100644 arch/powerpc/platforms/iseries/head.S
> 
> Built for iseries_defconfig, pseries_defconfig, ppc64_defconfig,
> allmodconfig and booted on iSeries 270 for iseries_defconfig and
> ppc64_defconfig.
> 

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
