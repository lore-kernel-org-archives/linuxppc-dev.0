Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 31C53679E7
	for <linuxppc-dev@ozlabs.org>; Sun, 30 Apr 2006 13:50:38 +1000 (EST)
Date: Sat, 29 Apr 2006 22:50:01 -0500
To: Paul Mackerras <paulus@samba.org>
Subject: Re: please pull powerpc.git 'merge' branch
Message-ID: <20060430035001.GN5518@pb15.lixom.net>
References: <17491.1134.565353.149941@cargo.ozlabs.ibm.com>
	<20060429151936.GM5518@pb15.lixom.net>
	<17491.64254.653743.367039@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <17491.64254.653743.367039@cargo.ozlabs.ibm.com>
From: Olof Johansson <olof@lixom.net>
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org, torvalds@osdl.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Apr 30, 2006 at 09:47:10AM +1000, Paul Mackerras wrote:
> Olof Johansson writes:
> 
> > Previously we've said implementation instead of specification
> > ("PPC_FEATURE_POWER5_PLUS" etc). That's better than saying base
> > architecture version, since there are parts of the arch that might or
> > might not be implemented (i.e. optional features, etc).
> 
> We now have the AT_PLATFORM string, which we didn't have when we added
> the POWER5_PLUS etc. features.  That specifies which particular
> implementation we are on quite precisely.  We don't want to have a bit
> for every single implementation or we'll run out of bits.
> 
> The ARCH_2_05 bit means all the non-optional bits of the 2.05
> architecture.  If there are optional features in the architecture, we
> have separate bits for them.  For example, we don't have separate
> bits for POWER4 and for 970; instead we have a HAS_ALTIVEC bit, and
> for 970 we set both POWER4 and HAS_ALTIVEC.  So the POWER4 bit is
> really a "2.00 architecture version" bit.

Ok, I guess that's more or less how it's been used, since there's only
been one implementation per architecture version in the past (970 series
being the main exception). The only one left out from the table seems
to be 2.01 (POWER4+), not sure if it had any userspace-visible changes
in the first place.

A rename of existing names might make sense for consistency/clarity. But
that's outside of __KERNEL__ so it would break userspace.

> > Don't you want to fall back to the ELF method if the prom call fails
> > (ret != 0)? Right you close and return.
> 
> If the ibm,client-architecture-support method exists but
> returns an error, call_prom_ret returns zero but puts a non-zero value
> in ret.

Right, that's quite obvious from the implementation.

> In that case we don't want to try the elf-header method.

That was my question, if it made sense to fall back to it. And that's a
"no". Thanks. :-)


-Olof
