Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5F4DC1A034B
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Feb 2016 10:03:24 +1100 (AEDT)
Message-ID: <1454540598.2486.22.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: Edward L Swarthout <ed.swarthout@nxp.com>, Zhiqiang Hou
 <zhiqiang.hou@nxp.com>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "mpe@ellerman.id.au" <mpe@ellerman.id.au>
Cc: "Mingkai.Hu@freescale.com" <Mingkai.Hu@freescale.com>
Date: Wed, 03 Feb 2016 17:03:18 -0600
In-Reply-To: <HE1PR04MB119473A0D817A832E40806D899D00@HE1PR04MB1194.eurprd04.prod.outlook.com>
References: <1451893517-20934-1-git-send-email-Zhiqiang.Hou@freescale.com>
 <HE1PR04MB0906BB81802E707FEF34619B84DE0@HE1PR04MB0906.eurprd04.prod.outlook.com>
 ,<1454299649.2486.11.camel@buserror.net>
 <HE1PR04MB119473A0D817A832E40806D899D00@HE1PR04MB1194.eurprd04.prod.outlook.com>
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

On Wed, 2016-02-03 at 21:32 +0000, Edward L Swarthout wrote:
> From: Scott Wood:
> > On Mon, 2016-02-01 at 03:57 +0000, Zhiqiang Hou wrote:
> > > Any comments?
> > 
> > Only that it was submitted too late for the last merge window, and I have
> > not
> > yet begun processing patches for the next one.  If you meant this to be a
> > fix
> > important enough to go in outside the merge window, it's missing any
> > statement
> > of what the actual symptoms are.
> > 
> > > -----Original Message-----
> > > From: Zhiqiang Hou [mailto:Zhiqiang.Hou@freescale.com]
> > > To: linuxppc-dev@lists.ozlabs.org; benh@kernel.crashing.org;
> > > Subject: [PATCH] powerpc/fsl-pci: Correct the comparison of the LTSSM
> > > 
> > > Only the value PCIE_LTSSM_L0 stands for the link is up, instead of >=
> > > PCIE_LTSSM_L0.
> > > 
> > > diff --git a/arch/powerpc/sysdev/fsl_pci.c
> > > b/arch/powerpc/sysdev/fsl_pci.c
> > > @@ -73,7 +73,7 @@ static int fsl_pcie_check_link(struct pci_controller
> > >                     early_read_config_dword(hose, 0, 0, PCIE_LTSSM,
> > > -           if (val < PCIE_LTSSM_L0)
> > > +           if (val != PCIE_LTSSM_L0)
> > >                     return 1;
> 
> This patch is incorrect as there are actually two states L0 and L0s
> (standby) 
> that indicate an active link (a LTSSM value of 0x11 or  0x12).
> 
> The next user manual revision should contain this detail.

The next manual of what chip?

Are there any non-active states for which the current test does not work?

-Scott
