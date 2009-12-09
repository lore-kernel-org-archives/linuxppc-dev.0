Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 84F11B7B60
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Dec 2009 18:43:01 +1100 (EST)
In-Reply-To: <1260332399.16132.7.camel@pasglop>
References: <1258712471-3104-1-git-send-email-Joakim.Tjernlund@transmode.se>	
	<1258712471-3104-2-git-send-email-Joakim.Tjernlund@transmode.se>
	<1258712471-3104-3-git-send-email-Joakim.Tjernlund@transmode.se>	
	<1258712471-3104-4-git-send-email-Joakim.Tjernlund@transmode.se>
	<1258712471-3104-5-git-send-email-Joakim.Tjernlund@transmode.se>
	<1260332399.16132.7.camel@pasglop>
Subject: Re: [PATCH 04/10] 8xx: Always pin kernel instruction TLB
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <OFB03B60EA.0352DA78-ONC1257687.002955A6-C1257687.002A145F@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Wed, 9 Dec 2009 08:39:37 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: Scott Wood <scottwood@freescale.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Rex Feany <RFeany@mrv.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote on 09/12/2009 05:19:59:

> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> To: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
> Cc: Scott Wood <scottwood@freescale.com>, "linuxppc-dev@ozlabs.org" <linuxppc-
> dev@ozlabs.org>, Rex Feany <RFeany@mrv.com>
> Date: 09/12/2009 05:20
> Subject: Re: [PATCH 04/10] 8xx: Always pin kernel instruction TLB
>
> On Fri, 2009-11-20 at 11:21 +0100, Joakim Tjernlund wrote:
> > Various kernel asm modifies SRR0/SRR1 just before executing
> > a rfi. If such code crosses a page boundary you risk a TLB miss
> > which will clobber SRR0/SRR1. Avoid this by always pinning
> > kernel instruction TLB space.
> >
> > Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
> > ---
> >  arch/powerpc/kernel/head_8xx.S |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> >
> > diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
> > index a9f1ace..e70503d 100644
> > --- a/arch/powerpc/kernel/head_8xx.S
> > +++ b/arch/powerpc/kernel/head_8xx.S
> > @@ -705,7 +705,7 @@ start_here:
> >   */
> >  initial_mmu:
> >     tlbia         /* Invalidate all TLB entries */
> > -#ifdef CONFIG_PIN_TLB
> > +#if 1 /* CONFIG_PIN_TLB */
> >     lis   r8, MI_RSV4I@h
> >     ori   r8, r8, 0x1c00
> >  #else
>
> Not nice. Either remove the config option or make sure all those code
> sequences are appropriately aligned so it doesn't happen. I recommend
> the later :-)

The later isn't as simple :) I believe the bulk of such code in entry_32.S.
Anyhow, the config option is still valid as if enabled
it will pin several DTLB's too. Scott had some concerns about removing the
config option completely so this was the next best thing.

>
> I'll apply the other patches.
OK, great.
