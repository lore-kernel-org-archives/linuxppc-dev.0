Date: Tue, 16 Feb 1999 23:45:20 -0700 (MST)
From: Cort Dougan <cort@persephone.cs.nmt.edu>
To: Troy Benjegerdes <hozer@drgw.net>
cc: Christian Zankel <zankel@tarantel.rz.fh-muenchen.de>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: Restructuring Efforts
In-Reply-To: <Pine.LNX.4.04.9902162012560.432-100000@narn.local.drgw.net>
Message-ID: <Pine.LNX.3.96.990216232757.32682C-100000@persephone.cs.nmt.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I was thinking about that over the last few hours.  The cvs repository for
ppc could work.  I'd be happy to set one up and maintain the cvs tree
for ppc but I have a few problems with it.  1) I would have to move things
from our tree to vger then to linus.  I think testing things in vger is
pretty important since we get to find problems with other peoples code
coming in before it goes to Linus' tree - we can work on it there quickly
to solve the early problems.  2) The changes could come in way too
quickly.  We have incompatible patches out there now, but how would it be
having incompatible changes going into the linux/ppc cvs tree?  We'd have
a broken starting point rather than a working and reasonably stable one.
Bitkeeper might help here, but in essence it just ships patches (Larry
calls 'em deltas) around via smtp.

With metered (and well behaved :) changes going into a linux/ppc cvs tree
I think that wouldn't be a problem.  So I can get a handle on the scope of
things, how many people would want r/w access to a linux/ppc cvs tree?

I believe the number of patches floating around that can go into the
main kernel are in the single digits.  There's quite a bit of overlap in
them I'm pretty sure.  I see the patches as a system for fleshing out
problems before I move them into vger. 

}I would argue that after the careful redesign has been done, a second tree
}would be a good idea. As it is now, it seem to me that there are a large
}bunch of incompatible chaotic patches floating around. If there were
}another CVS archive with the new redesign, you could slowly merge things
}into the mainline kernel, while the rest of us that need all these new

We can do that with vger.  There's no reason vger has to be the same as
Linus'.  That is, the ppc specific parts of the tree only.

}Another reason (IMO) to have a separate tree.. As soon as an official 2.3
}is out, we can dump a large set of working patches directly into it from
}the redone PPC-rework tree.

That's coming up next.

}I'm somewhat partial to the work Corey Minyard started (since I'm using it
}for the MTX SMP support). I think it would help for anyone interested to
}take a look at the way Alpha handles different architectures.

GCC must be the personification of sin itself :)

}ifdefs are evil ;) 

(if _machine) was a euphemism for switch(_machine) which is cleaner than
#ifdef.

}OTOH, I don't know if I like a ton of 'if _machine' from a readability
}standpoint. I would like something similiar to the Alpha's and Corey
}Minyards rework with a structure for various machines with any code that
}would have been inside an #ifdef , switch(_machine) if _machine. 

Similar to what I was aiming at with the pci config access stuff and got
closer to with the current irq.c, right?  I'm trying to do the shaking of
all the patches for restructing to see what comes out.  Corey's work (along
with others) does look good.


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
