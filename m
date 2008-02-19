Return-Path: <Nicolas.Genevrier@jdsu.com>
Received: from jdsu.com (mio.acterna.de [141.169.254.2])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B3D42DDED1
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 20 Feb 2008 00:07:12 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: Ethernet breakdown on a Yosemite evaluation board
Date: Tue, 19 Feb 2008 14:00:19 +0100
Message-ID: <8C40729B7184DC459A15060FA1AF589602045556@ENIEXCH01.ds.jdsu.net>
From: "Nicolas Genevrier" <Nicolas.Genevrier@jdsu.com>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello all,

I noticed an Ethernet blocking on a Yosemite evaluation board when we
are using both Ethernet devices (eth0 and eth1).
To reproduce the issue, I just telnet the board from a PC (PC1) through
eth0 and then telnet another PC (PC2) from the first telnet session
through eth1. Then I display a lot of characters on the last telnet
session:
	$ for i in `seq 1 100000`; do echo "$i
aaaaaaaaaaa..(x160)..aaa"; done

After a while, transmission is blocked and leads to an rxde interruption
from the MAL.

Yosemite evaluation kit runs Linux 2.16.13 but I reproduced the issue
with our board running Linux-2.6.16 on a 440EP.
In Linux 2.6.16, the new ibm_emac driver tries to recover the error but
Ethernet remains very very slow even one day after the end of the
transmission.
 I didn't notice any evolution related to this neither any discussion on
the topic. Sorry if I missed them.

I am working on the subject but an idea or related information would be
helpful.

Thank you,

Nicolas Genevrier
