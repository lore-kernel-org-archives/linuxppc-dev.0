Return-Path: <mgreer@mvista.com>
Date: Thu, 1 Sep 2005 17:47:40 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Andrew Morton <akpm@osdl.org>
Message-ID: <20050902004740.GA10106@mag.az.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-embedded <Linuxppc-embedded@ozlabs.org>
Subject: [PATCH 2.6.13-mm1] ppc32: mv64x60 updates & enhancements
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Updates and enhancement to the ppc32 mv64x60 code:
- move code to get mem size from mem ctlr to bootwrapper
- address some errata in the mv64360 pic code
- some minor cleanups
- export one of the bridge's regs via sysfs so user daemon can watch for
  extraction events

Signed-off-by: Mark A. Greer <mgreer@mvista.com>
--

diff -Nur linux-2.6.13-mm1/arch/ppc/boot/simple/misc-mv64x60.c linux-2.6.13-mm1-mag/arch/ppc/boot/simple/misc-mv64x60.c
--- linux-2.6.13-mm1/arch/ppc/boot/simple/misc-mv64x60.c	2005-08-28 16:41:01.000000000 -0700
+++ linux-2.6.13-mm1-mag/arch/ppc/boot/simple/misc-mv64x60.c	2005-09-01 16:56:42.000000000 -0700
@@ -19,6 +19,33 @@
 extern struct bi_record *decompress_kernel(unsigned long load_addr,
 	int num_words, unsigned long cksum);
 
+
+u32 size_reg[MV64x60_CPU2MEM_WINDOWS] = {
+	MV64x60_CPU2MEM_0_SIZE, MV64x60_CPU2MEM_1_SIZE,
+	MV64x60_CPU2MEM_2_SIZE, MV64x60_CPU2MEM_3_SIZE
+};
+
+/* Read mem ctlr to get the amount of mem in system */
+unsigned long
+mv64360_get_mem_size(void)
+{
+	u32	enables, i, v;
+	u32	mem = 0;
+
+	enables = in_le32((void __iomem *)CONFIG_MV64X60_NEW_BASE +
+		MV64360_CPU_BAR_ENABLE) & 0xf;
+
+	for (i=0; i<MV64x60_CPU2MEM_WINDOWS; i++)
+		if (!(enables & (1<<i))) {
+			v = in_le32((void __iomem *)CONFIG_MV64X60_NEW_BASE
+				+ size_reg[i]) & 0xffff;
+			v = (v + 1) << 16;
+			mem += v;
+		}
+
+	return mem;
+}
+
 void
 mv64x60_move_base(void __iomem *old_base, void __iomem *new_base)
 {
diff -Nur linux-2.6.13-mm1/arch/ppc/Kconfig.debug linux-2.6.13-mm1-mag/arch/ppc/Kconfig.debug
--- linux-2.6.13-mm1/arch/ppc/Kconfig.debug	2005-08-28 16:41:01.000000000 -0700
+++ linux-2.6.13-mm1-mag/arch/ppc/Kconfig.debug	2005-09-01 16:56:42.000000000 -0700
@@ -62,7 +62,8 @@
 
 config SERIAL_TEXT_DEBUG
 	bool "Support for early boot texts over serial port"
-	depends on 4xx || GT64260 || LOPEC || PPLUS || PRPMC800 || PPC_GEN550 || PPC_MPC52xx
+	depends on 4xx || LOPEC || MV64X60 || PPLUS || PRPMC800 || \
+		PPC_GEN550 || PPC_MPC52xx
 
 config PPC_OCP
 	bool
diff -Nur linux-2.6.13-mm1/arch/ppc/syslib/mv64360_pic.c linux-2.6.13-mm1-mag/arch/ppc/syslib/mv64360_pic.c
--- linux-2.6.13-mm1/arch/ppc/syslib/mv64360_pic.c	2005-08-28 16:41:01.000000000 -0700
+++ linux-2.6.13-mm1-mag/arch/ppc/syslib/mv64360_pic.c	2005-09-01 16:56:42.000000000 -0700
@@ -366,10 +366,16 @@
 	return IRQ_HANDLED;
 }
 
