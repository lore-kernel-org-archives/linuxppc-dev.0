In-Reply-To: <Pine.LNX.3.96.990217172825.19695C-100000@globegate.utm.edu>
Date: Thu, 18 Feb 1999 12:25:39 +0100
To: "David A. Gatwood" <marsmail@globegate.utm.edu>,
        linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: [ppc-dev] Re: Restructuring Efforts
Message-Id: <19990218122539.026672@mail.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Feb 17, 1999, David A. Gatwood <marsmail@globegate.utm.edu> wrote:

>Sounds a lot like a bunch of things in BSD-like kernels, where, in
>MkLinux, for instance, interrupt_heathrow.c, interrupt_pdm.c, etc. each
>have a static structure with pointers to their externally visible
>functions, and the main function checks the hardware type and assigns a
>global pointer to point to the static structure for the particular set of
>routines.  Is that what you mean?

Almost ;-)

This scheme still requires one more pointer dereferencing: one to get to
the global holding the structure pointer, one to get the structure, one
to get the function.

I was thinking about filling a static structure with function pointers
instead (but the "modules" can still export a pointer to a structure, the
kernel will just copy the pointers in the structure instead of just
storing a pointer to the structure).
This way, we have one less indirection.
If the structure can be stored at a fixed address in kernel virtual space
(hummm....) then access to the function pointers can be really fast.

Of course, this is really a matter of details, but since those will be
used in a lot of performance sensitive execution path (interrupts, mm,
...), such optimisation can make a difference by avoiding unnecessary
cache misses.

Maybe we could wrap the calls to the functions themselves in macros so
that we can later change the way the mecanism is implemented.

-- 
           E-Mail: <mailto:bh40@calva.net>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>





[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
