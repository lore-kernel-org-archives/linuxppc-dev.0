Message-ID: <384574A2.A003F5F6@eecs.lehigh.edu>
Date: Wed, 01 Dec 1999 14:18:58 -0500
From: Jason Kim <jwk2@eecs.lehigh.edu>
MIME-Version: 1.0
To: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>,
        "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>,
        "gcc-patches@gcc.gnu.org" <gcc-patches@gcc.gnu.org>
Subject: Re: patch for problem with va-ppc.h included with egcs and
	  gcc-2.95.2
References: <4.2.2.19991130110534.00b563b0@mail.lauterbach.com> <4.2.2.19991201162019.03c111b0@mail.lauterbach.com>
Content-Type: text/plain; charset=iso-2022-kr
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Franz Sirl wrote:
> 
> At 00:28 01.12.99 , Jason Kim wrote:
> >Also, in the ANSI C (9x) documentation (``n843''), taking the address of a
> >va_list is NOT listed as one of the things that will produce an undefined
> >result. Actually, on page 7.15 (pg246 as seen by acroread), footnote item 198
> >specifically states ``It is permitted to create a pointer to a va_list and
> >pass that pointer to another function,.. in which case the original list may
> >make further use of the original list after the other function returns.''
> 
> Well, I see this is also in ISO C9x, but unless the standard restricts the
> possible types for va_list (I can't find anything about that), you have
> still to be aware that any callee gets a reference to the va_list if
> va_list is an array and so the usual array handling rules apply, or?
> 


This is getting rather silly. So for a coder to use a set of macros
which were standardized for encapsulating portability issues, he has
to develop another set of macros to get past this
C-array-passed-as-pointer ``feature'' to even pretend to have portable
code?

What about double indirection? or triple, for that matter?

Not to mention implementing va_list this way explicitly breaks compatibility
between gcc on ppc and gcc on SPARC, x86, clipper, alpha... etc.. You name it.
Its broken.

Does this make any sense?

Having a fixed size array as a user accessible item (which is TYPEDEF'ed to
resemble a structure, no less) which could be passed around is just a BAD idea
in C/C++. I have yet to hear any concrete reasons (besides just plain
obstinacy) why va_list HAS to be implemented this way.


-jason.



> Franz.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
