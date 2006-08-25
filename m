Return-Path: <claus.gindhart@kontron.com>
Received: from mail.kontron-modular.com (mail.kontron-modular.com
	[62.159.155.200]) by ozlabs.org (Postfix) with ESMTP id BFC5F67A5E
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 25 Aug 2006 15:48:57 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: "ip=" command line strangeness...
Date: Fri, 25 Aug 2006 07:48:54 +0200
Message-ID: <DADA32856852FC458E0F96B664A6F55E011E2425@kom-mailsrv1.kontron-modular.com>
From: "Claus Gindhart" <claus.gindhart@kontron.com>
To: "T Ziomek" <ctz001@email.mot.com>,
	"linuxppc-embedded" <linuxppc-embedded@ozlabs.org>
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

please provide the ip-commandline in the full-size format
 ip=3D<my ip>:<server ip>:<host ip>:<net mask>:<hostname>:<which =
ethernet port, e.g. "eth0">=20

I assume, that this will fix your problem

--=20
Mit freundlichen Gruessen / Best regards

Claus Gindhart
SW R&D
Kontron Modular Computers
phone :++49 (0)8341-803-374
mailto:claus.gindhart@kontron-modular.com
http://www.kontron.com

-----BEGIN GEEK CODE BLOCK-----
  Version: 3.1
  GU d- s++:>++:+ a+ C++$ !U !P L++>$ E-- W+(-) N- o?
  K? w !O !M V !PS PE- Y+ PGP+ t 5? X R* tv- b+ DI+++
  D-- G e++> h--- !r x+++
------END GEEK CODE BLOCK------
=20
-----Original Message-----
From: linuxppc-embedded-bounces+claus.gindhart=3Dkontron.com@ozlabs.org
[mailto:linuxppc-embedded-bounces+claus.gindhart=3Dkontron.com@ozlabs.org=
]
On Behalf Of T Ziomek
Sent: Freitag, 25. August 2006 01:39
To: linuxppc-embedded
Cc: tomz
Subject: "ip=3D" command line strangeness...


On my previous project, a 2.4 kernel on PPC, I frequently used=20
"ip=3Dw.x.y.z" on the kernel command line to specify a static IP address =
for
my target board (when booting with a flash- or RAM-based root =
filesystem).
    Similarly, when using an NFS-mounted root fs, I would use
"ip=3Dw.x.y.z:a.b.c.d", along with the appropriate "nfsroot=3D..." =
setting,
with my NFS server having IP a.b.c.d .

Now I am working with a 2.6.10-based kernel on ARM.  Using an NFS root =
fs
works fine when I use the expected "ip=3Dw.x.y.z:a.b.c.d".  And booting =
off
with "root=3D/dev/hda1" works fine with "ip=3Ddhcp".
    I'd expect to be able to use "root=3D/dev/hda1 ip=3Dw.x.y.z" if I =
want the
target using a static IP address.  But this fails, and in a VERY weird
way:  (1) It tries doing DHCP, which it shouldn't, and (2) the DHCP =
fails,
which it shouldn't because it works when I want DHCP to be used.
    Here's a snippet of console output:
             .
             .
             .
            NET: Registered protocol family 2
            IP: routing cache hash table of 512 buckets, 4Kbytes
            TCP: Hash tables configured (established 8192 bind 16384)
            NET: Registered protocol family 1
            NET: Registered protocol family 17
            Sending DHCP requests ...... timed out!
            EMAC: TX Complete: Starting queue
            IP-Config: Reopening network devices...
            Sending DHCP requests ...

Okay, that's two weird things.  There is a third -- this problem goes a-
way if I change the command line to something like
"root=3D/dev/hda1 ip=3Dw.x.y.z:a.b.c.d".  The only change is adding an =
NFS
server IP address to the "ip=3D" command, which should have no effect =
be-
cause NFS is not being used.  Yet when I do that the board boots as ex-
pected -- it does not try to do DHCP, it does use /dev/hda1 for its root
fs, and it does take the specified IP address.

In fact, it works even if I use a command line with, literally,
"root=3D/dev/hda1 ip=3D199.5.233.72:gobbledygook":
             .
             .
             .
            NET: Registered protocol family 2
            IP: routing cache hash table of 512 buckets, 4Kbytes
            TCP: Hash tables configured (established 8192 bind 16384)
            NET: Registered protocol family 1
            NET: Registered protocol family 17
            IP-Config: Guessing netmask 255.255.255.0
            IP-Config: Complete:
                  device=3Deth0, addr=3D199.5.233.72, =
mask=3D255.255.255.0, gw=3D255.255.255.255,
                 host=3D199.5.233.72, domain=3D, nis-domain=3D(none),
                 bootserver=3D232.0.0.0, rootserver=3D232.0.0.0, =
rootpath=3D
             .
             .
             .

This isn't a big problem, but can anybody explain what the heck is going
on?

Thanks, Tom
--=20
   /"\  ASCII Ribbon Campaign   |
   \ /                          |   Email to user 'CTZ001'
    X        Against HTML       |             at 'email.mot.com'
   / \     in e-mail & news     |
_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded
