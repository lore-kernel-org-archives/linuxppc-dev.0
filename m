Message-Id: <5.0.2.1.2.20010130131525.01ce0010@mail.lauterbach.com>
Date: Tue, 30 Jan 2001 13:39:06 +0100
To: "Iain Sandoe" <iain@sandoe.co.uk>
From: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
Subject: Re: network stack oops 2.4.1/gcc 2.95.3 
Cc: David Edelsohn <dje@watson.ibm.com>, linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20010129235359.1B26D2EFD0@apollo.valhalla.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 00:54 2001-01-30, Iain Sandoe wrote:
> >  I do not mean rewinding all of the way to gcc-2.95.2, but to
> > Franz's patched version of GCC prior to the gcc-2.95.3 changes.
>
>OK. It might be possible - I have a build timestamp on the kernel (I keep
>the last four or five builds) and I guess I could somehow track down which
>revs to get from bk.  I still have the previous glibc & gcc rpms.
>
>However, (see below) I will only do this if someone really believes they
>will get useful info... I'm mid-way through a fairly large chunk of work
>ATM.

At least it would be nice if you could tell me the version of the RPM you
were using before. I haven't added new patches since early December and
most of my RPM patches are in test2 (even more in test3) now.

FYI, here's my current list of patches that are not in test3:

2000-12-04  Franz Sirl  <Franz.Sirl-kernel@lauterbach.com>

         2000-08-24  Jim Wilson  <wilson@cygnus.com>
         * c-common.c (decl_attributes, case A_ALIGN): Revert last change.
         Copy type in a TYPE_DECL, just like pushdecl does.

2000-10-17  Franz Sirl  <Franz.Sirl-kernel@lauterbach.com>

         2000-10-17  Franz Sirl  <Franz.Sirl-kernel@lauterbach.com>
         * function.c (locate_and_pad_parm): Don't align stack unconditionally.

         1999-12-06  Jakub Jelinek  <jakub@redhat.com>
         * calls.c (save_fixed_argument_area): If save_mode is BLKmode,
         always use move_by_pieces to avoid infinite recursion.
         (restore_fixed_argument_area): Likewise.

2000-10-14  Franz Sirl  <Franz.Sirl-kernel@lauterbach.com>

         2000-03-17  Martin v. Löwis  <loewis@informatik.hu-berlin.de>
         * calls.c (special_function_p): It is only malloc if it returns
         Pmode.

         2000-04-12  Mark Mitchell  <mark@codesourcery.com>
         * function.c (aggregate_value_p): VOID_TYPE nodes are never
         aggregates.

         Tue Sep 14 01:33:15 1999  Andreas Schwab  <schwab@suse.de>
         * loop.c (strength_reduce): Don't call reg_used_between_p if the
         insn from BL2 is after the insn from BL.

         Tue Dec 14 18:13:32 1999  J"orn Rennecke <amylaar@cygnus.co.uk>
         * loop.c (strength_reduce): Fix sign of giv lifetime calculation
         for givs made from biv increments.

         Mon Feb 28 11:34:43 2000  J"orn Rennecke <amylaar@cygnus.co.uk>
         * loop.c (reg_in_basic_block_p): Don't abort when falling through
         to the end of the function.

         Sat Apr 22 22:35:38 MET DST 2000  Jan Hubicka  <jh@suse.cz>
         * loop.c (strength_reduce): Fix biv removal code.

         Thu Oct 14 03:59:57 1999  Stephane Carrez  <stcarrez@worldnet.fr>
         * stor-layout.c (layout_union): Use HOST_WIDE_INT for const_size;
         check for member bit-size overflow and use var_size if it occurs.
         (layout_record): Use bitsize_int() to define the type size in bits.
         Likewise for computation and assignment to DECL_FIELD_BITPOS.
         (layout_decl): Likewise when assigning to DECL_SIZE.

         Thu Oct 28 10:20:02 1999  Geoffrey Keating  <geoffk@cygnus.com>
         * config/rs6000/rs6000.md (movsf): Don't convert a SUBREG
         of the function return register into a plain REG until
         after function inlining is done.

Another datapoint:
[fsirl@entropy:~]$ cat /proc/version
Linux version 2.4.0 (trini@entropy.crashing.org) (gcc version 2.95.3
20010111 (prerelease/franzo/20010111)) #1 Sun Jan 14 15:10:21 MST 2001
[fsirl@entropy:~]$ uptime
   5:21am  up 11 days, 20:50,  2 users,  load average: 0.00, 0.00, 0.00

But this machine has a fairly weak net connection, so mabe this is never
triggered (define heavy network load?).


> >  I am just trying to narrow down whether this is something new.
>
>I believe so.  Because I really think I'd built that particular pull before
>I upgraded the tool-chain.  BUT because it only happens under fairly unusual
>circumstances (for my set-up) I can't be 100% sure.
>
>Also it involves a depressingly large amount of system context: kernel, X,
>inetd, da-da-da...
>
>If it happens again - I'll see if I really have a genuine Illegal
>Instruction in the code stream (or I'm just trying to execute a format
>string ;)

I would rather think this is a new kernel bug...

Franz.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