+/*
+ * Bit 0 of MV64x60_PCIx_ERR_MASK does not exist on the 64360 and because of
+ * errata FEr-#11 and FEr-##16 for the 64460, it should be 0 on that chip as
+ * well.  IOW, don't set bit 0.
+ */
+#define MV64360_PCI0_ERR_MASK_VAL	0x00a50c24
+
 static int __init
 mv64360_register_hdlrs(void)
 {
-	u32	mask;
 	int	rc;
 
 	/* Clear old errors and register CPU interface error intr handler */
@@ -387,17 +393,6 @@
 		mv64360_sram_error_int_handler,SA_INTERRUPT,SRAM_INTR_STR, 0)))
 		printk(KERN_WARNING "Can't register SRAM error handler: %d",rc);
 
-	/*
-	 * Bit 0 reserved on 64360 and erratum FEr PCI-#11 (PCI internal
-	 * data parity error set incorrectly) on rev 0 & 1 of 64460 requires
-	 * bit 0 to be cleared.
-	 */
-	mask = 0x00a50c24;
-
-	if ((mv64x60_get_bridge_type() == MV64x60_TYPE_MV64460) &&
-		(mv64x60_get_bridge_rev() > 1))
-		mask |= 0x1;	/* enable DPErr on 64460 */
-
 	/* Clear old errors and register PCI 0 error intr handler */
 	mv64x60_write(&bh, MV64x60_PCI0_ERR_CAUSE, 0);
 	if ((rc = request_irq(MV64360_IRQ_PCI0 + mv64360_irq_base,
@@ -407,7 +402,11 @@
 			rc);
 
 	mv64x60_write(&bh, MV64x60_PCI0_ERR_MASK, 0);
-	mv64x60_write(&bh, MV64x60_PCI0_ERR_MASK, mask);
+	mv64x60_write(&bh, MV64x60_PCI0_ERR_MASK, MV64360_PCI0_ERR_MASK_VAL);
+
+	/* Erratum FEr PCI-#16 says to clear bit 0 of PCI SERRn Mask reg. */
+	mv64x60_write(&bh, MV64x60_PCI0_ERR_SERR_MASK,
+		mv64x60_read(&bh, MV64x60_PCI0_ERR_SERR_MASK) & ~0x1UL);
 
 	/* Clear old errors and register PCI 1 error intr handler */
 	mv64x60_write(&bh, MV64x60_PCI1_ERR_CAUSE, 0);
@@ -418,7 +417,11 @@
 			rc);
 
 	mv64x60_write(&bh, MV64x60_PCI1_ERR_MASK, 0);
-	mv64x60_write(&bh, MV64x60_PCI1_ERR_MASK, mask);
+	mv64x60_write(&bh, MV64x60_PCI1_ERR_MASK, MV64360_PCI0_ERR_MASK_VAL);
+
+	/* Erratum FEr PCI-#16 says to clear bit 0 of PCI Intr Mask reg. */
+	mv64x60_write(&bh, MV64x60_PCI1_ERR_SERR_MASK,
+		mv64x60_read(&bh, MV64x60_PCI1_ERR_SERR_MASK) & ~0x1UL);
 
 	return 0;
 }
diff -Nur linux-2.6.13-mm1/arch/ppc/syslib/mv64x60.c linux-2.6.13-mm1-mag/arch/ppc/syslib/mv64x60.c
--- linux-2.6.13-mm1/arch/ppc/syslib/mv64x60.c	2005-09-01 16:26:10.000000000 -0700
+++ linux-2.6.13-mm1-mag/arch/ppc/syslib/mv64x60.c	2005-09-01 16:58:41.000000000 -0700
@@ -30,13 +30,17 @@
 #include <asm/mv64x60.h>
 
 
-u8		mv64x60_pci_exclude_bridge = 1;
 DEFINE_SPINLOCK(mv64x60_lock);
 
