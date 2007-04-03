Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id F421ADE020
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Apr 2007 22:52:40 +1000 (EST)
Date: Tue, 3 Apr 2007 22:46:10 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH 14/17] [POWERPC] Rename get_property to of_get_property:
	drivers/scsi
Message-Id: <20070403224610.b61c7377.sfr@canb.auug.org.au>
In-Reply-To: <20070403224505.5d5a1495.sfr@canb.auug.org.au>
References: <20070403105217.7b9fea08.sfr@canb.auug.org.au>
	<20070403105401.1fcdee27.sfr@canb.auug.org.au>
	<20070403105539.7222cf2a.sfr@canb.auug.org.au>
	<20070403105650.204003b6.sfr@canb.auug.org.au>
	<20070403105748.769f156c.sfr@canb.auug.org.au>
	<20070403105852.7c7bfaa0.sfr@canb.auug.org.au>
	<20070403222406.cf39c459.sfr@canb.auug.org.au>
	<20070403222641.e93cb73b.sfr@canb.auug.org.au>
	<20070403222841.a2c6af1c.sfr@canb.auug.org.au>
	<20070403223000.5d44b2f1.sfr@canb.auug.org.au>
	<20070403223136.6ecdabbd.sfr@canb.auug.org.au>
	<20070403223257.cb8c4d15.sfr@canb.auug.org.au>
	<20070403223535.dd6731d6.sfr@canb.auug.org.au>
	<20070403223738.03386a13.sfr@canb.auug.org.au>
	<20070403223914.35bf04e1.sfr@canb.auug.org.au>
	<20070403224039.913af749.sfr@canb.auug.org.au>
	<20070403224205.807cffe0.sfr@canb.auug.org.au>
	<20070403224340.5533abc9.sfr@canb.auug.org.au>
	<20070403224505.5d5a1495.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/scsi/ibmvscsi/ibmvstgt.c  |    8 ++++----
 drivers/scsi/ibmvscsi/rpa_vscsi.c |    4 ++--
 drivers/scsi/mac53c94.c           |    2 +-
 drivers/scsi/mesh.c               |    2 +-
 4 files changed, 8 insertions(+), 8 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/drivers/scsi/ibmvscsi/ibmvstgt.c b/drivers/scsi/ibmvscsi/ibmvstgt.c
index f65f21d..3fe831c 100644
--- a/drivers/scsi/ibmvscsi/ibmvstgt.c
+++ b/drivers/scsi/ibmvscsi/ibmvstgt.c
@@ -903,16 +903,16 @@ static int get_system_info(void)
 	if (!rootdn)
 		return -ENOENT;
 
-	model = get_property(rootdn, "model", NULL);
-	id = get_property(rootdn, "system-id", NULL);
+	model = of_get_property(rootdn, "model", NULL);
+	id = of_get_property(rootdn, "system-id", NULL);
 	if (model && id)
 		snprintf(system_id, sizeof(system_id), "%s-%s", model, id);
 
-	name = get_property(rootdn, "ibm,partition-name", NULL);
+	name = of_get_property(rootdn, "ibm,partition-name", NULL);
 	if (name)
 		strncpy(partition_name, name, sizeof(partition_name));
 
-	num = get_property(rootdn, "ibm,partition-no", NULL);
+	num = of_get_property(rootdn, "ibm,partition-no", NULL);
 	if (num)
 		partition_number = *num;
 
diff --git a/drivers/scsi/ibmvscsi/rpa_vscsi.c b/drivers/scsi/ibmvscsi/rpa_vscsi.c
index 227c0f2..9bbb69c 100644
--- a/drivers/scsi/ibmvscsi/rpa_vscsi.c
+++ b/drivers/scsi/ibmvscsi/rpa_vscsi.c
@@ -162,11 +162,11 @@ static void gather_partition_info(void)
 		return;
 	}
 
-	ppartition_name = get_property(rootdn, "ibm,partition-name", NULL);
+	ppartition_name = of_get_property(rootdn, "ibm,partition-name", NULL);
 	if (ppartition_name)
 		strncpy(partition_name, ppartition_name,
 				sizeof(partition_name));
-	p_number_ptr = get_property(rootdn, "ibm,partition-no", NULL);
+	p_number_ptr = of_get_property(rootdn, "ibm,partition-no", NULL);
 	if (p_number_ptr)
 		partition_number = *p_number_ptr;
 }
diff --git a/drivers/scsi/mac53c94.c b/drivers/scsi/mac53c94.c
index 753d883..5806ede 100644
--- a/drivers/scsi/mac53c94.c
+++ b/drivers/scsi/mac53c94.c
@@ -471,7 +471,7 @@ static int mac53c94_probe(struct macio_dev *mdev, const struct of_device_id *mat
 		goto out_free;
 	}
 
-       	clkprop = get_property(node, "clock-frequency", &proplen);
+	clkprop = of_get_property(node, "clock-frequency", &proplen);
        	if (clkprop == NULL || proplen != sizeof(int)) {
        		printk(KERN_ERR "%s: can't get clock frequency, "
        		       "assuming 25MHz\n", node->full_name);
diff --git a/drivers/scsi/mesh.c b/drivers/scsi/mesh.c
index 1fd3c75..cf3666d 100644
--- a/drivers/scsi/mesh.c
+++ b/drivers/scsi/mesh.c
@@ -1947,7 +1947,7 @@ static int mesh_probe(struct macio_dev *mdev, const struct of_device_id *match)
 	       	ms->tgts[tgt].current_req = NULL;
        	}
 
-	if ((cfp = get_property(mesh, "clock-frequency", NULL)))
+	if ((cfp = of_get_property(mesh, "clock-frequency", NULL)))
        		ms->clk_freq = *cfp;
 	else {
        		printk(KERN_INFO "mesh: assuming 50MHz clock frequency\n");
-- 
1.5.0.3
