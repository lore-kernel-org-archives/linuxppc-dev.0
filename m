Message-Id: <200002092154.NAA13033@work.bitmover.com>
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Vger CVS R.I.P. (Was Re: the state of the linuxppc-dev community)
In-Reply-To: Your message of "Wed, 09 Feb 2000 22:41:55 +0100."
             <Pine.LNX.4.10.10002092236290.15408-100000@opal.biophys.uni-duesseldorf.de>
Date: Wed, 09 Feb 2000 13:54:15 -0800
From: Larry McVoy <lm@bitmover.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


: And I just got used to CVS :-(( I'd need a BK primer when it gets
: available.

It's not too bad to get used to.  The main weirdness for most people is that
you are working in a tree with the revision history files right there.  So
if you are in fs/ext2 and you do this

    $ bk clean
    $ ls -F
    SCCS/
    $ bk co
    CHANGES 1.1: 157 lines
    Makefile 1.1: 15 lines
    acl.c 1.1: 17 lines
    balloc.c 1.1: 756 lines
    bitmap.c 1.1: 27 lines
    dir.c 1.2: 212 lines
    file.c 1.4: 173 lines
    fsync.c 1.2: 156 lines
    ialloc.c 1.1: 569 lines
    inode.c 1.4: 932 lines
    ioctl.c 1.1: 90 lines
    namei.c 1.3: 894 lines
    super.c 1.4: 805 lines
    symlink.c 1.1: 43 lines
    truncate.c 1.1: 382 lines
    $ ls -F
    CHANGES   SCCS/  balloc.c  dir.c   fsync.c   inode.c  namei.c  symlink.c
    Makefile  acl.c  bitmap.c  file.c  ialloc.c  ioctl.c  super.c  truncate.c

This makes people a little crazy until they get used to it.  The BitKeeper
model is "one user, one repository" and it's a lot like using straight
RCS or SCCS.  On top of that, we've added the ability to resync and
merge the revision histories.

In some ways, it's based on the observation that basic SCCS/RCS worked fine
as long as it was single user.  We've returned to that model plus added the
ability to have a lot of singler user copies of a project.

Basic stuff you'll need:

    # get yourself a baseline tree
    $ bk clone hq.fsmlabs.com:/home/bk/linuxppc_2_3 linuxppc_2_3

    # Set it up for building/working (this checks out and locks all files)
    $ bk -r edit

    # hack, build, debug, hack, build, debug

    # Run citool to commit (LOCALLY! Not like CVS) your changes
    $ bk citool

    # Update your tree with anything that's happened since last time
    $ bk pull

    # Push back any changes you've made
    $ bk push

    # Browse the tree's changes
    $ bk sccstool

    # Browse a specific file
    $ bk sccstool fs/ext2/super.c

There's tons more but that's all most people ever need.  Cort, did I
forget anything?

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
