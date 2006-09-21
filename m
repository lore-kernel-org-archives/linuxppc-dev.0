Return-Path: <Tord.Andersson@combitech.se>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: Lite5200 NFS mount issue
Date: Thu, 21 Sep 2006 16:53:35 +0200
Message-ID: <18CE82D3EF6EA84F9A1A79D6051A090028500C@CORPAPPL020.corp.saab.se>
From: "Andersson Tord " <Tord.Andersson@combitech.se>
To: <Linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

I have some additional information on the problems we had with NFS on =
the Lite5200 card and the=20
2.4.25 kernel (DENX linuxppc_2_4_devel 2006-04-06) .=20
When analyzing the IP traffic with Etherreal, it was seen that the =
problems were=20
caused by loss of fragmented IP-packets. When the IP fragmentation was =
removed by forcing NFS's=20
UDP size to less than the Ethernet MTU size, the problems disappeared.=20
We used the kernel NFS argument option to this effect;

	nfsroot=3D${serverip}:${rootpath},rsize=3D1024,wsize=3D1024

Still, the question remains, why do fragmented packets get lost? Do =
anyone know of any related FEC/BESTCOMM/driver/buffer issues which might =
cause this problem? The problem also exist with the 5200B version.=20

Regards,

Tord Andersson

=20

> -----Original Message-----
> From:
> linuxppc-embedded-bounces+tord.andersson=3Dcombitechsystems.com@
> ozlabs.org
> [mailto:linuxppc-embedded-bounces+tord.andersson=3Dcombitechsyst
> ems.com@ozlabs.org] On Behalf Of Bj=F6rn =D6stby
> Sent: den 20 juni 2006 10:15
> To: linuxppc-embedded@ozlabs.org
> Subject: Lite5200 NFS mount issue
>=20
>=20
> Hi all,
> I'm using u-boot 1.1.4 (CVS downloaded 2006-05-04) and ELDK
> 4.0. I've encountered=20
> problems when trying to mount a NFS root filesystem when=20
> using the Lite MPC5200 development board. The system mounts=20
> ok when the board is connected to office wide=20
> network switches but if the board is connected directly=20
> through a small 100/10Mbit switch to the NFS server, the=20
> mount halts as shown in the log below (The 100/10Mbit switch=20
> do work as other boards can mount their filesystem through=20
> these). Does anyone recognize this problem and know a=20
> suitable work-around/solution?
>=20
> =3D>run flash_nfs
>  ## Booting image at ff0a0000 ...
>    Image Name:   Linux-2.4.25
>    Created:      2006-06-16  13:11:56 UTC
>    Image Type:   PowerPC Linux Kernel Image (gzip compressed)
>    Data Size:    945550 Bytes =3D 923.4 kB
>    Load Address: 00000000
>    Entry Point:  00000000
>    Verifying Checksum ... OK
>    Uncompressing Kernel Image ... OK
> Memory BAT mapping: BAT2=3D64Mb, BAT3=3D0Mb, residual: 0Mb
> Linux version 2.4.25 (tord@toshiba) (gcc version 4.0.0 (DENX
> ELDK 4.0 4.0.0)) #1 fre jun 16 14:46:35 CEST 2006 On node 0=20
> totalpages: 16384
> zone(0): 16384 pages.
> zone(1): 0 pages.
> zone(2): 0 pages.
> Kernel command line: root=3D/dev/nfs rw=20
> nfsroot=3D10.3.67.98:/opt/eldk_4_0/ppc_6xx=20
> ip=3D10.3.67.99:10.3.67.98:10.3.67.1:::eth0:off panic=3D1=20
...
> Looking up port of RPC 100003/2 on 10.3.67.98
> Looking up port of RPC 100005/1 on 10.3.67.98
> VFS: Mounted root (nfs filesystem).
> Freeing unused kernel memory: 80k init
> nfs: server 10.3.67.98 not responding, still trying
> nfs: server 10.3.67.98 OK
> nfs: server 10.3.67.98 not responding, still trying
> nfs: server 10.3.67.98 OK
> [time to this about 5 minutes]
> INIT: version 2.85 booting
> nfs: server 10.3.67.98 not responding, still trying
> nfs: server 10.3.67.98 OK
> nfs: server 10.3.67.98 not responding, still trying
> nfs: server 10.3.67.98 OK
>=20
> Regards,
> Bjorn Ostby
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>=20
