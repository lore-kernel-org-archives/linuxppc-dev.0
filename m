Date: Thu, 31 Dec 1998 14:52:51 -0700 (MST)
From: Cort Dougan <cort@persephone.cs.nmt.edu>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: grackle, patches, MMU, ...
In-Reply-To: <19981230113716.015659@mail.mipsys.com>
Message-ID: <Pine.LNX.3.96.981231144829.14374A-100000@persephone.cs.nmt.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Against vger please.  I'll smooth out the vger/linus differences myself.

Getting things to Linus now is difficult with the 'real' freeze now.
Things are going to have to sit still for a while unless they really need
fixing.

}I'll post a cleaned up set of patches with only the safe ones to simplify
}merging (I'm waiting some stuff from Tom Rini to complete the ADB+mice
}patches) but do you (you=people doing the merge with Linus tree) prefer
}patches against current vger (still at 2.1.130) or directly against Linus
}2.2-pre1 ?

Right.  We only use 2 bats for the kernel if one won't cover it.

}I also spent some time looking at the MMU initialisations, and it looks
}like we are using one BAT on powermacs for mac-io and that's all. PREP is
}using two, APUS too. BATs 2 and 3 are used to map physical RAM for the
}kernel, that's it ?

The # of free bats depends on the machine.  We'd only have all the bats
free if we map without the BATS entirely.  We don't to switch between
mapping with and without BATS on the kernel depending on the process.

}So we have one free BAT (#1) only on pmac and chrp, but if we plan to
}switch BATs along with process contexts (for mapping fbdevs with BATs for
}example), then we would have all BATs free for user processes. Am I correct ?

PCI is a lot bigger than one bat.  On prep we map all the pci space we use
with a bat.

}I was wondering if, instead of using the remaining free BAT to map the
}framebuffer for the kernel (to speed up console), why couldn't we use a
}BAT to map the entire assigned PCI memory space for the kernel ? This
}would speed-up accesses to all devices (including framebuffers). We
}already map the entire mac-io (at least the first one on machines with
}two of them).


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
