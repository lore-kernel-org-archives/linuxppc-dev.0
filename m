To: linuxppc-dev@lists.linuxppc.org, Cort Dougan <cort@persephone.cs.nmt.edu>
Subject: Restructure of arch/ppc/kernel and include/asm-ppc, part 2
Reply-To: minyard@acm.org
From: Corey Minyard <minyard@acm.org>
Date: 15 Dec 1998 23:55:01 -0600
Message-ID: <m2ww3sd422.fsf@wf-rch.cirr.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



Hello all,

This is a second patch (again relative to stock 2.1.131) that goes a
lot farther than the previous patch to make the arch/ppc/kernel
directory a lot more modular.  The changes are much more drastic than
the previous patch.  This currently works on my MVME2700, but I
haven't compiled or tested it for anything else.

Can some people try this out and send me patches to fix stuff?

The patch is on my web site, at http://www.concentric.net/~Minyard.

Significantly, the following have been done:
  * Most machine-dependencies have been removed from include/asm-ppc.

  * CONFIG_MACH_SPECIFIC occurs in one place now in setup.c.  Once
    good detection code is done, it should be easier to pull that
    out.

  * Decrementer calculation for Motorola cards has been changed to
    not be hardcoded but calculated using the mk48t59, which seems
    to work pretty well.

  * Almost all machine-dependent stuff except for detection has been
    pulled out of setup.c and moved into the specific setup files.

  * The <asm/machdep.h> file has been extended to add a data structure
    that has function pointers to machine-dependent routines.  This
    must be filled in by the specific setup routines.

  * Most machine-dependent #ifdef CONFIG_xxx have been pulled out.

  * The irq.c file has been restructured.  do_IRQ() was kind of a mess
    and required some work to split it out into machine-dependent
    portions.  I'm sure I messed that up somewhere, but I got the
    PReP stuff right the first time, so I'm hoping :-).

  * The restructure is pretty much complete from a gross level.  Some
    details still need to be handled, but the major structure is done.

To still be done:
  * There is a lot of stuff with CONFIG_APUS that has dependencies on
    the include/asm-m68k directory.  We are going to have to wait until
    the Amiga stuff is pulled out into its own directory to fix that.
    Hopefully that will be in early 2.3.

  * Lots of CONFIG_8xx still occur.  I'm not sure what to do for these,
    it's hard to tell exactly what is 8xx specific and MBX specific.
    Are all MBX cards 8xx based?  I'd assume so, from the code.  And
    I doubt we are going to be able to get rid of these.

  * Include/asm-ppc/ide.h refers to _machine a bunch.  This makes the
    file kind of messy, and I'm not sure what to do with it, especially
    since it redifines inb, outb, etc.  Who is responsible for this
    file?  I'd like to fit it into my new structure, but I'm not sure
    what to do with it.

  * A few references to _machine and is_prep are still around,
    specifically in these files: pmac_support.c (some chrp-specific
    stuff), prom.c, smp.c, and process.c.

  * I need to make a prep_irq.c to pull out the irq-specific stuff from
    prep_setup.c.  In fact, I've thrown pretty much everything into
    xxx_setup.c, each one needs a restructure, but I'm probably only
    going to do the prep one since that's what I have.

  * I'm sure it won't compile for all architectures.  If you fix
    something to make it compile (or work, for that matter :-) please
    send me a patch.

  * Detection needs to be done.  This might be pretty tricky.

When I issue more patches, they will always be relative to 2.1.131
(or whatever kernel), not relative to the previous patches.  So keep
the original stuff around.

The patch applies to 2.1.127 (although I haven't tested) except for
the keyboard.h file, which I'm not sure what to do with since it was
significantly restructured.

-- 
Corey Minyard               Internet:  minyard@acm.org
  Work: minyard@nortel.ca       UUCP:  minyard@wf-rch.cirr.com

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
