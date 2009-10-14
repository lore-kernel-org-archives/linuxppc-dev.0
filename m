Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 807A6B7B75
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Oct 2009 16:40:22 +1100 (EST)
Subject: Re: [PATCH] i2c-powermac: Reject unsupported I2C transactions
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jean Delvare <khali@linux-fr.org>
In-Reply-To: <20090930221435.58636363@hyperion.delvare>
References: <20090930221435.58636363@hyperion.delvare>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 14 Oct 2009 16:39:48 +1100
Message-Id: <1255498788.2347.37.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Linux I2C <linux-i2c@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2009-09-30 at 22:14 +0200, Jean Delvare wrote:
> The i2c-powermac driver doesn't support arbitrary multi-message I2C
> transactions, only SMBus ones. Make it clear by returning an error if
> a multi-message I2C transaction is attempted. This is better than only
> processing the first message, because most callers won't recover from
> the short transaction. Anyone wishing to issue multi-message
> transactions should use the SMBus API instead of the raw I2C API.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> Cc: Paul Mackerras <paulus@samba.org>
> ---
>  drivers/i2c/busses/i2c-powermac.c |    6 ++++++
>  1 file changed, 6 insertions(+)
> 
> --- linux-2.6.32-rc1.orig/drivers/i2c/busses/i2c-powermac.c	2009-06-10 05:05:27.000000000 +0200
> +++ linux-2.6.32-rc1/drivers/i2c/busses/i2c-powermac.c	2009-09-30 20:29:42.000000000 +0200
> @@ -146,6 +146,12 @@ static int i2c_powermac_master_xfer(	str
>  	int			read;
>  	int			addrdir;
>  
> +	if (num != 1) {
> +		dev_err(&adap->dev,
> +			"Multi-message I2C transactions not supported\n");
> +		return -EOPNOTSUPP;
> +	}
> +
>  	if (msgs->flags & I2C_M_TEN)
>  		return -EINVAL;
>  	read = (msgs->flags & I2C_M_RD) != 0;
> 
> 
