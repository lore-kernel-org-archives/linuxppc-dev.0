Message-ID: <38F4BBFA.B3CE8273@execpc.com>
Date: Wed, 12 Apr 2000 13:10:02 -0500
From: Joseph Garcia <jpgarcia@execpc.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: Problems with Ethernet on PowerBook Wallstreet G3
References: <Pine.LNX.3.96.1000412105423.25261A-100000@deepspace.mklinux.org>
Content-Type: text/plain; charset=iso-2022-jp
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Here's my observations on whats happening with my system (PDQ/300):

Any out-going FTP transfer maxes around 100K/s, and has potential to corrupt.
NFS, atalk, etc seem to be ok.  Incoming transfers also seem to be ok.  By
outgoing, I do mean out going.  Whether its with a server (wu or pro), or a
client, if the file originates from my powerbook, it has this common problem.

During the time of transfer, the collision light on the hub blares.  I have
tried this with a normal hub and a switch.  As far as I can tell, this would
mean it is colliding with itself.  How else could a switched hub get collisions
this prevalent?

Initially, I was thinking that this is a bug brought on by the BMAC+, a
sibling/upgrade to the BMAC that can do 100BT and full duplex.  I looked at the
driver, and one wait value was changed from a few hundred ms (early 2.2.x) to 10
ms.  I tried switching it back, but there was no change.  so its not that.
Anything else that could be causing it?  I don't remember this problem with
earlier 2.2 kernels.  Anyone confirm this?  2.1.x maybe?

I severly doubt it is a pure TCP problem, because ftp using the lo device
regards high return.  The only possible cause is the BMAC driver IMO.  But how
would it only effect FTP outgoing?  I've heard that FTP uses raw bandwidth, so
does that mean it uses some low level handshaking that nothing else uses, and
depends on the file's host?   So where do FTP-out and BMAC collide in such a way
that it doesnt affect lo, nor incoming files?

Sorry if I'm ranting.

Is this info any help?

--
Joseph P. Garcia      jpgarcia@execpc.com      jpgarcia@lidar.ssec.wisc.edu
CS Undergraduate                      Student Employee - Systems Programmer
University of Wisconsin - Madison                            UW Lidar Group

"Did you ever notice how the Chinese Abacus, with 2 '5' beads and 5 '1'
beads, is perfect for hexidecimal math?"

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
