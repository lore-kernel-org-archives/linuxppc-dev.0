Return-Path: <ed.swarthout@nxp.com>
Received: from emea01-db3-obe.outbound.protection.outlook.com
 (mail-db3on0069.outbound.protection.outlook.com [157.55.234.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F340D1A0709
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Feb 2016 10:06:42 +1100 (AEDT)
From: Edward L Swarthout <ed.swarthout@nxp.com>
To: Scott Wood <oss@buserror.net>, Zhiqiang Hou <zhiqiang.hou@nxp.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "mpe@ellerman.id.au" <mpe@ellerman.id.au>
CC: "Mingkai.Hu@freescale.com" <Mingkai.Hu@freescale.com>
Subject: Re: [PATCH] powerpc/fsl-pci: Correct the comparison of the LTSSM
Date: Wed, 3 Feb 2016 21:32:41 +0000
Message-ID: <HE1PR04MB119473A0D817A832E40806D899D00@HE1PR04MB1194.eurprd04.prod.outlook.com>
References: <1451893517-20934-1-git-send-email-Zhiqiang.Hou@freescale.com>
 <HE1PR04MB0906BB81802E707FEF34619B84DE0@HE1PR04MB0906.eurprd04.prod.outlook.com>,
 <1454299649.2486.11.camel@buserror.net>
In-Reply-To: <1454299649.2486.11.camel@buserror.net>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Scott Wood:
>On Mon, 2016-02-01 at 03:57 +0000, Zhiqiang Hou wrote:
>> Any comments?
>
> Only that it was submitted too late for the last merge window, and I have=
 not
> yet begun processing patches for the next one.  If you meant this to be a=
 fix
> important enough to go in outside the merge window, it's missing any stat=
ement
> of what the actual symptoms are.
>
> > -----Original Message-----
> > From: Zhiqiang Hou [mailto:Zhiqiang.Hou@freescale.com]
> > To: linuxppc-dev@lists.ozlabs.org; benh@kernel.crashing.org;
> > Subject: [PATCH] powerpc/fsl-pci: Correct the comparison of the LTSSM
> >
> > Only the value PCIE_LTSSM_L0 stands for the link is up, instead of >=3D
> > PCIE_LTSSM_L0.
> >
> > diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pc=
i.c
> > @@ -73,7 +73,7 @@ static int fsl_pcie_check_link(struct pci_controller
> >                     early_read_config_dword(hose, 0, 0, PCIE_LTSSM,
> > -           if (val < PCIE_LTSSM_L0)
> > +           if (val !=3D PCIE_LTSSM_L0)
> >                     return 1;

This patch is incorrect as there are actually two states L0 and L0s (standb=
y)=20
that indicate an active link (a LTSSM value of 0x11 or  0x12).

The next user manual revision should contain this detail.

Ed
