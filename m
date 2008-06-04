Return-Path: <wg@grandegger.com>
Message-ID: <484665EC.30001@grandegger.com>
Date: Wed, 04 Jun 2008 11:52:44 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH] [NAND] driver extension to support NAND on TQM85xx	modules
References: <1212129392-27589-1-git-send-email-wg@grandegger.com>
	<20080530125057.GB13407@polina.dev.rtsoft.ru>
In-Reply-To: <20080530125057.GB13407@polina.dev.rtsoft.ru>
Content-Type: text/plain; charset=UTF-8
Cc: Linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Anton,

Anton Vorontsov wrote:
> On Fri, May 30, 2008 at 08:36:32AM +0200, Wolfgang Grandegger wrote:
>> This patch extends the FSL UPM NAND driver from Anton Vorontsov to
>> support for the TQM85xx modules. Unfortunately, the hardware does
>> not support the R/B pins of the NAND chip and therefore the specified
>> maximum delay time must used. It therefore re-introduces the chip-delay
>> property.
>>
>> Note: this patch is based on a patch Anton Vorontsov posted to this list:
>>       See http://ozlabs.org/pipermail/linuxppc-dev/2008-April/055587.html.
>>       It should show up mainstream soon. 
> 
> Personally, I like this patch. But OF people should approve "chip-delay"
> property. Though, the whole UPM NAND bindings are in the air still.
> 
>> --- a/include/linux/of_gpio.h
>> +++ b/include/linux/of_gpio.h
>> @@ -15,7 +15,7 @@
>>  #define __LINUX_OF_GPIO_H
>>  
>>  #include <linux/errno.h>
>> -#include <asm/gpio.h>
>> +#include <linux/gpio.h>
> 
> This should be done separately.

I have a technical question. Do you understand why the Linux NAND FSL UPM 
driver needs polling the R/B pin when writing out a sequence of bytes:

static void fun_write_buf(struct mtd_info *mtd, const uint8_t *buf, int len)
{
	struct fsl_upm_nand *fun = to_fsl_upm_nand(mtd);
	int i;

	for (i = 0; i < len; i++) {
		out_8(fun->chip.IO_ADDR_W, buf[i]);
		fun_wait_rnb(fun);
	}
}

We do not need that in the corresponding U-Boot driver. On my board (not 
having the R/B pin connected) I need a small delay of approx. 100 ns
instead to get it working properly.

Wolfgang.

 
