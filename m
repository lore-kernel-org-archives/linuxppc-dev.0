Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C6036DDE43
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Oct 2007 09:14:18 +1000 (EST)
Subject: [PATCH] fix EMAC driver for proper napi_synchronize API
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stephen Hemminger <shemminger@linux-foundation.org>
In-Reply-To: <20071017083107.6a1b1bd3@freepuppy.rosehill>
References: <1192513792.19073.23.camel@pasglop>
	<20071016115318.0fc36af3@freepuppy.rosehill>
	<1192589522.11899.130.camel@pasglop> <47157EA4.1000500@garzik.org>
	<1192591481.11899.134.camel@pasglop>
	<20071017083107.6a1b1bd3@freepuppy.rosehill>
Content-Type: text/plain
Date: Thu, 18 Oct 2007 09:14:03 +1000
Message-Id: <1192662843.6783.48.camel@pasglop>
Mime-Version: 1.0
Cc: netdev@vger.kernel.org, Roland Dreier <rdreier@cisco.com>,
	"David S. Miller" <davem@davemloft.net>, Jeff Garzik <jeff@garzik.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The EMAC driver "fix" was merged by mistake before the dust had settled on
the new napi synchronize interface (and before it got merged). The final
version of that function is spelled without underscores.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
--- 

Index: linux-work/drivers/net/ibm_newemac/mal.c
===================================================================
--- linux-work.orig/drivers/net/ibm_newemac/mal.c	2007-10-18 08:02:22.000000000 +1000
+++ linux-work/drivers/net/ibm_newemac/mal.c	2007-10-18 08:02:24.000000000 +1000
@@ -322,7 +322,7 @@ void mal_poll_disable(struct mal_instanc
 		msleep(1);
 
 	/* Synchronize with the MAL NAPI poller */
-	__napi_synchronize(&mal->napi);
+	napi_synchronize(&mal->napi);
 }
 
 void mal_poll_enable(struct mal_instance *mal, struct mal_commac *commac)
