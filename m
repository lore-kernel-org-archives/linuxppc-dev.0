Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 93F24DDFEF
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Apr 2007 22:52:38 +1000 (EST)
Date: Tue, 3 Apr 2007 22:42:05 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH 11/17] [POWERPC] Rename get_property to of_get_property:
	drivers/char
Message-Id: <20070403224205.807cffe0.sfr@canb.auug.org.au>
In-Reply-To: <20070403224039.913af749.sfr@canb.auug.org.au>
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
 drivers/char/agp/uninorth-agp.c |    2 +-
 drivers/char/briq_panel.c       |    2 +-
 drivers/char/hvc_iseries.c      |    2 +-
 drivers/char/hvc_vio.c          |    2 +-
 drivers/char/hvsi.c             |    4 ++--
 drivers/char/tpm/tpm_atmel.h    |    2 +-
 6 files changed, 7 insertions(+), 7 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/drivers/char/agp/uninorth-agp.c b/drivers/char/agp/uninorth-agp.c
index 91b0621..42c0a60 100644
--- a/drivers/char/agp/uninorth-agp.c
+++ b/drivers/char/agp/uninorth-agp.c
@@ -613,7 +613,7 @@ static int __devinit agp_uninorth_probe(struct pci_dev *pdev,
 		uninorth_node = of_find_node_by_name(NULL, "u3");
 	}
 	if (uninorth_node) {
-		const int *revprop = get_property(uninorth_node,
+		const int *revprop = of_get_property(uninorth_node,
 				"device-rev", NULL);
 		if (revprop != NULL)
 			uninorth_rev = *revprop & 0x3f;
diff --git a/drivers/char/briq_panel.c b/drivers/char/briq_panel.c
index 8dcf9d2..669965a 100644
--- a/drivers/char/briq_panel.c
+++ b/drivers/char/briq_panel.c
@@ -206,7 +206,7 @@ static int __init briq_panel_init(void)
 	const char *machine;
 	int i;
 
-	machine = get_property(root, "model", NULL);
+	machine = of_get_property(root, "model", NULL);
 	if (!machine || strncmp(machine, "TotalImpact,BRIQ-1", 18) != 0)
 		return -ENODEV;
 
diff --git a/drivers/char/hvc_iseries.c b/drivers/char/hvc_iseries.c
index f144a94..ec420fe 100644
--- a/drivers/char/hvc_iseries.c
+++ b/drivers/char/hvc_iseries.c
@@ -575,7 +575,7 @@ static int hvc_find_vtys(void)
 				(num_found >= VTTY_PORTS))
 			break;
 
-		vtermno = get_property(vty, "reg", NULL);
+		vtermno = of_get_property(vty, "reg", NULL);
 		if (!vtermno)
 			continue;
 
diff --git a/drivers/char/hvc_vio.c b/drivers/char/hvc_vio.c
index f9c0084..94a542e 100644
--- a/drivers/char/hvc_vio.c
+++ b/drivers/char/hvc_vio.c
@@ -153,7 +153,7 @@ static int hvc_find_vtys(void)
 		if (num_found >= MAX_NR_HVC_CONSOLES)
 			break;
 
-		vtermno = get_property(vty, "reg", NULL);
+		vtermno = of_get_property(vty, "reg", NULL);
 		if (!vtermno)
 			continue;
 
diff --git a/drivers/char/hvsi.c b/drivers/char/hvsi.c
index 50315d6..d5a752d 100644
--- a/drivers/char/hvsi.c
+++ b/drivers/char/hvsi.c
@@ -1279,8 +1279,8 @@ static int __init hvsi_console_init(void)
 		struct hvsi_struct *hp;
 		const uint32_t *vtermno, *irq;
 
-		vtermno = get_property(vty, "reg", NULL);
-		irq = get_property(vty, "interrupts", NULL);
+		vtermno = of_get_property(vty, "reg", NULL);
+		irq = of_get_property(vty, "interrupts", NULL);
 		if (!vtermno || !irq)
 			continue;
 
diff --git a/drivers/char/tpm/tpm_atmel.h b/drivers/char/tpm/tpm_atmel.h
index 3c85200..377bc60 100644
--- a/drivers/char/tpm/tpm_atmel.h
+++ b/drivers/char/tpm/tpm_atmel.h
@@ -52,7 +52,7 @@ static void __iomem * atmel_get_base_addr(unsigned long *base, int *region_size)
 		return NULL;
 	}
 
-	reg = get_property(dn, "reg", &reglen);
+	reg = of_get_property(dn, "reg", &reglen);
 	naddrc = of_n_addr_cells(dn);
 	nsizec = of_n_size_cells(dn);
 
-- 
1.5.0.3
