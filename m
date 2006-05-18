Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2323967A75
	for <linuxppc-dev@ozlabs.org>; Thu, 18 May 2006 17:02:27 +1000 (EST)
Subject: RE: [PATCH/2.6.17-rc4 10/10]  bugs fix for marvell SATA on powerp
	c pl atform
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Zang Roy-r61911 <tie-fei.zang@freescale.com>
In-Reply-To: <9FCDBA58F226D911B202000BDBAD46730626DE6E@zch01exm40.ap.freescale.net>
References: <9FCDBA58F226D911B202000BDBAD46730626DE6E@zch01exm40.ap.freescale.net>
Content-Type: text/plain; charset=utf-8
Date: Thu, 18 May 2006 17:02:14 +1000
Message-Id: <1147935734.17679.93.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Alexandre.Bounine@tundra.com, linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>,
	Yang Xin-Xin-r48390 <Xin-Xin.Yang@freescale.com>, jgarzik@pobox.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2006-05-18 at 12:03 +0800, Zang Roy-r61911 wrote:
> -----Original Message-----
> From: Kumar Gala [mailto:galak@kernel.crashing.org]
> Sent: 2006年5月17日 21:28
> To: Zang Roy-r61911
> Cc: Paul Mackerras; linuxppc-dev list; Alexandre.Bounine@tundra.com; Yang Xin-Xin-r48390
> Subject: Re: [PATCH/2.6.17-rc4 10/10] bugs fix for marvell SATA on powerpc pl atform

Copying here the comments I already made so Jeff gets them...

> @@ -1032,6 +1032,9 @@ static inline void mv_crqb_pack_cmd(u16 
>  {
>       *cmdw = data | (addr << CRQB_CMD_ADDR_SHIFT) | CRQB_CMD_CS |
>               (last ? CRQB_CMD_LAST : 0);
> +#ifdef CONFIG_PPC
> +     *cmdw = cpu_to_le16(*cmdw);
> +#endif
>  }

Why an ifdef here ? The cpu_to_le16 should probably be unconditional.
And even if for some weird reason you wanted to ifdef it, why PPC ? and
what about other BE architectures ?
 
>  /**
> @@ -1567,13 +1570,18 @@ static void mv5_read_preamp(struct mv_ho
>  static void mv5_enable_leds(struct mv_host_priv *hpriv, void __iomem
*mmio)
>  {
>       u32 tmp;
> -
> +#ifndef CONFIG_PPC
>       writel(0, mmio + MV_GPIO_PORT_CTL);
> +#endif

You'll have to do better here too... I don't wee why when compiled on
PPC, this driver should "magically" not clear those bits... At the very
least, you should test the machine type if you want to do something
specific to your platform, but first, you'll have to convince Jeff why
this change has to be done in the first place and if there is a better
way to handle it.

>       /* FIXME: handle MV_HP_ERRATA_50XXB2 errata */
>  
>       tmp = readl(mmio + MV_PCI_EXP_ROM_BAR_CTL);
> +#ifdef CONFIG_PPC
> +     tmp &= ~(1 << 0);
> +#else        
>       tmp |= ~(1 << 0);
> +#endif
>       writel(tmp, mmio + MV_PCI_EXP_ROM_BAR_CTL);
>  }

Looks to me like the initial code was bogus, thus the #ifdef shouldn't
be necessary neither, and even if it was, an ifdef CONFIG_PPC would be
the wrong approach for what I think should be ovious enough reasons...

Ben.
