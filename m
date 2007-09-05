Return-Path: <tony@bakeyournoodle.com>
Received: from pythia.bakeyournoodle.com (pythia.bakeyournoodle.com
	[203.82.209.197]) by ozlabs.org (Postfix) with ESMTP id A7774DDE21
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Sep 2007 10:23:15 +1000 (EST)
Date: Wed, 5 Sep 2007 10:23:14 +1000
To: LinuxPPC-dev <linuxppc-dev@ozlabs.org>, Olof Johansson <olof@lixom.net>
Subject: [POWERPC] flags as passed to spin_*_irqsave() should be unsigned long.
Message-ID: <20070905002314.GT10345@bakeyournoodle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
From: tony@bakeyournoodle.com (Tony Breeds)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>

---
Found trying to build a -rt kernel, which has a BUILD_BUG_ON(), in this
caswe.

 drivers/net/pasemi_mac.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: working/drivers/net/pasemi_mac.c
===================================================================
--- working.orig/drivers/net/pasemi_mac.c	2007-09-04 16:46:40.000000000 +1000
+++ working/drivers/net/pasemi_mac.c	2007-09-04 16:47:01.000000000 +1000
@@ -524,7 +524,7 @@ static int pasemi_mac_clean_tx(struct pa
 	struct pasemi_mac_buffer *info;
 	struct pas_dma_xct_descr *dp;
 	int start, count;
-	int flags;
+	unsigned long flags;
 
 	spin_lock_irqsave(&mac->tx->lock, flags);
 
@@ -950,7 +950,7 @@ static int pasemi_mac_start_tx(struct sk
 	struct pas_dma_xct_descr *dp;
 	u64 dflags;
 	dma_addr_t map;
-	int flags;
+	unsigned long flags;
 
 	dflags = XCT_MACTX_O | XCT_MACTX_ST | XCT_MACTX_SS | XCT_MACTX_CRC_PAD;
 

Yours Tony

  linux.conf.au        http://linux.conf.au/ || http://lca2008.linux.org.au/
  Jan 28 - Feb 02 2008 The Australian Linux Technical Conference!
