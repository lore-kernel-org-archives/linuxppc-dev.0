Return-Path: <mamsadegh@hotmail.com>
Received: from bay0-omc3-s33.bay0.hotmail.com (bay0-omc3-s33.bay0.hotmail.com
	[65.54.246.233]) by ozlabs.org (Postfix) with ESMTP id 5DC00DDED4
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 26 May 2007 20:05:56 +1000 (EST)
Message-ID: <BAY115-W7237FE8CEE9FBD0306B52B22A0@phx.gbl>
From: Mohammad Sadegh Sadri <mamsadegh@hotmail.com>
To: <grant.likely@secretlab.ca>, <akonovalov@ru.mvista.com>,
	<miroslaw.dach@psi.ch>
Subject: RE: ML403 2.6 kernel, root file system on NFS, stops after freeing
	unused kernel memory
Date: Sat, 26 May 2007 10:05:53 +0000
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


dear grant

As i said i'm using ELDK 4.0 root file system via NFS

ML403 gets IP address from DHCP , mounts the root file system via NFS and t=
hen simply stops printing messages on the screen. The board is alive becaus=
e it answers ping requests.

-- VFS: Mounted root file system (nfs filesystem)
-- Freeing unused kernel memory :108k init
( No more messages after here , hyperterminal does not show anything more )

I have chosen my root file system to be /home/sadri/hld/eldk/ppc_4xx=20
(/home/sadri/hdl/eldk is eldk installation folder )

/eldk/ppc_4xx/dev contains the following node:

crw-rw-rw- 1 root root 5, 1 May 16 09:08 console

and the last line for /etc/inittab is :

# Run gettys in standard runlevels
3:2345:respawn:/sbin/mingetty --noclear console

in addition I passed the init=3D/bin/sh parameter to the kernel with no suc=
cess.=20

the link is auto negotiated at 100MBPS

I'm using OPB UART 16550.=20

I studied the ports by Mirek23 carefully and I know that his problem has be=
en the definition of SDRAM size in xparameters.h , but this is not my probl=
em. I checked that for EDK 9 it is correct.

what is your idea?

thanks
mohammad sadegh.





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
