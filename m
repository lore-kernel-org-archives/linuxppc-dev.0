Return-Path: <jmasel@arabellasw.com>
Received: from gold.webfusion.co.uk (gold.webfusion.co.uk [212.67.202.159])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0FB6F67A40
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  6 May 2005 00:25:09 +1000 (EST)
Received: from bzq-82-81-29-215.red.bezeqint.net ([82.81.29.215] helo=Jonathan)
	by gold.webfusion.co.uk with asmtp (Exim 3.36 #1) id 1DTgrw-0004Lt-00
	for linuxppc-embedded@ozlabs.org; Thu, 05 May 2005 14:58:24 +0100
From: "Jonathan Masel" <jmasel@arabellasw.com>
To: <linuxppc-embedded@ozlabs.org>
Date: Thu, 5 May 2005 16:58:10 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <mailman.0.1115279646.20825.linuxppc-embedded@ozlabs.org>
Message-Id: <E1DTgrw-0004Lt-00@gold.webfusion.co.uk>
Subject: Re: [RFC][PATCH 2.6.12-rc2 3/3] FCC Ethernet PlatformDevice
Reply-To: jmasel@arabellasw.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Are you interested in looking at our Resource Manager? It works in 2.4 and
2.6 kernels for a wide range of PQ's (virtually all of them).

It seems to take some of these ideas, but further. The basic idea is to
handle at all on-chip resources in an orderly and robust way (not just
modularly, but that too). We allocate parallel port pins, clocks (BRG or
CLK), internal DPRAM and communication channels to "consumers". Board
specific (if/where needed) are all located in a single per-board file.
Allocation is all dynamic and we can check that we're not conflicting with
prior requests. There are quite a few other goodies too (display all
consumers to which certain resources are allocated, etc).

This lets us easily handle dynamic configurations. E.g. configure pins for
I2C during reset or start-up, modify them later on when you need ATM (they
are multiplexed on the same pins on several devices). Or, as you mentioned,
dynamic modules - but even when they have potentially conflicting requests.

And it is one, simple to use mechanism that we use across all devices
(adapted for PQ1, PQ2 and PQ3).

If you're interested, please let me know. We'd be happy to contribute it if
it will help.

Jonathan
