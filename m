Return-Path: <kishon@ti.com>
Received: from lelnx193.ext.ti.com (lelnx193.ext.ti.com [198.47.27.77])
 (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v22ln0JwszDqSM
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Jan 2017 17:05:40 +1100 (AEDT)
Subject: Re: [PATCH 36/37] ARM: DRA7: clockdomain: Change the CLKTRCTRL of
 CM_PCIE_CLKSTCTRL to SW_WKUP
To: Tony Lindgren <tony@atomide.com>
References: <1484216786-17292-1-git-send-email-kishon@ti.com>
 <1484216786-17292-37-git-send-email-kishon@ti.com>
 <20170113171537.GZ2630@atomide.com>
CC: Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>,
 Joao Pinto <Joao.Pinto@synopsys.com>, Arnd Bergmann <arnd@arndb.de>,
 <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-omap@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-samsung-soc@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-arm-kernel@axis.com>, <linux-arm-msm@vger.kernel.org>,
 <nsekhar@ti.com>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <587C628E.7070804@ti.com>
Date: Mon, 16 Jan 2017 11:35:02 +0530
MIME-Version: 1.0
In-Reply-To: <20170113171537.GZ2630@atomide.com>
Content-Type: text/plain; charset="windows-1252"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Tony,

On Friday 13 January 2017 10:45 PM, Tony Lindgren wrote:
> * Kishon Vijay Abraham I <kishon@ti.com> [170112 02:35]:
>> The PCIe programming sequence in TRM suggests CLKSTCTRL of PCIe should
>> be set to SW_WKUP. There are no issues when CLKSTCTRL is set to HW_AUTO
>> in RC mode. However in EP mode, the host system is not able to access the
>> MEMSPACE and setting the CLKSTCTRL to SW_WKUP fixes it.
> 
> I guess ideally in the long run we would set this dynamically based on
> the selected mode, right?

The programming sequence mentioned in the TRM w.r.t clock programming is same
for both host mode or device mode. Though we never faced any issues in host
mode when HW_AUTO is set, it's better to follow TRM recommended settings IMHO.

Thanks
Kishon

> 
> Regards,
> 
> Tony
> 
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> ---
>>  arch/arm/mach-omap2/clockdomains7xx_data.c |    2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/mach-omap2/clockdomains7xx_data.c b/arch/arm/mach-omap2/clockdomains7xx_data.c
>> index 6c67965..67ebff8 100644
>> --- a/arch/arm/mach-omap2/clockdomains7xx_data.c
>> +++ b/arch/arm/mach-omap2/clockdomains7xx_data.c
>> @@ -524,7 +524,7 @@
>>  	.dep_bit	  = DRA7XX_PCIE_STATDEP_SHIFT,
>>  	.wkdep_srcs	  = pcie_wkup_sleep_deps,
>>  	.sleepdep_srcs	  = pcie_wkup_sleep_deps,
>> -	.flags		  = CLKDM_CAN_HWSUP_SWSUP,
>> +	.flags		  = CLKDM_CAN_SWSUP,
>>  };
>>  
>>  static struct clockdomain atl_7xx_clkdm = {
>> -- 
>> 1.7.9.5
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
