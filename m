Return-Path: <gkenaley@echelon.com>
Received: from [205.229.50.10] (ntfw.echelon.com [205.229.50.10])
	by ozlabs.org (Postfix) with ESMTP id F2793DE000
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  1 Jun 2007 05:48:14 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Kernel 2.6, ML403, rootfs on nfs, gigabit ethernet link,
	nfsmount problems
Date: Thu, 31 May 2007 12:36:10 -0700
Message-ID: <DDBD7B17DB2ECE48BCD94C593F7255B4046EA0FE@monk.echelon.echcorp.com>
In-reply-to: <BAY115-W17F1AB35DDD5B358CAC89B22D0@phx.gbl>
References: <BAY115-W17F1AB35DDD5B358CAC89B22D0@phx.gbl>
From: "Gary Kenaley" <gkenaley@echelon.com>
To: "Mohammad Sadegh Sadri" <mamsadegh@hotmail.com>,
	<bwarren@qstreams.com>
Cc: Linux PPC Linux PPC <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This can be caused by problems with your host Ethernet driver. For
instance, the e1000 driver running on the Intel 82573L controller must
have ~ the following line added to /etc/modprobe.conf:
	options e1000 RxIntDelay=3D32
Another symptom is occasional erratic ping times to and from the host.

The quickest way to test this theory is to put the rootfs on a
different-hardware, known-good host and see if the problem goes away.

On an 8349, we have also see Phy chip problems which required a reset
after every write to the Phy, and problems setting up the Phy when
stepping through the debugger.


> -----Original Message-----
> From: linuxppc-embedded-bounces+gkenaley=3Dechelon.com@ozlabs.org
> [mailto:linuxppc-embedded-bounces+gkenaley=3Dechelon.com@ozlabs.org] =
On
> Behalf Of Mohammad Sadegh Sadri
> Sent: Thursday, May 31, 2007 11:55 AM
> To: bwarren@qstreams.com
> Cc: Linux PPC Linux PPC
> Subject: RE: Kernel 2.6, ML403, rootfs on nfs, gigabit ethernet link,
> nfsmount problems
>=20
>=20
> Hi all,
>=20
> thanks for suggestions
> I added rsize=3D1024,wsize=3D1024 to CMD LINE. INIT can now be =
executed
from
> nfs, but I think that the problem still exists,
> during the start up process ( from when the rootfs is mounted until
user
> get a command prompt ) some times ML403 stops working completely, and
> generates "Segmentation Fault" and similar messages. some other times
the
> system comes up with no problem.
>=20
> I had the same problem when mounting rootfs using nfs via 100mbits
link ,
> but for gigabit link the probability of reaching this unstable state
is
> much higher.
>=20
> any ideas?
>=20
> thanks
>=20
>=20
>=20
>=20
> ----------------------------------------
> > Subject: Re: Kernel 2.6, ML403, rootfs on nfs, gigabit ethernet
link,
> nfs	mount problems
> > From: bwarren@qstreams.com
> > To: mamsadegh@hotmail.com
> > CC: linuxppc-embedded@ozlabs.org
> > Date: Tue, 29 May 2007 10:52:21 -0400
> >
> > Hi Mohammad,
> >
> > On Tue, 2007-05-29 at 14:41 +0000, Mohammad Sadegh Sadri wrote:
> > > Hi all,
> > >
> > > well I could bring up the grant's kernel on ml403 completely. the
root
> file system was over nfs.
> > >
> > > when I use a 100mbits link for connection to ml403 , every thing
is
> working suitably.
> > > but when I use a 1000mbits link, I see that ml403 gets ip address
from
> dhcp and mounts the root file system but can not go further , it stops
> with a message: "nfs server not responding ...." some thing like this.
> > >
> > > when pinging to ml403 with 64 bytes packets, ping works fine for
both
> of 100 and 1000mbits links
> > > but when I try to ping the board with 4000 bytes packets I notice
that
> ml403 on gigabit link can not answer to ping packets, however on
100mbit
> link every thing works just fine.
> > >
> > > any ideas?
> >
> > NFS is notorious for sending lots of big packets one right after
> > another.  This can easily overwhelm an Ethernet receiver.  Until
you're
> > able to figure out why the 1000M link can't keep up, limit the NFS
> > receive packet sizes by passing the following NFS option in your
kernel
> > command line:
> >
> > rsize=3D1024
> >
> > You can experiment with the value.  I believe the NFS default size
is
> > typically 8kB or greater.
> >
> > regards,
> > Ben
> >
>=20
> _________________________________________________________________
> Invite your mail contacts to join your friends list with Windows Live
> Spaces. It's easy!
>
http://spaces.live.com/spacesapi.aspx?wx_action=3Dcreate&wx_url=3D/friend=
s.a
sp
> x&mkt=3Den-us
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
