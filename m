Return-Path: <phenning@vastech.co.za>
Received: from www6.jnb1.host-h.net (www6b.your-server.co.za [196.22.132.6])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 441A3B6F6F
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 13 Jul 2011 18:26:35 +1000 (EST)
Received: from 41-134-83-187.dsl.mweb.co.za ([41.134.83.187]
	helo=[172.16.63.184]) by www6.jnb1.host-h.net with esmtpa (Exim 4.72)
	(envelope-from <phenning@vastech.co.za>) id 1QguPX-0003Wu-L0
	for linuxppc-dev@lists.ozlabs.org; Wed, 13 Jul 2011 10:03:11 +0200
Message-ID: <4E1D513F.9030405@vastech.co.za>
Date: Wed, 13 Jul 2011 10:03:11 +0200
From: Pieter <phenning@vastech.co.za>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: problem receiving udp broadcasts
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi All

Im running Linux 2.6.32.14 on an embedded  MPC4858.
One of the Application (CLI) must reciece a UDP broadcast packet.

The problem is that I only receive packets broadcast from within the=20
same subnet  (192.168.0.x)  even though the broadcast app sends the=20
broadcast to  255.255.255.255.

when i run tcpdump on the embedded machine it shows both broadcasts from =

the same subnet well as different subsets: as shown below:

     SDH-0A000221> /tmp/tcpdump port 23 or port 33334
     tcpdump: verbose output suppressed, use -v or -vv for full protocol =

decode
     listening on eth0, link-type EN10MB (Ethernet), capture size 65535=20
bytes
(1)    07:48:35.787826 IP 172.16.63.184.cli > 255.255.255.255.cli: UDP,=20
length 58
(2)   07:48:43.832539 IP 192.168.0.1.cli > 255.255.255.255.cli: UDP,=20
length 60
(3)    07:48:43.840627 IP 192.168.0.254.cli > 192.168.0.1.cli: UDP,=20
length 112

The embedded machine is configured with:
ip 192.168.0.254
mask 255.255.0.0

(1) is a broadcast from a different subnet
(2) is broadcast from within same subnet
(3) the imbeded applications reply to the broadcast from same subnet


The service has been delared in  "etc/xinetd.d/cli" as follows:
service cli
{
     socket_type        =3D dgram
     protocol        =3D udp
     port            =3D 23
     wait            =3D yes
     user            =3D root
     server            =3D /usr/vastech/in.cli
     disable            =3D no
     cps                =3D 10 5
     flags            =3D IPv4
}

and the port assigned in "/etc/xinetd.d/services" as follows (port 23=20
for back comparability with older products)

     #telnet        23/udp
     cli                23/udp
     cli                33334/udp

Is there something basic that I have overlooked ? should the interface=20
be set and left in
promiscuous mode to do what I require?

thanks pieter

--=20
VASTech PTY (LTD)
021 880 9807
