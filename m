Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6933AB7B61
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Nov 2009 01:29:36 +1100 (EST)
Subject: Re: [PATCH v3 3/3] powerpc/fsl: 85xx: add cache-sram support
Mime-Version: 1.0 (Apple Message framework v1076)
Content-Type: text/plain; charset=us-ascii; format=flowed; delsp=yes
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <181208B7-AC0B-4634-A04E-46468D376719@freescale.com>
Date: Thu, 19 Nov 2009 08:29:19 -0600
Message-Id: <2B43D645-7977-4C24-A3EF-C55A392228B4@kernel.crashing.org>
References: <1256129459-10685-1-git-send-email-vivek.mahajan@freescale.com>
	<1256129459-10685-2-git-send-email-vivek.mahajan@freescale.com>
	<1256129459-10685-3-git-send-email-vivek.mahajan@freescale.com>
	<181208B7-AC0B-4634-A04E-46468D376719@freescale.com>
To: Kumar Gala <kumar.gala@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Vivek Mahajan <vivek.mahajan@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Nov 19, 2009, at 8:21 AM, Kumar Gala wrote:

>> diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/ 
>> platforms/85xx/Kconfig
>> index d3a975e..b6f23c3 100644
>> --- a/arch/powerpc/platforms/85xx/Kconfig
>> +++ b/arch/powerpc/platforms/85xx/Kconfig
>> @@ -144,6 +144,15 @@ config SBC8560
>> 	help
>> 	  This option enables support for the Wind River SBC8560 board
>>
>> +config FSL_85XX_CACHE_SRAM
>> +	bool
>> +	select PPC_LIB_RHEAP
>> +
>> +config FSL_85XX_CACHE_SRAM_BASE
>> +	hex
>> +	depends on FSL_85XX_CACHE_SRAM
>> +	default "0xfff00000"
>> +
>
> I really don't like setting the physical address this way, can we  
> not do this via the device tree?

At a high level I think we should add something like the following in  
the .dts:

sram@fff00000 {
	fsl,sram-ctrl-handle = <&L2>;
	reg = <0xfff00000 0xNNNN>;
	compatible = "fsl,mpc85xx-l2-sram";
}

the NNNN can be the size the sram is configured as.

- k
