From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15772.15234.260268.112782@nanango.paulus.ozlabs.org>
Date: Thu, 3 Oct 2002 22:43:46 +1000 (EST)
To: linuxppc-dev@lists.linuxppc.org
Subject: changes to linuxppc-2.5 4xx files
Reply-To: paulus@samba.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


If you do a pull from linuxppc-2.5 you will notice that several
4xx-related files get deleted and undeleted.  However, nothing should
actually change beyond a few BK tags disappearing.  Nevertheless, if
you are working on 4xx you may like to do a bk export on your tree
before the pull just in case.

We have had a situation for a little while where BitKeeper thinks that
the local versions of several files in the linuxppc-2.5 tree are
completely different files from the files of the same name in Linus'
tree.  This creates problems because it makes it difficult for me to
send 4xx updates to Linus, and because it means that any updates that
are done in Linus' tree to those files don't propagate to the
linuxppc-2.5 tree.

This came about because Armin deleted a bunch of files and then
created new files with the same names.  I'm not blaming him for
anything, but people, if you want to create, move or delete files,
please, if at all possible, do it like this: (a) make a clone of
Linus' linux-2.5 tree, (b) do the creation/move/deletions there, (c)
pull from there into your linuxppc-2.5 repo (and push to bkbits if
appropriate), (d) make your clone available for me to pull from.  Then
I can pull from there and get Linus to pull from my tree.  That way
when we pull from Linus' tree into linuxppc-2.5, BitKeeper will just
say "oh I've already done that" rather than getting confused.  But to
do that, I need to be able to pull from a repo that has *only* the one
set of changes in it (as compared to Linus' tree).

What I have done to rectify the situation is to delete the new
versions of the files (in the linuxppc-2.5 tree) and undelete the old
versions, so that linuxppc-2.5 and Linus' tree are now coherent
again.  Then I checked in the changes that had been done since the
deletion/creation event.

That has meant that we have lost a bit of revision history (or at
least it has become less accessible).  That's unfortunate, but the
other alternative - doing a similar deletion/creation and pushing it
to Linus - would also have lost the revision history, since when that
changeset came around, the newly created files in Linus' tree would
still have been different files (as far as BK is concerned) from the
local files.

Note that as things stand, we are also going to lose the revision
history on all the new files that are in linuxppc-2.5 but not in
Linus' tree, once they get sent to Linus.

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
