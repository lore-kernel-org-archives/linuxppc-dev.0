Return-Path: <linas@austin.ibm.com>
Date: Tue, 22 May 2007 18:39:01 -0500
To: Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH 5/10] spidernet: null out skb pointer after its been used.
Message-ID: <20070522233901.GD2147@austin.ibm.com>
References: <20070522230942.GT5921@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070522230942.GT5921@austin.ibm.com>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: netdev@vger.kernel.org, Florin Malita <fmalita@gmail.com>,
	cbe-oss-dev@ozlabs.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


If the ethernet interface is brought down while there is still
RX traffic in flight, the device shutdown routine can end up
trying to double-free an skb, leading to a crash in mm/slab.c
Avoid the double-free by nulling out the skb pointer.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

----
 drivers/net/spider_net.c |    1 +
 1 file changed, 1 insertion(+)

Index: netdev-2.6/drivers/net/spider_net.c
===================================================================
--- netdev-2.6.orig/drivers/net/spider_net.c	2007-05-22 18:03:32.000000000 -0500
+++ netdev-2.6/drivers/net/spider_net.c	2007-05-22 18:03:34.000000000 -0500
@@ -1136,6 +1136,7 @@ spider_net_decode_one_descr(struct spide
 
 	/* Ok, we've got a packet in descr */
 	spider_net_pass_skb_up(descr, card);
+	descr->skb = NULL;
 	hwdescr->dmac_cmd_status = SPIDER_NET_DESCR_NOT_IN_USE;
 	return 1;
 
