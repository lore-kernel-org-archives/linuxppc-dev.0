Return-Path: <mamsadegh@hotmail.com>
Received: from bay0-omc2-s12.bay0.hotmail.com (bay0-omc2-s12.bay0.hotmail.com
	[65.54.246.148]) by ozlabs.org (Postfix) with ESMTP id 78376DE248
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 19 Apr 2008 15:06:59 +1000 (EST)
Message-ID: <BAY115-W2171F152CF03D1C03F6C4FB2E70@phx.gbl>
From: Mohammad Sadegh Sadri <mamsadegh@hotmail.com>
To: Rick Moleres <rick.moleres@xilinx.com>, Rami WEHBI
	<rwehbi@wirecom-tech.com>, <linuxppc-embedded@ozlabs.org>
Subject: RE: XPS_LL_TEMAC works correctly?
Date: Sat, 19 Apr 2008 05:06:58 +0000
In-Reply-To: <20080414154236.64322C88074@mail166-sin.bigfish.com>
References: <D3C541E264C021479BFB60B3B790C0FB30A657@etoilenoire.STARWARS.local>
	<BAY115-W23ED8F42C0F097D8A7864AB2E80@phx.gbl>
	<20080414154236.64322C88074@mail166-sin.bigfish.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


I solved the problem,=20

As i said,=20
problem was : kernel could easily mount the root file system on NFS and beg=
in init , but after that every thing stopped and there was no more progress=
.=20

My problem was with the kernel command line parameters :=20
console=3DttyUL0 console=3Dtty0 root=3D/dev/nfs.......

the second console parameter was the source of the problem, when init is ex=
ecuted, the second parameter caused no more messages to be written on the s=
creen.

I tested using both LL_TEMAC 1.00a and 1.00b , both work well.=20
thanks.

________________________________
> Subject: RE: XPS_LL_TEMAC works correctly?
> Date: Mon, 14 Apr 2008 09:42:33 -0600
> From: Rick.Moleres@xilinx.com
> To: mamsadegh@hotmail.com; rwehbi@wirecom-tech.com; linuxppc-embedded@ozl=
abs.org
>=20
>=20
> There are a couple of bugs in the v1.00b version of xps_ll_temac (one in =
checksum offload, one in multicast address reception).  You should try drop=
ping back to v1.00a of the core and give that a try, or if you have EDK 10.=
1 you can move to v1.01a of the core.
>=20
>=20
>=20
> -Rick
>=20
>=20
>=20
> ________________________________
>=20
> From: linuxppc-embedded-bounces+moleres=3Dxilinx.com@ozlabs.org [mailto:l=
inuxppc-embedded-bounces+moleres=3Dxilinx.com@ozlabs.org] On Behalf Of Moha=
mmad Sadegh Sadri
> Sent: Monday, April 14, 2008 3:10 AM
> To: Rami WEHBI; linuxppc-embedded@ozlabs.org
> Subject: RE: XPS_LL_TEMAC works correctly?
>=20
>=20
>=20
> Rami,
>=20
> Thanks for reply,
>=20
> But if u study the kernel log I posted carefully, you can simply see that=
 Kernel has mounted the root file system,
> Look at this line in my prev post : VFS: Mounted root (nfs filesystem). t=
hen init has began and after that nothing more happens.
>=20
> the NFS is working correctly and the folder can be mounted easily from ot=
her computers. I personally think that the problem can be with NFS or the r=
oot file system of ELDK.
>=20
> I have done the same things with older versions of EDK using PLB_TEMAC an=
d every thing has worked correctly.
>=20
>=20
> ________________________________
>=20
> Subject: RE: XPS_LL_TEMAC works correctly?
> Date: Mon, 14 Apr 2008 10:31:31 +0200
> From: rwehbi@wirecom-tech.com
> To: mamsadegh@hotmail.com
>=20
> Hi,
>=20
>=20
>=20
> I would suggest that you verify that your system file is already mounted =
on the host PC (where your server NFS is installed), and that the /etc/expo=
rts file (configuration file of the nfs server) permit to your board to mou=
nt the system file.
>=20
>=20
>=20
> example of an /etc/exports file:
>=20
>=20
>=20
> /opt/ml403/rootfs
>=20
> 192.168.206.223/24(rw,no_root_squash,sync,subtree_check)
>=20
>=20
>=20
> where the ip addresse is that of nfs client, and the path indicates where=
 I mounted the system file.
>=20
>=20
>=20
> Good luck,
>=20
>=20
>=20
> Rami
>=20
>=20
>=20
> ________________________________
>=20
> De : linuxppc-embedded-bounces+rami.wehbi=3Dwirecom-tech.com@ozlabs.org [=
mailto:linuxppc-embedded-bounces+rami.wehbi=3Dwirecom-tech.com@ozlabs.org] =
De la part de Mohammad Sadegh Sadri
> Envoy=E9 : lundi 14 avril 2008 10:16
> =C0 : linuxppc-embedded@ozlabs.org
> Objet : XPS_LL_TEMAC works correctly?
>=20
> Hi all,
>=20
> Using:
> EDK 9.2.02,
> Xilinx Linux 2.6.24-rc8-xlnx
> XPS_LL_TEMAC version 1.00.b
>=20
> I bring up the Linux kernel on ML403 -Rev04 board,
> LL_TEMAC buffer size 128kbits, and set to use SG DMA
>=20
> I encounter the following messages when the kernel wants to mount the roo=
t file system, as one can see the kernel has mounter the nfs root file syst=
em and init is initiated, but after that a Link carrier lost happens and it=
 stops working.
>=20
> is this behavior natural? ( the PC has attansic gigabit ethernet port wit=
h kernel 2.6.24.4 running, nfs works very well in other tests)
>=20
> thanks
>=20
> .............
> eth0: XLlTemac: speed set to 1000Mb/s
> eth0: XLlTemac: Send Threshold =3D 24, Receive Threshold =3D 4
> eth0: XLlTemac: Send Wait bound =3D 254, Receive Wait bound =3D 254
> IP-Config: Complete:
>       device=3Deth0, addr=3D10.10.10.11, mask=3D255.255.255.0, gw=3D10.10=
.10.10,
>      host=3D10.10.10.11, domain=3D, nis-domain=3D(none),
>      bootserver=3D10.10.10.10, rootserver=3D10.10.10.10, rootpath=3D
> Looking up port of RPC 100003/2 on 10.10.10.10
> Looking up port of RPC 100005/1 on 10.10.10.10
> VFS: Mounted root (nfs filesystem).
> Freeing unused kernel memory: 88k init
> eth0: XLlTemac: PHY Link carrier lost.
> eth0: XLlTemac: speed set to 1000Mb/s
> eth0: XLlTemac: PHY Link carrier restored.
> ( KERNEL STOPS WORKING HERE!!!!!!!!)
>=20
>=20
>=20
> ________________________________
>=20
> Sign in today. When you sign in to Windows Live Messenger you could win $=
1000 a day until May 12th. Learn more at SignInAndWIN.ca
>=20
>=20
>=20
> ________________________________
>=20
> Sign in now! Windows Live Messenger is giving you a chance to win $1000 a=
 day until May 12th Check out SignInAndWIN.ca today!

_________________________________________________________________
Find hidden words, unscramble celebrity names, or try the ultimate crosswor=
d puzzle with Live Search Games. Play now!
http://g.msn.ca/ca55/212=
