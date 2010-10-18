Return-Path: <Bo.Liu@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.windriver.com",
	Issuer "Intel External Basic Issuing CA 3A" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 6C5D2B70EC
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 18 Oct 2010 19:23:44 +1100 (EST)
Message-ID: <4CBC04E8.5030706@windriver.com>
Date: Mon, 18 Oct 2010 16:27:20 +0800
From: Tonyliu <Bo.Liu@windriver.com>
MIME-Version: 1.0
To: Maria Johansen <m.johansen@no.parkairsystems.com>
Subject: Re: eSDHC controller driver on MPC8308rdb
References: <DF61B4AD1C20A54EADF5C05E1F1110DE08D449@Exchange.parkairsystems.net>
In-Reply-To: <DF61B4AD1C20A54EADF5C05E1F1110DE08D449@Exchange.parkairsystems.net>
Content-Type: multipart/mixed; boundary="------------070204040306030104080800"
Cc: linuxppc-dev@lists.ozlabs.org
Reply-To: Bo.Liu@windriver.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------070204040306030104080800
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Maria Johansen wrote:
> Hello,
> (apologies for writing such a long e-mail, hope you can bother to read it all ☺ )
> I have some difficulties with the eSDHC controller driver used on a MPC8308 evaluation board with kernel 2.6.36-rc7, and hope that some of you may be able to help me with the debugging. 
>
> The driver is loaded properly, and binds to the eSDHC controller without problems. When inserting a sd-card it is bound to the  mmcblk-driver, so no problems there either.  
>
> However, I am not able to read nor write to the card, I have attached output with error messages below:
>
> **********************************************************
> mmc0: new SDHC card at address 9155
> mmcblk0: mmc0:9155 SD04G 3.69 GiB
> mmc0: Too large timeout requested!
> mmcblk0: retrying using single block read
> mmc0: Too large timeout requested!
> mmcblk0: error -84 sending status comand
> mmcblk0: error -110 sending read/write command, response 0x0, card status 0x0
> end_request: I/O error, dev mmcblk0, sector 0
> mmc0: Too large timeout requested!
> mmcblk0: error -84 sending status comand
> mmcblk0: error -110 sending read/write command, response 0x0, card status 0x0
> end_request: I/O error, dev mmcblk0, sector 1
> …..<this continues up to sector 7 before starting anew>
>
> Debug output with no SD-card:
> **********************************************************
> mmc0: clock 0Hz busmode 1 powermode 1 cs 0 Vdd 20 width 0 timing 0
> mmc0: clock 400000Hz busmode 1 powermode 2 cs 0 Vdd 20 width 0 timing 0
> of:sdhci-of e002e000.sdhci: desired SD clock: 400000, actual: 0
> mmc0: starting CMD52 arg 00000c00 flags 00000195
> sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00010001
> mmc0: req done (CMD52): -110: 00000000 00000000 00000000 00000000
> mmc0: starting CMD52 arg 80000c08 flags 00000195
> sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00010001
> mmc0: req done (CMD52): -110: 00000000 00000000 00000000 00000000
> mmc0: clock 400000Hz busmode 1 powermode 2 cs 1 Vdd 20 width 0 timing 0
> mmc0: starting CMD0 arg 00000000 flags 000000c0
> sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
> mmc0: req done (CMD0): 0: 00000000 00000000 00000000 00000000
> mmc0: clock 400000Hz busmode 1 powermode 2 cs 0 Vdd 20 width 0 timing 0
> mmc0: starting CMD8 arg 000001aa flags 000002f5
> sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00010001
> mmc0: req done (CMD8): -110: 00000000 00000000 00000000 00000000
> mmc0: starting CMD5 arg 00000000 flags 000002e1
> sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00010001
> mmc0: req failed (CMD5): -110, retrying...
> sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00010001
> mmc0: req failed (CMD5): -110, retrying...
> sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00010001
> mmc0: req failed (CMD5): -110, retrying...
> …
>
> I have the following in my dts:
>        sdhci@2e000 {
> 		compatible = "fsl,mpc8308-esdhc", "fsl,esdhc";
> 		reg = <0x2e000 0x1000>;
> 		interrupts = <42 0x8>;
> 		interrupt-parent = <&ipic>;
> 		clock-frequency = <0>;
> 	};
>
>
> Could this be a problem related the eSDHC controller (or the driver), or is it the memory card? (a 4GB SanDisk Extreme SDHC card, which unfortunately is the only card I have available at the moment.)
> I will keep digging into drivers/mmc/host/sdhci.c in search of a solution, and any tips to how I should proceed would be greatly appreciated!
>   
Hi,
Try the patch in attatchment. By default, on some e300 platforms such as 
mpc8308_rdb, the entry "clock-frequency" of section sdchi in DTB is not 
fixed by u-boot, so has to caculate the input clock for sdhci controller 
explicitly in driver.

