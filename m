Message-Id: <3.0.6.32.19990621190801.008382d0@sins.uia.ac.be>
Date: Mon, 21 Jun 1999 19:08:01 +0200
To: David Hoover <david.hoover@epfl.ch>
From: David De Ridder <david.de.ridder@bitsmart.com>
Subject: Re: dhcp, linuxppc and remote /usr
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <376E5D5F.EBEC6CD3@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 17:42 21-6-99 +0200, David Hoover wrote:

>It is generally desirable for a machine to be able to do it's basic
>startup sequence even if /usr is not mounted yet (if for example it's
>on a remote NFS server).  This is not the case with LinuxPPC when using
>DHCP to get network parameters.
>
>Briefly, DHCP booting does not work if /usr is mounted on a remote
>server.  This is simply because /etc/rc.d/rc3.d/S10network uses the
>'xargs' command (which is in /usr/bin instead of /bin).

 I am booting this way, from an MVME2306 board without harddisk.
 The server providing the kernel also serves as root nfs server,
 apart from /usr (due to a lack of space). The /usr fs is on
 another (DEC) machine. This is no problemo at all - but I am
 using BOOTP instead of DHCP (because the boards primary 
 bootsequence needs it).

>(if you are wondering why somebody would do this, the idea is to
>create a generic ZIP disk that can be used on any machine to start
>up a full LinuxPPC session.  DHCP is used so that it's not
>necessary to hardwire net addresses onto the boot disk).

 I don't either. The /usr system is cleanly mounted while booting
 the init scripts.

>I believe that either xargs should not be used in startup scripts, or
>xargs should be in /bin by default.  After making this change, bootup
>proceeds perfectly).

 That would be my first thought too.

>Just thought somebody might like to know this.

 Thanks for sharing,

+-----------------------------------------------------------------+
  David 'Septimus' De Ridder       <david.de.ridder@bitsmart.com> 

"Never underestimate the power of the soul unleashed."
 - 'Essence Flare' (M:TG)

+-----------------------------------------------------------------+
  


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
