Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 60994DDE21
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Sep 2007 05:01:18 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l8EJ1DLH005401
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Sep 2007 15:01:13 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l8EJ17Oc025556
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Sep 2007 13:01:08 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l8EJ17h7021255
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Sep 2007 13:01:07 -0600
Message-Id: <20070914185648.970788000@linux.vnet.ibm.com>>
References: <20070914185410.387074000@linux.vnet.ibm.com>>
Date: Fri, 14 Sep 2007 13:54:12 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [patch 2/4] Make partitions optional in physmap_of
In-Reply-To: <20070914185410.387074000@linux.vnet.ibm.com>>
Content-Type: text/plain
Mime-Version: 1.0
Cc: david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The latest physmap_of driver has a small error where it will fail the probe
with:

physmap-flash: probe of fff00000.small-flas failed with error -2

if there are no partition subnodes in the device tree and the old style binding
is not used.  Since partition definitions are optional, the probe should still
succeed.

Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

---
 drivers/mtd/maps/physmap_of.c |    2 ++
 1 file changed, 2 insertions(+)

--- linux-2.6.orig/drivers/mtd/maps/physmap_of.c
+++ linux-2.6/drivers/mtd/maps/physmap_of.c
@@ -142,6 +142,8 @@ static int __devinit process_partitions(
 		}
 	} else {
 		nr_parts = parse_obsolete_partitions(dev, info, dp);
+		if (nr_parts == -ENOENT)
+			nr_parts = 0;
 	}
 
 	if (nr_parts < 0)

-- 
