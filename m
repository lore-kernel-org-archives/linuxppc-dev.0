Return-Path: <Paul.Gortmaker@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id EC2262C00B1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Feb 2014 09:25:06 +1100 (EST)
Message-ID: <53052F6A.4050400@windriver.com>
Date: Wed, 19 Feb 2014 17:25:46 -0500
From: Paul Gortmaker <paul.gortmaker@windriver.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] powerpc: select MEMORY for FSL_IFC to not break existing
 .config files
References: <1392847641-63777-1-git-send-email-paul.gortmaker@windriver.com>
 <1392848350.6733.809.camel@snotra.buserror.net>
In-Reply-To: <1392848350.6733.809.camel@snotra.buserror.net>
Content-Type: text/plain; charset="UTF-8"
Cc: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-next@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 Prabhakar Kushwaha <prabhakar@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 14-02-19 05:19 PM, Scott Wood wrote:
> On Wed, 2014-02-19 at 17:07 -0500, Paul Gortmaker wrote:
>> commit d2ae2e20fbdde5a65f3a5a153044ab1e5c53f7cc ("driver/memory:Move
>> Freescale IFC driver to a common driver") introduces this build
>> regression into the mpc85xx_defconfig:
>>
>>  drivers/built-in.o: In function `fsl_ifc_nand_remove':
>>  drivers/mtd/nand/fsl_ifc_nand.c:1147: undefined reference to `fsl_ifc_ctrl_dev'
>>  drivers/mtd/nand/fsl_ifc_nand.c:1147: undefined reference to `fsl_ifc_ctrl_dev'
>>  drivers/built-in.o: In function `fsl_ifc_nand_probe':
>>  drivers/mtd/nand/fsl_ifc_nand.c:1031: undefined reference to `fsl_ifc_ctrl_dev'
>>  drivers/mtd/nand/fsl_ifc_nand.c:1031: undefined reference to `fsl_ifc_ctrl_dev'
>>  drivers/built-in.o: In function `match_bank':
>>  drivers/mtd/nand/fsl_ifc_nand.c:1013: undefined reference to `convert_ifc_address'
>>  drivers/built-in.o: In function `fsl_ifc_nand_probe':
>>  drivers/mtd/nand/fsl_ifc_nand.c:1059: undefined reference to `fsl_ifc_ctrl_dev'
>>  drivers/mtd/nand/fsl_ifc_nand.c:1080: undefined reference to `fsl_ifc_ctrl_dev'
>>  drivers/mtd/nand/fsl_ifc_nand.c:1069: undefined reference to `fsl_ifc_ctrl_dev'
>>  drivers/mtd/nand/fsl_ifc_nand.c:1069: undefined reference to `fsl_ifc_ctrl_dev'
>>  make: *** [vmlinux] Error 1
>>
>> This happens because there is nothing to descend us into the
>> drivers/memory directory in the mpc85xx_defconfig.  It wasn't
>> selecting CONFIG_MEMORY.  So we never built drivers/memory/fsl_ifc.o
>> even with CONFIG_FSL_IFC=y, and so we have nothing to link against.
>>
>> In order to remain compatible with old config files and to avoid
>> such build failures, make CONFIG_FSL_IFC select CONFIG_MEMORY.
>> Also fix the whitespace issue (spaces vs. a tab) in the Kconfig.
>>
>> Cc: Prabhakar Kushwaha <prabhakar@freescale.com>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
>> ---
>>
>> [This probably makes sense to go in via Greg's char-misc/char-misc-next
>>  (vs. powerpc-next) since that is where the regression was introduced.]
>>
>>  arch/powerpc/Kconfig | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
>> index 957bf344c0f5..d2d8d8f50610 100644
>> --- a/arch/powerpc/Kconfig
>> +++ b/arch/powerpc/Kconfig
>> @@ -738,7 +738,8 @@ config FSL_LBC
>>  
>>  config FSL_IFC
>>  	bool
>> -        depends on FSL_SOC
>> +	depends on FSL_SOC
>> +	select MEMORY
> 
> Why do we still have FSL_IFC in arch/powerpc/Kconfig if the driver has
> been moved?  The NAND driver and other selectors of FSL_IFC can select
> MEMORY.

At the risk of a slightly larger footprint to the regression fix,
I'd agree that is a better overall solution.  I'll code that up.

Unless folks want the regression fix as-is, and then the move?

Paul.
--

> 
> -Scott
> 
> 
