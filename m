Return-Path: <benh@kernel.crashing.org>
Subject: Re: [RFC 1/3] powerpc: __copy_tofrom_user tweaked for Cell
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: sanjay3000@yahoo.com
In-Reply-To: <247666.12345.qm@web33104.mail.mud.yahoo.com>
References: <247666.12345.qm@web33104.mail.mud.yahoo.com>
Content-Type: text/plain
Date: Sat, 21 Jun 2008 09:20:27 +1000
Message-Id: <1214004027.8011.182.camel@pasglop>
Mime-Version: 1.0
Cc: Mark Nelson <markn@au1.ibm.com>, Gunnar von Boehn <VONBOEHN@de.ibm.com>,
	Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@ozlabs.org,
	Michael Ellerman <ellerman@au1.ibm.com>, cbe-oss-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2008-06-20 at 10:46 -0700, Sanjay Patel wrote:
> --- On Fri, 6/20/08, Gunnar von Boehn <VONBOEHN@de.ibm.com> wrote:
> > How important is best performance for the unaligned copy
> > to/from uncacheable memory?
> > The challenge of the CELL chip is that X-form of the shift
> > instructions are microcoded.
> > The shifts are needed to implement a copy that reads and
> > writes always aligned.
> 
> Hi Gunnar,
> 
> I have no idea how important unaligned or uncacheable copy perf is for
> Cell Linux. My experience is from Mac OS X for PPC, where we used dcbz
> in a general-purpose memcpy but were forced to pull that optimization
> because of the detrimental perf effect on important applications.

I though OS X had a trick with a CR bit that would disable the dcbz
optimization on the first alignment fault ? Or did they totally remove
it ?

> I may be missing something, but I don't see how Cell's microcoded
> shift is much of a factor here. The problem is that the dcbz will
> generate the alignment exception regardless of whether the data is
> actually unaligned or not. Once you're on that code path, performance
> can't be good, can it?

This is a concern. The problem is, do we want to lose all the benefit
of improved copy_to/from_user because of that ? Passing local store
addresses to/from read/write syscalls is supported, so I suppose it's a
real issue for reads.

On the other hand, how performant do we expect those to be ? That is, we
could have the alignment exception detect that it happened during
copy_to/from_user, and change the return address to a non-optimized
variant. Thus we would have at most one exception per read syscall.

Ben.
