Return-Path: <NWilson@Airspan.com>
Received: from mail.airspan.com (mail.airspan.com [62.189.116.4])
	by ozlabs.org (Postfix) with ESMTP id 559D42BC0F
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 22 Oct 2004 17:44:05 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Fri, 22 Oct 2004 08:36:49 +0100
Message-ID: <3506EDCDEC47904CBE6FD2E1DEEA8984020CFB59@fs5.airspan.com>
From: "Neil Wilson" <NWilson@Airspan.com>
To: "Hiroshi DOYU" <Hiroshi_DOYU@montavista.co.jp>,
	<linuxppc-embedded@ozlabs.org>
Cc: 
Subject: RE: [BUG] IBM440GX works too slow under nfsroot
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

I too had a similar problem with our custom 440GX board - this week in
fact.  It would DHCP, mount NFS then keep on reporting that the server
was not responding.  I eventually tracked it down to the fact that we
are running a single MII phy and the phy map was not being setup
correctly by my port.  As soon as I changed this in the arch_setup it
has worked ever since. BTW it is linuxppc 2.6.8.1,RevC
440,100BaseTX,busybox root.  This may not be Hiroshis problem but
thought I would add to the conversation...

Neil

> -----Original Message-----
> From: linuxppc-embedded-bounces@ozlabs.org=20
> [mailto:linuxppc-embedded-bounces@ozlabs.org] On Behalf Of=20
> Hiroshi DOYU
> Sent: Friday, October 22, 2004 12:58 AM
> To: linuxppc-embedded@ozlabs.org
> Subject: [BUG] IBM440GX works too slow under nfsroot
>=20
> Hi all,
>=20
> Now I am strugging with booting vanilla(2.4.2x) on ibm440gx=20
> and I could succeed to boot it but, after nfs mounted, it's=20
> behavior seems too slow. I guess, it looks like the system is=20
> running half duplex. I have attached  the boot message below.
>=20
> If anyone knows some information about such issue, please let me know.
>=20
> Thanks,
> -doyu
>=20
> ----------------
> .....
> Generic RTC Driver v1.07                                     =20
>                                         =20
> emac: IBM OCP EMAC Ethernet driver, version 2.0              =20
>                                         =20
> Maintained by Benjamin Herrenschmidt=20
> <benh@kernel.crashing.org>                                       =20
> mal0: Initialized, 4 tx channels, 2 rx channels              =20
>                                         =20
> zmii0: bridge in SMII mode                                   =20
>                                         =20
> eth0: IBM emac, MAC 00:04:ac:e3:2a:f5                        =20
>                                         =20
> eth0: Found Generic MII PHY (0x01)                           =20
>                                         =20
> eth1: IBM emac, MAC 00:04:ac:e3:2a:f7                        =20
>                                         =20
> eth1: Found Generic MII PHY (0x02)                           =20
>                                         =20
> NET4: Linux TCP/IP 1.0 for NET4.0                            =20
>                                         =20
> IP Protocols: ICMP, UDP, TCP, IGMP                           =20
>                                         =20
> IP: routing cache hash table of 2048 buckets, 16Kbytes       =20
>                                         =20
> TCP: Hash tables configured (established 16384 bind 32768)   =20
>                                         =20
> Sending BOOTP requests .<6>eth0: Link is Up                  =20
>                                         =20
> eth0: Speed: 10, Half duplex.                                =20
>                                         =20
> . OK                                                         =20
>                                         =20
> IP-Config: Got BOOTP answer from 192.168.1.10, my address is=20
> 192.168.1.2                              =20
> IP-Config: Complete:                                         =20
>                                         =20
>       device=3Deth0, addr=3D192.168.1.2, mask=3D255.255.255.0,=20
> gw=3D192.168.1.10,                             =20
>      host=3Dibm440gx, domain=3D, nis-domain=3D(none),              =20
>                                         =20
>      bootserver=3D192.168.1.10, rootserver=3D192.168.1.10,=20
> rootpath=3D/opt/montavista/pro/devkit/ppc/440/tart
> NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.          =20
>                                         =20
> Looking up port of RPC 100003/2 on 192.168.1.10              =20
>                                         =20
> Looking up port of RPC 100005/1 on 192.168.1.10              =20
>                                         =20
> VFS: Mounted root (nfs filesystem).                          =20
>                                         =20
> Mounted devfs on /dev                                        =20
>                                         =20
> Freeing unused kernel memory: 76k init                       =20
>                                         =20
> nfs: server 192.168.1.10 not responding, still trying        =20
>                                         =20
> nfs: server 192.168.1.10 not responding, still trying        =20
>                                         =20
> nfs: server 192.168.1.10 OK                                  =20
>                                         =20
> nfs: server 192.168.1.10 OK                                  =20
>                                         =20
> nfs: server 192.168.1.10 not responding, still trying
> nfs: server 192.168.1.10 OK                                        =20
> .....
> ----------------
>=20
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>=20
