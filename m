Return-Path: <dragos.carp@toptica.com>
Received: from tomcat.toptica.com (gateway.tuioptics.com [213.183.22.85])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A34B0B7B6B
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Sep 2009 00:15:02 +1000 (EST)
Date: Thu, 17 Sep 2009 16:04:42 +0200
From: Dragos Carp <dragos.carp@toptica.com>
To: Wolfram Sang <w.sang@pengutronix.de>
Message-ID: <4AB241FA.9090604@toptica.com>
In-Reply-To: <20090916204853.GA21627@pengutronix.de>
References: <4AB0C706.5020601@toptica.com>
References: <20090916204853.GA21627@pengutronix.de>
Subject: Re: [spi-devel-general] [PATCH] mpc52xx_psc_spi: enlarge clock range
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Cc: spi-devel-general@lists.sourceforge.net,
	David Brownell <dbrownell@users.sourceforge.net>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

I wasn't aware that MPC5200 differ from MPC5200B in this regard. I also
couldn't find any MPC5200 user manual on Freescale's webpage.
Is there a #define that I can use to distinguish between the two
processor variants? Querying the PVR register is not a nice solution
because the chip-select activate function is called in some scenarios
quite often.

Regards,
Dragos


On 09/16/2009 10:48 PM, Wolfram Sang wrote:
> Hi,
>
> adding powerpc-list and Grant to cc.
>
> On Wed, Sep 16, 2009 at 01:07:50PM +0200, Dragos Carp wrote:
>   
>> allow spi clock values bellow 78kbps down to ca. 300bps
>>     
> Looks like your patch converts the driver from mpc5200 to mpc5200b? If this is
> really all which is needed, it should support both versions, I think.
>
> Regards,
>
>    Wolfram
>
>   
>> Signed-off-by: Dragos Carp <dragos.carp@toptica.com>
>> ---
>>  mpc52xx_psc_spi.c |   26 +++++++++++++-------------
>>  1 file changed, 13 insertions(+), 13 deletions(-)
>>
>>     
>   
>> diff --git a/drivers/spi/mpc52xx_psc_spi.c b/drivers/spi/mpc52xx_psc_spi.c
>> index 1b74d5c..b15882a 100644
>> --- a/drivers/spi/mpc52xx_psc_spi.c
>> +++ b/drivers/spi/mpc52xx_psc_spi.c
>> @@ -78,7 +78,8 @@ static void mpc52xx_psc_spi_activate_cs(struct spi_device *spi)
>>  	struct mpc52xx_psc_spi *mps = spi_master_get_devdata(spi->master);
>>  	struct mpc52xx_psc __iomem *psc = mps->psc;
>>  	u32 sicr;
>> -	u16 ccr;
>> +	u32 ccr;
>> +	u32 bitclkdiv;
>>  
>>  	sicr = in_be32(&psc->sicr);
>>  
>> @@ -98,17 +99,16 @@ static void mpc52xx_psc_spi_activate_cs(struct spi_device *spi)
>>  		sicr &= ~0x10000000;
>>  	out_be32(&psc->sicr, sicr);
>>  
>> -	/* Set clock frequency and bits per word
>> -	 * Because psc->ccr is defined as 16bit register instead of 32bit
>> -	 * just set the lower byte of BitClkDiv
>> -	 */
>> -	ccr = in_be16((u16 __iomem *)&psc->ccr);
>> -	ccr &= 0xFF00;
>> -	if (cs->speed_hz)
>> -		ccr |= (MCLK / cs->speed_hz - 1) & 0xFF;
>> -	else /* by default SPI Clk 1MHz */
>> -		ccr |= (MCLK / 1000000 - 1) & 0xFF;
>> -	out_be16((u16 __iomem *)&psc->ccr, ccr);
>> +	/* Set clock frequency */
>> +	bitclkdiv = MCLK / (cs->speed_hz ? cs->speed_hz : 1000000) - 1;
>> +	bitclkdiv &= 0xFFFF;
>> +	bitclkdiv |= (bitclkdiv & 0xFF) << 16;	/* byte swapped */
>> +	bitclkdiv &= 0x00FFFF00;
>> +	ccr = in_be32(&psc->ccr);
>> +	ccr &= 0xFF0000FF;
>> +	ccr |= bitclkdiv;
>> +	out_be32(&psc->ccr, ccr);
>> +	
>>  	mps->bits_per_word = cs->bits_per_word;
>>  
>>  	if (mps->cs_control)
>> @@ -333,7 +333,7 @@ static int mpc52xx_psc_spi_port_config(int psc_id, struct mpc52xx_psc_spi *mps)
>>  	/* Configure 8bit codec mode as a SPI master and use EOF flags */
>>  	/* SICR_SIM_CODEC8|SICR_GENCLK|SICR_SPI|SICR_MSTR|SICR_USEEOF */
>>  	out_be32(&psc->sicr, 0x0180C800);
>> -	out_be16((u16 __iomem *)&psc->ccr, 0x070F); /* default SPI Clk 1MHz */
>> +	out_be32(&psc->ccr, 0x07130000); /* default SPI Clk 1MHz */
>>  
>>  	/* Set 2ms DTL delay */
>>  	out_8(&psc->ctur, 0x00);
>>     
>   
