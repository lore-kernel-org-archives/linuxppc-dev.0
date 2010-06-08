Return-Path: <grant.likely@secretlab.ca>
Received: from mail-pz0-f182.google.com (mail-pz0-f182.google.com
	[209.85.222.182]) by ozlabs.org (Postfix) with ESMTP id A486FB7DA8
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jun 2010 00:15:53 +1000 (EST)
Received: by pzk12 with SMTP id 12so3115654pzk.9
	for <linuxppc-dev@ozlabs.org>; Tue, 08 Jun 2010 07:15:53 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
Subject: [PATCH 4/5] of/address: little-endian fixes
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 08 Jun 2010 08:10:13 -0600
Message-ID: <20100608141013.25879.34892.stgit@angua>
In-Reply-To: <20100608140917.25879.67745.stgit@angua>
References: <20100608140917.25879.67745.stgit@angua>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Michal Simek <monstr@monstr.eu>,
	linuxppc-dev@ozlabs.org, microblaze-uclinux@itee.uq.edu.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Fix some endian issues in the OF address translation code.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
CC: Michal Simek <monstr@monstr.eu>
CC: Wolfram Sang <w.sang@pengutronix.de>
CC: Stephen Rothwell <sfr@canb.auug.org.au>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: microblaze-uclinux@itee.uq.edu.au
CC: linuxppc-dev@ozlabs.org
---
 drivers/of/address.c |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/of/address.c b/drivers/of/address.c
index 2a905d5..0b04137 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -22,7 +22,7 @@ static void of_dump_addr(const char *s, const u32 *addr, int na)
 {
 	printk(KERN_DEBUG "%s", s);
 	while (na--)
-		printk(" %08x", *(addr++));
+		printk(" %08x", be32_to_cpu(*(addr++)));
 	printk("\n");
 }
 #else
@@ -79,8 +79,8 @@ static int of_bus_default_translate(u32 *addr, u64 offset, int na)
 	memset(addr, 0, na * 4);
 	a += offset;
 	if (na > 1)
-		addr[na - 2] = a >> 32;
-	addr[na - 1] = a & 0xffffffffu;
+		addr[na - 2] = cpu_to_be32(a >> 32);
+	addr[na - 1] = cpu_to_be32(a & 0xffffffffu);
 
 	return 0;
 }
@@ -190,14 +190,16 @@ const u32 *of_get_pci_address(struct device_node *dev, int bar_no, u64 *size,
 	psize /= 4;
 
 	onesize = na + ns;
-	for (i = 0; psize >= onesize; psize -= onesize, prop += onesize, i++)
-		if ((prop[0] & 0xff) == ((bar_no * 4) + PCI_BASE_ADDRESS_0)) {
+	for (i = 0; psize >= onesize; psize -= onesize, prop += onesize, i++) {
+		u32 val = be32_to_cpu(prop[0]);
+		if ((val & 0xff) == ((bar_no * 4) + PCI_BASE_ADDRESS_0)) {
 			if (size)
 				*size = of_read_number(prop + na, ns);
 			if (flags)
 				*flags = bus->get_flags(prop);
 			return prop;
 		}
+	}
 	return NULL;
 }
 EXPORT_SYMBOL(of_get_pci_address);
