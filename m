Date: Wed, 1 Dec 1999 23:15:52 -0800
From: Richard Henderson <rth@cygnus.com>
To: Jason Kim <jwk2@EECS.Lehigh.EDU>
Cc: khendricks@ivey.uwo.ca,
        "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>,
        "gcc-patches@gcc.gnu.org" <gcc-patches@gcc.gnu.org>,
        "David A. Gatwood" <dgatwood@deepspace.mklinux.org>,
        Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
Subject: Re: patch for problem with va-ppc.h included with egcs and gcc-2.95.2
Message-ID: <19991201231552.A15266@cygnus.com>
References: <4.2.2.19991130110534.00b563b0@mail.lauterbach.com> <4.2.2.19991201162019.03c111b0@mail.lauterbach.com> <384574A2.A003F5F6@eecs.lehigh.edu> <99120114490800.04790@localhost.localdomain> <38460186.8CEC249C@eecs.lehigh.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <38460186.8CEC249C@eecs.lehigh.edu>; from Jason Kim on Thu, Dec 02, 1999 at 12:20:06AM -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Dec 02, 1999 at 12:20:06AM -0500, Jason Kim wrote:
> Well, xemacs-21.1.8, Mesa-3.0, gcc-2.95.2, xscreensaver-3.21, gle-2.3 and
> ssh-2.0.13 all compile and link against the older dynamic libraries, but
> use the va_list definition from my patch. All seem to work fine.

An interesting happy accident.  The PPC SVR4 ABI passes structures
by reference, which at the machine level winds up looking just like
it does when the array decomposes into a pointer.

> Anybody have any examples of where there IS va_list passage from user code to
> existing dynlib code (or vice versa)?

Of course -- vfprintf.

> If that is the case, then applying the patch en-mass
> seems harmless way for getting rid of the array based va_list once
> and for all.

Except that we're not going to do that.  We'll stay with the
letter of the PPC SVR4 ABI law, thanks. 

Despite what you may think, PPC is not unique in its use of an
array definition for va_list.  Whatever changes that might could
be made in gcc doesn't make the code in question any more correct
pedantically, and will continue to break when you go use someone
else's compiler.



r~

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
