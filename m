Return-Path: <CPONTOIS@nortel.com>
Received: from zcars04e.nortel.com (zcars04e.nortel.com [47.129.242.56])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "zcars04e.nortel.com", Issuer "NORTEL" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 27C8EDDE32
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  6 Mar 2007 22:18:19 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [patch 1/1] ppc: Possible bug fix for FCC driver
Date: Tue, 6 Mar 2007 12:03:57 +0100
Message-ID: <00B1F4365DDBE745B091C67A1CCFCB4307124DB1@zctfhxm1>
In-Reply-To: <20070306124218.4bebc288@localhost.localdomain>
From: "Cedric Pontois" <cpontois@nortel.com>
To: "Vitaly Bordug" <vbordug@ru.mvista.com>,
	"Li Yang-r58472" <LeoLi@freescale.com>
Cc: Rachid Koucha <koucha@nortel.com>, dmalek@jlc.net,
	linux-kernel@vger.kernel.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Vitaly,

The problem seems to be similar in recent kernels
(/drivers/net/fs_enet/mac-fcc.c). The transmit clock is inverted (TCI
bit set). The packets are well received, transmitted packets go out (tx
counter is ok), unfortunately as the clock is inverted (TCI) the data
are not correctly received by the other side. The FCC works in 100Mbps
(luck?) but doesn't in 10Mbps. I solved this problem by removing the TCI
bit set as described in the patch. Actually, this problem depends also
of the Ethernet phy used on board.

Cedric

-----Original Message-----
From: Vitaly Bordug [mailto:vbordug@ru.mvista.com]=20
Sent: mardi 6 mars 2007 10:42
To: Li Yang-r58472
Cc: Pontois, Cedric UMTS (CEZ:8Z10); dmalek@jlc.net;
linux-kernel@vger.kernel.org; linuxppc-embedded@ozlabs.org
Subject: Re: [patch 1/1] ppc: Possible bug fix for FCC driver


On Tue, 6 Mar 2007 10:23:43 +0800
Li Yang-r58472 wrote:

> Hi Cedric,
>=20
> For ppc embedded related patches, please also cc:=20
> linuxppc-embedded@ozlabs.org.
>=20
> > We use a kernel 2.6.14 on PPC platform (MPC 8555). The FCC driver
> works
>=20
> To submit a kernel patch upstream, the patch should be against the=20
> latest kernel version which is 2.6.21-rc now.
> > well with a 100Mbps link. But it doesn't with a 10Mbps link. To=20
> > solve it, I modified the GFMR register init: removed TCI bit and set

> > CRC32
> bit
> > instead of.
>=20
> I don't know how these bits caused the 10M link issue.  Do you have=20
> any reasoning?
>=20
> > 	Signed-off-by: Cedric Pontois <cpontois@nortel.com>
> >=20
> >
> ----------------------------------------------------------------------
> --
> > -----
> >=20
> > diff -ruN pa-original/arch/ppc/8260_io/fcc_enet.c
The fcc code in 8260_io has been obsoleted by fs_enet driver
(drivers/net/fs_enet). It is known to work with 85xx at least in recent
kernels. If it does not for some reason, please letus know.

Thanks,

-Vitaly
