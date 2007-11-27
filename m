Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay002.isp.belgacom.be (mailrelay002.isp.belgacom.be
	[195.238.6.175]) by ozlabs.org (Postfix) with ESMTP id 29A53DDE3D
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Nov 2007 02:51:15 +1100 (EST)
Received: from mail.technotrade.biz (localhost [127.0.0.1])
	by mail.technotrade.biz (Postfix) with ESMTP id 972F94DFB
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Nov 2007 16:51:08 +0100 (CET)
Received: from pclaurent.technotrade.biz (pclaurent.technotrade.biz
	[192.168.1.47])
	by mail.technotrade.biz (Postfix) with ESMTP id 7FC9C4B64
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Nov 2007 16:51:08 +0100 (CET)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: linuxppc-dev@ozlabs.org
Subject: How to notify userspace of custom bus master/slave access mode
	changes ?
Date: Tue, 27 Nov 2007 16:51:01 +0100
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4418662.IMYsjNrjqE";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200711271651.07191.laurentp@cse-semaphore.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart4418662.IMYsjNrjqE
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi everybody,

I'm a bit unsure about how to notify userspace of changes to access mode to=
 a=20
custom bus. This is more an architecture issue than an implementation issue.

My system has an ISA-like cold-pluggable extension bus. The bus controller=
=20
sits on the CPU board which is plugged along with slave devices into a=20
passive backplane.

To add CPU redundancy support to the system, I implemented master and slave=
=20
modes for the CPU board. The slave monitors the master and can disconnect i=
t=20
from the bus when a failure is detected.

The bus drivers haven't been developed with hotplug in mind, but I eventual=
ly=20
managed to fix them. The kernel is now able to scan the bus when a CPU boar=
d=20
switches from slave to master mode, adding peripherals as they are detected=
,=20
and to remove all peripherals when the CPU board switches from master to=20
slave.

I now have to notify userspace applications of master <-> slave mode change=
s.=20
I thought about using kobject netlink notifications, but the kernel only=20
generates events for individual peripherals (when they are added or removed=
).

The bus driver registers a peripheral for the bus controller at boot time. =
I=20
thought about registering the peripheral only when the system switches from=
=20
slave to master, and deregistering it when it switches back to slave mode,=
=20
but that's not very clean as the bus controller is always attached to the=20
CPU, regardless of its bus access mode. Beside, I need to access the bus=20
controller to detect master <-> slave transitions, so this would be a bit=20
hackish.

Is there a kobject netlink event I could use that I haven't thought about ?=
 Am=20
I missing a pseudo-peripheral in my implementation ? Is there a preferred w=
ay=20
to notify userspace of such events ?

Thanks for any help you can provide (and thanks for having read this mail=20
throughout :-)).

Best regards,

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chauss=E9e de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart4418662.IMYsjNrjqE
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBHTDzr8y9gWxC9vpcRAjF8AKDE/wmqP2ohvGO1W0u57igc5WrOOACg2vI8
xtvhKOlu8qeId0t4cu1zsDA=
=1BNs
-----END PGP SIGNATURE-----

--nextPart4418662.IMYsjNrjqE--
