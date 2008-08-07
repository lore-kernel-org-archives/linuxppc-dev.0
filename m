Return-Path: <LeoLi@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1F613DDF07
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Aug 2008 20:04:33 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m77A4R8d015433
	for <linuxppc-dev@ozlabs.org>; Thu, 7 Aug 2008 03:04:27 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m77A4PSD015852
	for <linuxppc-dev@ozlabs.org>; Thu, 7 Aug 2008 05:04:26 -0500 (CDT)
Subject: Re: [PATCH 2/6] powerpc: export cpm2_immr symbol for CPM2 drivers
	to compile as module
From: Li Yang <leoli@freescale.com>
To: avorontsov@ru.mvista.com
In-Reply-To: <20080806152454.GA18655@polina.dev.rtsoft.ru>
References: <1218006285-27138-1-git-send-email-leoli@freescale.com>
	<1218006285-27138-2-git-send-email-leoli@freescale.com>
	<20080806152454.GA18655@polina.dev.rtsoft.ru>
Content-Type: text/plain
Date: Thu, 07 Aug 2008 18:19:22 +0800
Message-Id: <1218104362.29628.41.camel@Gundam>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: leoli@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2008-08-06 at 19:24 +0400, Anton Vorontsov wrote:
> On Wed, Aug 06, 2008 at 03:04:41PM +0800, Li Yang wrote:
> > Signed-off-by: Li Yang <leoli@freescale.com>
> > ---
> >  arch/powerpc/sysdev/cpm2.c |    1 +
> >  1 files changed, 1 insertions(+), 0 deletions(-)
> > 
> > diff --git a/arch/powerpc/sysdev/cpm2.c b/arch/powerpc/sysdev/cpm2.c
> > index f1c3395..021480e 100644
> > --- a/arch/powerpc/sysdev/cpm2.c
> > +++ b/arch/powerpc/sysdev/cpm2.c
> > @@ -52,6 +52,7 @@ cpm_cpm2_t __iomem *cpmp; /* Pointer to comm processor space */
> >   * the communication processor devices.
> >   */
> >  cpm2_map_t __iomem *cpm2_immr;
> > +EXPORT_SYMBOL(cpm2_immr);
> 
> This is uneeded if you'll start using cpm_muram_* functions
> from include/asm-powerpc/cpm.h.

Right.  But there are still a few in tree drivers rely on this such as
fs_enet.

Ps: In your cpm_muram_init() you re-mapped the muram space separately .
Are we planning to get rid of cpm2_immr completely and manage memory
mapping by each block?

- Leo
