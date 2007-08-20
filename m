Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 499F0DDEB7
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Aug 2007 02:36:30 +1000 (EST)
Date: Mon, 20 Aug 2007 11:36:19 -0500
From: Scott Wood <scottwood@freescale.com>
To: paulus@samba.org
Subject: [PATCH 1/4] Whitespace cleanup in arch/powerpc.
Message-ID: <20070820163619.GA29889@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/boot/dts/mpc8272ads.dts    |  376 ++++++++++++++++---------------
 arch/powerpc/kernel/irq.c               |    4 +-
 arch/powerpc/platforms/8xx/m8xx_setup.c |   72 +++---
 arch/powerpc/sysdev/commproc.c          |   20 +-
 arch/powerpc/sysdev/cpm2_common.c       |    2 +-
 5 files changed, 238 insertions(+), 236 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8272ads.dts b/arch/powerpc/boot/dts/mpc8272ads.dts
index 1934b80..4d09dca 100644
--- a/arch/powerpc/boot/dts/mpc8272ads.dts
+++ b/arch/powerpc/boot/dts/mpc8272ads.dts
@@ -10,207 +10,209 @@
  */
 
 / {
-       model = "MPC8272ADS";
-       compatible = "MPC8260ADS";
-       #address-cells = <1>;
-       #size-cells = <1>;
-
-       cpus {
-               #address-cells = <1>;
-               #size-cells = <0>;
-
-               PowerPC,8272@0 {
-                       device_type = "cpu";
-                       reg = <0>;
-                       d-cache-line-size = <20>;       // 32 bytes
-                       i-cache-line-size = <20>;       // 32 bytes
-                       d-cache-size = <4000>;          // L1, 16K
-                       i-cache-size = <4000>;          // L1, 16K
-                       timebase-frequency = <0>;
-                       bus-frequency = <0>;
-                       clock-frequency = <0>;
-                       32-bit;
-               };
-       };
-
-		pci_pic: interrupt-controller@f8200000 {
-               #address-cells = <0>;
-               #interrupt-cells = <2>;
-               interrupt-controller;
-               reg = <f8200000 f8200004>;
-               built-in;
-               device_type = "pci-pic";
-       };
-       memory {
-               device_type = "memory";
-               reg = <00000000 4000000 f4500000 00000020>;
-       };
-
-       chosen {
-               name = "chosen";
-               linux,platform = <0>;
+	model = "MPC8272ADS";
+	compatible = "MPC8260ADS";
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		PowerPC,8272@0 {
+			device_type = "cpu";
+			reg = <0>;
+			d-cache-line-size = <20>;       // 32 bytes
+			i-cache-line-size = <20>;       // 32 bytes
+			d-cache-size = <4000>;          // L1, 16K
+			i-cache-size = <4000>;          // L1, 16K
+			timebase-frequency = <0>;
+			bus-frequency = <0>;
+			clock-frequency = <0>;
+			32-bit;
+		};
+	};
+
+	pci_pic: interrupt-controller@f8200000 {
+		#address-cells = <0>;
+		#interrupt-cells = <2>;
+		interrupt-controller;
+		reg = <f8200000 f8200004>;
+		built-in;
+		device_type = "pci-pic";
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <00000000 4000000 f4500000 00000020>;
+	};
+
+	chosen {
+		name = "chosen";
+		linux,platform = <0>;
 		interrupt-controller = <&Cpm_pic>;
-       };
-
-       soc8272@f0000000 {
-               #address-cells = <1>;
-               #size-cells = <1>;
-               #interrupt-cells = <2>;
-               device_type = "soc";
-               ranges = <00000000 f0000000 00053000>;
-               reg = <f0000000 10000>;
-
-               mdio@0 {
-                       device_type = "mdio";
-                       compatible = "fs_enet";
-                       reg = <0 0>;
-                       #address-cells = <1>;
-                       #size-cells = <0>;
+	};
+
+	soc8272@f0000000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		#interrupt-cells = <2>;
+		device_type = "soc";
+		ranges = <00000000 f0000000 00053000>;
+		reg = <f0000000 10000>;
+
+		mdio@0 {
+			device_type = "mdio";
+			compatible = "fs_enet";
+			reg = <0 0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
 			phy0:ethernet-phy@0 {
 				interrupt-parent = <&Cpm_pic>;
-                               interrupts = <17 4>;
-                               reg = <0>;
-                               bitbang = [ 12 12 13 02 02 01 ];
-                               device_type = "ethernet-phy";
-                       };
+				interrupts = <17 4>;
+				reg = <0>;
+				bitbang = [ 12 12 13 02 02 01 ];
+				device_type = "ethernet-phy";
+			};
+
 			phy1:ethernet-phy@1 {
 				interrupt-parent = <&Cpm_pic>;
-                               interrupts = <17 4>;
-                               bitbang = [ 12 12 13 02 02 01 ];
-                               reg = <3>;
-                               device_type = "ethernet-phy";
-                       };
-               };
-
-               ethernet@24000 {
-                       #address-cells = <1>;
-                       #size-cells = <0>;
-                       device_type = "network";
-                       device-id = <1>;
-                       compatible = "fs_enet";
-                       model = "FCC";
-                       reg = <11300 20 8400 100 11380 30>;
-                       mac-address = [ 00 11 2F 99 43 54 ];
-                       interrupts = <20 2>;
+				interrupts = <17 4>;
+				bitbang = [ 12 12 13 02 02 01 ];
+				reg = <3>;
+				device_type = "ethernet-phy";
+			};
+		};
+
+		ethernet@24000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			device_type = "network";
+			device-id = <1>;
+			compatible = "fs_enet";
+			model = "FCC";
+			reg = <11300 20 8400 100 11380 30>;
+			mac-address = [ 00 11 2F 99 43 54 ];
+			interrupts = <20 2>;
 			interrupt-parent = <&Cpm_pic>;
 			phy-handle = <&Phy0>;
