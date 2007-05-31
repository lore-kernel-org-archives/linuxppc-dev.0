Return-Path: <mamsadegh@hotmail.com>
Received: from bay0-omc3-s31.bay0.hotmail.com (bay0-omc3-s31.bay0.hotmail.com
	[65.54.246.231]) by ozlabs.org (Postfix) with ESMTP id 2D721DDF1A
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  1 Jun 2007 04:54:37 +1000 (EST)
Message-ID: <BAY115-W17F1AB35DDD5B358CAC89B22D0@phx.gbl>
From: Mohammad Sadegh Sadri <mamsadegh@hotmail.com>
To: <bwarren@qstreams.com>
Subject: RE: Kernel 2.6, ML403, rootfs on nfs, gigabit ethernet link, nfs
	mount problems
Date: Thu, 31 May 2007 18:54:36 +0000
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
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


Hi all,

thanks for suggestions
I added rsize=3D1024,wsize=3D1024 to CMD LINE. INIT can now be executed fro=
m nfs, but I think that the problem still exists,
during the start up process ( from when the rootfs is mounted until user ge=
t a command prompt ) some times ML403 stops working completely, and generat=
es "Segmentation Fault" and similar messages. some other times the system c=
omes up with no problem.=20

I had the same problem when mounting rootfs using nfs via 100mbits link , b=
ut for gigabit link the probability of reaching this unstable state is much=
 higher.

any ideas?

thanks




----------------------------------------
> Subject: Re: Kernel 2.6, ML403, rootfs on nfs, gigabit ethernet link, nfs=
	mount problems
> From: bwarren@qstreams.com
> To: mamsadegh@hotmail.com
> CC: linuxppc-embedded@ozlabs.org
> Date: Tue, 29 May 2007 10:52:21 -0400
>=20
> Hi Mohammad,
>=20
> On Tue, 2007-05-29 at 14:41 +0000, Mohammad Sadegh Sadri wrote:
> > Hi all,
> >=20
> > well I could bring up the grant's kernel on ml403 completely. the root =
file system was over nfs.=20
> >=20
> > when I use a 100mbits link for connection to ml403 , every thing is wor=
king suitably.
> > but when I use a 1000mbits link, I see that ml403 gets ip address from =
dhcp and mounts the root file system but can not go further , it stops with=
 a message: "nfs server not responding ...." some thing like this.
> >=20
> > when pinging to ml403 with 64 bytes packets, ping works fine for both o=
f 100 and 1000mbits links
> > but when I try to ping the board with 4000 bytes packets I notice that =
ml403 on gigabit link can not answer to ping packets, however on 100mbit li=
nk every thing works just fine.
> >=20
> > any ideas?
>=20
> NFS is notorious for sending lots of big packets one right after
> another.  This can easily overwhelm an Ethernet receiver.  Until you're
> able to figure out why the 1000M link can't keep up, limit the NFS
> receive packet sizes by passing the following NFS option in your kernel
> command line:
>=20
> rsize=3D1024
>=20
> You can experiment with the value.  I believe the NFS default size is
> typically 8kB or greater.
>=20
> regards,
> Ben
>=20

_________________________________________________________________
Invite your mail contacts to join your friends list with Windows Live Space=
s. It's easy!
http://spaces.live.com/spacesapi.aspx?wx_action=3Dcreate&wx_url=3D/friends.=
aspx&mkt=3Den-us=
