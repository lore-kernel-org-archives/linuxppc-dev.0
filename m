Return-Path: <abounine@idt.com>
Received: from mxout1.idt.com (mxout1.idt.com [157.165.5.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mxout1.idt.com", Issuer "idt.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 28E79B70AA
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 11 Dec 2010 07:38:49 +1100 (EST)
From: Alexandre Bounine <alexandre.bounine@idt.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH -mm 3/4] RapidIO: Use Component Tag for unified switch
	identification
Date: Fri, 10 Dec 2010 15:38:17 -0500
Message-Id: <1292013498-31406-4-git-send-email-alexandre.bounine@idt.com>
In-Reply-To: <1292013498-31406-1-git-send-email-alexandre.bounine@idt.com>
References: <1292013498-31406-1-git-send-email-alexandre.bounine@idt.com>
Cc: Alexandre Bounine <alexandre.bounine@idt.com>,
	Thomas Moll <thomas.moll@sysgo.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Change the way how switchid value is set. Local counter variable does not
provide unified way to identify switch devices in a system with multiple
processors. Using local counter leads to the situation when the same RIO
switch has different switch ID for each processor. Replacing local counter
with unique portion of the Component Tag provides unified reference to the
switch by every processor in the system.

Signed-off-by: Alexandre Bounine <alexandre.bounine@idt.com>
Cc: Kumar Gala <galak@kernel.crashing.org>
Cc: Matt Porter <mporter@kernel.crashing.org>
Cc: Li Yang <leoli@freescale.com>
Cc: Thomas Moll <thomas.moll@sysgo.com>
Cc: Micha Nelissen <micha@neli.hopto.org>
---
 drivers/rapidio/rio-scan.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/rapidio/rio-scan.c b/drivers/rapidio/rio-scan.c
index e655756..467e82b 100644
--- a/drivers/rapidio/rio-scan.c
+++ b/drivers/rapidio/rio-scan.c
@@ -46,7 +46,6 @@ static void rio_init_em(struct rio_dev *rdev);
 DEFINE_SPINLOCK(rio_global_list_lock);
 
 static int next_destid = 0;
-static int next_switchid = 0;
 static int next_net = 0;
 static int next_comptag = 1;
 
@@ -438,6 +437,10 @@ static struct rio_dev __devinit *rio_setup_device(struct rio_net *net,
 		rio_mport_write_config_32(port, destid, hopcount,
 					  RIO_COMPONENT_TAG_CSR, next_comptag);
 		rdev->comp_tag = next_comptag++;
+	}  else {
+		rio_mport_read_config_32(port, destid, hopcount,
+					 RIO_COMPONENT_TAG_CSR,
+					 &rdev->comp_tag);
 	}
 
 	if (rio_device_has_destid(port, rdev->src_ops, rdev->dst_ops)) {
@@ -461,7 +464,7 @@ static struct rio_dev __devinit *rio_setup_device(struct rio_net *net,
 	/* If a PE has both switch and other functions, show it as a switch */
 	if (rio_is_switch(rdev)) {
 		rswitch = rdev->rswitch;
-		rswitch->switchid = next_switchid;
+		rswitch->switchid = rdev->comp_tag & RIO_CTAG_UDEVID;
 		rswitch->port_ok = 0;
 		rswitch->route_table = kzalloc(sizeof(u8)*
 					RIO_MAX_ROUTE_ENTRIES(port->sys_size),
@@ -816,7 +819,6 @@ static int __devinit rio_enum_peer(struct rio_net *net, struct rio_mport *port,
 		return -1;
 
 	if (rio_is_switch(rdev)) {
-		next_switchid++;
 		sw_inport = RIO_GET_PORT_NUM(rdev->swpinfo);
 		rio_route_add_entry(rdev, RIO_GLOBAL_TABLE,
 				    port->host_deviceid, sw_inport, 0);
@@ -964,8 +966,6 @@ rio_disc_peer(struct rio_net *net, struct rio_mport *port, u16 destid,
 		return -1;
 
 	if (rio_is_switch(rdev)) {
-		next_switchid++;
-
 		/* Associated destid is how we accessed this switch */
 		rdev->destid = destid;
 
-- 
1.7.3.1
