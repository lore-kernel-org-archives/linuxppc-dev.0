Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 04214B70E2
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Jan 2011 08:22:19 +1100 (EST)
Subject: Re: [patch 1/2] macintosh: wrong test in fan_{read,write}_reg()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: akpm@linux-foundation.org
In-Reply-To: <201101182109.p0IL992W005451@imap1.linux-foundation.org>
References: <201101182109.p0IL992W005451@imap1.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 19 Jan 2011 08:22:07 +1100
Message-ID: <1295385727.2148.85.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, roel.kluin@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2011-01-18 at 13:09 -0800, akpm@linux-foundation.org wrote:
> From: roel kluin <roel.kluin@gmail.com>
> 
> Fix error test in fan_{read,write}_reg()

Thanks, I'll pick that up.

Cheers,
Ben.

> Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  drivers/macintosh/therm_pm72.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff -puN drivers/macintosh/therm_pm72.c~macintosh-wrong-test-in-fan_readwrite_reg drivers/macintosh/therm_pm72.c
> --- a/drivers/macintosh/therm_pm72.c~macintosh-wrong-test-in-fan_readwrite_reg
> +++ a/drivers/macintosh/therm_pm72.c
> @@ -443,7 +443,7 @@ static int fan_read_reg(int reg, unsigne
>  	tries = 0;
>  	for (;;) {
>  		nr = i2c_master_recv(fcu, buf, nb);
> -		if (nr > 0 || (nr < 0 && nr != ENODEV) || tries >= 100)
> +		if (nr > 0 || (nr < 0 && nr != -ENODEV) || tries >= 100)
>  			break;
>  		msleep(10);
>  		++tries;
> @@ -464,7 +464,7 @@ static int fan_write_reg(int reg, const 
>  	tries = 0;
>  	for (;;) {
>  		nw = i2c_master_send(fcu, buf, nb);
> -		if (nw > 0 || (nw < 0 && nw != EIO) || tries >= 100)
> +		if (nw > 0 || (nw < 0 && nw != -EIO) || tries >= 100)
>  			break;
>  		msleep(10);
>  		++tries;
> _