+u8	mv64x60_pci_exclude_bridge = 1;
+
 static phys_addr_t 	mv64x60_bridge_pbase = 0;
 static void 		*mv64x60_bridge_vbase = 0;
 static u32		mv64x60_bridge_type = MV64x60_TYPE_INVALID;
 static u32		mv64x60_bridge_rev = 0;
+#if defined(CONFIG_SYSFS) && !defined(CONFIG_GT64260)
+static struct pci_controller	sysfs_hose_a;
+#endif
 
 static u32 gt64260_translate_size(u32 base, u32 size, u32 num_bits);
 static u32 gt64260_untranslate_size(u32 base, u32 size, u32 num_bits);
@@ -432,6 +436,20 @@
 };
 #endif
 
+#if defined(CONFIG_SYSFS) && !defined(CONFIG_GT64260)
+static struct mv64xxx_pdata mv64xxx_pdata = {
+	.hs_reg_valid	= 0,
+};
+
+static struct platform_device mv64xxx_device = { /* general mv64x60 stuff */
+	.name	= MV64XXX_DEV_NAME,
+	.id	= 0,
+	.dev = {
+		.platform_data = &mv64xxx_pdata,
+	},
+};
+#endif
+
 static struct platform_device *mv64x60_pd_devs[] __initdata = {
 #ifdef CONFIG_SERIAL_MPSC
 	&mpsc_shared_device,
@@ -453,6 +471,9 @@
 #ifdef	CONFIG_I2C_MV64XXX
 	&i2c_device,
 #endif
+#if defined(CONFIG_SYSFS) && !defined(CONFIG_GT64260)
+	&mv64xxx_device,
+#endif
 };
 
 /*
@@ -574,6 +595,11 @@
 	bh->hose_a = &hose_a;
 	bh->hose_b = &hose_b;
 
+#if defined(CONFIG_SYSFS) && !defined(CONFIG_GT64260)
+	/* Save a copy of hose_a for sysfs functions -- hack */
+	memcpy(&sysfs_hose_a, &hose_a, sizeof(hose_a));
+#endif
+
 	mv64x60_set_bus(bh, 0, 0);
 	mv64x60_set_bus(bh, 1, 0);
 
@@ -590,8 +616,6 @@
 
 	mv64x60_set_bits(bh, MV64x60_PCI0_TO_RETRY, 0xffff);
 	mv64x60_set_bits(bh, MV64x60_PCI1_TO_RETRY, 0xffff);
-
-	return;
 }
 
 /*
@@ -628,19 +652,15 @@
 			val = mv64x60_read(bh, size_reg);
 			val = get_from_field(val, size_bits);
 			*size = bh->ci->untranslate_size(*base, val, size_bits);
-		}
-		else
+		} else
 			*size = 0;
-	}
-	else {
+	} else {
 		*base = 0;
 		*size = 0;
 	}
 
 	pr_debug("get 32bit window: %d, base: 0x%x, size: 0x%x\n",
 		window, *base, *size);
-
-	return;
 }
 
 /*
@@ -677,8 +697,6 @@
 
 		(void)mv64x60_read(bh, base_reg); /* Flush FIFO */
 	}
-
-	return;
 }
 
 /*
@@ -712,11 +730,9 @@
 			val = get_from_field(val, size_bits);
 			*size = bh->ci->untranslate_size(*base_lo, val,
 								size_bits);
-		}
-		else
+		} else
 			*size = 0;
-	}
-	else {
+	} else {
 		*base_hi = 0;
 		*base_lo = 0;
 		*size = 0;
@@ -724,8 +740,6 @@
 
 	pr_debug("get 64bit window: %d, base hi: 0x%x, base lo: 0x%x, "
 		"size: 0x%x\n", window, *base_hi, *base_lo, *size);
-
-	return;
 }
 
 /*
@@ -766,8 +780,6 @@
 
 		(void)mv64x60_read(bh, base_lo_reg); /* Flush FIFO */
 	}
