Date: Fri, 18 Jun 1999 18:59:52 -0400
From: Daniel Jacobowitz <drow@false.org>
To: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>,
        linuxppc-dev@lists.linuxppc.org
Subject: Fix for atyfb and gcc 2.95
Message-ID: <19990618185952.A808@drow.res.cmu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


After a frustrating day playing with yet more of gcc's uglier and
insufficiently-documented internals, I've found the problem with atyfb. 
By chance and/or better register usage, r0 came up as the base register
passed to aty_ld_le32; gcc currently has no way to detect this sort of
mis-specified constraint on user assembly.  r0 is a valid register for
an "r" constraint, but the proper constraint is actually "b" for base. 
This explicitly disallows the use of r0, so egcs will shuffle around
the registers to do the right thing.

Dan

/--------------------------------\  /--------------------------------\
|       Daniel Jacobowitz        |__|        SCS Class of 2002       |
|   Debian GNU/Linux Developer    __    Carnegie Mellon University   |
|         dan@debian.org         |  |       dmj+@andrew.cmu.edu      |
\--------------------------------/  \--------------------------------/

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
