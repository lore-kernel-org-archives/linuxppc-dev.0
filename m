Date: Fri, 19 Feb 1999 00:25:30 -0700 (MST)
From: Cort Dougan <cort@persephone.cs.nmt.edu>
Reply-To: Cort Dougan <cort@persephone.cs.nmt.edu>
To: Christian Zankel <zankel@tarantel.rz.fh-muenchen.de>
cc: Benjamin Herrenschmidt <bh40@calva.net>,
        Bill Davidsen <davidsen@prodigy.com>,
        "David A. Gatwood" <marsmail@globegate.utm.edu>,
        Douglas Godfrey <dvdoug@tiac.net>, Gabriel Paubert <paubert@iram.es>,
        Jesper Skov <jskov@cygnus.co.uk>, Troy Benjegerdes <hozer@drgw.net>,
        "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [ppc-dev] Summary: Restructuring Efforts
In-Reply-To: <36CCB670.CE42A873@mailserv.rz.fh-muenchen.de>
Message-ID: <Pine.LNX.3.96.990219000847.9633A-100000@persephone.cs.nmt.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Thanks for the summary, that stated things far more eloquently and
succinctly than I did.

My understanding was that the idea of a linux/ppc developers tree would be
that nearly all the people sending patches could have access.  Was that
not the idea?  The description here sounds like the vger tree.  The vger
tree is play-land for ppc.

}1. CVS
}
}There should be another cvs tree used for developers. A lot of
}(inofficial) patches are floating around. So, this tree can be used as
}the common base where developers can start with their patches upon.
}These patches will be (carefully) added (by Cort). There is no need for
}r/w access for everyone. However, it is a developers kernel, so patches
}can be made much easier in this tree than in an official one. Perhaps
}the use of bitkeeper might also be of help.

I want to have the ability to generate one - I don't want to require it.
I like being able to test 3 archs at once.  I don't like users having to
have a lot of code slowing their machine down if they only use chrp, pmac
or prep and want to build their own arch-specific kernel.

}2. GENERIC KERNEL
}
}Cort wants to have one generic kernel for all desktops. There are
}difficulties with APUS because of the 'non byte swapping io accesses',
}though. 
}The usage of OpenFirmware by supporting functions should be compiled in
}into the generic kernel. Using the variable _having_of will then help to

Already done.

}decide whether to use these functions or not. This can happen either at
}run-time or, when _having_of is made a constant, the optimizer of gcc
}will/might remove this code. 

Putting this critter on a few cache lines is a winner of an idea.  I think
this idea needs some work but what Cory+others (sorry, but I've lost track
of what path this idea has followed :) have come up with is a good
direction.

}Arch specific functions might be grouped into a structure. This
}structure is initialized at startup.  
}To many integration might result in performance penalty because of to
}many functionpointer lookups. Though, careful design (cache boundaries)

head.S just needs to be taken apart for different chips.  8xx, 4xx, 5xx
and 6xx/7xx are too different to try to share.  I've learned my lesson
with the mistake of trying to keep one head.S.  There's a lot of common
code in there that we could call arch-head.S or some such thing.

}3. SEPARATIONS
}
}There have been no suggestions so far about if and how all the pmac_*,
}prep_*, etc. should be seperated into a seperate directory. However,
}Cort stated that head.S will be seperated.
}After the restructuration is completed, it is then easy to support
}different machines by just dropping another directory into the arch/ppc
}directory and doing some minor changes to the Makefile and maybe also to
}config.in.

This is the most important thing to me.  Lots of people have good ideas
but I want to make sure we won't be suffering growing pains too soon again
(for a few months at least).  Many more ports to different systems/chips
are looming and I'd like to make sure the design isn't going to stop us.
I'd also like for machine maker X with patches I don't want to bring into
the kernel (too limited use, too messy or whatever) or because they don't
want them in (proprietary board) can drop in their changes quickly and
easily (within reason).


}- asks for a 'behaved' redesign (ie. not quick'n'dirty)
}- bootloader cleanups are underway (eg. mbxboot for embedded)

The stability issue isn't quite fully realized due to general linux
problems right now, though.

}- 2.2 supposed to be stable with only few changes; restructuring is
}necessary, though

Actually, I'm not saying I dislike the design or don't want to use it.  I
want more people to look at it and try it on their boards to make sure it
works for them.  Mostly the embedded board people (not mbx/rpx, but
mtx,mvme,prep and so on).

}- there is a FTP access for patches; different ideas for restructuring
}should be evaluated

I like that idea as well.  If people really want a linux/ppc CVS I'm
willing to set it up and maintain it.  We should figure out how we'll do
it though.  I like keeping on the bleeding edge but every patch breaking
another arch isn't a good thing :)  I think bitkeeper might help us out,
but it seems to me to work similar to individual cvs trees with a script
to create patches (I'm oversimplifying quite a bit) and shipping them via
email - I know Larry would disagree but from my end-user view it seems to
work this way.

}Benjamin
}- prefers own cvs for developers tree instead of vger 
}Troy
}- we should try out bitkeeper

In the end, I think I do have to use vger.  If only as a stepping stone
from any other ppc trees before going to linus.

}Gabriel
}- is against using vger

My ideas was to do lazy filling-in of structures and/or function pointers.
This falls into the 'half-baked' drawer so I'm not suggesting it as a real
possiblity yet.

}Cort
}- using traps to emulate non existant instructions like tlbia


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
