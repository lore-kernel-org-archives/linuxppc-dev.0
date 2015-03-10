Return-Path: <ludovic.desroches@atmel.com>
Received: from eusmtp01.atmel.com (eusmtp01.atmel.com [212.144.249.243])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3CE861A0008
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2015 00:56:12 +1100 (AEDT)
Date: Tue, 10 Mar 2015 14:55:20 +0100
From: Ludovic Desroches <ludovic.desroches@atmel.com>
To: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [RFC V2 03/12] i2c: at91: make use of the new infrastructure for
 quirks
Message-ID: <20150310135520.GY9132@odux.rfo.atmel.com>
References: <1424880126-15047-1-git-send-email-wsa@the-dreams.de>
 <1424880126-15047-4-git-send-email-wsa@the-dreams.de>
 <20150308082845.GB1904@katana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20150308082845.GB1904@katana>
Cc: linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
 Ludovic Desroches <ludovic.desroches@atmel.com>, linux-i2c@vger.kernel.org,
 Yingjoe Chen <yingjoe.chen@mediatek.com>,
 Eddie Huang <eddie.huang@mediatek.com>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Wolfram,

You can add my 

Acked-by and Tested-By: Ludovic Desroches <ludovic.desroches@atmel.com>

Tested on sama5d3, some problems with at24 eeprom on sama5d4 but it
doesn't come from the i2c quirks patch series.

Regards

Ludovic

On Sun, Mar 08, 2015 at 09:28:45AM +0100, Wolfram Sang wrote:
> On Wed, Feb 25, 2015 at 05:01:54PM +0100, Wolfram Sang wrote:
> > From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > 
> > Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> 
> Hi Ludovic,
> 
> if you have a few minutes, could you please test this series? I'd like to
> include it in 4.1. and because at91 is using the quirk infrastructure in
> a more complex way, it is a really good test candidate.
> 
> Thanks,
> 
>    Wolfram
> 
> > ---
> >  drivers/i2c/busses/i2c-at91.c | 32 +++++++++++---------------------
> >  1 file changed, 11 insertions(+), 21 deletions(-)
> > 
> > diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91.c
> > index 636fd2efad8850..b3a70e8fc653c5 100644
> > --- a/drivers/i2c/busses/i2c-at91.c
> > +++ b/drivers/i2c/busses/i2c-at91.c
> > @@ -487,30 +487,10 @@ static int at91_twi_xfer(struct i2c_adapter *adap, struct i2c_msg *msg, int num)
> >  	if (ret < 0)
> >  		goto out;
> >  
> > -	/*
> > -	 * The hardware can handle at most two messages concatenated by a
> > -	 * repeated start via it's internal address feature.
> > -	 */
> > -	if (num > 2) {
> > -		dev_err(dev->dev,
> > -			"cannot handle more than two concatenated messages.\n");
> > -		ret = 0;
> > -		goto out;
> > -	} else if (num == 2) {
> > +	if (num == 2) {
> >  		int internal_address = 0;
> >  		int i;
> >  
> > -		if (msg->flags & I2C_M_RD) {
> > -			dev_err(dev->dev, "first transfer must be write.\n");
> > -			ret = -EINVAL;
> > -			goto out;
> > -		}
> > -		if (msg->len > 3) {
> > -			dev_err(dev->dev, "first message size must be <= 3.\n");
> > -			ret = -EINVAL;
> > -			goto out;
> > -		}
> > -
> >  		/* 1st msg is put into the internal address, start with 2nd */
> >  		m_start = &msg[1];
> >  		for (i = 0; i < msg->len; ++i) {
> > @@ -540,6 +520,15 @@ out:
> >  	return ret;
> >  }
> >  
> > +/*
> > + * The hardware can handle at most two messages concatenated by a
> > + * repeated start via it's internal address feature.
> > + */
> > +static struct i2c_adapter_quirks at91_twi_quirks = {
> > +	.flags = I2C_AQ_COMB | I2C_AQ_COMB_WRITE_FIRST | I2C_AQ_COMB_SAME_ADDR,
> > +	.max_comb_1st_msg_len = 3,
> > +};
> > +
> >  static u32 at91_twi_func(struct i2c_adapter *adapter)
> >  {
> >  	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL
> > @@ -777,6 +766,7 @@ static int at91_twi_probe(struct platform_device *pdev)
> >  	dev->adapter.owner = THIS_MODULE;
> >  	dev->adapter.class = I2C_CLASS_DEPRECATED;
> >  	dev->adapter.algo = &at91_twi_algorithm;
> > +	dev->adapter.quirks = &at91_twi_quirks;
> >  	dev->adapter.dev.parent = dev->dev;
> >  	dev->adapter.nr = pdev->id;
> >  	dev->adapter.timeout = AT91_I2C_TIMEOUT;
> > -- 
> > 2.1.4
> > 