-                       rx-clock = <13>;
-                       tx-clock = <12>;
-               };
-
-               ethernet@25000 {
-                       device_type = "network";
-                       device-id = <2>;
-                       compatible = "fs_enet";
-                       model = "FCC";
-                       reg = <11320 20 8500 100 113b0 30>;
-                       mac-address = [ 00 11 2F 99 44 54 ];
-                       interrupts = <21 2>;
+			rx-clock = <13>;
+			tx-clock = <12>;
+		};
+
+		ethernet@25000 {
+			device_type = "network";
+			device-id = <2>;
+			compatible = "fs_enet";
+			model = "FCC";
+			reg = <11320 20 8500 100 113b0 30>;
+			mac-address = [ 00 11 2F 99 44 54 ];
+			interrupts = <21 2>;
 			interrupt-parent = <&Cpm_pic>;
 			phy-handle = <&Phy1>;
-                       rx-clock = <17>;
-                       tx-clock = <18>;
-               };
-
-               cpm@f0000000 {
-                       #address-cells = <1>;
-                       #size-cells = <1>;
-                       #interrupt-cells = <2>;
-                       device_type = "cpm";
-                       model = "CPM2";
-                       ranges = <00000000 00000000 20000>;
-                       reg = <0 20000>;
-                       command-proc = <119c0>;
-                       brg-frequency = <17D7840>;
-                       cpm_clk = <BEBC200>;
-
-                       scc@11a00 {
-                               device_type = "serial";
-                               compatible = "cpm_uart";
-                               model = "SCC";
-                               device-id = <1>;
-                               reg = <11a00 20 8000 100>;
-                               current-speed = <1c200>;
-                               interrupts = <28 2>;
+			rx-clock = <17>;
+			tx-clock = <18>;
+		};
+
+		cpm@f0000000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			#interrupt-cells = <2>;
+			device_type = "cpm";
+			model = "CPM2";
+			ranges = <00000000 00000000 20000>;
+			reg = <0 20000>;
+			command-proc = <119c0>;
+			brg-frequency = <17D7840>;
+			cpm_clk = <BEBC200>;
+
+			scc@11a00 {
+				device_type = "serial";
+				compatible = "cpm_uart";
+				model = "SCC";
+				device-id = <1>;
+				reg = <11a00 20 8000 100>;
+				current-speed = <1c200>;
+				interrupts = <28 2>;
 				interrupt-parent = <&Cpm_pic>;
-                               clock-setup = <0 00ffffff>;
-                               rx-clock = <1>;
-                               tx-clock = <1>;
-                       };
-
-                       scc@11a60 {
-                               device_type = "serial";
-                               compatible = "cpm_uart";
-                               model = "SCC";
-                               device-id = <4>;
-                               reg = <11a60 20 8300 100>;
-                               current-speed = <1c200>;
-                               interrupts = <2b 2>;
+				clock-setup = <0 00ffffff>;
+				rx-clock = <1>;
+				tx-clock = <1>;
+			};
+
+			scc@11a60 {
+				device_type = "serial";
+				compatible = "cpm_uart";
+				model = "SCC";
+				device-id = <4>;
+				reg = <11a60 20 8300 100>;
+				current-speed = <1c200>;
+				interrupts = <2b 2>;
 				interrupt-parent = <&Cpm_pic>;
-                               clock-setup = <1b ffffff00>;
-                               rx-clock = <4>;
-                               tx-clock = <4>;
-                       };
-
-               };
-			cpm_pic:interrupt-controller@10c00 {
-                       #address-cells = <0>;
-                       #interrupt-cells = <2>;
-                       interrupt-controller;
-                       reg = <10c00 80>;
-                       built-in;
-                       device_type = "cpm-pic";
-		       compatible = "CPM2";
-               };
-               pci@0500 {
-                       #interrupt-cells = <1>;
-                       #size-cells = <2>;
-                       #address-cells = <3>;
-                       compatible = "8272";
-                       device_type = "pci";
-                       reg = <10430 4dc>;
-                       clock-frequency = <3f940aa>;
-                       interrupt-map-mask = <f800 0 0 7>;
-                       interrupt-map = <
-
-                                       /* IDSEL 0x16 */
-                                        b000 0 0 1 f8200000 40 8
-                                        b000 0 0 2 f8200000 41 8
-                                        b000 0 0 3 f8200000 42 8
-                                        b000 0 0 4 f8200000 43 8
-
-                                       /* IDSEL 0x17 */
-                                        b800 0 0 1 f8200000 43 8
-                                        b800 0 0 2 f8200000 40 8
-                                        b800 0 0 3 f8200000 41 8
-                                        b800 0 0 4 f8200000 42 8
-
-                                       /* IDSEL 0x18 */
-                                        c000 0 0 1 f8200000 42 8
-                                        c000 0 0 2 f8200000 43 8
-                                        c000 0 0 3 f8200000 40 8
-                                        c000 0 0 4 f8200000 41 8>;
+				clock-setup = <1b ffffff00>;
+				rx-clock = <4>;
+				tx-clock = <4>;
+			};
+		};
+
+		cpm_pic:interrupt-controller@10c00 {
+			#address-cells = <0>;
+			#interrupt-cells = <2>;
+			interrupt-controller;
+			reg = <10c00 80>;
+			built-in;
+			device_type = "cpm-pic";
+			compatible = "CPM2";
+		};
+
+		pci@0500 {
+			#interrupt-cells = <1>;
+			#size-cells = <2>;
+			#address-cells = <3>;
+			compatible = "8272";
+			device_type = "pci";
+			reg = <10430 4dc>;
+			clock-frequency = <3f940aa>;
+			interrupt-map-mask = <f800 0 0 7>;
+			interrupt-map = <
+			                /* IDSEL 0x16 */
+			                 b000 0 0 1 f8200000 40 8
+			                 b000 0 0 2 f8200000 41 8
+			                 b000 0 0 3 f8200000 42 8
+			                 b000 0 0 4 f8200000 43 8
+
+			                /* IDSEL 0x17 */
+			                 b800 0 0 1 f8200000 43 8
+			                 b800 0 0 2 f8200000 40 8
+			                 b800 0 0 3 f8200000 41 8
+			                 b800 0 0 4 f8200000 42 8
+
+			                /* IDSEL 0x18 */
+			                 c000 0 0 1 f8200000 42 8
+			                 c000 0 0 2 f8200000 43 8
+			                 c000 0 0 3 f8200000 40 8
+			                 c000 0 0 4 f8200000 41 8>;
 			interrupt-parent = <&Cpm_pic>;
-                       interrupts = <14 8>;
-                       bus-range = <0 0>;
-                       ranges = <02000000 0 80000000 80000000 0 40000000
-                                 01000000 0 00000000 f6000000 0 02000000>;
-               };
+			interrupts = <14 8>;
+			bus-range = <0 0>;
+			ranges = <02000000 0 80000000 80000000 0 40000000
+			          01000000 0 00000000 f6000000 0 02000000>;
+		};
 
 /* May need to remove if on a part without crypto engine */
