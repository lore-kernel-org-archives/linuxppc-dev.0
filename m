Message-Id: <199902171226.HAA00130@darkstar.prodigy.com>
From: davidsen@prodigy.com (Bill Davidsen)
Date: Wed, 17 Feb 1999 07:26:18 -0500
In-Reply-To: <Pine.LNX.3.96.990216125317.30556A-100000@persephone.cs.nmt.edu> from cort@persephone.cs.nmt.edu
To: Cort Dougan <cort@persephone.cs.nmt.edu>,
        Christian Zankel <zankel@tarantel.rz.fh-muenchen.de>
Subject: Re: [ppc-dev] Re: Restructuring Efforts
Cc: linuxppc-dev@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> Keep in mind the 2.2 tree is supposed to be stable.  As few changes as
> possible and only to fix things.  I think the restructure is important
> enough to work on now, though.

Maybe work should be moved to the 2.3 tree when it emerges.

> I'd like the end result to be something that allows you to apply patches
> for your board without much trouble from version to version.  Things with
> limited use (your board?) shouldn't go into the kernel.  It'll complicate
> things too much I think.  That doesn't preclude the main tree from making
> it an easy job for you to apply your changes.  Trying to do everything
> right off could make a big mess of things.

This seems to indicate the desirability of using directories rather than
putting everything inline with ifdefs. It allows someone to support a
small production board by dropping in their own directory and pointing
the symbolic link. It also makes it easier to apply patches, since it's
obvious if a change is generic or related to a single board (or board
family).

> As always, I'm willing to change my mind but I want a general consensus
> from the community before I do.
> 
> }I hope that a little discussion is allowed here:
> }(Please, understand that my point of view is from a board where the
> }initialization is different from those with an OF)
> 
> Not quite.  Just chrp/prep/pmac (and soon apus I hope).  I want a single
> kernel for the desktop to avoid recompiles when testing out kernels.  Ram
> isn't a big deal on these machines (a few K for a generic kernel isn't a
> big deal anyway).  The performance loss is negligible as well (it can be
> improved though).  Other boards (especially embedded) can't do this - it
> would be insane :)  Those will be compiled specifically for the target
> architecture.

But it would be desirable to have the "all purpose" init also in a dir
of its own, rather than ifdef it out. Or so it seems to me.

> }It seems that efforts are going to create one 'super' PPC-kernel
> }suitable for all the PPC machines.
> 
> Those #ifdefs are really hard to work with - the single kernel avoids many
> of them.  It takes a lot of work to move in even one small patch if I have
> to recompile for each architecture and track down bugs.  Too many code
> paths are dangerous.

See above on this, I agree that it can make sense to do some arch
detection at runtime, but the init which does so should probably be off
by itself, rather than needing to be ifdef'd out.

> I want to get rid of ifdefs.  When creating the generic desktop kernel the
> comparisons in the 'if' (not ifdef) are done.  When compiling for a
> specific arch the _machine value is no longer a variable but a constant.
> The compile optimizes out the 'if' and gives you a straight path.

Does the switch get optimized in the same way? ie.
  m = 4;
  switch(m) {
    case 1:
      printf("Will this no generate code?\n");
      break;
    case 2:
    case 4:
      /* is this the only code compiled? */
    case 8:
  }
-- 
   -bill davidsen (davidsen@prodigy.com)
"The secret to procrastination is to put things off until the
 last possible moment - but no longer"  -me

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