-
-	return;
 }
 
 /*
@@ -1008,8 +1020,6 @@
 			mem_windows[i][0] = 0;
 			mem_windows[i][1] = 0;
 		}
-
-	return;
 }
 
 /*
@@ -1077,8 +1087,6 @@
 			}
 
 		}
-
-	return;
 }
 
 /*
@@ -1112,8 +1120,7 @@
 		mv64x60_set_32bit_window(bh, remap_tab[bus][0],
 			pi->pci_io.pci_base_lo, 0, 0);
 		bh->ci->enable_window_32bit(bh, win_tab[bus][0]);
-	}
-	else /* Actually, the window should already be disabled */
+	} else /* Actually, the window should already be disabled */
 		bh->ci->disable_window_32bit(bh, win_tab[bus][0]);
 
 	for (i=0; i<3; i++)
@@ -1125,11 +1132,8 @@
 				pi->pci_mem[i].pci_base_hi,
 				pi->pci_mem[i].pci_base_lo, 0, 0);
 			bh->ci->enable_window_32bit(bh, win_tab[bus][i+1]);
-		}
-		else /* Actually, the window should already be disabled */
+		} else /* Actually, the window should already be disabled */
 			bh->ci->disable_window_32bit(bh, win_tab[bus][i+1]);
-
-	return;
 }
 
 /*
@@ -1206,8 +1210,6 @@
 				MV64x60_PCI0_BAR_ENABLE :
 				MV64x60_PCI1_BAR_ENABLE), (1 << i));
 		}
-
-	return;
 }
 
 /*
@@ -1229,7 +1231,6 @@
 	*hose = pcibios_alloc_controller();
 	setup_indirect_pci_nomap(*hose, bh->v_base + cfg_addr,
 		bh->v_base + cfg_data);
-	return;
 }
 
 /*
@@ -1272,7 +1273,6 @@
 						pi->pci_mem[0].size - 1;
 	hose->pci_mem_offset = pi->pci_mem[0].cpu_base -
 						pi->pci_mem[0].pci_base_lo;
-	return;
 }
 
 /*
@@ -1309,7 +1309,6 @@
 	early_write_config_word(hose, 0, devfn, PCI_CACHE_LINE_SIZE, u16_val);
 
 	mv64x60_pci_exclude_bridge = save_exclude;
-	return;
 }
 
 /*
@@ -1336,8 +1335,7 @@
 		p2p_cfg = MV64x60_PCI0_P2P_CONFIG;
 		pci_cfg_offset = 0x64;
 		hose = bh->hose_a;
-	}
-	else {
+	} else {
 		pci_mode = bh->pci_mode_b;
 		p2p_cfg = MV64x60_PCI1_P2P_CONFIG;
 		pci_cfg_offset = 0xe4;
@@ -1352,8 +1350,7 @@
 		val |= (child_bus << 16) | 0xff;
 		mv64x60_write(bh, p2p_cfg, val);
 		(void)mv64x60_read(bh, p2p_cfg); /* Flush FIFO */
