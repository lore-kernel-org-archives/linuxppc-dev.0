Return-Path: <ricardo.ribalda@gmail.com>
Received: from mail-ew0-f167.google.com (mail-ew0-f167.google.com
	[209.85.219.167]) by ozlabs.org (Postfix) with ESMTP id 6EC56DE1DE
	for <linuxppc-dev@ozlabs.org>; Sat, 25 Apr 2009 00:07:27 +1000 (EST)
Received: by ewy11 with SMTP id 11so984039ewy.9
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Apr 2009 07:07:25 -0700 (PDT)
Sender: Ricardo <ricardo.ribalda@gmail.com>
From: Ricardo Ribalda Delgado <ricardo.ribalda@uam.es>
To: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	David.Woodhouse@intel.com, ben@codiert.org
Subject: [PATCH] [MTD] ofpart: Partitions at same address cannot have the same
	name v3
Date: Fri, 24 Apr 2009 16:01:55 +0200
Message-Id: <1240581715-25926-1-git-send-email-ricardo.ribalda@uam.es>
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
full@ff000000 {
       compatible = "partition";
       reg = < 0x000000 0x1000000 >;
       label = "Full FLASH";
};

Because two nodes of a device tree cannot have the same name, but all the
partitions must be named "partition", this special partition is invalid.

This patch makes ofpart.c accept spetial partitions compatible with
"partition" but not named partition.

These spetial partitions are very useful for flashing the full firmware
of a device from linux
---
This v3 includes feedback from Scott Wood, Peter Korsgaard & Benjamin Kril

v3: Use the compatible propierty
v2: buggy implementation, strlen-1 instead of strlen
v1: Just check the firt part of the name


 drivers/mtd/ofpart.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/mtd/ofpart.c b/drivers/mtd/ofpart.c
index 3e164f0..59c1e4a 100644
--- a/drivers/mtd/ofpart.c
+++ b/drivers/mtd/ofpart.c
@@ -48,7 +48,9 @@ int __devinit of_mtd_parse_partitions(struct device *dev,
 
 		/* check if this is a partition node */
 		partname = of_get_property(pp, "name", &len);
-		if (strcmp(partname, "partition") != 0) {
+		if ((strcmp(partname, "partition") != 0) &&
+			(of_device_is_compatible(pp, "partition") != 1))
+		{
 			nr_parts--;
 			continue;
 		}
-- 
1.6.2.4
