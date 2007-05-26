Return-Path: <mamsadegh@hotmail.com>
Received: from bay0-omc3-s37.bay0.hotmail.com (bay0-omc3-s37.bay0.hotmail.com
	[65.54.246.237]) by ozlabs.org (Postfix) with ESMTP id EA92FDDE0E
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 26 May 2007 23:46:57 +1000 (EST)
Message-ID: <BAY115-W15A8C3F50BF6AA5251BAB9B22A0@phx.gbl>
From: Mohammad Sadegh Sadri <mamsadegh@hotmail.com>
To: <grant.likely@secretlab.ca>
Subject: RE: ML403 2.6 kernel, root file system on NFS, stops after freeing
	unused kernel memory
Date: Sat, 26 May 2007 13:46:56 +0000
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


hi

ok! problem solved

problem was kernel command line

mine was:

CONFIG_CMDLINE=3D"console=3DttyS0,9600 console=3Dtty0 root=3D/dev/nfs rw nf=
sroot=3D10.10.10.10:/home/sadri/hdl/eldk_rootfs/ppc_4xx ip=3Ddhcp"

by default 2.6.21 CMDLINE contains two console parameters,=20
the correct one should be=20

CONFIG_CMDLINE=3D"console=3DttyS0,9600 root=3D/dev/nfs rw nfsroot=3D10.10.1=
0.10:/home/sadri/hdl/eldk_rootfs/ppc_4xx ip=3Ddhcp"

well , rootfs comes up until login prompt,
I enter root as the password but it gives "incorrect login" message/

another note:
I changed the memory size to 32Mbytes from 64, I feel the system is more st=
able in this case. some times the system does not come up probperly. ( gene=
rates segmentation fault and similar messages )

thanks


----------------------------------------
> Date: Wed, 23 May 2007 10:58:28 -0600
> From: grant.likely@secretlab.ca
> To: mamsadegh@hotmail.com
> Subject: Re: ML403 2.6 kernel, root file system on NFS, stops after freei=
ng unused kernel memory
> CC: linuxppc-embedded@ozlabs.org
>=20
> On 5/23/07, Mohammad Sadegh Sadri  wrote:
> >
> > Hi all
> >
> > I have studied the disscussion here mainly by Mirek32 (I think this was=
 the name)  but unfortunately the disscussion is finished without any suita=
ble answer and solution.
> >
> > the 2.6 kernel comes up on ml403 with no problem, it gets an IP address=
 from my DHCP and mounts the root file system from my NFS server , all of t=
hese are ok.
> >
> > Unfortunately , after "freeing unused kernel memory ", init , console s=
tops working however the board is alive because it answers all of my pings =
correctly. I tried to make a telnet connection to the board with no success=
. ( I'm using ELDK 4.0)
> >
> > any suggestions what is happening here?
>=20
> Is there a /dev/console node?
>=20
> try booting with init=3D/bin/sh to see if you get a console.
>=20
> Your /etc/inittab might not be starting a getty on the console device.
>=20
> Cheers,
> g.
>=20
> --=20
> Grant Likely, B.Sc., P.Eng.
> Secret Lab Technologies Ltd.
> grant.likely@secretlab.ca
> (403) 399-0195

_________________________________________________________________
Invite your mail contacts to join your friends list with Windows Live Space=
s. It's easy!
http://spaces.live.com/spacesapi.aspx?wx_action=3Dcreate&wx_url=3D/friends.=
aspx&mkt=3Den-us=
