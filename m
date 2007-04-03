Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 4BDEEDDE9F
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Apr 2007 22:52:27 +1000 (EST)
Date: Tue, 3 Apr 2007 22:24:06 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH 01/17] [POWERPC] Rename get_property to of_get_property:
	include
Message-Id: <20070403222406.cf39c459.sfr@canb.auug.org.au>
In-Reply-To: <20070403105852.7c7bfaa0.sfr@canb.auug.org.au>
References: <20070403105217.7b9fea08.sfr@canb.auug.org.au>
	<20070403105401.1fcdee27.sfr@canb.auug.org.au>
	<20070403105539.7222cf2a.sfr@canb.auug.org.au>
	<20070403105650.204003b6.sfr@canb.auug.org.au>
	<20070403105748.769f156c.sfr@canb.auug.org.au>
	<20070403105852.7c7bfaa0.sfr@canb.auug.org.au>
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
 include/asm-powerpc/parport.h |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

This set of patches follows the previous 6.  The whole lot have been
built with allmodconfig on PowerPC64.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/include/asm-powerpc/parport.h b/include/asm-powerpc/parport.h
index 3fca21d..b37b81e 100644
--- a/include/asm-powerpc/parport.h
+++ b/include/asm-powerpc/parport.h
@@ -20,18 +20,18 @@ extern struct parport *parport_pc_probe_port (unsigned long int base,
 static int __devinit parport_pc_find_nonpci_ports (int autoirq, int autodma)
 {
 	struct device_node *np;
-	u32 *prop;
+	const u32 *prop;
 	u32 io1, io2;
 	int propsize;
 	int count = 0;
 	for (np = NULL; (np = of_find_compatible_node(np,
 						      "parallel",
 						      "pnpPNP,400")) != NULL;) {
-		prop = (u32 *)get_property(np, "reg", &propsize);
+		prop = of_get_property(np, "reg", &propsize);
 		if (!prop || propsize > 6*sizeof(u32))
 			continue;
 		io1 = prop[1]; io2 = prop[2];
-		prop = (u32 *)get_property(np, "interrupts", NULL);
+		prop = of_get_property(np, "interrupts", NULL);
 		if (!prop)
 			continue;
 		if (parport_pc_probe_port(io1, io2, prop[0], autodma, NULL) != NULL)
-- 
1.5.0.3
