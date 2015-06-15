Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3875D1A0E1E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jun 2015 11:49:12 +1000 (AEST)
Message-ID: <1434332951.19706.1.camel@ellerman.id.au>
Subject: Re: [PATCH] powerpc/powernv: pnv_init_idle_states() should only run
 on powernv
From: Michael Ellerman <mpe@ellerman.id.au>
To: Shreyas B Prabhu <shreyas@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org
Date: Mon, 15 Jun 2015 11:49:11 +1000
In-Reply-To: <557DAB91.7000100@linux.vnet.ibm.com>
References: <1434103220-8591-1-git-send-email-mpe@ellerman.id.au>
 <557DAB91.7000100@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2015-06-14 at 21:58 +0530, Shreyas B Prabhu wrote:
> 
> On 06/12/2015 03:30 PM, Michael Ellerman wrote:
> > Although this init call checks for device tree properties before doing
> > anything, it should still only run on powernv machines.
> > 
> > Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> > ---
> >  arch/powerpc/platforms/powernv/idle.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
> > index bd39a120bd60..e8168cf13812 100644
> > --- a/arch/powerpc/platforms/powernv/idle.c
> > +++ b/arch/powerpc/platforms/powernv/idle.c
> > @@ -289,5 +289,4 @@ out_free:
> >  out:
> >  	return 0;
> >  }
> > -
> > -subsys_initcall(pnv_init_idle_states);
> > +machine_subsys_initcall(powernv, pnv_init_idle_states);
> > 
> 
> <asm/machdep.h> needs to be included, otherwise I get a build error.

Ah yep, I built the wrong config to test :}

> With that,
> Reviewed-by: Shreyas B Prabhu <shreyas@linux.vnet.ibm.com>

Thanks for testing.

cheers
