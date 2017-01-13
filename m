Return-Path: <tony@atomide.com>
Received: from muru.com (muru.com [72.249.23.125])
 by lists.ozlabs.org (Postfix) with ESMTP id 3v0Tts0WtyzDq60
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Jan 2017 04:21:24 +1100 (AEDT)
Date: Fri, 13 Jan 2017 09:15:37 -0800
From: Tony Lindgren <tony@atomide.com>
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>,
 Joao Pinto <Joao.Pinto@synopsys.com>, Arnd Bergmann <arnd@arndb.de>,
 linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@axis.com, linux-arm-msm@vger.kernel.org, nsekhar@ti.com
Subject: Re: [PATCH 36/37] ARM: DRA7: clockdomain: Change the CLKTRCTRL of
 CM_PCIE_CLKSTCTRL to SW_WKUP
Message-ID: <20170113171537.GZ2630@atomide.com>
References: <1484216786-17292-1-git-send-email-kishon@ti.com>
 <1484216786-17292-37-git-send-email-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1484216786-17292-37-git-send-email-kishon@ti.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Kishon Vijay Abraham I <kishon@ti.com> [170112 02:35]:
> The PCIe programming sequence in TRM suggests CLKSTCTRL of PCIe should
> be set to SW_WKUP. There are no issues when CLKSTCTRL is set to HW_AUTO
> in RC mode. However in EP mode, the host system is not able to access the
> MEMSPACE and setting the CLKSTCTRL to SW_WKUP fixes it.

I guess ideally in the long run we would set this dynamically based on
the selected mode, right?

Regards,

Tony

> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  arch/arm/mach-omap2/clockdomains7xx_data.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-omap2/clockdomains7xx_data.c b/arch/arm/mach-omap2/clockdomains7xx_data.c
> index 6c67965..67ebff8 100644
> --- a/arch/arm/mach-omap2/clockdomains7xx_data.c
> +++ b/arch/arm/mach-omap2/clockdomains7xx_data.c
> @@ -524,7 +524,7 @@
>  	.dep_bit	  = DRA7XX_PCIE_STATDEP_SHIFT,
>  	.wkdep_srcs	  = pcie_wkup_sleep_deps,
>  	.sleepdep_srcs	  = pcie_wkup_sleep_deps,
> -	.flags		  = CLKDM_CAN_HWSUP_SWSUP,
> +	.flags		  = CLKDM_CAN_SWSUP,
>  };
>  
>  static struct clockdomain atl_7xx_clkdm = {
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
