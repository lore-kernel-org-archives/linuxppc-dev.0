Return-Path: <Paul.Gortmaker@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 227B02C00C9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Feb 2014 01:40:31 +1100 (EST)
Message-ID: <530613CD.2080309@windriver.com>
Date: Thu, 20 Feb 2014 09:40:13 -0500
From: Paul Gortmaker <paul.gortmaker@windriver.com>
MIME-Version: 1.0
To: Prabhakar Kushwaha <prabhakar@freescale.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2] powerpc: select MEMORY for FSL_IFC to not break
 existing .config files
References: <1392848350.6733.809.camel@snotra.buserror.net>
 <1392850000-4601-1-git-send-email-paul.gortmaker@windriver.com>
 <53059B47.8000103@freescale.com>
In-Reply-To: <53059B47.8000103@freescale.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: Arnd Bergmann <arnd@arndb.de>, linux-next@vger.kernel.org,
 linux-mtd@lists.infradead.org, Scott Wood <scottwood@freescale.com>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 David Woodhouse <dwmw2@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 14-02-20 01:05 AM, Prabhakar Kushwaha wrote:
> 
> On 2/20/2014 4:16 AM, Paul Gortmaker wrote:
>> commit d2ae2e20fbdde5a65f3a5a153044ab1e5c53f7cc ("driver/memory:Move
>> Freescale IFC driver to a common driver") introduces this build
>> regression into the mpc85xx_defconfig:
>>
>>   drivers/built-in.o: In function `fsl_ifc_nand_remove':
>>   drivers/mtd/nand/fsl_ifc_nand.c:1147: undefined reference to `fsl_ifc_ctrl_dev'
>>   drivers/mtd/nand/fsl_ifc_nand.c:1147: undefined reference to `fsl_ifc_ctrl_dev'
>>   drivers/built-in.o: In function `fsl_ifc_nand_probe':
>>   drivers/mtd/nand/fsl_ifc_nand.c:1031: undefined reference to `fsl_ifc_ctrl_dev'
>>   drivers/mtd/nand/fsl_ifc_nand.c:1031: undefined reference to `fsl_ifc_ctrl_dev'
>>   drivers/built-in.o: In function `match_bank':
>>   drivers/mtd/nand/fsl_ifc_nand.c:1013: undefined reference to `convert_ifc_address'
>>   drivers/built-in.o: In function `fsl_ifc_nand_probe':
>>   drivers/mtd/nand/fsl_ifc_nand.c:1059: undefined reference to `fsl_ifc_ctrl_dev'
>>   drivers/mtd/nand/fsl_ifc_nand.c:1080: undefined reference to `fsl_ifc_ctrl_dev'
>>   drivers/mtd/nand/fsl_ifc_nand.c:1069: undefined reference to `fsl_ifc_ctrl_dev'
>>   drivers/mtd/nand/fsl_ifc_nand.c:1069: undefined reference to `fsl_ifc_ctrl_dev'
>>   make: *** [vmlinux] Error 1
>>
>> This happens because there is nothing to descend us into the
>> drivers/memory directory in the mpc85xx_defconfig.  It wasn't
>> selecting CONFIG_MEMORY.  So we never built drivers/memory/fsl_ifc.o
>> and so we have nothing to link the above symbols against.
>>
>> Since the goal of the original commit was to relocate the driver to
>> an arch independent location, it only makes sense to relocate the
>> Kconfig setting there as well.  But that alone won't fix the build
>> failure; for that we ensure whoever selects FSL_IFC also selects MEMORY.
>>
>> Cc: Prabhakar Kushwaha <prabhakar@freescale.com>
>> Cc: Scott Wood <scottwood@freescale.com>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Cc: David Woodhouse <dwmw2@infradead.org>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
>> ---
>>
>> [v2: fix the mislocated FSL_IFC as per Scott's comment.  It still
>>   probably makes sense to go in via Greg's char-misc/char-misc-next
>>   (vs. powerpc-next) since that is where the regression was introduced.]
>>
>>   arch/powerpc/Kconfig     | 4 ----
>>   drivers/memory/Kconfig   | 4 ++++
>>   drivers/mtd/nand/Kconfig | 1 +
>>   3 files changed, 5 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
>> index 957bf344c0f5..b9fcecc706ab 100644
>> --- a/arch/powerpc/Kconfig
>> +++ b/arch/powerpc/Kconfig
>> @@ -736,10 +736,6 @@ config FSL_LBC
>>   	  controller.  Also contains some common code used by
>>   	  drivers for specific local bus peripherals.
>>   
>> -config FSL_IFC
>> -	bool
>> -        depends on FSL_SOC
>> -
>>   config FSL_GTM
>>   	bool
>>   	depends on PPC_83xx || QUICC_ENGINE || CPM2
>> diff --git a/drivers/memory/Kconfig b/drivers/memory/Kconfig
>> index 29a11db365bc..a3640fe9852f 100644
>> --- a/drivers/memory/Kconfig
>> +++ b/drivers/memory/Kconfig
>> @@ -50,4 +50,8 @@ config TEGRA30_MC
>>   	  analysis, especially for IOMMU/SMMU(System Memory Management
>>   	  Unit) module.
>>   
>> +config FSL_IFC
>> +	bool
>> +	depends on FSL_SOC
>> +
>>   endif
>> diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
>> index 90ff447bf043..a4bee41ad5cb 100644
>> --- a/drivers/mtd/nand/Kconfig
>> +++ b/drivers/mtd/nand/Kconfig
>> @@ -428,6 +428,7 @@ config MTD_NAND_FSL_IFC
>>   	tristate "NAND support for Freescale IFC controller"
>>   	depends on MTD_NAND && FSL_SOC
>>   	select FSL_IFC
>> +	select MEMORY
>>   	help
>>   	  Various Freescale chips e.g P1010, include a NAND Flash machine
>>   	  with built-in hardware ECC capabilities.
> 
> Hi All,
> 
> I am not sure which version of patch is being picked here.
> 
> Latest version is v8 and it is a "patch set" and it do enable 
> CONFIG_MEMORY in powerpc/configs

It really doesn't matter what the latest version is, if the
maintainer has already taken an earlier version and merged it.
In that case one needs to work with the maintainer to determine
whether they want a new version, or a delta/fixup commit on the
old one.

> 
> 1.  driver/memory:Move Freescale IFC driver to a common driver
> http://patchwork.ozlabs.org/patch/315531/

So, this has the Kconfig move part, but the one currently in 
char-misc does not.  And it still needs the "select".

> 
> 2. powerpc/config: Enable memory driver
> http://patchwork.ozlabs.org/patch/315532/

Updating the defconfigs is fine, but incomplete in itself.  You
still need the IFC users to select MEMORY, otherwise you still
introduce build failures for anyone else who chooses IFC but
does not choose MEMORY.

In short, the char-misc tree still needs the v2 patch above.

Paul.
--

> 
> Regards,
> Prabhakar
> 
> 
> 
> 
> 
