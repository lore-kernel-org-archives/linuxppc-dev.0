Return-Path: <wg@grandegger.com>
Message-ID: <48EE5EAE.1090105@grandegger.com>
Date: Thu, 09 Oct 2008 21:42:38 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: Linuxppc-dev@ozlabs.org
Subject: Re: [PATCH v3] [NAND] driver extension to support NAND on TQM85xx
	modules
References: <484CE77C.70506@grandegger.com> <486B39C8.10502@grandegger.com>
In-Reply-To: <486B39C8.10502@grandegger.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: David Woodhouse <dwmw2@infradead.org>, linux-mtd@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Wolfgang Grandegger wrote:
> Hello,
> 
> I would like to ask for the status of the patch below and the related
> ones. Any chance to get them in for 2.6.27.

Already sometime ago I asked for the status of these patches but I never
got an answer and they did make it into 2.6.27, like the related patches
from Anton. That's really disappointing. What do I need to do to get
them finally accepted?

Thanks,

Wolfgang.

> Wolfgang Grandegger wrote:
>> This patch extends the FSL UPM NAND driver from Anton Vorontsov to
>> support hardware which does not have the R/B pin of the NAND chip
>> connected, like the TQM8548 module:
>>
>> - The OF_GPIO dependency has been removed from the Kconfig option
>>   because GPIO is not needed. The relevant gpio_* function are then
>>   stubbed out in <linux/gpio.h>.
>>  
>> - It re-introduces the chip-delay property to define an appropriate
>>   maximum delay time (tR) required for read operations. The binding
>>   will be documented in a separate patch.
>>
>> Note: this patch is based on a patch from Anton Vorontsov aöready
>>       posted to this list:
>>
>>       http://ozlabs.org/pipermail/linuxppc-dev/2008-April/055587.html.
>>       http://ozlabs.org/pipermail/linuxppc-dev/2008-May/057158.html
>>
>> Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
>> ---
>>  drivers/mtd/nand/Kconfig   |    2 +-
>>  drivers/mtd/nand/fsl_upm.c |   17 +++++++++++++----
>>  2 files changed, 14 insertions(+), 5 deletions(-)
>>
>> Index: linux-2.6-galak/drivers/mtd/nand/Kconfig
>> ===================================================================
>> --- linux-2.6-galak.orig/drivers/mtd/nand/Kconfig
>> +++ linux-2.6-galak/drivers/mtd/nand/Kconfig
>> @@ -380,7 +380,7 @@ config MTD_NAND_FSL_ELBC
>>  
>>  config MTD_NAND_FSL_UPM
>>      tristate "Support for NAND on Freescale UPM"
>> -    depends on MTD_NAND && OF_GPIO && (PPC_83xx || PPC_85xx)
>> +    depends on MTD_NAND && (PPC_83xx || PPC_85xx)
>>      select FSL_LBC
>>      help
>>        Enables support for NAND Flash chips wired onto Freescale PowerPC
>> Index: linux-2.6-galak/drivers/mtd/nand/fsl_upm.c
>> ===================================================================
>> --- linux-2.6-galak.orig/drivers/mtd/nand/fsl_upm.c
>> +++ linux-2.6-galak/drivers/mtd/nand/fsl_upm.c
>> @@ -13,6 +13,7 @@
>>  
>>  #include <linux/kernel.h>
>>  #include <linux/module.h>
>> +#include <linux/delay.h>
>>  #include <linux/mtd/nand.h>
>>  #include <linux/mtd/nand_ecc.h>
>>  #include <linux/mtd/partitions.h>
>> @@ -36,6 +37,7 @@ struct fsl_upm_nand {
>>      uint8_t upm_cmd_offset;
>>      void __iomem *io_base;
>>      int rnb_gpio;
>> +    int chip_delay;
>>  };
>>  
>>  #define to_fsl_upm_nand(mtd) container_of(mtd, struct fsl_upm_nand, mtd)
>> @@ -58,10 +60,11 @@ static void fun_wait_rnb(struct fsl_upm_
>>      if (fun->rnb_gpio >= 0) {
>>          while (--cnt && !fun_chip_ready(&fun->mtd))
>>              cpu_relax();
>> +        if (!cnt)
>> +            dev_err(fun->dev, "tired waiting for RNB\n");
>> +    } else {
>> +        ndelay(100);
>>      }
>> -
>> -    if (!cnt)
>> -        dev_err(fun->dev, "tired waiting for RNB\n");
>>  }
>>  
>>  static void fun_cmd_ctrl(struct mtd_info *mtd, int cmd, unsigned int
>> ctrl)
>> @@ -129,7 +132,7 @@ static int __devinit fun_chip_init(struc
>>      fun->chip.IO_ADDR_R = fun->io_base;
>>      fun->chip.IO_ADDR_W = fun->io_base;
>>      fun->chip.cmd_ctrl = fun_cmd_ctrl;
>> -    fun->chip.chip_delay = 50;
>> +    fun->chip.chip_delay = fun->chip_delay;
>>      fun->chip.read_byte = fun_read_byte;
>>      fun->chip.read_buf = fun_read_buf;
>>      fun->chip.write_buf = fun_write_buf;
>> @@ -233,6 +236,12 @@ static int __devinit fun_probe(struct of
>>          goto err2;
>>      }
>>  
>> +    prop = of_get_property(ofdev->node, "chip-delay", NULL);
>> +    if (prop)
>> +        fun->chip_delay = *prop;
>> +    else
>> +        fun->chip_delay = 50;
>> +
>>      fun->io_base = devm_ioremap_nocache(&ofdev->dev, io_res.start,
>>                        io_res.end - io_res.start + 1);
>>      if (!fun->io_base) {
>> _______________________________________________
>> Linuxppc-dev mailing list
>> Linuxppc-dev@ozlabs.org
>> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>>
>>
> 
> 
