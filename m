Date: Tue, 16 Feb 1999 13:11:19 -0700 (MST)
From: Cort Dougan <cort@persephone.cs.nmt.edu>
To: Christian Zankel <zankel@tarantel.rz.fh-muenchen.de>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Restructuring Efforts
In-Reply-To: <36C99DC8.357EEF2A@mailserv.rz.fh-muenchen.de>
Message-ID: <Pine.LNX.3.96.990216125317.30556A-100000@persephone.cs.nmt.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I want to avoid another tree.  It'll create chaos.  It'll also make my job
a lot harder.  Things do need to move slowly for a while.  The ppc tree
could get ugly really quickly by adding all the new archs.  We already have
more than any other port and will be getting more soon.  I want this to
serve as motivation for a slow (by linux standards) and careful redesign
rather than a hack to get arch X, Y and Z working now.

The first step is underway.  I want to cleanup the bootloader mess for
prep/yellowknife/mbx/rpx.  Moving the embedded stuff to arch/ppc/mbxboot
will cleanup the prep stuff a good deal.  Then I'll go through the prep
stuff and most likely replace it with Gabriels bootloader for prep.  It's a
small step but it needs to be done and it'll move us ahead.

Keep in mind the 2.2 tree is supposed to be stable.  As few changes as
possible and only to fix things.  I think the restructure is important
enough to work on now, though.

This is why I have the directory at linuxppc.cs.nmt.edu for patches.  I'd
like to collect the patches so we can all look through one anothers work.
I'd like things to bounce around a bit before going into the tree.  I think
we should use the -dev list for that. There are several different ideas out
there for the restructure and I'd like to go through them pretty thoroughly
before adopting one or any combination of them.

}I've seen that you have setup a directory for those patches. But
}couldn't you start with a seperate cvs tree to move the process of
}restructuring the kernel forward? I mean, having a kind of 'official'
}inofficial LinuxPPC developer kernel. I'd also really appreciate it if
}there could be a kind of a statement(?) and perhaps a short discussion
}about the restructured arch/ppc tree. I'd like to ask especially you,
}Cort, as you seem to be the maintainer of the LinuxPPC port, how you see
}the restructured arch/ppc tree. I'd like to help, but need to know where
}arch/ppc is going to be. 

I'd like the end result to be something that allows you to apply patches
for your board without much trouble from version to version.  Things with
limited use (your board?) shouldn't go into the kernel.  It'll complicate
things too much I think.  That doesn't preclude the main tree from making
it an easy job for you to apply your changes.  Trying to do everything
right off could make a big mess of things.

As always, I'm willing to change my mind but I want a general consensus
from the community before I do.

}I hope that a little discussion is allowed here:
}(Please, understand that my point of view is from a board where the
}initialization is different from those with an OF)

Not quite.  Just chrp/prep/pmac (and soon apus I hope).  I want a single
kernel for the desktop to avoid recompiles when testing out kernels.  Ram
isn't a big deal on these machines (a few K for a generic kernel isn't a
big deal anyway).  The performance loss is negligible as well (it can be
improved though).  Other boards (especially embedded) can't do this - it
would be insane :)  Those will be compiled specifically for the target
architecture.

}It seems that efforts are going to create one 'super' PPC-kernel
}suitable for all the PPC machines.

Those #ifdefs are really hard to work with - the single kernel avoids many
of them.  It takes a lot of work to move in even one small patch if I have
to recompile for each architecture and track down bugs.  Too many code
paths are dangerous.

}I can't say that I'm really happy about it. I think there might be more
}overhead, unreadibility (i.e. a lot #ifdef's), bigger kernels, etc. I'd

Take a tour through the code looking for places that can be done.  I still
think things can be merged with careful thought.  There's quite a bit of
common code (pmac/prep/chrp/apus wise anyway).  If you can find some
specific places you don't think this isn't the case point them out to me.

}like to see the Macintosh, PreP, CHRP, etc. more seperated, ie. in
}different directories (one for pmac, prep, chrp, apus, mbx, pcore6750,
}etc.) I think, it's then much easier to add new machines, new PPC
}generations, etc. Short: I don't think is wise to have only one
}CONFIG_PMAC_PREP_CHRP_?_? for all machines and let the kernel decide at
}boot time what to do. Do I overlook here something?

I think this will happen.  The 8xx series is really different from the
6xx/7xx and the 4xx/5xx are as well.

}2. kernel/head.S
}It seems that the basic initialization varies from board to board.
}Porting LinuxPPC to the Force board would result in more #ifdef's. I'd
}suggest to seperate the 'exceptions' part (into trap.S) from the
}initialization code and put the later one into the mach-dirs.

They're init sections so they get dropped after boot.  There is some of
code that gets freed after boot on machines that don't need it.  We can
make that conditional upon have_of.

}The Force board has no OF and no residual structures. What I have in
}mind is to replace the firmware of the board completely with a MILO-like
}firmware. This firmware should be able to boot an elf-vmlinux image
}either from the same flash, or the user-flash, from network, or scsi.
}Would it possible to seperate the calls to read data from OF and to read
}residual data, from the generic sources (especially in arch/ppc/mm) ? 

I want to get rid of ifdefs.  When creating the generic desktop kernel the
comparisons in the 'if' (not ifdef) are done.  When compiling for a
specific arch the _machine value is no longer a variable but a constant.
The compile optimizes out the 'if' and gives you a straight path.

}These are some questions I ran into porting LinuxPPC to the Force board.
}Mainly, I do not understand why those three machines, PowerMac
}(PPC601-PPC750), CHRP and PReP are put so closely together. For me, it
}seems that a lot of #ifdef's, switch(es) and branches are necessary to
}achieve this. Perhaps someone can point me in the right direction here.


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
