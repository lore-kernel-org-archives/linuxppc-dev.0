From: Kevin Hendricks <khendricks@ivey.uwo.ca>
Reply-To: khendricks@ivey.uwo.ca
To: Jason Kim <jwk2@eecs.lehigh.edu>,
        Franz Sirl <Franz.Sirl-kernel@lauterbach.com>,
        "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>,
        "gcc-patches@gcc.gnu.org" <gcc-patches@gcc.gnu.org>
Subject: Re: patch for problem with va-ppc.h included with egcs and gcc-2.95.2
Date: Wed, 1 Dec 1999 14:41:05 -0500
Content-Type: text/plain
References: <4.2.2.19991130110534.00b563b0@mail.lauterbach.com> <4.2.2.19991201162019.03c111b0@mail.lauterbach.com> <384574A2.A003F5F6@eecs.lehigh.edu>
In-Reply-To: <384574A2.A003F5F6@eecs.lehigh.edu>
MIME-Version: 1.0
Message-Id: <99120114490800.04790@localhost.localdomain>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

My 2 cents.

> What about double indirection? or triple, for that matter?
> 
> Not to mention implementing va_list this way explicitly breaks compatibility
> between gcc on ppc and gcc on SPARC, x86, clipper, alpha... etc.. You name it.
> Its broken.

va_lists are used heavily in the jdk and pointers to va_lists are passed in
routines.   I had to track down each and every time a pointer into a va_list was
passed as a parameter to another routine and fix each one.  So there needed to
be ppc specific code if def'd into the Sun source code  in mutliple places which
otherwise worked as is on every other platform including sparc, x86, m68k, etc.

This is over and above using va_copy or memcpy trickery as required for the
jdk.

And the worst part about debugging all of this is that the code which
worked for all other platforms simply failed quietly on ppc.  So when debugging
a large source code base which you did not write and seems to be portable
across a number of other platforms, silent failures are nasty (unless you
luckily got a seg-fault).

The problem would just get worse with multiple indirection.

If there is any way to change this without beaking backward compatibility with
pre-compiled shared libs and things, I would vote for it.

Comments?

Kevin


> 
> Does this make any sense?
> 
> Having a fixed size array as a user accessible item (which is TYPEDEF'ed to
> resemble a structure, no less) which could be passed around is just a BAD idea
> in C/C++. I have yet to hear any concrete reasons (besides just plain
> obstinacy) why va_list HAS to be implemented this way.
> 
> 
> -jason.
> 
> 
> 
> > Franz.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
