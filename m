Return-Path: <sbajaj@tsi-telsys.com>
Received: from exchange.tsi-telsys.com (exchange.tsi-telsys.com
	[205.230.130.11]) by ozlabs.org (Postfix) with ESMTP id 2FD34679E6
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 24 May 2005 05:24:33 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Mon, 23 May 2005 15:17:26 -0400
Message-ID: <0007F077BB3476449151699150E8FEA21A7BA0@exchange.tsi-telsys.com>
From: "Sanjay Bajaj" <sbajaj@tsi-telsys.com>
To: "Eugene Surovegin" <ebs@ebshome.net>
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: tah reset?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

FYI,

I did find the source of the reset tah issue. The physical address of =
TAH 0 and TAH 1 was ending in B00h and D00h respectively. But in the UM, =
it ends in B50 and D50. the file affected is ibm440gx.c in =
arch/ppc/platforms.

Thanks,
Sanjay

-----Original Message-----
From: Eugene Surovegin [mailto:ebs@ebshome.net]
Sent: Thursday, May 19, 2005 2:23 PM
To: Sanjay Bajaj
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: tah reset?


On Thu, May 19, 2005 at 02:14:20PM -0400, Sanjay Bajaj wrote:
> While trying to reset the TAH on emac2 of PPC440GX, the Soft Reset=20
> (SR) bit never resets itself to 0. Does anybody know the reason for=20
> it?

Did you enable TAH0 in SDR0_MFR register?

Also, I don't remember for sure, but TAH may have the same problem as=20
EMAC, namely, it won't go out of reset if there is no RX clock from=20
PHY.

--=20
Eugene
