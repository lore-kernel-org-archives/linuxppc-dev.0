Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0148.outbound.protection.outlook.com [65.55.169.148])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D97431A1BF1
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  1 Aug 2015 03:24:36 +1000 (AEST)
Message-ID: <1438363461.19345.18.camel@freescale.com>
Subject: Re: [PATCH] c293/pci: remove hook pcibios_fixup_phb
From: Scott Wood <scottwood@freescale.com>
To: Hou Zhiqiang-B48286 <B48286@freescale.com>
CC: "galak@kernel.crashing.org" <galak@kernel.crashing.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "Hu
 Mingkai-B21284" <Mingkai.Hu@freescale.com>, Wang Dongsheng-B40534
 <Dongsheng.Wang@freescale.com>
Date: Fri, 31 Jul 2015 12:24:21 -0500
In-Reply-To: <CY1PR0301MB0780F0F41541CBFC5B5998018B8A0@CY1PR0301MB0780.namprd03.prod.outlook.com>
References: <1437473400-11184-1-git-send-email-B48286@freescale.com>
 <CY1PR0301MB0780F0F41541CBFC5B5998018B8A0@CY1PR0301MB0780.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-07-31 at 05:59 -0500, Hou Zhiqiang-B48286 wrote:
> Hi Dongsheng and Scott,
> 
> Do you have any comment?
> 
> > -----Original Message-----
> > From: Zhiqiang Hou [mailto:B48286@freescale.com]
> > Sent: 2015年7月21日 18:10
> > To: galak@kernel.crashing.org; linuxppc-dev@lists.ozlabs.org
> > Cc: Hu Mingkai-B21284; Wang Dongsheng-B40534; Hou Zhiqiang-B48286
> > Subject: [PATCH] c293/pci: remove hook pcibios_fixup_phb
> > 
> > From: Hou Zhiqiang <B48286@freescale.com>
> > 
> > The c293pcie board is an endpoint device, and it does't need PM.
> > 
> > Signed-off-by: Hou Zhiqiang <B48286@freescale.com>
> > ---
> >  arch/powerpc/platforms/85xx/c293pcie.c | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/arch/powerpc/platforms/85xx/c293pcie.c
> > b/arch/powerpc/platforms/85xx/c293pcie.c
> > index 84476b6..213d5b8 100644
> > --- a/arch/powerpc/platforms/85xx/c293pcie.c
> > +++ b/arch/powerpc/platforms/85xx/c293pcie.c
> > @@ -68,7 +68,6 @@ define_machine(c293_pcie) {
> >     .init_IRQ               = c293_pcie_pic_init,
> >  #ifdef CONFIG_PCI
> >     .pcibios_fixup_bus      = fsl_pcibios_fixup_bus,
> > -   .pcibios_fixup_phb      = fsl_pcibios_fixup_phb,
> >  #endif
> >     .get_irq                = mpic_get_irq,
> >     .restart                = fsl_rstcr_restart,

If this is an endpoint why do you need pcibios_fixup_bus?

-Scott