-	}
-	else { /* PCI-X */
+	} else { /* PCI-X */
 		/*
 		 * Need to use the current bus/dev number (that's in the
 		 * P2P CONFIG reg) to access the bridge's pci config space.
@@ -1365,8 +1362,6 @@
 			pci_cfg_offset, child_bus << 8);
 		mv64x60_pci_exclude_bridge = save_exclude;
 	}
-
-	return;
 }
 
 /*
@@ -1423,8 +1418,6 @@
 			j++;
 		}
 	}
-
-	return;
 }
 
 /*
@@ -1498,8 +1491,6 @@
 	early_write_config_dword(hose, 0, PCI_DEVFN(0, 0),
 		gt64260_reg_addrs[bus][window], mv64x60_mask(base, 20) | 0x8);
 	mv64x60_pci_exclude_bridge = save_exclude;
-
-	return;
 }
 
 /*
@@ -1523,8 +1514,6 @@
 	early_write_config_dword(hose, 0, PCI_DEVFN(0,0), gt64260_offset[bus],
 		(base << 16));
 	mv64x60_pci_exclude_bridge = save_exclude;
-
-	return;
 }
 
 /*
@@ -1561,7 +1550,6 @@
 gt64260_enable_window_32bit(struct mv64x60_handle *bh, u32 window)
 {
 	pr_debug("enable 32bit window: %d\n", window);
-	return;
 }
 
 /*
@@ -1584,8 +1572,6 @@
 		mv64x60_write(bh, gt64260_32bit_windows[window].base_reg,0xfff);
 		mv64x60_write(bh, gt64260_32bit_windows[window].size_reg, 0);
 	}
-
-	return;
 }
 
 /*
@@ -1599,7 +1585,6 @@
 gt64260_enable_window_64bit(struct mv64x60_handle *bh, u32 window)
 {
 	pr_debug("enable 64bit window: %d\n", window);
-	return;	/* Enabled when window configured (i.e., when top >= base) */
 }
 
 /*
@@ -1624,8 +1609,6 @@
 		mv64x60_write(bh, gt64260_64bit_windows[window].base_hi_reg, 0);
 		mv64x60_write(bh, gt64260_64bit_windows[window].size_reg, 0);
 	}
-
-	return;
 }
 
 /*
@@ -1712,8 +1695,6 @@
 	mv64x60_write(bh, GT64260_IC_CPU_INT_1_MASK, 0);
 	mv64x60_write(bh, GT64260_IC_CPU_INT_2_MASK, 0);
 	mv64x60_write(bh, GT64260_IC_CPU_INT_3_MASK, 0);
-
-	return;
 }
 
 /*
@@ -1781,14 +1762,11 @@
 	mv64x60_mpsc1_pdata.cache_mgmt = 1;
 
 	if ((r = platform_get_resource(&mpsc1_device, IORESOURCE_IRQ, 0))
-		!= NULL) {
-
+			!= NULL) {
 		r->start = MV64x60_IRQ_SDMA_0;
 		r->end = MV64x60_IRQ_SDMA_0;
 	}
 #endif
-
-	return;
 }
 
 /*
@@ -1861,14 +1839,11 @@
 	mv64x60_mpsc1_pdata.cache_mgmt = 1;
 
 	if ((r = platform_get_resource(&mpsc1_device, IORESOURCE_IRQ, 0))
-		!= NULL) {
-
+			!= NULL) {
 		r->start = MV64x60_IRQ_SDMA_0;
 		r->end = MV64x60_IRQ_SDMA_0;
 	}
 #endif
-
-	return;
 }
 
 /*
@@ -1945,8 +1920,6 @@
 		mv64360_reg_addrs[bus][window].base_lo_bar,
 		mv64x60_mask(base,20) | 0xc);
 	mv64x60_pci_exclude_bridge = save_exclude;
-
-	return;
 }
 
 /*
@@ -1972,8 +1945,6 @@
 	early_write_config_dword(hose, 0, PCI_DEVFN(0,0),
 		mv64360_offset[bus][1], 0);
 	mv64x60_pci_exclude_bridge = save_exclude;
-
-	return;
 }
 
 /*
@@ -2082,8 +2053,6 @@
 				"32bit table corrupted");
 		}
 	}
-
-	return;
 }
 
 /*
@@ -2139,8 +2108,6 @@
 				"32bit table corrupted");
 		}
 	}
-
-	return;
 }
 
 /*
@@ -2158,8 +2125,7 @@
 		(mv64360_64bit_windows[window].size_reg != 0)) {
 
 		if ((mv64360_64bit_windows[window].extra & MV64x60_EXTRA_MASK)
-			== MV64x60_EXTRA_PCIACC_ENAB)
-
+				== MV64x60_EXTRA_PCIACC_ENAB)
 			mv64x60_set_bits(bh,
 				mv64360_64bit_windows[window].base_lo_reg,
 				(1 << (mv64360_64bit_windows[window].extra &
@@ -2168,8 +2134,6 @@
 			printk(KERN_ERR "mv64360_enable: %s\n",
 				"64bit table corrupted");
 	}
-
-	return;
 }
 
 /*
@@ -2186,11 +2150,9 @@
 		mv64360_64bit_windows[window].size_reg);
 
 	if ((mv64360_64bit_windows[window].base_lo_reg != 0) &&
-		(mv64360_64bit_windows[window].size_reg != 0)) {
-
+			(mv64360_64bit_windows[window].size_reg != 0)) {
 		if ((mv64360_64bit_windows[window].extra & MV64x60_EXTRA_MASK)
-			== MV64x60_EXTRA_PCIACC_ENAB)
-
+				== MV64x60_EXTRA_PCIACC_ENAB)
 			mv64x60_clr_bits(bh,
 				mv64360_64bit_windows[window].base_lo_reg,
 				(1 << (mv64360_64bit_windows[window].extra &
@@ -2199,8 +2161,6 @@
 			printk(KERN_ERR "mv64360_disable: %s\n",
 				"64bit table corrupted");
 	}
-
-	return;
 }
 
 /*
@@ -2241,8 +2201,6 @@
 	/* Disable all PCI-><whatever> windows */
 	mv64x60_set_bits(bh, MV64x60_PCI0_BAR_ENABLE, 0x0000f9ff);
 	mv64x60_set_bits(bh, MV64x60_PCI1_BAR_ENABLE, 0x0000f9ff);
