Date: Fri, 19 Feb 1999 17:12:21 +1100
Message-Id: <199902190612.RAA00610@tango.anu.edu.au>
From: Paul Mackerras <paulus@cs.anu.edu.au>
To: zankel@tarantel.rz.fh-muenchen.de
CC: bh40@calva.net, davidsen@prodigy.com, cort@persephone.cs.nmt.edu,
        marsmail@globegate.utm.edu, dvdoug@tiac.net, paubert@iram.es,
        jskov@cygnus.co.uk, hozer@drgw.net, linuxppc-dev@lists.linuxppc.org
In-reply-to: <36CCB670.CE42A873@mailserv.rz.fh-muenchen.de> (message from
	Christian Zankel on Fri, 19 Feb 1999 01:55:12 +0100)
Subject: Re: [ppc-dev] Summary: Restructuring Efforts
Reply-to: Paul.Mackerras@cs.anu.edu.au
References: <36CCB670.CE42A873@mailserv.rz.fh-muenchen.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Christian Zankel <zankel@tarantel.rz.fh-muenchen.de> wrote:

> There should be another cvs tree used for developers. A lot of
> (inofficial) patches are floating around. So, this tree can be used as
> the common base where developers can start with their patches upon.

I think a CVS tree for developers is a good idea.  In fact I think we
need two trees; one for developers to share their latest thoughts, and
another one where we put stuff once it is tested and known not to
break things for most users.  The second tree would then be the one
from which patches get sent to Linus.

If we do that, then we can give relatively wide access to the
development tree, and restrict access to the stable tree to one or two
people (Cort and I, maybe).  That way the divergence of the stable
tree from Linus' could be controlled.

Ideally the trees should provide read-only rsync access since that is
so much more efficient for people who are a long way from the cvs
server.

I would think that dev.linuxppc.org is probably the best place to keep
these trees.

> Cort wants to have one generic kernel for all desktops. There are
> difficulties with APUS because of the 'non byte swapping io accesses',
> though. 

There is some value in having a generic kernel for the desktops (PReP,
powermac, CHRP), particularly if they can all boot an ELF image.

As for APUS, I think it is sufficiently different that having a
separate APUS-only kernel is not a problem.  The various embedded
ports don't want a generic kernel because space is usually at a
premium.

> The usage of OpenFirmware by supporting functions should be compiled in
> into the generic kernel. Using the variable _having_of will then help to
> decide whether to use these functions or not. This can happen either at
> run-time or, when _having_of is made a constant, the optimizer of gcc
> will/might remove this code. 

If there is no device tree, then it should still be safe to call the
device-tree routines (e.g. find_device, etc.) because the variable
holding the root of the tree will be initialized to NULL, so
find_device etc. should just return NULL.  If necessary, a port could
define these as macros to save space.  It would be too ugly to have to
check _have_of each time before calling any device-tree routines.

> There have been no suggestions so far about if and how all the pmac_*,
> prep_*, etc. should be seperated into a seperate directory. However,

We thought about having separate prep, pmac, chrp etc. directories
back when we were integrating the prep and pmac ports.  At that stage
it was easier just to have a single directory since the amount of
common code outweighed the port-specific code.

I would definitely support having a separate directory for the
860-based ports, since they are substantially different, even the MMU
works quite differently.  Maybe separate directories for the desktops
and the embedded ports would work well.

Paul.

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
