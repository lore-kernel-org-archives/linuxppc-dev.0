From: "Joakim Tjernlund" <joakim.tjernlund@lumentis.se>
To: "'Paul Mackerras'" <paulus@samba.org>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Subject: SV: SV: New invalidate/clean/flush_dcache functions
Date: Thu, 26 Dec 2002 14:52:33 +0100
Message-ID: <000001c2ace6$0b811660$4cb8143e@hempc>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <15882.33210.146613.132083@argo.ozlabs.ibm.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> Joakim Tjernlund writes:
>
> > In my inline functions will just use 5 or 6 instructions in total
for
> > all
> > cases where len is known at compile time, which should be close to
the
> > number of instructions needed for preparing the arguments and making
the
> > call to the old versions(I did not check this, but I guess I will
have
> > to)
>
> Were you thinking that the address must be cacheline-aligned?  If it
> isn't, the number of cachelines that you have to do depends not only
> on the length parameter but also on the low-order bits of the
> address.  For example, if cache lines are 16 bytes and len = 18, then
> if addr = 0xc0000001 then we want to do 2 cache lines, but if addr =
> 0xc000000f then we need to do 3 cache lines.

You are right, on the other hand maybe it should be cache line aligned?
I can fix my functions but then I need to muck with the pointer address
and that will probably not generate very good assembler. Perhaps
these functions could coexist with the current ones, use the xx_range if
the address/len is not cache line aligned and mine if you know they are
cache line aligned? Invalidate on non cache line aligned memory is
usally
a bug.

>
> > Only the invalidate function is missing the sync instruction.
> > It's not needed. Invalidating the cache does not touch the memory
> > so there is no need to sync the memory. I have been running my
system
> > without it for a long time and I asked my HW contact at Motorola
about
> > it and he agreed. Others has used the dcbi without a sync without
> > problems.
>
> I don't have the architecture manual to hand, it's at work.  I can
> easily believe that sync after dcbi is not needed on any current 8xx
> implementation, or on any 4xx either.

Which arch's do need sync? I don't understand what the sync is good
for when invalidating the dcache. If it has something to with draining
the
pipe into cache, then the sync should be before the dcbi's or ...?

     Jocke

>
> Paul.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
