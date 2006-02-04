Return-Path: <olh@suse.de>
Received: from mx1.suse.de (ns.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 5A00B68A53
	for <linuxppc-dev@ozlabs.org>; Sat,  4 Feb 2006 23:20:18 +1100 (EST)
Date: Sat, 4 Feb 2006 13:20:13 +0100
From: Olaf Hering <olh@suse.de>
To: linuxppc-dev@ozlabs.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackeras <paulus@samba.org>
Subject: [PATCH] missing refcounting of of_find_node_by_name users
Message-ID: <20060204122013.GA20324@suse.de>
References: <20060118151840.GA24381@suse.de> <20060204115541.GB19392@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20060204115541.GB19392@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


drop the refcount of the node returned from of_find_node_by_name

Signed-off-by: Olaf Hering <olh@suse.de>

 arch/powerpc/platforms/powermac/feature.c |    5 +++++
 arch/powerpc/platforms/powermac/pci.c     |    1 +
 arch/powerpc/platforms/powermac/pic.c     |    1 +
 arch/powerpc/platforms/powermac/smp.c     |    1 +
 arch/powerpc/platforms/pseries/eeh.c      |    1 +
 arch/powerpc/platforms/pseries/setup.c    |    1 +
 drivers/char/hvc_vio.c                    |    1 +
 drivers/serial/pmac_zilog.c               |    1 +
 8 files changed, 12 insertions(+)

Index: linux-2.6.16-rc2-olh/arch/powerpc/platforms/powermac/feature.c
===================================================================
--- linux-2.6.16-rc2-olh.orig/arch/powerpc/platforms/powermac/feature.c
+++ linux-2.6.16-rc2-olh/arch/powerpc/platforms/powermac/feature.c
@@ -2772,6 +2772,7 @@ set_initial_features(void)
 				g5_gmac_enable(np, 0, 1);
 			np = of_find_node_by_name(np, "ethernet");
 		}
+		of_node_put(np);
 
 		/* Enable FW before PCI probe. Will be disabled later on
 		 * Note: We should have a batter way to check that we are
@@ -2786,6 +2787,7 @@ set_initial_features(void)
 			}
 			np = of_find_node_by_name(np, "firewire");
 		}
+		of_node_put(np);
 	}
 #else /* CONFIG_POWER4 */
 
@@ -2803,6 +2805,7 @@ set_initial_features(void)
 				core99_gmac_enable(np, 0, 1);
 			np = of_find_node_by_name(np, "ethernet");
 		}
+		of_node_put(np);
 
 		/* Enable FW before PCI probe. Will be disabled later on
 		 * Note: We should have a batter way to check that we are
@@ -2821,6 +2824,7 @@ set_initial_features(void)
 			}
 			np = of_find_node_by_name(np, "firewire");
 		}
+		of_node_put(np);
 
 		/* Enable ATA-100 before PCI probe. */
 		np = of_find_node_by_name(NULL, "ata-6");
@@ -2832,6 +2836,7 @@ set_initial_features(void)
 			}
 			np = of_find_node_by_name(np, "ata-6");
 		}
+		of_node_put(np);
 
 		/* Switch airport off */
 		np = find_devices("radio");
Index: linux-2.6.16-rc2-olh/arch/powerpc/platforms/powermac/pci.c
===================================================================
--- linux-2.6.16-rc2-olh.orig/arch/powerpc/platforms/powermac/pci.c
+++ linux-2.6.16-rc2-olh/arch/powerpc/platforms/powermac/pci.c
@@ -695,6 +695,7 @@ static void __init fixup_nec_usb2(void)
 				nec->intrs[0].line);
 		}
 	}
+	of_put_node(nec);
 }
 
 static void __init setup_bandit(struct pci_controller *hose,
Index: linux-2.6.16-rc2-olh/arch/powerpc/platforms/powermac/pic.c
===================================================================
--- linux-2.6.16-rc2-olh.orig/arch/powerpc/platforms/powermac/pic.c
+++ linux-2.6.16-rc2-olh/arch/powerpc/platforms/powermac/pic.c
@@ -658,6 +658,7 @@ static int pmacpic_find_viaint(void)
 	if (np == NULL)
 		goto not_found;
 	viaint = np->intrs[0].line;
+	of_node_put(np);
 #endif /* CONFIG_ADB_PMU */
 
 not_found:
Index: linux-2.6.16-rc2-olh/arch/powerpc/platforms/powermac/smp.c
===================================================================
--- linux-2.6.16-rc2-olh.orig/arch/powerpc/platforms/powermac/smp.c
+++ linux-2.6.16-rc2-olh/arch/powerpc/platforms/powermac/smp.c
@@ -588,6 +588,7 @@ static void __init smp_core99_setup_i2c_
 		if (pmac_tb_freeze != NULL)
 			break;
 	}
+	of_node_put(cc);
 	if (pmac_tb_freeze != NULL) {
 		/* Open i2c bus for synchronous access */
 		if (pmac_i2c_open(pmac_tb_clock_chip_host, 1)) {
Index: linux-2.6.16-rc2-olh/arch/powerpc/platforms/pseries/eeh.c
===================================================================
--- linux-2.6.16-rc2-olh.orig/arch/powerpc/platforms/pseries/eeh.c
+++ linux-2.6.16-rc2-olh/arch/powerpc/platforms/pseries/eeh.c
@@ -846,6 +846,7 @@ void __init eeh_init(void)
 		info.buid_hi = BUID_HI(buid);
 		traverse_pci_devices(phb, early_enable_eeh, &info);
 	}
+	of_node_put(phb);
 
 	if (eeh_subsystem_enabled)
 		printk(KERN_INFO "EEH: PCI Enhanced I/O Error Handling Enabled\n");
Index: linux-2.6.16-rc2-olh/arch/powerpc/platforms/pseries/setup.c
===================================================================
--- linux-2.6.16-rc2-olh.orig/arch/powerpc/platforms/pseries/setup.c
+++ linux-2.6.16-rc2-olh/arch/powerpc/platforms/pseries/setup.c
@@ -330,6 +330,7 @@ static  void __init pSeries_discover_pic
 			break;
 		}
 	}
+	of_node_put(np);
 	if (ppc64_interrupt_controller == IC_INVALID)
 		printk("pSeries_discover_pic: failed to recognize"
 			" interrupt-controller\n");
Index: linux-2.6.16-rc2-olh/drivers/char/hvc_vio.c
===================================================================
--- linux-2.6.16-rc2-olh.orig/drivers/char/hvc_vio.c
+++ linux-2.6.16-rc2-olh/drivers/char/hvc_vio.c
@@ -146,6 +146,7 @@ static int hvc_find_vtys(void)
 			++num_found;
 		}
 	}
+	of_node_put(vty);
 
 	return num_found;
 }
Index: linux-2.6.16-rc2-olh/drivers/serial/pmac_zilog.c
===================================================================
--- linux-2.6.16-rc2-olh.orig/drivers/serial/pmac_zilog.c
+++ linux-2.6.16-rc2-olh/drivers/serial/pmac_zilog.c
@@ -1767,6 +1767,7 @@ static int __init pmz_probe(void)
 next:
 		node_p = of_find_node_by_name(node_p, "escc");
 	}
+	of_node_put(node_p);
 	pmz_ports_count = count;
 
 	return 0;
-- 
short story of a lazy sysadmin:
 alias appserv=wotan
