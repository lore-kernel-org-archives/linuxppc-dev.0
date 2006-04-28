Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17490.42497.351114.712494@cargo.ozlabs.ibm.com>
Date: Sat, 29 Apr 2006 09:32:17 +1000
From: Paul Mackerras <paulus@samba.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: sign extension for 32bit syscalls on ppc64
In-Reply-To: <20060428131254.GA507@lst.de>
References: <20060428131254.GA507@lst.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Christoph Hellwig writes:

> OTOH various syscalls in the generic code don't do that and it seems to
> still work fine.  I have patches for various new generic compat
> routines, and they all seem to work fine without this sign extension.
> 
> What's the exact sign extention rules for ppc64?

As far as the ABI and the compiler are concerned, 32-bit values stored
in registers are always correctly extended to 64 bits according to
their type.  That is, the top 32 bits of the register will be either
all zeroes or all ones, and will only be all ones for negative values
of a signed type.

Syscall arguments are zero-extended in the syscall entry path for
32-bit processes (see lines 131-136 of arch/powerpc/kernel/entry_64.S)
so if the argument is an int, we do an (int) cast in the compat
wrapper, which makes the compiler emit an extsw instruction to get the
value correctly sign-extended.

However, it's debatable whether file descriptor arguments really need
to be sign-extended.  Although they are typed as int, negative values
are not generally valid (although there are one or two cases where
they are), and an fd value of 4294967295 will generate an EBADF error
just as well as -1 will.

Paul.
