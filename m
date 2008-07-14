Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 503B9DE04C
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Jul 2008 18:45:16 +1000 (EST)
Subject: Re: build error in powerpc tree
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20080714170301.93f940fd.sfr@canb.auug.org.au>
References: <20080714170301.93f940fd.sfr@canb.auug.org.au>
Content-Type: text/plain
Date: Mon, 14 Jul 2008 18:39:03 +1000
Message-Id: <1216024743.7549.266.camel@pasglop>
Mime-Version: 1.0
Cc: ppc-dev <linuxppc-dev@ozlabs.org>,
	Dave Kleikamp <shaggy@linux.vnet.ibm.com>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2008-07-14 at 17:03 +1000, Stephen Rothwell wrote:
> Hi Ben,
> 
> Commit ef3d3246a0d06be622867d21af25f997aeeb105f ("powerpc/mm: Add Strong
> Access Ordering support") in the powerpc/{next,master} tree caused the
> following in a powerpc allmodconfig build:
> 
> usr/include/asm/mman.h requires linux/mm.h, which does not exist in exported headers
> 
> Also, that header file is now using CONFIG_PPC64 which we should not do
> in the unprotected (by #ifdef __KERNEL__) part an exported header file,
> we should use __powerpc64__ instead.
> 
> I suspect all the CONFIG_PPC64 part of the file could be surrounded by
> #ifdef __KERNEL__ and the include of <linux/mm.h> could be moved to this
> section.  The file should then be changed to unifdef-y from header-y in
> the Kbuild file.  (Might have been easier to send a patch :-))

I'll dbl check tomorrow. PROT_SAO must be exported always but everything
else should pretty much be under __KERNEL__. Interesting that this
hasn't shown up in Paulus test build scripts that I used.

Cheers,
Ben.
