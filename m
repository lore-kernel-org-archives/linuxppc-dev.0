Return-Path: <clg@fr.ibm.com>
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e06smtp12.uk.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1146D2C0112
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Sep 2013 22:19:23 +1000 (EST)
Received: from /spool/local
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clg@fr.ibm.com>;
 Mon, 23 Sep 2013 13:19:16 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 32B611B0805D
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Sep 2013 13:19:15 +0100 (BST)
Received: from d06av12.portsmouth.uk.ibm.com (d06av12.portsmouth.uk.ibm.com
 [9.149.37.247])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r8NCJ1gr53543102
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Sep 2013 12:19:01 GMT
Received: from d06av12.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av12.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r8NCJCp8024439
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Sep 2013 06:19:13 -0600
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@fr.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>
Subject: [PATCH] powerpc/kernel: fix endian issue in rtas_pci
Date: Mon, 23 Sep 2013 14:17:54 +0200
Message-Id: <1379938674-4165-1-git-send-email-clg@fr.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@fr.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Cédric Le Goater <clg@fr.ibm.com>
---
 arch/powerpc/kernel/rtas_pci.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/rtas_pci.c b/arch/powerpc/kernel/rtas_pci.c
index 6e7b7cd..7d4c717 100644
--- a/arch/powerpc/kernel/rtas_pci.c
+++ b/arch/powerpc/kernel/rtas_pci.c
@@ -223,7 +223,7 @@ unsigned long get_phb_buid(struct device_node *phb)
 static int phb_set_bus_ranges(struct device_node *dev,
 			      struct pci_controller *phb)
 {
-	const int *bus_range;
+	const __be32 *bus_range;
 	unsigned int len;
 
 	bus_range = of_get_property(dev, "bus-range", &len);
@@ -231,8 +231,8 @@ static int phb_set_bus_ranges(struct device_node *dev,
 		return 1;
  	}
 
-	phb->first_busno =  bus_range[0];
-	phb->last_busno  =  bus_range[1];
+	phb->first_busno = be32_to_cpu(bus_range[0]);
+	phb->last_busno  = be32_to_cpu(bus_range[1]);
 
 	return 0;
 }
-- 
1.7.10.4