-
-	return;
 }
 
 /*
@@ -2335,8 +2293,6 @@
 			mv64x60_set_bits(bh, MV64360_IDMA2MEM_ACC_PROT_3,
 				(0x3 << (i << 1)));
 		}
-
-	return;
 }
 
 /*
@@ -2350,42 +2306,145 @@
 mv64360_set_mpsc2regs_window(struct mv64x60_handle *bh, u32 base)
 {
 	pr_debug("set mpsc->internal regs, base: 0x%x\n", base);
-
 	mv64x60_write(bh, MV64360_MPSC2REGS_BASE, base & 0xffff0000);
-	return;
 }
 
 /*
  * mv64360_chip_specific_init()
  *
- * No errata work arounds for the MV64360 implemented at this point.
+ * Implement errata work arounds for the MV64360.
  */
 static void __init
 mv64360_chip_specific_init(struct mv64x60_handle *bh,
 	struct mv64x60_setup_info *si)
 {
+#if !defined(CONFIG_NOT_COHERENT_CACHE)
+	mv64x60_set_bits(bh, MV64360_D_UNIT_CONTROL_HIGH, (1<<24));
+#endif
 #ifdef CONFIG_SERIAL_MPSC
 	mv64x60_mpsc0_pdata.brg_can_tune = 1;
 	mv64x60_mpsc0_pdata.cache_mgmt = 1;
 	mv64x60_mpsc1_pdata.brg_can_tune = 1;
 	mv64x60_mpsc1_pdata.cache_mgmt = 1;
 #endif
-
-	return;
 }
 
 /*
  * mv64460_chip_specific_init()
  *
- * No errata work arounds for the MV64460 implemented at this point.
+ * Implement errata work arounds for the MV64460.
  */
 static void __init
 mv64460_chip_specific_init(struct mv64x60_handle *bh,
 	struct mv64x60_setup_info *si)
 {
+#if !defined(CONFIG_NOT_COHERENT_CACHE)
+	mv64x60_set_bits(bh, MV64360_D_UNIT_CONTROL_HIGH, (1<<24) | (1<<25));
+	mv64x60_set_bits(bh, MV64460_D_UNIT_MMASK, (1<<1) | (1<<4));
+#endif
 #ifdef CONFIG_SERIAL_MPSC
 	mv64x60_mpsc0_pdata.brg_can_tune = 1;
+	mv64x60_mpsc0_pdata.cache_mgmt = 1;
 	mv64x60_mpsc1_pdata.brg_can_tune = 1;
+	mv64x60_mpsc1_pdata.cache_mgmt = 1;
 #endif
-	return;
 }
