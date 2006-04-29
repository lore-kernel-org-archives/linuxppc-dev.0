Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17491.64254.653743.367039@cargo.ozlabs.ibm.com>
Date: Sun, 30 Apr 2006 09:47:10 +1000
From: Paul Mackerras <paulus@samba.org>
To: Olof Johansson <olof@lixom.net>
Subject: Re: please pull powerpc.git 'merge' branch
In-Reply-To: <20060429151936.GM5518@pb15.lixom.net>
References: <17491.1134.565353.149941@cargo.ozlabs.ibm.com>
	<20060429151936.GM5518@pb15.lixom.net>
Cc: linuxppc-dev@ozlabs.org, torvalds@osdl.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Olof Johansson writes:

> Previously we've said implementation instead of specification
> ("PPC_FEATURE_POWER5_PLUS" etc). That's better than saying base
> architecture version, since there are parts of the arch that might or
> might not be implemented (i.e. optional features, etc).

We now have the AT_PLATFORM string, which we didn't have when we added
the POWER5_PLUS etc. features.  That specifies which particular
implementation we are on quite precisely.  We don't want to have a bit
for every single implementation or we'll run out of bits.

The ARCH_2_05 bit means all the non-optional bits of the 2.05
architecture.  If there are optional features in the architecture, we
have separate bits for them.  For example, we don't have separate
bits for POWER4 and for 970; instead we have a HAS_ALTIVEC bit, and
for 970 we set both POWER4 and HAS_ALTIVEC.  So the POWER4 bit is
really a "2.00 architecture version" bit.

> Don't you want to fall back to the ELF method if the prom call fails
> (ret != 0)? Right you close and return.

There are two return values here - the return from call-method, and
the return from ibm,client-architecture-support.  If the latter does
not exist, call-method returns non-zero, which gets returned from
call_prom_ret, and we close the root node and try the elf-header
method.  If the ibm,client-architecture-support method exists but
returns an error, call_prom_ret returns zero but puts a non-zero value
in ret.  In that case we don't want to try the elf-header method.

So I claim that the code is correct as it is. :)

Paul.
