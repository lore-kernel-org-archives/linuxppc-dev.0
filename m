Return-Path: <felix@embedded-sol.com>
Received: from vega.surpasshosting.com (vega.surpasshosting.com [72.29.83.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CC495B7C09
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Jan 2010 22:49:08 +1100 (EST)
Message-ID: <4B4B1027.4020708@embedded-sol.com>
Date: Mon, 11 Jan 2010 13:48:55 +0200
From: Felix Radensky <felix@embedded-sol.com>
MIME-Version: 1.0
To: Stef van Os <stef.van.os@Prodrive.nl>
Subject: Re: PCI-PCI bridge scanning broken on 460EX
References: <4B388D9D.7010404@embedded-sol.com><1262584539.2173.335.camel@pasglop>	<4B41ADF1.1000400@embedded-sol.com><4B49CE8A.7000609@embedded-sol.com>	<1263155906.724.2.camel@pasglop><4B4A4307.5050704@embedded-sol.com>	<1263159117.724.15.camel@pasglop>
	<4CD35CD1F8085945B597F80EEC89421303B8AD0C@exc01.bk.prodrive.nl>
In-Reply-To: <4CD35CD1F8085945B597F80EEC89421303B8AD0C@exc01.bk.prodrive.nl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Stefan Roese <sr@denx.de>, Feng Kan <fkan@amcc.com>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Stef,

Stef van Os wrote:
> Hello Felix,
>
> I had a problem similar to this on the 440GX, the PCI code was not
> sending type 1 transactions when scanning behind bridges. Perhaps you
> could try this:
>
> Index: linux/arch/powerpc/sysdev/ppc4xx_pci.c
> ===================================================================
> --- linux/arch/powerpc/sysdev/ppc4xx_pci.c      (revision 26)
> +++ linux/arch/powerpc/sysdev/ppc4xx_pci.c      (revision 27)
> @@ -569,7 +569,7 @@
>         hose->last_busno = bus_range ? bus_range[1] : 0xff;
>
>         /* Setup config space */
> -       setup_indirect_pci(hose, rsrc_cfg.start, rsrc_cfg.start + 0x4,
> 0);
> +       setup_indirect_pci(hose, rsrc_cfg.start, rsrc_cfg.start + 0x4,
> PPC_INDIRECT_TYPE_SET_CFG_TYPE);
>
>         /* Disable all windows */
>         writel(0, reg + PCIX0_POM0SA);
>
>
>
> With kind regards / Met vriendelijke groet,
>
> Stef van Os
>
> Prodrive B.V. 
>
>
>   

I think you patch is a valid one, and should be applied, but 
unfortunately it doesn't fix by problem.
BTW, in u-boot transaction type bit is set correctly.

Felix.
