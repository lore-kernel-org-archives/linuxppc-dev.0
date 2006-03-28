Return-Path: <linas@austin.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 50FED67A33
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Mar 2006 09:36:48 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k2SMaZha023227
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Mar 2006 17:36:35 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k2SMaOFj216928
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Mar 2006 17:36:24 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11/8.13.3) with ESMTP id k2SMaON7003853
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Mar 2006 17:36:24 -0500
Date: Tue, 28 Mar 2006 16:36:23 -0600
To: tsbogend@alpha.franken.de, donf@us.ibm.com
Subject: [PATCH] Janitor: drivers/net/pcnet32: fix incorrect comments
Message-ID: <20060328223623.GD2172@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, jklewis@us.bm.com,
	netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Please sign-off/ack/apply and/or forward upstream.

[PATCH] Janitor: drivers/net/pcnet32: fix incorrect comments

The comments concerning how the pcnet32 ethernet device driver selects 
the MAC addr to use are incorrect. A recent patch (in the last 3 months)
changed how the code worked, but did not change the comments.

Side comment: the new behaviour is good; I've got a pcnet32 card which
powers up with garbage in the CSR's, and a good MAC addr in the PROM.

Signed-off-by: Linas Vepstas <linas@linas.org>

----

 drivers/net/pcnet32.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6.16-git6/drivers/net/pcnet32.c
===================================================================
--- linux-2.6.16-git6.orig/drivers/net/pcnet32.c	2006-03-23 12:21:41.000000000 -0600
+++ linux-2.6.16-git6/drivers/net/pcnet32.c	2006-03-28 16:08:23.398158717 -0600
@@ -1167,8 +1167,8 @@ pcnet32_probe1(unsigned long ioaddr, int
 	 * station address PROM at the base address and programmed into the
 	 * "Physical Address Registers" CSR12-14.
 	 * As a precautionary measure, we read the PROM values and complain if
-	 * they disagree with the CSRs.  Either way, we use the CSR values, and
-	 * double check that they are valid.
+	 * they disagree with the CSRs.  If they miscompare, and the PROM addr
+	 * is valid, then the PROM addr is used.
 	 */
 	for (i = 0; i < 3; i++) {
 		unsigned int val;