-               crypto@30000 {
-                       device_type = "crypto";
-                       model = "SEC2";
-                       compatible = "talitos";
-                       reg = <30000 10000>;
-                       interrupts = <b 2>;
+		crypto@30000 {
+			device_type = "crypto";
+			model = "SEC2";
+			compatible = "talitos";
+			reg = <30000 10000>;
+			interrupts = <b 2>;
 			interrupt-parent = <&Cpm_pic>;
-                       num-channels = <4>;
-                       channel-fifo-len = <18>;
-                       exec-units-mask = <0000007e>;
+			num-channels = <4>;
+			channel-fifo-len = <18>;
+			exec-units-mask = <0000007e>;
 /* desc mask is for rev1.x, we need runtime fixup for >=2.x */
-                       descriptor-types-mask = <01010ebf>;
-               };
-
-       };
+			descriptor-types-mask = <01010ebf>;
+		};
+	};
 };
diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 24bea97..dfad0e4 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -272,7 +272,7 @@ void do_IRQ(struct pt_regs *regs)
 	struct thread_info *curtp, *irqtp;
 #endif
 
-        irq_enter();
+	irq_enter();
 
 #ifdef CONFIG_DEBUG_STACKOVERFLOW
 	/* Debugging check for stack overflow: is there less than 2KB free? */
