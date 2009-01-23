Return-Path: <andre.schwarz@matrix-vision.de>
Received: from p15137414.pureserver.info (matrixvision.de [217.160.213.229])
	by ozlabs.org (Postfix) with ESMTP id CA7F3DDF04
	for <linuxppc-dev@ozlabs.org>; Sat, 24 Jan 2009 01:46:18 +1100 (EST)
Message-ID: <4979D839.3060503@matrix-vision.de>
Date: Fri, 23 Jan 2009 15:46:17 +0100
From: Andre Schwarz <andre.schwarz@matrix-vision.de>
MIME-Version: 1.0
To: Wolfgang Wegner <wolfgang@leila.ping.de>
Subject: Re: MicroSD (SPI mode) support in Linux-2.6.26-1
References: <dd2f3b320901221959w956ccc6r3b700633acbefd3a@mail.gmail.com>
	<4979BB83.5060506@matrix-vision.de>
	<20090123134001.GR2004@leila.ping.de>
In-Reply-To: <20090123134001.GR2004@leila.ping.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, Sai Amruta <amrutasai.p@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Wolfgang Wegner wrote:
> Hi Andre,
>
> On Fri, Jan 23, 2009 at 01:43:47PM +0100, Andre Schwarz wrote:
>   
>> Sai Amruta wrote:
>>     
>>> Hi All,
>>>
>>> I am using linux-2.6.26 on MPC8567 and microSD is connected through 
>>> SPI interface.
>>> Is the existing mmc driver supports microSD?
>>>       
>> yes - it's working perfectly fine on my MPC8343.
>> Even with SDHC cards ;-)
>>     
>
> that's great to hear - is there anything like a HOWTO on how to set
> this up on top of the SPI driver (probably involving some custom GPIO
> stuff for card and WP detection) out there?
> I tried to but did not get it to work on MCF53xx (uClinux 2.6.23-uc0)
> and probably did not find the right search strings either.
>
> Regards,
> Wolfgang
>
>   
I'm sorry - no README.
All I can do is provide the info how it works for me :

platform code : provide init and chips select functions.

static void mvblm7_spi_activate_cs(u8 cs, u8 polarity)
{
        u32 data = in_be32( mvblm7_gpio + 2 );
        if (polarity)
                out_be32( mvblm7_gpio + 2, data | MVBLM7_MMC_CS );
        else
                out_be32( mvblm7_gpio + 2, data & ~MVBLM7_MMC_CS );
}

static void mvblm7_spi_deactivate_cs(u8 cs, u8 polarity)
{
        u32 data = in_be32( mvblm7_gpio + 2 );
        if (!polarity)
                out_be32( mvblm7_gpio + 2, data | MVBLM7_MMC_CS );
        else
                out_be32( mvblm7_gpio + 2, data & ~MVBLM7_MMC_CS );
}

static struct mmc_spi_platform_data mvblm7_mmc_pdata = {
        .ocr_mask = MMC_VDD_33_34,
};

static struct spi_board_info mvblm7_spi_boardinfo = {
        .bus_num = 0x7000,
        .chip_select = 0,
        .max_speed_hz = 50000000,
        .modalias = "mmc_spi",
        .platform_data = &mvblm7_mmc_pdata,
};

static int __init mvblm7_spi_init(void)
{
        return fsl_spi_init(&mvblm7_spi_boardinfo, 1,
                            mvblm7_spi_activate_cs,
                            mvblm7_spi_deactivate_cs);
}

machine_device_initcall(mvblm7, mvblm7_spi_init);


Kernel config :
CONFIG_MMC=y
CONFIG_MMC_BLOCK=y
CONFIG_MMC_BLOCK_BOUNCE=y
CONFIG_MMC_SPI=m

and of course the driver for your SPI controller ...

CONFIG_SPI=y
CONFIG_SPI_MASTER=y
CONFIG_SPI_MPC83xx=y


I've had no time to set up hotplug/card detect features.
Actually my system boots with card plugged in and and I do a "insmod 
mmc_spi.ko" -> card gets probed.

->mount -t vfat /dev/mmcblk0p1  /mnt/mmc


hope this helps.


cheers,
Andre

MATRIX VISION GmbH, Talstraße 16, DE-71570 Oppenweiler
Registergericht: Amtsgericht Stuttgart, HRB 271090
Geschäftsführer: Gerhard Thullner, Werner Armingeon, Uwe Furtner, Hans-Joachim Reich
