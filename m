Return-Path: <joe@perches.com>
Received: from mail.perches.com (mail.perches.com [173.55.12.10])
	by ozlabs.org (Postfix) with ESMTP id 0FB1FB7ECB
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Jan 2010 08:52:48 +1100 (EST)
Subject: Re: [RFC] [PATCH] watchdog_info separation and constify
From: Joe Perches <joe@perches.com>
To: Wim Van Sebroeck <wim@iguana.be>
In-Reply-To: <20100119211759.GE3804@infomag.iguana.be>
References: <20100119211759.GE3804@infomag.iguana.be>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 19 Jan 2010 13:42:31 -0800
Message-ID: <1263937351.18117.69.camel@Joe-Laptop.home>
Mime-Version: 1.0
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>,
	LKML <linux-kernel@vger.kernel.org>, linuxppc-dev@ozlabs.org,
	uclinux-dist-devel@blackfin.uclinux.org,
	Russell King <rmk+kernel@arm.linux.org.uk>,
	Andrew Morton <akpm@linux-foundation.org>, linux-omap@vger.kernel.org,
	Florian Fainelli <florian@openwrt.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2010-01-19 at 22:17 +0100, Wim Van Sebroeck wrote:
> -static struct watchdog_info at32_wdt_info = {
> +static const struct watchdog_info at32_wdt_info = {

It'd be good to use a consistent structure name:

static const struct watchdog_info ident = {
	etc...
}

$ grep -Poh "struct\s*watchdog_info\s*\w+" *.[ch] | sort | uniq -c | sort -rn
     65 struct watchdog_info ident
      8 struct watchdog_info __user
      4 struct watchdog_info info
      2 struct watchdog_info sh_wdt_info
      2 struct watchdog_info bfin_wdt_info
      2 struct watchdog_info at91_wdt_info
      1 struct watchdog_info zf_info
      1 struct watchdog_info wdinfo
      1 struct watchdog_info twl4030_wd_ident
      1 struct watchdog_info s3c2410_wdt_ident
      1 struct watchdog_info nuc900_wdt_info
      1 struct watchdog_info ks8695_wdt_info
      1 struct watchdog_info bcm47xx_wdt_info
      1 struct watchdog_info at32_wdt_info
      1 struct watchdog_info adx_wdt_info

firmware_version doesn't have to be initialized to 0.

It might be good to standardize .identity to include
either "WDT" or "watchdog" or exclude both of those.

Maybe a standard #define WATCHDOG_NAME <foo>

.identity = WATCHGOD_NAME

$ grep -Poh "\.identity\s*=\s*.*$" *.[ch] | sed -r -e 's/\s+/ /g' | sort 
.identity = "ALi M1535 WatchDog Timer",
.identity = "ALiM7101",
.identity = "at32ap700x watchdog",
.identity = "at91 watchdog",
.identity = "Avionic Design Xanthos Watchdog",
.identity = "Blackfin Watchdog",
.identity = "COH 901 327 Watchdog",
.identity = "CPU5 WDT",
.identity = "DaVinci Watchdog",
.identity = DRIVER_NAME,
.identity = DRIVER_NAME,
.identity = DRIVER_NAME,
.identity = DRV_NAME,
.identity = DRV_NAME,
.identity = DRV_NAME,
.identity = DRV_NAME,
.identity = DRV_NAME,
.identity = "EP93xx Watchdog",
.identity = ESB_MODULE_NAME,
.identity = "Footbridge Watchdog",
.identity = "GE Fanuc watchdog",
.identity = "Hardware Watchdog for PNX833x",
.identity = "Hardware Watchdog for SGI IP22",
.identity = "Hardware Watchdog for TXx9",
.identity = "HP iLO2 HW Watchdog Timer",
.identity = "IB700 WDT",
.identity = "IBM ASR",
.identity = "iop watchdog",
.identity = "IT8712F Watchdog",
.identity = "IXP2000 Watchdog",
.identity = "IXP4xx Watchdog",
.identity = "ks8695 watchdog",
.identity = LONGNAME,
.identity = "MixCOM watchdog",
.identity = "MPC8xxx",
.identity = "MPcore Watchdog",
.identity = "MTX-1 WDT",
.identity = "MV64x60 watchdog",
.identity = "NatSemi SCx200 Watchdog",
.identity = "nuc900 watchdog",
.identity = "OMAP Watchdog",
.identity = "Orion Watchdog",
.identity = "PC87307/PC97307",
.identity = "PC87413(HF/F) watchdog",
.identity = "PCI-WDT500/501",
.identity = "PCWD",
.identity = "PNX4008 Watchdog",
.identity = "PowerPC Book-E Watchdog",
.identity = "RC32434_WDT Watchdog",
.identity = "RDC321x WDT",
.identity = "S3C2410 Watchdog",
.identity = "SA1100/PXA255 Watchdog",
.identity = "SBC60xx",
.identity = "SBC7240",
.identity = "SC520",
.identity = "SH WDT",
.identity = "SiByte Watchdog",
.identity = "SMsC 37B787 Watchdog",
.identity = "Software Watchdog",
.identity = "STMP3XXX Watchdog",
.identity = "TWL4030 Watchdog",
.identity = "W83627HF WDT",
.identity = "W83697HF WDT",
.identity = "W83697UG WDT",
.identity = "W83877F",
.identity = "Wafer 5823 WDT",
.identity = WATCHDOG_DRIVER_NAME,
.identity = WATCHDOG_NAME,
.identity = WATCHDOG_NAME,
.identity = WATCHDOG_NAME,
.identity = WATCHDOG_NAME,
.identity = WATCHDOG_NAME,
.identity = WATCHDOG_NAME,
.identity = WATCHDOG_NAME,
.identity = "wdrtas",
.identity = "WDT500/501",
.identity = "WDT Eurotech CPU-1220/1410",
.identity = "Winsystems EPX-C3 H/W Watchdog",
.identity = "WM831x Watchdog",
.identity = "WM8350 Watchdog",
.identity = "ZF-Logic watchdog",

Maybe a DECLARE_WATCHDOG_IDENT() macro?
