Return-Path: <dgibson@ozlabs.org>
Date: Tue, 27 Nov 2007 15:17:13 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@jdl.com>
Subject: Re: dtc: Add valgrind support to testsuite
Message-ID: <20071127041713.GD12051@localhost.localdomain>
References: <20071121005614.GD13156@localhost.localdomain>
	<E1IwmA3-0002eh-OO@jdl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <E1IwmA3-0002eh-OO@jdl.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Nov 26, 2007 at 04:10:39PM -0600, Jon Loeliger wrote:
> So, like, the other day David Gibson mumbled:
> > This patch adds some options to the run_tests.sh script allowing it to
> > run all the testcases under valgrind to check for pointer corruption
> > bugs and memory leaks.  Invoking "make checkm" will run the testsuite
> > with valgrind.
> > 
> > It include a mechanism for specifying valgrind errors to be suppressed
> > on a per-testcase basis, and adds a couple of such suppression files
> > for the mangle-layout and open_pack testcases which dump for use by
> > other testcases a buffer which may contain uninitialized sections.  We
> > use suppressions rather than initializing the buffer so that valgrind
> > will catch any internal access s to the uninitialized data, which
> > would be a bug.
> > 
> > The patch also fixes one genuine bug caught by valgrind -
> > _packblocks() in fdt_rw.c was using memcpy() where it should have been
> > using memmove().
> > 
> > At present the valgrinding won't do anything useful for testcases
> > invoked via a shell script - which includes all the dtc testcases.  I
> > plan to fix that later.
> > 
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> 
> Applied.
> 
> Thanks,
> jdl
> 
> PS -- Clearly, I'm going to have to break down and install valgrind now. :-)

Absolutely.  Actually valgrind didn't show up much interesting on
libfdt.  Some preliminary investigations suggest it may find some
problems in dtc, once I get the shell scripts to pass the valgrind
option through properly.

Be aware that running the testsuite under valgrind will take a long
time.  It goes from something like 1s without valgrind to 10 minutes
on one of my machines.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
