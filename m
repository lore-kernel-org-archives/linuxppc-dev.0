Return-Path: <linas@austin.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id BEA2E67D8D
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Oct 2006 07:05:10 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e4.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id k9AL51Jb002098
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Oct 2006 17:05:01 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k9AL51Ik114652
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Oct 2006 17:05:01 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k9AL50P8009024
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Oct 2006 17:05:00 -0400
Date: Tue, 10 Oct 2006 16:05:00 -0500
To: akpm@osdl.org
Subject: [PATCH 9/21]: powerpc/cell spidernet bogus rx interrupt bit
Message-ID: <20061010210459.GF4381@austin.ibm.com>
References: <20061010204946.GW4381@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20061010204946.GW4381@austin.ibm.com>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: jeff@garzik.org, Arnd Bergmann <arnd@arndb.de>, netdev@vger.kernel.org,
	James K Lewis <jklewis@us.ibm.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


The current receive interrupt mask sets a bogus bit that doesn't even
belong to the definition of this register. Remove it.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
Cc: James K Lewis <jklewis@us.ibm.com>
Cc: Arnd Bergmann <arnd@arndb.de>

----
 drivers/net/spider_net.h |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

Index: linux-2.6.18-mm2/drivers/net/spider_net.h
===================================================================
--- linux-2.6.18-mm2.orig/drivers/net/spider_net.h	2006-10-10 12:51:26.000000000 -0500
+++ linux-2.6.18-mm2/drivers/net/spider_net.h	2006-10-10 12:54:06.000000000 -0500
@@ -332,9 +332,8 @@ enum spider_net_int2_status {
 				  (1 << SPIDER_NET_GDTDCEINT) | \
 				  (1 << SPIDER_NET_GDTFDCINT) )
 
-/* we rely on flagged descriptor interrupts*/
-#define SPIDER_NET_RXINT	( (1 << SPIDER_NET_GDAFDCINT) | \
-				  (1 << SPIDER_NET_GRMFLLINT) )
+/* We rely on flagged descriptor interrupts */
+#define SPIDER_NET_RXINT	( (1 << SPIDER_NET_GDAFDCINT) )
 
 #define SPIDER_NET_ERRINT	( 0xffffffff & \
 				  (~SPIDER_NET_TXINT) & \
