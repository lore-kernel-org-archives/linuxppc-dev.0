Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id DC51F67A72
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  6 Apr 2005 04:53:38 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Tue, 5 Apr 2005 13:53:36 -0500
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B85933A@ismail.innsys.innovsys.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: "Dan Malek" <dan@embeddededge.com>
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: RE: FCC Ethernet startup crash
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> From: Dan Malek [mailto:dan@embeddededge.com]=20
> On Apr 5, 2005, at 12:41 PM, Rune Torgersen wrote:
>=20
> > Without calling fcc_restart in the start, I get lots of=20
> "eth0: tx queue
> > full!." messages.
>=20
> Do you tftp boot your kernel using the boot rom?  Does the
> boot rom disable the Ethernet before calling the kernel?

Yes, I tftp the kernel, using U-Boot (1.1.2 CVS Head as of 11-20-04).
Haven't looked at the code, but I think it disablesd the FCC Ethernets
(Have seen discussions about htat on u-boot mailing list before)

The patch Stefan Nickl gave to me works perfectly, and all it does is
basically move the fcc_restart.
The kernel was still calling fcc_restart twiche per FCC at startup (one
time on init_fcc_startup, and then again in fcc_open), now it just calls
it twice in fcc_open. Seems to work.
