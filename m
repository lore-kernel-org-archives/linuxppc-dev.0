From: "Eddy Raineri" <eraineri@axiom-tx.com>
To: <linuxppc-dev@lists.linuxppc.org>
Subject: Quad SMP on G4
Date: Mon, 16 Apr 2001 10:48:42 -0500
Message-ID: <000d01c0c68c$b65be250$3e03a8c0@dnaent.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello,

If this is not the correct forum for these questions; I apologize and could
someone please direct me to the correct one forum for me to post this.

1)  I am currently working on a quad G4 custom processor board.  I have been
trying to keep up with the linuxppc_2_4 tree on bitkeeper.fsmlabs.com.  I
have successfully brought the board up with all 4 processors however at
times I get various lock ups in the spin locks.  These spinlock debugs
follow.

	spin_unlock(c0157384): no lock cpu 0 curr PC c0040500 mke2fs/22
	_spin_unlock(c0157384): cpu 0 trying clear of cpu 2 pc c00404f0 val
ffffffff
	_spin_unlock(c0157384): cpu 2 trying clear of cpu 0 pc 28/680bc val
ffffffff
	29/68_spin_unlock(c0157384): cpu 2 trying clear of cpu 0 pc c00400bc

This spin_lock is lru_list_lock.

I've also seen common instances where everything locks up inside of the
hash_table_lock.  I have gotten this by running Bonnie on my SCSI harddrive.

2)  I have also noticed that trying to mount an nfs disk without the -o
nolock option causes the following errors.  However it does mount.

    portmap: server localhost not responding, timed out
    portmap: server localhost not responding, timed out
    lockd_up: makesock failed, error=-5
    portmap: server localhost not responding, timed out


3)  I have also noticed some rather strange behavior with SCSI.   When I do
a mke2fs on the device partition I get repeated block: queued_sectors < 0,
however at times it stops and works correctly and at times it segment faults
with a 300 exception.

Other times when I try the mke2fs I get

	_spin_unlock(c0157384): no lock cpu 0 curr PC c0040500 mke2fs/28
	_spin_unlock(c0157384): no lock cpu 0 curr PC c0040500 mke2fs/28
	_spin_unlock(c0157384): no lock cpu 0 curr PC c0040500 mke2fs/28
	_spin_unlock(c0157384): no lock cpu 0 curr PC c0040500 mke2fs/28

This spinlock is the lru_list_lock as well

all the above work fine with no smp or in some cases with only 2 processors.


4)  One more simple question.  I'm unclear as to which 2_4 version I should
pull from I have been using the linuxppc_2_4 kernel and not linus' is this
correct?  I'm trying to stay current on the PPC fixes for the 2_4 kernel.  I
am assuming that any fixes Linus makes to the kernel will be put into the
linuxppc_2_4 version however any fixes made in general by the PPC group
might not make it into the Linus version.

I apologize if this is repeated.  I'm trying desperately to find the
resources necessary for me to stay informed but may have not found it yet.



Eddy


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
