Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id E68A2DDE36
	for <linuxppc-dev@ozlabs.org>; Sun,  6 Jan 2008 05:20:05 +1100 (EST)
Message-ID: <477FCA53.8010103@pikatech.com>
Date: Sat, 05 Jan 2008 13:20:03 -0500
From: Sean MacLennan <smaclennan@pikatech.com>
MIME-Version: 1.0
To: Stefan Roese <sr@denx.de>
Subject: Re: [PATCH] MTD for Taco
References: <477F12D1.2070109@pikatech.com> <200801051041.18173.sr@denx.de>
In-Reply-To: <200801051041.18173.sr@denx.de>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Stefan Roese wrote:
> On Saturday 05 January 2008, Sean MacLennan wrote:
>   
>> This patch adds the maps for the taco. It also gets the ndfc.c NAND
>> driver in a compilable state. The map is guaranteed to change since the
>> exact NOR/NAND flash configuration is in flux right now when we found
>> the 256M NAND flash won't boot properly.
>>
>> Currently it configures the NOR in a reasonable fashion and leaves the
>> NAND as one honkin' parition.
>>     
>
> <snip>
>
>   
>> diff --git a/drivers/mtd/nand/ndfc.c b/drivers/mtd/nand/ndfc.c
>> index 1c0e89f..f5e93cf 100644
>> --- a/drivers/mtd/nand/ndfc.c
>> +++ b/drivers/mtd/nand/ndfc.c
>> @@ -24,11 +24,6 @@
>>  #include <linux/platform_device.h>
>>  
>>  #include <asm/io.h>
>> -#ifdef CONFIG_40x
>> -#include <asm/ibm405.h>
>> -#else
>> -#include <asm/ibm44x.h>
>> -#endif
>>     
>
> You do break arch/ppc support with this patch. We have to still support
> arch/ppc a few month, so please don't break this support for now.
>   
Gotcha. Is CONFIG_PPC_MERGED the right flag for things like this?
>   
>   
>>  struct ndfc_nand_mtd {
>>         struct mtd_info                 mtd;
>> @@ -110,6 +105,40 @@ static int ndfc_calculate_ecc(struct mtd_info *mtd,
>>         return 0;
>>  }
>>  
>> +#ifdef CONFIG_TACO
>> +/* The NDFC may allow 32bit read/writes, but it sure doesn't work on
>> + * the taco!
>> + */
>>     
>
> We definitely don't want to see such board specific stuff in the common
> NDFC driver. And I really doubt that you need this change for your board.
> We are using this ndfc driver on multiple boards, and all have no
> problems accessing the controller with 32bit read/writes. So you most
> likely have a problem with your board port. Perhaps something with
> with the EBC setup. Please re-check and compare with boards that are know
> to work, like Sequoia.
>
>   
Does the Sequoia use a Rev C chip? We had to modify u-boot the same way. 
As soon as we do an 8-bit access we get a machine check exception.

To be honest, I don't know what more to check.
>> +static void ndfc_read_buf(struct mtd_info *mtd, uint8_t *buf, int len)
>> +{
>> +       struct ndfc_controller *ndfc = &ndfc_ctrl;
>> +       uint8_t *p = (uint8_t *) buf;
>> +
>> +       for(;len > 0; len -= 1)
>> +               *p++ = __raw_readb(ndfc->ndfcbase + NDFC_DATA);
>> +}
>> +
>> +static void ndfc_write_buf(struct mtd_info *mtd, const uint8_t *buf, int
>> len) +{
>> +       struct ndfc_controller *ndfc = &ndfc_ctrl;
>> +       uint8_t *p = (uint8_t *) buf;
>> +
>> +       for(;len > 0; len -= 1)
>> +               __raw_writeb(*p++, ndfc->ndfcbase + NDFC_DATA);
>> +}
>> +
>> +static int ndfc_verify_buf(struct mtd_info *mtd, const uint8_t *buf, int
>> len) +{
>> +       struct ndfc_controller *ndfc = &ndfc_ctrl;
>> +       uint8_t *p = (uint8_t *) buf;
>> +
>> +       for(;len > 0; len -= 1)
>> +               if (*p++ != __raw_readb(ndfc->ndfcbase + NDFC_DATA))
>> +                       return -EFAULT;
>> +
>> +       return 0;
>> +}
>> +#else
>>     
>
> <snip>
>
>   
>> +++ drivers/mtd/maps/taco.c     2008-01-02 13:07:43.000000000 -0500
>> @@ -0,0 +1,140 @@
>> +/*
>> + * $Id: $
>> + *
>> + * drivers/mtd/maps/taco.c
>> + *
>> + * Mapping for PIKA Taco flash
>>     
>
> I'm pretty sure that you don't need a board specific mapping driver
> for NOR flash. physmap_of should be exactly what you need. You just need
> to fill the device tree properties correctly.
>   
Yes, this was copied straight from the PPC port. The whole NOR/NAND 
flash is in flux. Marketing really really wants to drop NOR for price 
reasons. So I will probably leave this until a final decision is made.
> BTW: I noticed you are using the boot wrapper approach. This is not
> necessary anymore, since the latest U-Boot version has flattened
> device tree support included for 4xx too. Let me know if you have any
> questions about this.
>   
I did this port over Christmas and had no access to the hardware guys so 
I stayed away from u-boot since I had no way to recover from mistakes. I 
hope to make towards the tree image approach but for now the in-kernel 
version is much easier for me to work with.

Cheers,
    Sean