+
+
+#if defined(CONFIG_SYSFS) && !defined(CONFIG_GT64260)
+/* Export the hotswap register via sysfs for enum event monitoring */
+#define	VAL_LEN_MAX	11 /* 32-bit hex or dec stringified number + '\n' */
+
+DECLARE_MUTEX(mv64xxx_hs_lock);
+
+static ssize_t
+mv64xxx_hs_reg_read(struct kobject *kobj, char *buf, loff_t off, size_t count)
+{
+	u32	v;
+	u8	save_exclude;
+
+	if (off > 0)
+		return 0;
+	if (count < VAL_LEN_MAX)
+		return -EINVAL;
+
+	if (down_interruptible(&mv64xxx_hs_lock))
+		return -ERESTARTSYS;
+	save_exclude = mv64x60_pci_exclude_bridge;
+	mv64x60_pci_exclude_bridge = 0;
+	early_read_config_dword(&sysfs_hose_a, 0, PCI_DEVFN(0, 0),
+			MV64360_PCICFG_CPCI_HOTSWAP, &v);
+	mv64x60_pci_exclude_bridge = save_exclude;
+	up(&mv64xxx_hs_lock);
+
+	return sprintf(buf, "0x%08x\n", v);
+}
+
+static ssize_t
+mv64xxx_hs_reg_write(struct kobject *kobj, char *buf, loff_t off, size_t count)
+{
+	u32	v;
+	u8	save_exclude;
+
+	if (off > 0)
+		return 0;
+	if (count <= 0)
+		return -EINVAL;
+
+	if (sscanf(buf, "%i", &v) == 1) {
+		if (down_interruptible(&mv64xxx_hs_lock))
+			return -ERESTARTSYS;
+		save_exclude = mv64x60_pci_exclude_bridge;
+		mv64x60_pci_exclude_bridge = 0;
+		early_write_config_dword(&sysfs_hose_a, 0, PCI_DEVFN(0, 0),
+				MV64360_PCICFG_CPCI_HOTSWAP, v);
+		mv64x60_pci_exclude_bridge = save_exclude;
+		up(&mv64xxx_hs_lock);
+	}
+	else
+		count = -EINVAL;
+
+	return count;
+}
+
+static struct bin_attribute mv64xxx_hs_reg_attr = { /* Hotswap register */
+	.attr = {
+		.name = "hs_reg",
+		.mode = S_IRUGO | S_IWUSR,
+		.owner = THIS_MODULE,
+	},
+	.size  = VAL_LEN_MAX,
+	.read  = mv64xxx_hs_reg_read,
+	.write = mv64xxx_hs_reg_write,
+};
+
+/* Provide sysfs file indicating if this platform supports the hs_reg */
+static ssize_t
+mv64xxx_hs_reg_valid_show(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	struct platform_device	*pdev;
+	struct mv64xxx_pdata	*pdp;
+	u32			v;
+
+	pdev = container_of(dev, struct platform_device, dev);
+	pdp = (struct mv64xxx_pdata *)pdev->dev.platform_data;
+
+	if (down_interruptible(&mv64xxx_hs_lock))
+		return -ERESTARTSYS;
+	v = pdp->hs_reg_valid;
+	up(&mv64xxx_hs_lock);
+
+	return sprintf(buf, "%i\n", v);
+}
+static DEVICE_ATTR(hs_reg_valid, S_IRUGO, mv64xxx_hs_reg_valid_show, NULL);
+
+static int __init
+mv64xxx_sysfs_init(void)
+{
+	sysfs_create_bin_file(&mv64xxx_device.dev.kobj, &mv64xxx_hs_reg_attr);
+	sysfs_create_file(&mv64xxx_device.dev.kobj,&dev_attr_hs_reg_valid.attr);
+	return 0;
+}
+subsys_initcall(mv64xxx_sysfs_init);
+#endif
diff -Nur linux-2.6.13-mm1/include/asm-ppc/mv64x60_defs.h linux-2.6.13-mm1-mag/include/asm-ppc/mv64x60_defs.h
--- linux-2.6.13-mm1/include/asm-ppc/mv64x60_defs.h	2005-08-28 16:41:01.000000000 -0700
+++ linux-2.6.13-mm1-mag/include/asm-ppc/mv64x60_defs.h	2005-09-01 16:56:42.000000000 -0700
@@ -333,7 +333,7 @@
 /*
  *****************************************************************************
  *
- *	SRAM Cotnroller Registers
+ *	SRAM Controller Registers
  *
  *****************************************************************************
  */
