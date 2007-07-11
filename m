Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18068.11329.460505.177523@cargo.ozlabs.ibm.com>
Date: Wed, 11 Jul 2007 11:02:57 +1000
From: Paul Mackerras <paulus@samba.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] Allow exec on 32-bit from readable, non-exec pages,
	with a warning.
In-Reply-To: <89E626D4-D48D-4062-A996-E2DFFE8248E3@kernel.crashing.org>
References: <20070709195743.GA26089@ld0162-tx32.am.freescale.net>
	<200707092225.25287.arnd@arndb.de> <4692A5B8.9010702@freescale.com>
	<8CA741AA-D200-474F-943D-ECE4B3ACD38B@kernel.crashing.org>
	<18068.5706.700933.551828@cargo.ozlabs.ibm.com>
	<89E626D4-D48D-4062-A996-E2DFFE8248E3@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Segher Boessenkool writes:

> >> Yeah.  Giving the warning is a good thing though.
> >
> > No, it isn't; it's just noise, if we're not ever going to do anything
> > to prevent the behaviour - and we can't.
> 
> The same userland code will not run correctly on PPC64 or BookE
> systems.  Is that not a reason to warn?

It *will* run on ppc64 systems, because there we get the
READ_IMPLIES_EXEC personality flag set via the elf_read_implies_exec
thing in include/asm-powerpc/elf.h.  The READ_IMPLIES_EXEC flag is
only set if we don't have the non-executable stack note in the ELF
header, i.e. only for old binaries or libraries.

As for Book E, that could be fixed using elf_read_implies_exec too, if
anyone cared.  In fact maybe the correct solution is to have

#define elf_read_implies_exec(ex, exec_stk) \
	(exec_stk != EXSTACK_DISABLE_X) : 0)

for all 32-bit powerpc.

Paul.