@@ -321,7 +321,7 @@ void do_IRQ(struct pt_regs *regs)
 		/* That's not SMP safe ... but who cares ? */
 		ppc_spurious_interrupts++;
 
-        irq_exit();
+	irq_exit();
 	set_irq_regs(old_regs);
 
 #ifdef CONFIG_PPC_ISERIES
diff --git a/arch/powerpc/platforms/8xx/m8xx_setup.c b/arch/powerpc/platforms/8xx/m8xx_setup.c
index f169355..601b389 100644
--- a/arch/powerpc/platforms/8xx/m8xx_setup.c
+++ b/arch/powerpc/platforms/8xx/m8xx_setup.c
@@ -89,24 +89,24 @@ init_internal_rtc(void)
 
 static int __init get_freq(char *name, unsigned long *val)
 {
-        struct device_node *cpu;
-        const unsigned int *fp;
-        int found = 0;
+	struct device_node *cpu;
+	const unsigned int *fp;
+	int found = 0;
 
-        /* The cpu node should have timebase and clock frequency properties */
-        cpu = of_find_node_by_type(NULL, "cpu");
+	/* The cpu node should have timebase and clock frequency properties */
+	cpu = of_find_node_by_type(NULL, "cpu");
 
-        if (cpu) {
-                fp = of_get_property(cpu, name, NULL);
-                if (fp) {
-                        found = 1;
-                        *val = *fp;
-                }
+	if (cpu) {
+		fp = of_get_property(cpu, name, NULL);
+		if (fp) {
+			found = 1;
+			*val = *fp;
+		}
 
-                of_node_put(cpu);
-        }
+		of_node_put(cpu);
+	}
 
-        return found;
+	return found;
 }
 
 /* The decrementer counts at the system (internal) clock frequency divided by
@@ -122,7 +122,7 @@ void __init mpc8xx_calibrate_decr(void)
 	sit8xx_t *sys_tmr2;
 	int irq, virq;
 
-        clk_r1 = (cark8xx_t *) immr_map(im_clkrstk);
+	clk_r1 = (cark8xx_t *) immr_map(im_clkrstk);
 
 	/* Unlock the SCCR. */
 	out_be32(&clk_r1->cark_sccrk, ~KAPWR_KEY);
