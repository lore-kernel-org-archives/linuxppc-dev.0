Message-ID: <3713E45B.60335A75@airways.com>
Date: Tue, 13 Apr 1999 17:42:03 -0700
From: "D. Lance Robinson" <lancer@airways.com>
Reply-To: lancer@airways.com
MIME-Version: 1.0
To: linux-raid <linux-raid@vger.rutgers.edu>,
        linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Memory buffer corruption with Raid on PPC
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I have linux 2.2.3 with raid014519990309.. patch.

On a PPC (Mac G3) system, I am getting what seems to be memory buffer
courruption when using raidstart. The same kernel source run with i386
architecture seems to be fine.

To show the problem, I do something like the following...

#  cd ~me
#  gcc source_a.c 
#  raidstart /dev/md0 ; gcc source_a.c 
#  raidstop  /dev/md0 ; gcc source_a.c 
#  raidstart /dev/md0 ; gcc source_a.c 
#  raidstop  /dev/md0 ; gcc source_a.c 
#  raidstart /dev/md0 ; gcc source_a.c 
#  raidstop  /dev/md0 ; gcc source_a.c 
#  raidstart /dev/md0 ; gcc source_a.c 
#  raidstop  /dev/md0 ; gcc source_a.c 

Usually doing this will cause the compile to have a problem. Such as:
"Illegal Instruction", or some compile error. This indicates some sort
of memory buffer corruption since the gcc is all done out of memory.

The problem seems to be in the raidstart area. It shows up after
starting the array, but once the array is started (and passes the gcc
test,) it works fine.

Any ideas ?

Thanks, <>< Lance.

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
