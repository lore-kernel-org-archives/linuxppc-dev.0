In-Reply-To: <00012021232600.07340@localhost.localdomain>
Date: Fri, 21 Jan 2000 15:15:11 +0100
To: khendricks@ivey.uwo.ca
CC: linuxppc-dev@lists.linuxppc.org, linux-fbdev@vuser.vu.union.edu
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: Fwd: Re: still no accelerated X ($#!$*)
Message-Id: <20000121151511.029555@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Jan 20, 2000, Kevin Hendricks <khendricks@ivey.uwo.ca> wrote:

>Okay, I went and looked at the latest aty128fb.c code and it does not use
>eieio
>anywhere.  I looked at ealier verions of this file and it at one time had
>eieio
>but they have since been removed.
>
>I also looked and the endian conversion routines do not use the output
>contraint approach you took but do include the memory clobber on the writes.

I just looked at atyfb.c and aty128fb.c in my source tree (atyfb is
2.2.14 one and aty128fb is the latest backport done by atong) and neither
uses eieio nor mb(), wmb(), ...

This looks bogus to me. I've spotted a few cases where those calls should
be in.

We can either put the eieio back in the access functions (less optimal,
but we can also fix the constraints to get rid of the memory clobber as
discussed previously), or we can fill the code with carefuly placed mb()
and wmb() but this requires more knowledge of the chipset than I actually
have.

I'll put back eieio() in the access macros for my kernels until a
definitive answer pops up on this issue.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