@@ -352,7 +352,7 @@
 /*
  *****************************************************************************
  *
- *	SDRAM/MEM Cotnroller Registers
+ *	SDRAM/MEM Controller Registers
  *
  *****************************************************************************
  */
@@ -375,6 +375,7 @@
 /* SDRAM Control Registers */
 #define MV64360_D_UNIT_CONTROL_LOW		0x1404
 #define MV64360_D_UNIT_CONTROL_HIGH		0x1424
+#define MV64460_D_UNIT_MMASK			0x14b0
 
 /* SDRAM Error Report Registers (64360) */
 #define	MV64360_SDRAM_ERR_DATA_LO		0x1444
@@ -388,7 +389,7 @@
 /*
  *****************************************************************************
  *
- *	Device/BOOT Cotnroller Registers
+ *	Device/BOOT Controller Registers
  *
  *****************************************************************************
  */
@@ -680,6 +681,8 @@
 #define	MV64x60_PCI1_SLAVE_P2P_IO_REMAP		0x0dec
 #define	MV64x60_PCI1_SLAVE_CPU_REMAP		0x0df0
 
+#define	MV64360_PCICFG_CPCI_HOTSWAP		0x68
+
 /*
  *****************************************************************************
  *
diff -Nur linux-2.6.13-mm1/include/asm-ppc/mv64x60.h linux-2.6.13-mm1-mag/include/asm-ppc/mv64x60.h
--- linux-2.6.13-mm1/include/asm-ppc/mv64x60.h	2005-09-01 16:26:46.000000000 -0700
+++ linux-2.6.13-mm1-mag/include/asm-ppc/mv64x60.h	2005-09-01 16:56:42.000000000 -0700
@@ -286,6 +286,13 @@
 #define	mv64x60_set_bits(bh, offs, bits) mv64x60_modify(bh, offs, ~0, bits)
 #define	mv64x60_clr_bits(bh, offs, bits) mv64x60_modify(bh, offs, 0, bits)
 
+#if defined(CONFIG_SYSFS) && !defined(CONFIG_GT64260)
+#define	MV64XXX_DEV_NAME	"mv64xxx"
+
+struct mv64xxx_pdata {
+	u32	hs_reg_valid;
+};
+#endif
 
 /* Externally visible function prototypes */
 int mv64x60_init(struct mv64x60_handle *bh, struct mv64x60_setup_info *si);
diff -Nur linux-2.6.13-mm1/include/linux/mv643xx.h linux-2.6.13-mm1-mag/include/linux/mv643xx.h
--- linux-2.6.13-mm1/include/linux/mv643xx.h	2005-08-28 16:41:01.000000000 -0700
+++ linux-2.6.13-mm1-mag/include/linux/mv643xx.h	2005-09-01 16:56:42.000000000 -0700
@@ -980,7 +980,7 @@
 /* I2C Registers                        */
 /****************************************/
 
-#define MV64XXX_I2C_CTLR_NAME					"mv64xxx i2c"
+#define MV64XXX_I2C_CTLR_NAME					"mv64xxx_i2c"
 #define MV64XXX_I2C_OFFSET                                          0xc000
 #define MV64XXX_I2C_REG_BLOCK_SIZE                                  0x0020
 
