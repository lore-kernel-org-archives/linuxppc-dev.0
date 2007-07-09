Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.178])
	by ozlabs.org (Postfix) with ESMTP id 332B6DDEDF
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 10 Jul 2007 01:53:09 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so1370318wag
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 09 Jul 2007 08:53:08 -0700 (PDT)
Message-ID: <fa686aa40707090853j6079b0c7rbcff7c449baa15e0@mail.gmail.com>
Date: Mon, 9 Jul 2007 09:53:07 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Domen Puncer" <domen.puncer@telargo.com>
Subject: Re: [PATCH] i2c-mpc: work around missing-9th-clock-pulse bug
In-Reply-To: <20070709071955.GD4186@moe.telargo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <20070709071955.GD4186@moe.telargo.com>
Cc: khali@linux-fr.org, i2c@lm-sensors.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 7/9/07, Domen Puncer <domen.puncer@telargo.com> wrote:
> Work around a problem reported on:
> http://ozlabs.org/pipermail/linuxppc-embedded/2005-July/019038.html
> Without this patch I2C on mpc5200 becomes unusable after a while.
> Tested on mpc5200 based boards by Matthias and me.
>
> Index: work-powerpc.git/drivers/i2c/busses/i2c-mpc.c
> ===================================================================
> --- work-powerpc.git.orig/drivers/i2c/busses/i2c-mpc.c
> +++ work-powerpc.git/drivers/i2c/busses/i2c-mpc.c
> @@ -153,6 +167,9 @@ static void mpc_i2c_start(struct mpc_i2c
>  static void mpc_i2c_stop(struct mpc_i2c *i2c)
>  {
>         writeccr(i2c, CCR_MEN);
> +       mb();
> +       writeccr(i2c, 0);
> +       mb();
>  }

Are the mb() calls necessary?  The writeccr path includes eieio; is
that not sufficient?

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
