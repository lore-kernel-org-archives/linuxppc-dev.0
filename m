Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B16EFB7D4B
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Feb 2010 00:26:13 +1100 (EST)
In-Reply-To: <1266433154.2322.0@antares>
References: <1266433154.2322.0@antares>
Subject: Re: [Patch v2 1/2] 5200/mpc: improve i2c bus error recovery
To: =?ISO-8859-15?Q?Albrecht_Dre=DF?= <albrecht.dress@arcor.de>
Message-ID: <OFA4DA54B0.B66AC60E-ONC12576CE.004938F6-C12576CE.00499A98@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Thu, 18 Feb 2010 14:23:57 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: Linux PPC Development <linuxppc-dev@ozlabs.org>,
	Devicetree Discussions <devicetree-discuss@lists.ozlabs.org>,
	"Ben Dooks \(embedded platforms\)" <ben-linux@fluff.org>,
	"Ira W. Snyder" <iws@ovro.caltech.edu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> @@ -93,20 +94,23 @@ static irqreturn_t mpc_i2c_isr(int irq,
>   /* Sometimes 9th clock pulse isn't generated, and slave doesn't release
>    * the bus, because it wants to send ACK.
>    * Following sequence of enabling/disabling and sending start/stop generates
> - * the pulse, so it's all OK.
> + * the 9 pulses, so it's all OK.
>    */
>   static void mpc_i2c_fixup(struct mpc_i2c *i2c)
>   {
> -   writeccr(i2c, 0);
> -   udelay(30);
> -   writeccr(i2c, CCR_MEN);
> -   udelay(30);
> -   writeccr(i2c, CCR_MSTA | CCR_MTX);
> -   udelay(30);
> -   writeccr(i2c, CCR_MSTA | CCR_MTX | CCR_MEN);
> -   udelay(30);
> -   writeccr(i2c, CCR_MEN);
> -   udelay(30);
> +   int k;
> +   u32 delay_val = 1000000 / i2c->real_clk + 1;
> +
> +   if (delay_val < 2)
> +      delay_val = 2;
> +
> +   for (k = 9; k; k--) {
> +      writeccr(i2c, 0);
> +      writeccr(i2c, CCR_MSTA | CCR_MTX | CCR_MEN);
> +      udelay(delay_val);
> +      writeccr(i2c, CCR_MEN);
> +      udelay(delay_val << 1);
> +   }
>   }

I am curious, didn't old method work with by just wrapping
a for(k=9; k; k--) around it? How did the wave form look?

   Jocke
