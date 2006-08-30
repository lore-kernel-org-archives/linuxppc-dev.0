Return-Path: <benh@kernel.crashing.org>
Subject: Atomic operations in user space: Yes but No
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olof Johansson <olof@lixom.net>
In-Reply-To: <20060830063333.GA16468@pb15.lixom.net>
References: <4879B0C6C249214CBE7AB04453F84E4D0FC836@zch01exm20.fsl.freescale.net>
	<995B09A8299C2C44B59866F6391D263511BB62@zch01exm21.fsl.freescale.net>
	<20060830063333.GA16468@pb15.lixom.net>
Content-Type: text/plain
Date: Wed, 30 Aug 2006 17:00:40 +1000
Message-Id: <1156921240.12526.9.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Liu Dave-r63238 <DaveLiu@freescale.com>,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2006-08-30 at 01:33 -0500, Olof Johansson wrote:
> On Wed, Aug 30, 2006 at 10:55:39AM +0800, Liu Dave-r63238 wrote:
> 
> > Can we do atomic operation in user space as kernel space?

Ok, let's hope that clarifies it for everybody.

Atomic operations in user space are possible using reservations
(lwarx/stwcx. or their 64 bits counterpart). However they are very much
not recommended.

The reason they work is that the kernel always clears all pending
reservations in the exception path, thus if there is a task switch, an
interrupt or anything that can break the user program flow in the middle
of it's lwarx/stwcx. loop, the kernel will return to userspace with all
reservations cleared, thus causing stwcx. to fail.

However, they are not recommended unless you know VERY WELL what you are
doing. When I say, VERY WELL in all uppercases, I really mean it. That
is examples in books etc... are usually not enough to know very well
what you are doing :) There are three issues at hand at least that I
know about use of lwarx/stwcx, from the less to the most important:

 - Processor erratas. For example, the 405 requires a sync in an atomic
loop. The kernel has a mecanism to have those sync's in and eventually
comment them out at runtime. Future processors might have different
erratas regarding those instructions. It's better to keep their usage
local to the kernel and/or glibc to avoid having to fix too much
userland problems when that happens.

 - Performance issues and possible livelocks. There are both processor
and bus starvation issues related to the use of atomics. On some
processors, it's very recommended for example, when a lock operation
fails, to go do something else for a while (intentional branch
mispredict for example) before trying again. In general, there are
issues with cache lines used for lwarx/stwcx. ping-ponging all over the
fabric on some heavy duty SMP machines if great care isn't taken with
the way atomics or locks are laid out in memory and shared among
threads. 

 - Correctness vs. storage ordering. That's the biggest one. Almost
every time I've seen userland code try to do their own atomic stuffs, it
was done without full understanding of the out of order storage model of
the PowerPC architecture and thus without appropriate barriers. This is
a complicated topic and thus I won't get into a long explanation here,
but let's say that outside of pure atomic "counters" that have no
specific ordering requirements or no locking/exclusion semantics vs. the
execution flow, you should _not_ try to do it yourself with atomics, but
instead use some of the primitives provided by glibc. With NPTL,
nowadays, glibc provides pretty fast implementations that do not use the
kernel unless there is contention.

So yes, you can, but most of the time, you should not.

Cheers,
Ben.
