Return-Path: <michael@ellerman.id.au>
Message-ID: <1346741491.7619.12.camel@concordia>
Subject: Re: 3.5+: yaboot, Invalid memory access
From: Michael Ellerman <michael@ellerman.id.au>
To: Christian Kujau <lists@nerdbynature.de>
Date: Tue, 04 Sep 2012 16:51:31 +1000
In-Reply-To: <alpine.DEB.2.01.1209032310220.25392@trent.utfs.org>
References: <alpine.DEB.2.01.1207302235170.26923@trent.utfs.org>
 <alpine.DEB.2.01.1209032310220.25392@trent.utfs.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Steven Rostedt <rostedt@goodmis.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2012-09-03 at 23:18 -0700, Christian Kujau wrote:
> On Mon, 30 Jul 2012 at 22:46, Christian Kujau wrote:
> > when trying to upgrade from 3.5 (final) to today's git checkout from 
> > Linus' tree, yaboot cannot boot and the following is printed:
> > 
> >   [...]
> >   returning from prom_init
> >   Invalid memory access at %SRR0: 00c62fd4  %SRR1: 00003030
> 
> Finally got around to do a bisection:
> 
> -----------------------------
> b6e3796834faefe4b6e9a2aedfe12665cd51fbc5 is the first bad commit
> commit b6e3796834faefe4b6e9a2aedfe12665cd51fbc5
> Author: Steven Rostedt <srostedt@redhat.com>
> Date:   Thu Apr 26 08:31:18 2012 +0000
> 
>     powerpc: Have patch_instruction detect faults
>     
>     For ftrace to use the patch_instruction code, it needs to check for
>     faults on write. Ftrace updates code all over the kernel, and we need 
>     to know if code is updated or not due to protections that are placed 
>     on some portions of the kernel. If ftrace does not detect a fault, it 
>     will error later on, and it will be much more difficult to find the 
>     problem.
>     
>     By changing patch_instruction() to detect faults, then ftrace will be
>     able to make use of it too.
>     
>     Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
>     Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> 
> :040000 040000 83fb0e420524db452c07425e4dc402041428e696 0d1a01acd863237cf388045946ad4446a28df50c M      arch
> -----------------------------
> 
> The changeset looked pretty harmless to me but I tested with a current 
> 3.6+ git checkout and the kernel would only boot when this changeset was
> reverted.
> 
> Thoughts?

My guess would be we're calling that quite early and the __put_user()
check is getting confused and failing. That means we'll have left some
code unpatched, which then fails.

Can you try with the patch applied, but instead of returning if the
__put_user() fails, just continue on anyway.

That will isolate if it's something in the __put_user() (I doubt it), or
just that the __put_user() is failing and leaving the code unpatched.

cheers
