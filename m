Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id A255AB6EDF
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  4 Aug 2010 05:11:07 +1000 (EST)
To: galak@kernel.crashing.org, Kim Phillips <kim.phillips@freescale.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: Commit 3da34aa brakes MSI support on MPC8308 (possibly all
	MPC83xx) [REPOST]
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: <20100729212043.4258C152397@gemini.denx.de>
References: <4C48B384.1020006@emcraft.com>
	<20100729212043.4258C152397@gemini.denx.de>
Date: Tue, 03 Aug 2010 21:11:03 +0200
Message-Id: <20100803191103.A97BB28F@gemini.denx.de>
Cc: linuxppc-dev@lists.ozlabs.org, Ilya Yanok <yanok@emcraft.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Kumar, hello Kim,


can you _please_ comment?  Thanks.

In message <20100729212043.4258C152397@gemini.denx.de> I wrote:
> Dear Kumar & Kim,
> 
> any comments on this issue?
> 
> Thanks.
> 
> In message <4C48B384.1020006@emcraft.com> Ilya Yanok wrote:
> >   Hi Kumar, Kim, Josh, everybody,
> > 
> > I hope to disturb you but I haven't got any reply for my first posting...
> > 
> > I've found that MSI work correctly with older kernels on my MPC8308RDB 
> > board and don't work with newer ones. After bisecting I've found that 
> > the source of the problem is commit 3da34aa:
> > 
> > commit 3da34aae03d498ee62f75aa7467de93cce3030fd
> > Author: Kumar Gala <galak@kernel.crashing.org>
> > Date:   Tue May 12 15:51:56 2009 -0500
> > 
> >      powerpc/fsl: Support unique MSI addresses per PCIe Root Complex
> > 
> >      Its feasible based on how the PCI address map is setup that the region
> >      of PCI address space used for MSIs differs for each PHB on the same SoC.
> > 
> >      Instead of assuming that the address mappes to CCSRBAR 1:1 we read
> >      PEXCSRBAR (BAR0) for the PHB that the given pci_dev is on.
> > 
> >      Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> > 
> > I can see BAR0 initialization for 85xx/86xx hardware but not for 83xx 
> > neigher in the kernel nor in U-Boot (that makes me think that all 83xx 
> > can be affected).
> > I'm not actually an PCI expert so I've just tried to write IMMR base 
> > address to the BAR0 register from the U-Boot to get the correct address 
> > but this doesn't help.
> > Please direct me how to init 83xx PCIE controller to make it compatible 
> > with this patch.
> > 
> > Kim, I think MPC8315E is affected too, could you please test it?
> > 
> > Thanks in advance.
> > 
> > Regards, Ilya.
> 
> Best regards,
> 
> Wolfgang Denk


Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
In the beginning, there was nothing, which exploded.
                                - Terry Pratchett, _Lords and Ladies_
