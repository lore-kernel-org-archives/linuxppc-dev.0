Date: Tue, 16 Feb 1999 20:35:35 -0600 (CST)
From: Troy Benjegerdes <hozer@drgw.net>
To: Cort Dougan <cort@persephone.cs.nmt.edu>
cc: Christian Zankel <zankel@tarantel.rz.fh-muenchen.de>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: Restructuring Efforts
In-Reply-To: <Pine.LNX.3.96.990216125317.30556A-100000@persephone.cs.nmt.edu>
Message-ID: <Pine.LNX.4.04.9902162012560.432-100000@narn.local.drgw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 16 Feb 1999, Cort Dougan wrote:

> 
> I want to avoid another tree.  It'll create chaos.  It'll also make my job
> a lot harder.  Things do need to move slowly for a while.  The ppc tree
> could get ugly really quickly by adding all the new archs.  We already have
> more than any other port and will be getting more soon.  I want this to
> serve as motivation for a slow (by linux standards) and careful redesign
> rather than a hack to get arch X, Y and Z working now.
> 
I would argue that after the careful redesign has been done, a second tree
would be a good idea. As it is now, it seem to me that there are a large
bunch of incompatible chaotic patches floating around. If there were
another CVS archive with the new redesign, you could slowly merge things
into the mainline kernel, while the rest of us that need all these new
bleeding edge arches can have a central place where everything is kept, in
a format easy to get at. (patches are really a pain in the ass.. I started
keeping a local CVS repository for this very reason)

> The first step is underway.  I want to cleanup the bootloader mess for
> prep/yellowknife/mbx/rpx.  Moving the embedded stuff to arch/ppc/mbxboot
> will cleanup the prep stuff a good deal.  Then I'll go through the prep
> stuff and most likely replace it with Gabriels bootloader for prep.  It's a
> small step but it needs to be done and it'll move us ahead.
> 
> Keep in mind the 2.2 tree is supposed to be stable.  As few changes as
> possible and only to fix things.  I think the restructure is important
> enough to work on now, though.
> 
Another reason (IMO) to have a separate tree.. As soon as an official 2.3
is out, we can dump a large set of working patches directly into it from
the redone PPC-rework tree.

> This is why I have the directory at linuxppc.cs.nmt.edu for patches.  I'd
> like to collect the patches so we can all look through one anothers work.
> I'd like things to bounce around a bit before going into the tree.  I think
> we should use the -dev list for that. There are several different ideas out
> there for the restructure and I'd like to go through them pretty thoroughly
> before adopting one or any combination of them.
> 
I'm somewhat partial to the work Corey Minyard started (since I'm using it
for the MTX SMP support). I think it would help for anyone interested to
take a look at the way Alpha handles different architectures.

[snip]

> I want to get rid of ifdefs.  When creating the generic desktop kernel the
> comparisons in the 'if' (not ifdef) are done.  When compiling for a
> specific arch the _machine value is no longer a variable but a constant.
> The compile optimizes out the 'if' and gives you a straight path.
> 

ifdefs are evil ;) 
OTOH, I don't know if I like a ton of 'if _machine' from a readability
standpoint. I would like something similiar to the Alpha's and Corey
Minyards rework with a structure for various machines with any code that
would have been inside an #ifdef , switch(_machine) if _machine. 

Then, any generic kernel lookups take one memory access to find the
function (if we, or the compiler can keep the structure pointer in a
register), and hopefully the structure can be cache-aligned so that it
sits in a couple of L2 or L1 cache lines when in kernel mode.

For a specfic machine config, the structure members could be #defined to
be the actuall function, giveing a straight function call.

This also makes MTX support a lot easier, since I ended up haveing the
structure point to half of the CHRP functions and half of the PReP
functions.

--------------------------------------------------------------------------
| Troy Benjegerdes    |       troy@microux.com     |    hozer@drgw.net   |
|    Unix is user friendly... You just have to be friendly to it first.  |
| This message composed with 100% free software.    http://www.gnu.org   |
--------------------------------------------------------------------------


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
