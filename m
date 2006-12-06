Return-Path: <benh@kernel.crashing.org>
Subject: shared config registers and locking
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org
Content-Type: text/plain
Date: Wed, 06 Dec 2006 16:10:47 +1100
Message-Id: <1165381847.5469.70.camel@localhost.localdomain>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi !

On my work in porting emac over to arch/powerpc (and make it work on SMP
platforms since there's at least one coming, possibly too), I ended up
with a problem with things like the workarounds for the EMAC loss of RX
clock (CONFIG_IBM_EMAC_PHY_RX_CLK_FIX) that I think uncovers a more
generic problem about access global system wide configuration registers
in a race free way.

On UP configuration, there is no real problem: local_irq_disable/enable
around the code tweaking those bits (read/modify/write) is enough and
everybody is happy. That's what the current emac code does.

However, on SMP, we need spinlocking (or a semaphore, but for simple
register accesses like that, spinlocks are probably better).

So there are several possible approaches here...

One is to stay fine grained and have every bit that need locking have
it's own accessors and locking mecanisms (ugh). For example, 40x and 44x
could provide some "subsystem" specific to some of the config DCRs here
exposing APIs to toggle some of the clock bits with proper locking in
there.

It might be the cleanest way but I also find that a bit painful ...

One other approach I had in mind is to simplify the problem to: There is
a certain amount of global configuration register on any machine,
typically embedded gear, and thus we provide a single spinlock (the
global config lock ?) that can be used by all powerpc archs & drivers to
protect each other when flipping bits in such registers.

That is simpler, but that still requires that we are a bit careful that

 - We only use that for very short lived things (typically
read/modify/write cycles to set/clear bits in a register)

 - We make sure that all drivers that access a given register do it with
that lock held, that is we have some agreement on a given platform/CPU
family to what registers are to be covered by that lock

And thus, as a consequence of the above, if a given subsystem needs a
bit more efficient/smart or long lived locking, it should not use that
facility but instead provide a specific subsystem of code with external
interfaces.

Any comments ?

The result would be something like:

global_config_lock(flags);

global_config_unlock(flags);

(It has the semantics of spin_lock_irqsave/restore)

Cheers,
Ben.
