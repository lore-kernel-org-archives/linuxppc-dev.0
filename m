Date: Thu, 4 Mar 1999 18:22:03 -0500
From: Michael Meissner <meissner@tiktok.cygnus.com>
To: Gerd Knorr <kraxel@goldbach.in-berlin.de>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: MVME 2306 almost up and running
Message-ID: <19990304182203.A1856@tiktok.cygnus.com>
References: <Pine.SO4.4.05.9903041715480.4479-100000@hsins.uia.ac.be> <199903041951.UAA00814@macintoy.masq.in-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <199903041951.UAA00814@macintoy.masq.in-berlin.de>; from Gerd Knorr on Thu, Mar 04, 1999 at 08:51:55PM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Mar 04, 1999 at 08:51:55PM +0100, Gerd Knorr wrote:
> 
> > Hi,
> > 
> > My final question : our board now finally boots, it can mount an
> > NFS partition as root fs, but does anybody know where on the Internet
> > I can find a file system tree with the binaries for LinuxPPC ? I mean,
> > like Slackware, but for LinuxPPC. (We have no other [spare] PPC based
> > machines, so I need a full binary file tree to set up on the NFS fs).
> 
> Just download the basic rpm's and install them on the NFS Server
> with "rpm --root=/export/nfsroot4ppc -i *.rpm".

I think the point is that the normal rpm's (ie, ftp.linuxppc.{org,com}) won't
work too well on an ppc860, since that machine does not have a FPU, and the
kernel support for emulating fp might not be present or even if present, too
slow.

One thought is to build a cross compiler on some other system, and manually
build the compiler and enough tools to run native and then bootstrap the old
fashioned way (you probably want to use the --with-cpu=860 switch when
configuring, so that binaries by default don't reference the fpu).  However,
setting up a cross compiler is somewhat tricky if you've never done it before.

-- 
Michael Meissner, Cygnus Solutions
PO Box 98, Ayer Massachusetts, USA 01432-0098
meissner@cygnus.com

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
