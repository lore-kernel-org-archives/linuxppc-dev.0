Message-ID: <376E5D5F.EBEC6CD3@epfl.ch>
Date: Mon, 21 Jun 1999 17:42:23 +0200
From: David Hoover <david.hoover@epfl.ch>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: dhcp, linuxppc and remote /usr
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

It is generally desirable for a machine to be able to do it's basic
startup sequence even if /usr is not mounted yet (if for example it's
on a remote NFS server).  This is not the case with LinuxPPC when using
DHCP to get network parameters.

Briefly, DHCP booting does not work if /usr is mounted on a remote
server.  This is simply because /etc/rc.d/rc3.d/S10network uses the
'xargs' command (which is in /usr/bin instead of /bin).

(if you are wondering why somebody would do this, the idea is to
create a generic ZIP disk that can be used on any machine to start
up a full LinuxPPC session.  DHCP is used so that it's not
necessary to hardwire net addresses onto the boot disk).

I believe that either xargs should not be used in startup scripts, or
xargs should be in /bin by default.  After making this change, bootup
proceeds perfectly).

Just thought somebody might like to know this.

I'm not on this list--so please reply to me personally if you have
a comment.

Dave.

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
