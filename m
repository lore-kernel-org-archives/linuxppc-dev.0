Return-Path: <khali@linux-fr.org>
Received: from services.gcu-squad.org (zone0.gcu-squad.org [212.85.147.21])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 48362DDEF9
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Sep 2008 06:33:16 +1000 (EST)
Date: Fri, 19 Sep 2008 22:03:08 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 1/2] i2c: expand I2C's id.name to 23 characters
Message-ID: <20080919220308.3173320e@hyperion.delvare>
In-Reply-To: <20080919180339.GA13899@oksana.dev.rtsoft.ru>
References: <20080919180339.GA13899@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, i2c@lm-sensors.org,
	Ben Dooks <ben-linux@fluff.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 19 Sep 2008 22:03:39 +0400, Anton Vorontsov wrote:
> It was discussed[1] that we should match on the first (most specific)
> entry in the device tree.
> 
> The most lengthy I2C compatible entry for the MPC8349E-mITX MCU
> devices is "mc9s08qg8-mpc8349emitx" (w/o vendor name). This means
> that we have to allow longer IDs to be used in the I2C subsystem.
> 
> [1] http://www.mail-archive.com/linuxppc-dev@ozlabs.org/msg21196.html

Nack. Just come up with shorter names. "mc9s08qg8-mpc8349emitx" is
simply too long to start with. Looking at the mcu_mpc8349emitx driver
you just submitted, you are clearly abusing the i2c client name to pass
platform-specific information, and that's bad. I'm not even sure why
you do that, given that all the names are then handled the same as far
as I can see.

> 
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
>  include/linux/mod_devicetable.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
> index c4db582..9d9d1f5 100644
> --- a/include/linux/mod_devicetable.h
> +++ b/include/linux/mod_devicetable.h
> @@ -379,7 +379,7 @@ struct virtio_device_id {
>  
>  /* i2c */
>  
> -#define I2C_NAME_SIZE	20
> +#define I2C_NAME_SIZE	23
>  #define I2C_MODULE_PREFIX "i2c:"
>  
>  struct i2c_device_id {


-- 
Jean Delvare
