Content-Type: text/plain;
  charset="iso-8859-1"
From: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
Reply-To: khendricks@ivey.uwo.ca
To: Bill Fink <billfink@capu.net>
Subject: Re: xine, ppc and illegal instructions
Date: Mon, 2 Apr 2001 07:50:46 -0400
Cc: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>,
	linuxppc-dev@lists.linuxppc.org, billfink@capu.net
References: <Pine.LNX.4.21.0104011709010.9900-100000@gwiz.nasa.atd.net>
In-Reply-To: <Pine.LNX.4.21.0104011709010.9900-100000@gwiz.nasa.atd.net>
MIME-Version: 1.0
Message-Id: <01040207504600.17517@localhost>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

> > - could there be a cache flushing bug?  When run in gdb if you set some
> > breakpoints in the shared library, it will flush the icache (to make sure
the
> > breakpoint gets flushed out of data cache and any preloaded instruction
are
> > thrown away) this in turn seems to "fix" the cache flush problem if one
> > exists.
>
> That makes sense to me.


> As reported in my previous message, it's now working using the latest
> BenH kernel (2.4.3 final) instead of the Paulus kernel (2.4.3-pre8) I
> was previously trying with, so I'm happy.

Isn't Ben's rsync kernel the one with a change in the kernel cache flushing
code?

Samuel's message said the sequence should be

         stw     r4,0(r2)                        // store instruction
         dcbst   0,r2                            // Flush cache
         sync
         icbi    0,r2
         sync
         isync

I have sometimes seen code where you can batch things up with multiple  dcbf
and icbi before the final sync isync.

So does the batch version work properly on a 7400 series or not?

Either way, we should probably check the cache flushing code in XFree86  (it
has its own dynamic loader) and OpenOffice (bridges code uses self-modifying
code) and  the ppc closures code in libffi used by gcj to flush trampolines
and whatever ever other userland code uses cache flushing because many may
have been based on the kernel version of that routine.

I will check the latter two (OpenOffice and the gcj trampoline flush) since I
have easy access to that code.  Has anyone checked the XFree86 cache flushing
code?

Any info on if the flush a cache range with batched dcbf and icbi's version
used by the kernel works properly under 7400 would be greatly appreciated.

Kevin


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
