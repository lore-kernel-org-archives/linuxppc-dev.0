Return-Path: <grant.likely@secretlab.ca>
Received: from pd2mo2so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id E260FDE02C
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Oct 2007 17:29:18 +1100 (EST)
Received: from pd2mr4so.prod.shaw.ca
	(pd2mr4so-qfe3.prod.shaw.ca [10.0.141.107]) by l-daemon
	(Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
	with ESMTP id <0JQR003WZJC0U890@l-daemon> for linuxppc-dev@ozlabs.org;
	Wed, 31 Oct 2007 00:28:48 -0600 (MDT)
Received: from pn2ml7so.prod.shaw.ca ([10.0.121.151])
	by pd2mr4so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JQR00AT3JBZG850@pd2mr4so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Wed, 31 Oct 2007 00:28:48 -0600 (MDT)
Received: from trillian.cg.shawcable.net ([68.147.67.118])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JQR001LHJBZOO00@l-daemon> for linuxppc-dev@ozlabs.org;
	Wed, 31 Oct 2007 00:28:47 -0600 (MDT)
Date: Wed, 31 Oct 2007 00:28:48 -0600
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 2/2] [POWERPC] Fix region size check in mpc5200 FEC driver
In-reply-to: <20071031062842.7966.99739.stgit@trillian.cg.shawcable.net>
To: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Message-id: <20071031062848.7966.35512.stgit@trillian.cg.shawcable.net>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
References: <20071031062842.7966.99739.stgit@trillian.cg.shawcable.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

Driver shouldn't complain if the register range is larger than what
it expects.  This works around failures with some device trees.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 drivers/net/fec_mpc52xx.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/fec_mpc52xx.c b/drivers/net/fec_mpc52xx.c
index fc1cf0b..a8a0ee2 100644
--- a/drivers/net/fec_mpc52xx.c
+++ b/drivers/net/fec_mpc52xx.c
@@ -879,9 +879,9 @@ mpc52xx_fec_probe(struct of_device *op, const struct of_device_id *match)
 				"Error while parsing device node resource\n" );
 		return rv;
 	}
-	if ((mem.end - mem.start + 1) != sizeof(struct mpc52xx_fec)) {
+	if ((mem.end - mem.start + 1) < sizeof(struct mpc52xx_fec)) {
 		printk(KERN_ERR DRIVER_NAME
-			" - invalid resource size (%lx != %x), check mpc52xx_devices.c\n",
+			" - invalid resource size (%lx < %x), check mpc52xx_devices.c\n",
 			(unsigned long)(mem.end - mem.start + 1), sizeof(struct mpc52xx_fec));
 		return -EINVAL;
 	}
