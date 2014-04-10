Return-Path: <ldufour@linux.vnet.ibm.com>
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 93C271400DF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Apr 2014 23:02:25 +1000 (EST)
Received: from /spool/local
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ldufour@linux.vnet.ibm.com>;
 Thu, 10 Apr 2014 14:02:19 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id CDA7417D805C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Apr 2014 14:03:10 +0100 (BST)
Received: from d06av02.portsmouth.uk.ibm.com (d06av02.portsmouth.uk.ibm.com
 [9.149.37.228])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s3AD2D2a63701110
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Apr 2014 13:02:13 GMT
Received: from d06av02.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av02.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s3AD2FuN023505
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Apr 2014 07:02:16 -0600
Subject: [PATCH] PCI/hotplug/rphahp: Fix endianess issues
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Date: Thu, 10 Apr 2014 15:02:13 +0200
Message-ID: <20140410130213.8435.16459.stgit@nimbus>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: mdroth@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Numerical values stored in the device tree are encoded in Big Endian and
should be byte swapped when running in Little Endian.

RPA hot plug module should convert those values as well.

Note that in rpaphp_get_drc_props the comparison between indexes[i+1] and
*index is done using the BE values (whatever is the current endianess).
This doesn't matter since we are checking for equality here. This way only
the returned value is byte swapped.

RPA also made RTAS calls which implies BE values to be used. According to
the patch done in RTAS (http://patchwork.ozlabs.org/patch/336865), no
additional conversion is required in RPA.

Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
---
 drivers/pci/hotplug/rpaphp_core.c |   15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/hotplug/rpaphp_core.c b/drivers/pci/hotplug/rpaphp_core.c
index 4796c15..984d708 100644
--- a/drivers/pci/hotplug/rpaphp_core.c
+++ b/drivers/pci/hotplug/rpaphp_core.c
@@ -223,16 +223,16 @@ int rpaphp_get_drc_props(struct device_node *dn, int *drc_index,
 	type_tmp = (char *) &types[1];
 
 	/* Iterate through parent properties, looking for my-drc-index */
-	for (i = 0; i < indexes[0]; i++) {
+	for (i = 0; i < be32_to_cpu(indexes[0]); i++) {
 		if ((unsigned int) indexes[i + 1] == *my_index) {
 			if (drc_name)
 				*drc_name = name_tmp;
 			if (drc_type)
 				*drc_type = type_tmp;
 			if (drc_index)
-				*drc_index = *my_index;
+				*drc_index = be32_to_cpu(*my_index);
 			if (drc_power_domain)
-				*drc_power_domain = domains[i+1];
+				*drc_power_domain = be32_to_cpu(domains[i+1]);
 			return 0;
 		}
 		name_tmp += (strlen(name_tmp) + 1);
@@ -321,16 +321,19 @@ int rpaphp_add_slot(struct device_node *dn)
 	/* register PCI devices */
 	name = (char *) &names[1];
 	type = (char *) &types[1];
-	for (i = 0; i < indexes[0]; i++) {
+	for (i = 0; i < be32_to_cpu(indexes[0]); i++) {
+		int index;
 
-		slot = alloc_slot_struct(dn, indexes[i + 1], name, power_domains[i + 1]);
+		index = be32_to_cpu(indexes[i + 1]);
+		slot = alloc_slot_struct(dn, index, name,
+					 be32_to_cpu(power_domains[i + 1]));
 		if (!slot)
 			return -ENOMEM;
 
 		slot->type = simple_strtoul(type, NULL, 10);
 
 		dbg("Found drc-index:0x%x drc-name:%s drc-type:%s\n",
-				indexes[i + 1], name, type);
+				index, name, type);
 
 		retval = rpaphp_enable_slot(slot);
 		if (!retval)