@@ -130,24 +130,24 @@ void __init mpc8xx_calibrate_decr(void)
 	immr_unmap(clk_r1);
 
 	/* Force all 8xx processors to use divide by 16 processor clock. */
-        clk_r2 = (car8xx_t *) immr_map(im_clkrst);
+	clk_r2 = (car8xx_t *) immr_map(im_clkrst);
 	setbits32(&clk_r2->car_sccr, 0x02000000);
 	immr_unmap(clk_r2);
 
 	/* Processor frequency is MHz.
 	 */
-        ppc_tb_freq = 50000000;
-        if (!get_freq("bus-frequency", &ppc_tb_freq)) {
-                printk(KERN_ERR "WARNING: Estimating decrementer frequency "
-                                "(not found)\n");
-        }
-        ppc_tb_freq /= 16;
-        ppc_proc_freq = 50000000;
-        if (!get_freq("clock-frequency", &ppc_proc_freq))
-                printk(KERN_ERR "WARNING: Estimating processor frequency"
-                                "(not found)\n");
-
-        printk("Decrementer Frequency = 0x%lx\n", ppc_tb_freq);
+	ppc_tb_freq = 50000000;
+	if (!get_freq("bus-frequency", &ppc_tb_freq)) {
+		printk(KERN_ERR "WARNING: Estimating decrementer frequency "
+		                "(not found)\n");
+	}
+	ppc_tb_freq /= 16;
+	ppc_proc_freq = 50000000;
+	if (!get_freq("clock-frequency", &ppc_proc_freq))
+		printk(KERN_ERR "WARNING: Estimating processor frequency"
+		                "(not found)\n");
+
+	printk("Decrementer Frequency = 0x%lx\n", ppc_tb_freq);
 
 	/* Perform some more timer/timebase initialization.  This used
 	 * to be done elsewhere, but other changes caused it to get
@@ -164,7 +164,7 @@ void __init mpc8xx_calibrate_decr(void)
 	 * we guarantee the registers are locked, then we unlock them
 	 * for our use.
 	 */
-        sys_tmr1 = (sitk8xx_t *) immr_map(im_sitk);
+	sys_tmr1 = (sitk8xx_t *) immr_map(im_sitk);
 	out_be32(&sys_tmr1->sitk_tbscrk, ~KAPWR_KEY);
 	out_be32(&sys_tmr1->sitk_rtcsck, ~KAPWR_KEY);
 	out_be32(&sys_tmr1->sitk_tbk, ~KAPWR_KEY);
@@ -180,8 +180,8 @@ void __init mpc8xx_calibrate_decr(void)
 	 * we have to enable the timebase).  The decrementer interrupt
 	 * is wired into the vector table, nothing to do here for that.
 	 */
-        cpu = of_find_node_by_type(NULL, "cpu");
-        virq= irq_of_parse_and_map(cpu, 0);
+	cpu = of_find_node_by_type(NULL, "cpu");
+	virq= irq_of_parse_and_map(cpu, 0);
 	irq = irq_map[virq].hwirq;
 
 	sys_tmr2 = (sit8xx_t *) immr_map(im_sit);
@@ -211,10 +211,10 @@ int mpc8xx_set_rtc_time(struct rtc_time *tm)
 	sit8xx_t *sys_tmr2;
 	int time;
 
-        sys_tmr1 = (sitk8xx_t *) immr_map(im_sitk);
+	sys_tmr1 = (sitk8xx_t *) immr_map(im_sitk);
 	sys_tmr2 = (sit8xx_t *) immr_map(im_sit);
 	time = mktime(tm->tm_year+1900, tm->tm_mon+1, tm->tm_mday,
-                      tm->tm_hour, tm->tm_min, tm->tm_sec);
+	              tm->tm_hour, tm->tm_min, tm->tm_sec);
 
 	out_be32(&sys_tmr1->sitk_rtck, KAPWR_KEY);
 	out_be32(&sys_tmr2->sit_rtc, time);
@@ -233,8 +233,8 @@ void mpc8xx_get_rtc_time(struct rtc_time *tm)
 	/* Get time from the RTC. */
 	data = in_be32(&sys_tmr->sit_rtc);
 	to_tm(data, tm);
