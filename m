Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6BED31A0166
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Feb 2016 15:07:34 +1100 (AEDT)
Message-ID: <1454299649.2486.11.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: Zhiqiang Hou <zhiqiang.hou@nxp.com>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "mpe@ellerman.id.au" <mpe@ellerman.id.au>
Cc: "Mingkai.Hu@freescale.com" <Mingkai.Hu@freescale.com>
Date: Sun, 31 Jan 2016 22:07:29 -0600
In-Reply-To: <HE1PR04MB0906BB81802E707FEF34619B84DE0@HE1PR04MB0906.eurprd04.prod.outlook.com>
References: <1451893517-20934-1-git-send-email-Zhiqiang.Hou@freescale.com>
 <HE1PR04MB0906BB81802E707FEF34619B84DE0@HE1PR04MB0906.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [PATCH] powerpc/fsl-pci: Correct the comparison of the LTSSM
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[cc list trimmed]

On Mon, 2016-02-01 at 03:57 +0000, Zhiqiang Hou wrote:
> Hi,
> 
> Any comments?

Only that it was submitted too late for the last merge window, and I have not
yet begun processing patches for the next one.  If you meant this to be a fix
important enough to go in outside the merge window, it's missing any statement
of what the actual symptoms are.

-Scott

> 
> > -----Original Message-----
> > From: Zhiqiang Hou [mailto:Zhiqiang.Hou@freescale.com]
> > Sent: 2016年1月4日 15:45
> > To: linuxppc-dev@lists.ozlabs.org; benh@kernel.crashing.org; 
> > paulus@samba.org;
> > mpe@ellerman.id.au
> > Cc: Scott Wood <scottwood@freescale.com>; akpm@linux-foundation.org;
> > robh@kernel.org; Mingkai.Hu@freescale.com; Hou Zhiqiang
> > <Zhiqiang.Hou@freescale.com>
> > Subject: [PATCH] powerpc/fsl-pci: Correct the comparison of the LTSSM
> > 
> > From: Hou Zhiqiang <Zhiqiang.Hou@freescale.com>
> > 
> > Only the value PCIE_LTSSM_L0 stands for the link is up, instead of >=
> > PCIE_LTSSM_L0.
> > 
> > Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@freescale.com>
> > ---
> >  arch/powerpc/sysdev/fsl_pci.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
> > index
> > 610f472..1595f55 100644
> > --- a/arch/powerpc/sysdev/fsl_pci.c
> > +++ b/arch/powerpc/sysdev/fsl_pci.c
> > @@ -73,7 +73,7 @@ static int fsl_pcie_check_link(struct pci_controller
> > *hose)
> >  					       PCIE_LTSSM, 4, &val);
> >  		else
> >  			early_read_config_dword(hose, 0, 0, PCIE_LTSSM,
> > &val);
> > -		if (val < PCIE_LTSSM_L0)
> > +		if (val != PCIE_LTSSM_L0)
> >  			return 1;
> >  	} else {
> >  		struct ccsr_pci __iomem *pci = hose->private_data;
> > --
> > 2.1.0.27.g96db324
> 
> Thanks,
> Zhiqiang
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
