Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0124.outbound.protection.outlook.com [65.55.169.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2D0A01A09A7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2015 11:17:03 +1100 (AEDT)
Message-ID: <1446164196.22185.15.camel@freescale.com>
Subject: Re: [PATCH v2 2/3] ppc64: Avoid rfid if no need to clear MSR_LE
From: Scott Wood <scottwood@freescale.com>
To: Simon Horman <horms@verge.net.au>
CC: <linuxppc-dev@lists.ozlabs.org>, <kexec@lists.infradead.org>, "Samuel
 Mendoza-Jonas" <sam.mj@au1.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>
Date: Thu, 29 Oct 2015 19:16:36 -0500
In-Reply-To: <20151016014803.GF20667@verge.net.au>
References: <1444172150-29493-1-git-send-email-scottwood@freescale.com>
 <1444172150-29493-2-git-send-email-scottwood@freescale.com>
 <20151016014803.GF20667@verge.net.au>
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

On Fri, 2015-10-16 at 10:48 +0900, Simon Horman wrote:
> On Tue, Oct 06, 2015 at 05:55:49PM -0500, Scott Wood wrote:
> > Commit a304e2d82a8c3 ("ppc64: purgatory: Reset primary cpu endian to
> > big-endian) changed bctr to rfid.  rfid is book3s-only and will cause a
> > fatal exception on book3e.
> > 
> > Purgatory is an isolated environment which makes importing information
> > about the subarch awkward, so instead rely on the fact that MSR_LE
> > should never be set on book3e, and the rfid is only needed if MSR_LE is
> > set (and thus needs to be cleared).  In theory that MSR bit is reserved
> > on book3e, rather than zero, but in practice I have not seen it set.
> > 
> > Signed-off-by: Scott Wood <scottwood@freescale.com>
> > Cc: Samuel Mendoza-Jonas <sam.mj@au1.ibm.com>
> > ---
> > v2: new patch
> 
> Could I get a review of this from at lest one ppc person?

Michael, can you comment on this as well as patch 3/3?

-Scott

> 
> >  purgatory/arch/ppc64/v2wrap.S | 10 +++++++++-
> >  1 file changed, 9 insertions(+), 1 deletion(-)
> > 
> > diff --git a/purgatory/arch/ppc64/v2wrap.S b/purgatory/arch/ppc64/v2wrap.S
> > index 179ade9..3534080 100644
> > --- a/purgatory/arch/ppc64/v2wrap.S
> > +++ b/purgatory/arch/ppc64/v2wrap.S
> > @@ -116,9 +116,17 @@ master:
> >     stw     7,0x5c(4)       # and patch it into the kernel
> >     mr      3,16            # restore dt address
> >  
> > +   mfmsr   5
> > +   andi.   10,5,1          # test MSR_LE
> > +   bne     little_endian
> > +
> > +   li      5,0             # r5 will be 0 for kernel
> > +   mtctr   4               # prepare branch to
> > +   bctr                    # start kernel
> > +   
> > +little_endian:                     # book3s-only
> >     mtsrr0  4               # prepare branch to
> >  
> > -   mfmsr   5
> >     clrrdi  5,5,1           # clear MSR_LE
> >     mtsrr1  5
> >  
