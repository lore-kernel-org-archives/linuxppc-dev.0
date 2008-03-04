Return-Path: <John.Linn@xilinx.com>
Received: from outbound1-dub-R.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id C63BCDDE34
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  5 Mar 2008 01:22:20 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: Xilinx git tree, LLTemac driver
Date: Tue, 4 Mar 2008 07:21:53 -0700
In-Reply-To: <000f01c87dde$30ee1460$92ca3d20$@se>
References: <000f01c87dde$30ee1460$92ca3d20$@se>
From: "John Linn" <John.Linn@xilinx.com>
To: "Magnus Hjorth" <mh@omnisys.se>,
	<linuxppc-embedded@ozlabs.org>
Message-Id: <20080304142203.75CBF5F80AE@mail186-dub.bigfish.com>
Cc: git <git@xilinx.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Magnus,

I just applied the change to the git tree for getting the mac address =
from the board data and it looks like I should have taken into account =
the powerpc arch also as I was building and testing ppc arch.

It looks like #ifndef needs to be added around the use of the __res for =
copying the mac address from the board data so that it doesn't do that =
in the powerpc arch.

#ifndef CONFIG_OF
	memcpy(ndev->dev_addr, ((bd_t *) &__res)->bi_enetaddr, 6);
	memcpy(pdata->mac_addr, ((bd_t *) &__res)->bi_enetaddr, 6);
#endif

The #ifndef may also be needed around the extern for __res.

I'll test these changes.

Thanks,
John

-----Original Message-----
From: Magnus Hjorth [mailto:mh@omnisys.se]=20
Sent: Tuesday, March 04, 2008 2:58 AM
To: linuxppc-embedded@ozlabs.org
Cc: git
Subject: Xilinx git tree, LLTemac driver

Hi,

I'm trying to compile the Linux kernel from the Xilinx git tree
(linux-2.6-xlnx) and am having some trouble with the LLTemac driver, =
having
to do with MAC address settings.=20

There seems to be two routines getting the MAC address in different =
ways.
The xtenet_probe function tries to access an extern bd_t __res, the type
bd_t doesn't exist in the powerpc tree which causes the compilation to =
fail.
Then there is the xtenet_of_probe function which uses =
of_get_mac_address.

What confuses me is that both the regular and the OF driver is =
registered in
the xtenet_init function, I would have expected it to be either/or.=20

Can I expect under the powerpc arch and supplying a .dts file, that the
xtenet_probe function will never be called?=20

Best regards,
Magnus


--

Magnus Hjorth, M.Sc.
Omnisys Instruments AB
Gruvgatan 8
SE-421 30  V=E4stra Fr=F6lunda, SWEDEN
Phone: +46 31 734 34 09
Fax: +46 31 734 34 29
http://www.omnisys.se
