Return-Path: <markc@mail.com>
Received: from relay04.roc.ny.frontiernet.net (relay04.roc.ny.frontiernet.net
	[66.133.131.37]) by ozlabs.org (Postfix) with ESMTP id 8D0392BF10
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 31 Dec 2004 07:31:54 +1100 (EST)
Received: from filter02.roc.ny.frontiernet.net
	(filter02.roc.ny.frontiernet.net [66.133.131.177])
	by relay04.roc.ny.frontiernet.net (Postfix) with ESMTP id CEE0F10323
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 30 Dec 2004 20:31:50 +0000 (UTC)
Received: from relay04.roc.ny.frontiernet.net ([66.133.131.37])
	by filter02.roc.ny.frontiernet.net (filter02.roc.ny.frontiernet.net
	[66.133.131.177]) (amavisd-new, port 10024)
	with LMTP id 05762-14-91 for <linuxppc-embedded@ozlabs.org>;
	Thu, 30 Dec 2004 20:31:50 +0000 (UTC)
Received: from chuck2 (67-139-157-94.br1.rmn.wv.frontiernet.net
	[67.139.157.94])
	by relay04.roc.ny.frontiernet.net (Postfix) with ESMTP id 8F397FEEF
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 30 Dec 2004 20:31:47 +0000 (UTC)
Message-ID: <061001c4eeaf$0b5e1860$0301a8c0@chuck2>
From: "Mark Chambers" <markc@mail.com>
To: <linuxppc-embedded@ozlabs.org>
References: <200412301246.48870.david.jander@protonic.nl>
	<C6D7331E-5A77-11D9-AECD-003065F9B7DC@embeddededge.com>
Date: Thu, 30 Dec 2004 15:35:00 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: MPC5200 PCI byte-swapping
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I've just realized that the 5200 does byte-lane swapping
on all PCI accesses.  That is, if you write a 32 bit word
0x12345678, 0x12 will go out on byte 0, 0x34 on byte 1,
etc.  Unfortunately, my target, a T.I. DM642, does not
do this, so I've got a big/little endian mismatch.  A couple
of questions if anybody knows:

- Do all MPC8xxx processors do this - byte swap on
all PCI accesses, not just configuration space?

- Is there an elegant (simple) way to re-swap the bytes?
It's not a big problem really, but if there were a way to 
set LE mode on a particular page or something like that
it might be worth it.

Thanks,
Mark Chambers
