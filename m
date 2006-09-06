Return-Path: <tim.martin@viasat.com>
Received: from VCAEXCH02.hq.corp.viasat.com (kestrel.viasat.com
	[199.106.52.139]) by ozlabs.org (Postfix) with ESMTP id E85C867B22
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  7 Sep 2006 04:11:49 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: MAC driver issue
Date: Wed, 6 Sep 2006 11:11:14 -0700
Message-ID: <821B2170E9E7F04FA38DF7EC21DE487106404241@VCAEXCH01.hq.corp.viasat.com>
From: "Martin, Tim" <tim.martin@viasat.com>
To: "David H. Lynch Jr." <dhlii@dlasys.net>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

>=20
> >     I have no doubt it is with the driver.  I am somewhat=20
> fortunate in=20
> > this instance that I have a nearly identical setup - this=20
> is an FPGA=20
> > based system
> >     I can swap the FPGA firmware, get an almost identical=20
> kernel with=20
> > a slightly different NIC, and everything works - same=20
> cables, same IP's,
> >     Same switch, The only things different are the NIC and=20
> its driver.=20
> > Even the Linux kernels are identical - except the NIC driver.
> >   =20
> >     BUT so is the data received and passed on to the kernel=20
> (outside=20
> > random differences in the padding of the ARP packet)

Why is the ARP packet padding random?  I would think it would be fixed,
since the ARP packet itself is a fixed length (for IPv4<->Ethernet ARPs)
and the minimum Ethernet frame is 64 bytes...


> >     One works the other doesn't.
> >=20
>=20
> Well ethernet device drivers contain multiple arp supporting=20
> methods, e.g. header_cache, header_cache_update,=20
> hard_header_parse, etc etc.
> Generally driver writers don't need to concern themselves=20
> about these as they are assigned to generic handlers by=20
> ether_setup().  However, your problematic driver may do=20
> something different.
>=20
> Given this problem appears to be driver specific rather than=20
> PPC specific your best bet is to try and contact the author. =20
> BTW, I don't think you've said which driver you are using, a=20
> key piece of info....
>=20

Might I suggest putting static ARP entries in the kernel (use the "arp"
command from a prompt) and some other packet traffic - UDP perhaps.  See
if the problem is specifically with the way your network driver handles
ARP packets, or if it's a more fundamental problem of how the driver
hands any type of Ethernet packet off to the upper kernel stack layers.
