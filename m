Message-ID: <38A018A5.FD10C45D@execpc.com>
Date: Tue, 08 Feb 2000 07:22:45 -0600
From: Joseph Garcia <jpgarcia@execpc.com>
MIME-Version: 1.0
To: Josh Huber <huberj@wpi.edu>
CC: Linux/PowerPC Devel List <linuxppc-dev@lists.linuxppc.org>
Subject: Re: BMAC eth problems...
References: <20000208020802.B5287@majere.nightshade.org>
Content-Type: text/plain; charset=iso-2022-jp
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Josh Huber wrote:
> Anyone else seeing this?

My wallstreet/300 has a similar, possibly related problem.  any FTP transfer
originating from my powerbook in Linux (under any client or server) has a max
transfer under 100k.  This is a BMAC driver problem.  my brother's lombard
(BMAC+) seems to have no problem.  The big thing to notice is that in my case,
the traffic is colliding... with itself.  Duplex problem? (BMAC+ can, BMAC
cant).. but since we're not on a switched hub, that doesn't make much sense.

MacOS has no problems with my ethernet card; incoming FTP transfers work normal;
and i double checked with an FTP to myself (using lo), and it went fast.  So i
deduce this is a problem in someway connected to the hardware driver.

I have tested one theory.  In bmac.c, there is a delay called MIFDELAY that in
2.2.1 was 500, and now is 10.  I tried putting it back to make sure it wasn't
tripping on itself with that, but there was no improvement.

Other ideas?

--
Joseph P. Garcia      jpgarcia@execpc.com      jpgarcia@lidar.ssec.wisc.edu
CS Undergraduate                      Student Employee - Systems Programmer
University of Wisconsin - Madison                            UW Lidar Group

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
