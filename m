Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao10.cox.net (fed1rmmtao10.cox.net [68.230.241.29])
	by ozlabs.org (Postfix) with ESMTP id 6527967A5E
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Aug 2006 03:04:33 +1000 (EST)
Date: Thu, 17 Aug 2006 10:04:30 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Dan Malek <dan@embeddedalley.com>
Subject: Re: [PATCH] Gunzip call fix for PPC kernel images >4MB
Message-ID: <20060817170430.GK3249@smtp.west.cox.net>
References: <20060816113137.7a8e5608@bob.dt.e-technik.uni-dortmund.de>
	<20060817050408.GJ3249@smtp.west.cox.net>
	<6BBC3673-85C2-4B35-9740-8299BF39A3B7@embeddedalley.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6BBC3673-85C2-4B35-9740-8299BF39A3B7@embeddedalley.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Milton Miller <miltonm@bga.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Aug 17, 2006 at 12:09:56PM -0400, Dan Malek wrote:
> 
> On Aug 17, 2006, at 1:04 AM, Tom Rini wrote:
> 
> 
> >The arch/ppc/boot code makes some assumptions such as that 4MB-8MB  
> >(except
> >on 40x which is end of the wrapper code to 8MB, and BOOT_LOAD defaults
> >to 4MB here) is free to use for malloc()'ing for the inflate routine.
> >
> >It also assumes that the vmlinux.gz will live at BOOT_LOAD + a bit,  
> >when
> >the wrapper is set to kick off linux.
> 
> First, why do you have a 4 MB kernel?
> 
> Second, another bit of luck is that most processors rely on
> the boot information passed to be in the lower 8M of memory.
> There are many comments about this in the initialization code,
> I don't know how many processors actually rely on this.  So,
> if you allow large kernels to be loaded into memory, there should
> be some test to ensure we still have space for these boot
> parameters, however they are passed.

I think this second case is handled as I believe we end up relocating
this information to a 'safer' spot as if it's too low it may be eaten by
the kernel BSS.  But this is indeed something else to be sure will be OK
before we change this code.

-- 
Tom Rini
