Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id 0DDDA2BF22
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 13 Jan 2005 02:32:32 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Wed, 12 Jan 2005 09:32:28 -0600
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B85928F@ismail.innsys.innovsys.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: "Steffen Rumler" <Steffen.Rumler@siemens.com>,
	"linuxppc" <linuxppc-embedded@ozlabs.org>
Subject: RE: Kernel boot hangs by parallel flood pings
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I have had the problem before (and so has several other people)

This is a reply I got on the old Linux PPC mailinglist last year
(from Gerard Guevel [gguevel@interfaceconcept.com])
---- Original message -----
RE: FCC ethernets not stable

I received the right solution from Jean-Denis Boyer (thanks to him...)
>>
It registers the IPv4 handling functions AFTER initializing the IP
routing
stuff.
Early packets could enter the stack and crash the system.

--- Kernel.old/net/ipv4/ip_output.c     Thu Jun  5 09:00:39 2003
+++ Kernel/net/ipv4/ip_output.c Thu Jun  5 09:00:28 2003
@@ -1087,11 +1087,11 @@

 void __init ip_init(void)
 {
-       dev_add_pack(&ip_packet_type);
-
        ip_rt_init();
        inet_initpeers();

+       dev_add_pack(&ip_packet_type);
+
 #ifdef CONFIG_IP_MULTICAST
        proc_net_create("igmp", 0, ip_mc_procinfo);
 #endif
>>

I never saw this problem after installing this patch.

Regards
Gerard Guevel=20

> -----Original Message-----
> From: linuxppc-embedded-bounces@ozlabs.org=20
> [mailto:linuxppc-embedded-bounces@ozlabs.org] On Behalf Of=20
> Steffen Rumler
> Sent: Wednesday, January 12, 2005 02:38
> To: linuxppc
> Subject: Kernel boot hangs by parallel flood pings
>=20
> I'm using a 2.4.20 kernel (PPC).
>=20
> When I run multiple 'ping -f' directed to my board
> during the kernel boots, sometimes it hangs with
> the following messages:
>=20
>=20
>    Memory BAT mapping: BAT2=3D64Mb, BAT3=3D32Mb, residual: 84Mb
>    Linux version 2.4.20-rthal5 (ru@styx) (gcc version 2.95.3=20
> 20010111 (prerelease/franzo/20010111))
>    #9 Tue Jan 11 17:09:22 CET 2005
>    On node 0 totalpages: 29859
>    zone(0): 29859 pages.
>    zone(1): 0 pages.
>    zone(2): 0 pages.
>    Kernel command line: bootdev=3Daps0=20
> ip=3D218.1.36.70:218.1.36.47:218.1.36.254:255.255.255.0::eth0:off
>    panic=3D1 mem=3D119436k
>    Calibrating delay loop... 194.15 BogoMIPS
>    ...
>    NET4: Linux TCP/IP 1.0 for NET4.0
>    IP Protocols: ICMP, UDP, TCP
>    IP: routing cache ha
>                  ^^^^^^^
>                    the kernel boot hangs here
>=20
>=20
> I have checked this with the BDI2000 and found that the
> kernel loops anywhere inside ip_route_input().
>=20
> I think this is because the ethernet driver (fcc_enet.c)
> enables the hardware too already inside it's init routine=20
> (fec_enet_init()).
>=20
> In this way, frames may be received and forwarded to the upper
> layers with netif_rx(), before the TCP/IP was initialized.
>=20
> I suggest to delay the lines
>=20
>    /* Enable transmit/receive */
>    fccp->fcc_gfmr |=3D FCC_GFMR_ENR | FCC_GFMR_ENT;
>=20
> to the open entry point (fcc_enet_open()), which is
> triggered by 'ifconfig up' in the following way:
>=20
>=20
>    if(!((fccp->fcc_gfmr) & FCC_GFMR_ENR))
>       fccp->fcc_gfmr |=3D (FCC_GFMR_ENR | FCC_GFMR_ENT);
>=20
> By the way, fcc_enet_close() does _NOT_ stop the hardware.
> Hopefully, this is not a real problem.
>=20
>=20
> Steffen
>=20
> --=20
>=20
>=20
> --------------------------------------------------------------
>=20
> Steffen Rumler
> ICN CP D NT SW 3
> Siemens AG
> Hofmannstr. 51                 Email: Steffen.Rumler@siemens.com
> D-81359 Munich                 Phone: +49 89 722-44061
> Germany                        Fax  : +49 89 722-36703
>=20
> --------------------------------------------------------------
>=20
>=20
>=20
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>=20
>=20
