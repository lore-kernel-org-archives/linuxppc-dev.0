Return-Path: <ricardo.ribalda@gmail.com>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.31])
	by ozlabs.org (Postfix) with ESMTP id 21AD2DDE9E
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Apr 2009 18:05:07 +1000 (EST)
Received: by yw-out-2324.google.com with SMTP id 9so1782629ywe.39
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Apr 2009 01:05:05 -0700 (PDT)
Sender: Ricardo <ricardo.ribalda@gmail.com>
From: Ricardo Ribalda Delgado <ricardo.ribalda@uam.es>
To: linuxppc-dev@ozlabs.org, ben@codiert.org, David.Woodhouse@intel.com,
	linuxppc-embedded@ozlabs.org
Subject: [MTD] ofpart: Partitions at same address cannot have the same name
Date: Wed, 22 Apr 2009 10:05:41 +0200
Message-Id: <1240387541-16594-1-git-send-email-ricardo.ribalda@uam.es>
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@uam.es>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Sometimes, an special partition is included in the device tree including all the
partitions. Like in:

partition@ff000000 {
	reg = < 0x000000 0x800000 >;
	label = "Root File System";
};
partition@ff800000 {
	reg = < 0x800000 0x1a0000 >;
	label = "Bitstream";
};
...
partitionAll@ff000000 {
	reg = < 0x000000 0x1000000 >;
	label = "Full FLASH";
};

Because two nodes of a device tree cannot have the same name, but all the 
partitions must be named "partition", this special partition is invalid.

This patch makes ofpart.c only check for the firt part of the name, and 
ignore the rest, allowing this special partition.


---

The extra partition is quite useful while formating the full firmware from linux

 drivers/mtd/ofpart.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/mtd/ofpart.c b/drivers/mtd/ofpart.c
index 3e164f0..0af3b07 100644
--- a/drivers/mtd/ofpart.c
+++ b/drivers/mtd/ofpart.c
@@ -48,7 +48,8 @@ int __devinit of_mtd_parse_partitions(struct device *dev,
 
 		/* check if this is a partition node */
 		partname = of_get_property(pp, "name", &len);
-		if (strcmp(partname, "partition") != 0) {
+		if (strncmp(partname, "partition", strlen("partition")-1)
+									!= 0) {
 			nr_parts--;
 			continue;
 		}
-- 
1.6.2.4
