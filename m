Return-Path: <stefanr@s5r6.in-berlin.de>
Received: from einhorn.in-berlin.de (einhorn.in-berlin.de [192.109.42.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.vr.in-berlin.de",
	Issuer "IN-Berlin Server CA (G2)" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 86647DDEEF
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Sep 2007 04:07:54 +1000 (EST)
Date: Wed, 5 Sep 2007 20:06:50 +0200 (CEST)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH] Re: Sleep problems with kernels >= 2.6.21 on powerpc
To: Andrew Morton <akpm@linux-foundation.org>
In-Reply-To: <46DEEBBE.4070201@s5r6.in-berlin.de>
Message-ID: <tkrat.7174534bdd0ddaff@s5r6.in-berlin.de>
References: <6540c930708251937o2a9a23efv72a0f2b8947067bd@mail.gmail.com>
	<6bffcb0e0708261621q25316becqce7b3ae2176f45a8@mail.gmail.com>
	<20070827065246.GA21220@ime.usp.br> <46D279E8.10001@edge.ping.de>
	<46D72BC6.3020809@edge.ping.de>
	<20070905100754.57ab4e3e.akpm@linux-foundation.org>
	<46DEEBBE.4070201@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Cc: michal.k.k.piotrowski@gmail.com, rbrito@gmail.com,
	=?iso-8859-1?Q?Kristian_H=F8gsberg?= <krh@redhat.com>,
	linux-kernel@vger.kernel.org, rjw@sisk.pl,
	linuxppc-dev@ozlabs.org, debian-powerpc@lists.debian.org,
	linux-pm@lists.linux-foundation.org, Tim Teulings <rael@edge.ping.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: firewire: fw-ohci: ignore failure of pci_set_power_state (fix suspend regression)

Fixes "Sleep problems with kernels >= 2.6.21 on powerpc",
http://lkml.org/lkml/2007/8/25/155.

Like it was suggested earlier in http://lkml.org/lkml/2006/10/24/13,
we do *not* fail .suspend anymore if pci_set_power_state failed.

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
---
 drivers/firewire/fw-ohci.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

Index: linux-2.6.23-rc4/drivers/firewire/fw-ohci.c
===================================================================
--- linux-2.6.23-rc4.orig/drivers/firewire/fw-ohci.c
+++ linux-2.6.23-rc4/drivers/firewire/fw-ohci.c
@@ -1946,8 +1946,11 @@ static int pci_suspend(struct pci_dev *p
 	}
 	err = pci_set_power_state(pdev, pci_choose_state(pdev, state));
 	if (err) {
+		/*
+		 * Some Apple onboard controllers are known to fail here.
+		 * Ignore it and let the machine proceed to suspend.
+		 */
 		fw_error("pci_set_power_state failed\n");
-		return err;
 	}
 
 	return 0;

-- 
Stefan Richter
-=====-=-=== =--= --=-=
http://arcgraph.de/sr/