-        tm->tm_year -= 1900;
-        tm->tm_mon -= 1;
+	tm->tm_year -= 1900;
+	tm->tm_mon -= 1;
 	immr_unmap(sys_tmr);
 	return;
 }
@@ -298,7 +298,7 @@ void __init m8xx_pic_init(void)
 	int irq;
 
 	if (mpc8xx_pic_init()) {
-                printk(KERN_ERR "Failed interrupt 8xx controller  initialization\n");
+		printk(KERN_ERR "Failed interrupt 8xx controller  initialization\n");
 		return;
 	}
 
diff --git a/arch/powerpc/sysdev/commproc.c b/arch/powerpc/sysdev/commproc.c
index 4f67b89..e8e79f8 100644
--- a/arch/powerpc/sysdev/commproc.c
+++ b/arch/powerpc/sysdev/commproc.c
@@ -45,10 +45,10 @@
 #define CPM_MAP_SIZE    (0x4000)
 
 static void m8xx_cpm_dpinit(void);
-static	uint	host_buffer;	/* One page of host buffer */
-static	uint	host_end;	/* end + 1 */
-cpm8xx_t	*cpmp;		/* Pointer to comm processor space */
-cpic8xx_t	*cpic_reg;
+static uint host_buffer; /* One page of host buffer */
+static uint host_end;    /* end + 1 */
+cpm8xx_t *cpmp;          /* Pointer to comm processor space */
+cpic8xx_t *cpic_reg;
 
 static struct device_node *cpm_pic_node;
 static struct irq_host *cpm_pic_host;
@@ -115,7 +115,7 @@ static int cpm_pic_host_map(struct irq_host *h, unsigned int virq,
  * and return.  This is a no-op function so we don't need any special
  * tests in the interrupt handler.
  */
-static	irqreturn_t cpm_error_interrupt(int irq, void *dev)
+static irqreturn_t cpm_error_interrupt(int irq, void *dev)
 {
 	return IRQ_HANDLED;
 }
@@ -181,7 +181,7 @@ unsigned int cpm_pic_init(void)
 		printk(KERN_ERR "CPM PIC init: can not find cpm node\n");
 		goto end;
 	}
-	eirq= irq_of_parse_and_map(np, 0);
+	eirq = irq_of_parse_and_map(np, 0);
 	if (eirq == NO_IRQ)
 		goto end;
 
@@ -197,15 +197,15 @@ end:
 
 void cpm_reset(void)
 {
-	cpm8xx_t	*commproc;
-	sysconf8xx_t    *siu_conf;
+	cpm8xx_t *commproc;
+	sysconf8xx_t *siu_conf;
 
 	commproc = (cpm8xx_t *)ioremap(CPM_MAP_ADDR, CPM_MAP_SIZE);
 
 #ifdef CONFIG_UCODE_PATCH
 	/* Perform a reset.
 	*/
-	out_be16(&commproc->cp_cpcr,  CPM_CR_RST | CPM_CR_FLG);
+	out_be16(&commproc->cp_cpcr, CPM_CR_RST | CPM_CR_FLG);
 
 	/* Wait for it.
 	*/
@@ -307,7 +307,7 @@ static rh_block_t cpm_boot_dpmem_rh_block[16];
 static rh_info_t cpm_dpmem_info;
 
 #define CPM_DPMEM_ALIGNMENT	8
-static u8* dpram_vbase;
+static u8 *dpram_vbase;
 static uint dpram_pbase;
 
 void m8xx_cpm_dpinit(void)
diff --git a/arch/powerpc/sysdev/cpm2_common.c b/arch/powerpc/sysdev/cpm2_common.c
index 9244129..dbe8d18 100644
--- a/arch/powerpc/sysdev/cpm2_common.c
+++ b/arch/powerpc/sysdev/cpm2_common.c
@@ -201,7 +201,7 @@ int cpm2_clk_setup(enum cpm_clk_target target, int clock, int mode)
 	}
 
 	if (mode == CPM_CLK_RX)
-		shift +=3;
+		shift += 3;
 
 	for (i=0; i<24; i++) {
 		if (clk_map[i][0] == target && clk_map[i][1] == clock) {
-- 
1.5.0.3
