From: "Joakim Tjernlund" <joakim.tjernlund@lumentis.se>
To: "'Paul Mackerras'" <paulus@samba.org>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Subject: SV: New invalidate/clean/flush_dcache functions
Date: Mon, 23 Dec 2002 14:19:58 +0100
Message-ID: <000001c2aa85$ff48d250$83b9143e@hempc>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <15877.25339.355590.772957@argo.ozlabs.ibm.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>
> Joakim Tjernlund writes:
>
> > How about adding new xxx_dcache_range() functions functions to PPC.
> > Below is my suggestion which is more logical and more efficient:
>
> Why do you say it's more efficient?  Because it's inline?  Inlining
> isn't necessarily a win, you know; by inlining something you can
> reduce the number of instructions executed in a particular code path,
> but usually you increase the size of the kernel, and together with
> that, the icache footprint, which is important because you can execute
> quite a lot of instructions in the time taken for one cache miss.

Sorry for not being more verbose. Most(all?) uses of these functions
are of the form xxx_dcache_range(ptr, ptr+len)(len is usally known at
compile time). So for the current impl. There will be one add then a
call,
inside the function there are a few instructions to set the loop
variables
then the actual loop is executed. Finally a return is executed.

In my inline functions will just use 5 or 6 instructions in total for
all
cases where len is known at compile time, which should be close to the
number of instructions needed for preparing the arguments and making the
call to the old versions(I did not check this, but I guess I will have
to)
>
> I'm not saying that your functions aren't more efficient, I'm saying
> that you haven't established that they are more efficient.  Simply
> inlining things doesn't necessarily increase efficiency.  What you
> need to do is to show a measurable increase in efficiency, in the
> context of the kernel, which is sufficient to justify the increased
> size of the kernel.

Yes I know, but in this case it should a win. I hope the above
explanation makes it clearer.

>
> The other thing is that you haven't included the synchronization
> instructions that are required by the PPC architecture spec.

Only the invalidate function is missing the sync instruction.
It's not needed. Invalidating the cache does not touch the memory
so there is no need to sync the memory. I have been running my system
without it for a long time and I asked my HW contact at Motorola about
it and he agreed. Others has used the dcbi without a sync without
problems.

Can you give me a pointer to where the spec claims that a sync is
needed after a dcbi?

    Jocke
>
> Paul.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