Tony
> --
> Maria 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev


-- 
Tony Liu | Liu Bo
-------------------------------------------------------------
WIND RIVER | China Development Center
Tel: 86-10-8477-8542 ext: 8542 |  Fax: 86-10-64790367
(M): 86-136-7117-3612
Address: 15/F, Wangjing TowerB, Chaoyang District, Beijing, P.R.China




--------------070204040306030104080800
Content-Type: text/x-patch;
 name="0001-esdhci-fix-clock-frequency-for-e300.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="0001-esdhci-fix-clock-frequency-for-e300.patch"

>From 02dcd667389aa5143a43d245ac5ecc1559a956ed Mon Sep 17 00:00:00 2001
From: Tonyliu <Bo.Liu@windriver.com>
Date: Mon, 18 Oct 2010 16:24:21 +0800
Subject: [PATCH] esdhci: fix clock-frequency for e300

The DTB clock-frequency property of esdhci is not fixed in u-boot by default for most
e300 platforms.So has to caculate the input clock frequency explicitly from CPU's
bus-frequency property.

Signed-off-by: Tonyliu <Bo.Liu@windriver.com>
---
 drivers/mmc/host/sdhci-of-core.c |   43 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 43 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-core.c b/drivers/mmc/host/sdhci-of-core.c
index c51b711..2a1ef0b 100644
--- a/drivers/mmc/host/sdhci-of-core.c
+++ b/drivers/mmc/host/sdhci-of-core.c
@@ -167,6 +167,49 @@ static int __devinit sdhci_of_probe(struct platform_device *ofdev,
 	clk = of_get_property(np, "clock-frequency", &size);
 	if (clk && size == sizeof(*clk) && *clk)
 		of_host->clock = *clk;
+	else {
+		/* clock frequency of peripherals maybe not fixed by u-boot
+		 * on some platforms, then need to find proper clock of
+		 * SDHCI controller by CPU's bus frequency.*/
+		struct device_node *cpu;
+
+		cpu = of_find_node_by_type(NULL, "cpu");
+		if (cpu) {
+			unsigned int size;
+			const u32 *prop = of_get_property(cpu, "bus-frequency", &size);
+			of_host->clock = *prop;
+			of_node_put(cpu);
+		} else {
+			ret = -EINVAL;
+			goto err_bad_freq;
+		}
+
+		/*
+		 * SDHCI input clock can be scaled against platform bus frequency.
+		 */
+		if (of_get_property(np, "sdhci,clk-scale", NULL)) {
+			void __iomem *immap = NULL;
+			unsigned int sdhccm;
+
+			immap = ioremap(get_immrbase(), 0x1000);
+			if (!immap) {
+				ret = -ENOMEM;
+				goto err_bad_freq;
+			}
+
+			sdhccm = (in_be32(immap + SDHCI_SCCR_OFFS) & SDHCI_SDHCCM_MASK)
+				>> SDHCI_SDHCCM_SHIFT;
+
+			iounmap(immap);
+
+			if (sdhccm == 0) {
+				printk(KERN_ERR "The eSDHC clock was disable!\n");
+				ret = -EBADSLT;
+				goto err_bad_freq;
+			} else
+                of_host->clock /= sdhccm;
+		}
+	}
 
 	ret = sdhci_add_host(host);
 	if (ret)
-- 
1.6.0.4


--------------070204040306030104080800--
