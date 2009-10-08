Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8E15BB7B68
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Oct 2009 06:24:13 +1100 (EST)
In-Reply-To: <1254950285.2409.10.camel@pasglop>
References: <1254948364-30074-1-git-send-email-Joakim.Tjernlund@transmode.se>	
	<1254948364-30074-2-git-send-email-Joakim.Tjernlund@transmode.se>
	<1254948364-30074-3-git-send-email-Joakim.Tjernlund@transmode.se>	
	<1254948364-30074-4-git-send-email-Joakim.Tjernlund@transmode.se>
	<1254950285.2409.10.camel@pasglop>
Subject: Re: [PATCH 3/6] 8xx: invalidate non present TLBs
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <OF44C1983F.1C42E290-ONC1257649.0069CAF3-C1257649.006A78D1@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Thu, 8 Oct 2009 21:22:57 +0200
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

Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote on 07/10/2009 23:18:05:
>
> On Wed, 2009-10-07 at 22:46 +0200, Joakim Tjernlund wrote:
> > 8xx sometimes need to load a invalid/non-present TLBs in
> > it DTLB asm handler.
> > These must be invalidated separaly as linux mm don't.
>
> not sure about the dsisr test here, what is the point ?

Without this patch I get about twice as many DTLB errors( on 2.4)

I have also noted that all my dcbst DTLB has the store bit set:
  trap:300 address:10030b8c, dar:10030b8c,err:42000000 dcbst

Thare are comments in the kernel that dcbst wrongly
generates TLB Errors with store set on 8xx. Is this really so?
Should dcbst always trap as a load?

 Jocke

>
> Cheers,
> Ben.
>
> > ---
> >  arch/powerpc/mm/fault.c |    8 +++++++-
> >  1 files changed, 7 insertions(+), 1 deletions(-)
> >
> > diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
> > index 7699394..72941c7 100644
> > --- a/arch/powerpc/mm/fault.c
> > +++ b/arch/powerpc/mm/fault.c
> > @@ -39,7 +39,7 @@
> >  #include <asm/uaccess.h>
> >  #include <asm/tlbflush.h>
> >  #include <asm/siginfo.h>
> > -
> > +#include <mm/mmu_decl.h>
> >
> >  #ifdef CONFIG_KPROBES
> >  static inline int notify_page_fault(struct pt_regs *regs)
> > @@ -243,6 +243,12 @@ good_area:
> >        goto bad_area;
> >  #endif /* CONFIG_6xx */
> >  #if defined(CONFIG_8xx)
> > +   /* 8xx sometimes need to load a invalid/non-present TLBs.
> > +    * These must be invalidated separately as linux mm don't.
> > +    */
> > +   if (error_code & 0x40000000) /* no translation? */
> > +      _tlbil_va(address);
> > +
> >          /* The MPC8xx seems to always set 0x80000000, which is
> >           * "undefined".  Of those that can be set, this is the only
> >           * one which seems bad.
>
>
>
>
