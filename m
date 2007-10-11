Return-Path: <dgibson@ozlabs.org>
Date: Thu, 11 Oct 2007 11:34:12 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] Bootwrapper: Enable debug info on boot wrapper
Message-ID: <20071011013412.GA14873@localhost.localdomain>
References: <20071004040501.16923.68468.stgit@trillian.cg.shawcable.net>
	<fa686aa40710101256q3783994dr854e2bdecddf9820@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <fa686aa40710101256q3783994dr854e2bdecddf9820@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Oct 10, 2007 at 01:56:05PM -0600, Grant Likely wrote:
> Any comments on this one?  Scott?  David?

Seems reasonable AFAICT.

> On 10/3/07, Grant Likely <grant.likely@secretlab.ca> wrote:
> > From: Grant Likely <grant.likely@secretlab.ca>
> >
> > Add '-g' to BOOTCFLAGS if CONFIG_DEBUG_INFO is set.
> >
> > Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> > ---
> >
> >  arch/powerpc/boot/Makefile |    4 ++++
> >  1 files changed, 4 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
> > index cf80db3..9dfe79b 100644
> > --- a/arch/powerpc/boot/Makefile
> > +++ b/arch/powerpc/boot/Makefile
> > @@ -25,6 +25,10 @@ BOOTCFLAGS    := -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs \
> >                  -isystem $(shell $(CROSS32CC) -print-file-name=include)
> >  BOOTAFLAGS     := -D__ASSEMBLY__ $(BOOTCFLAGS) -traditional -nostdinc
> >
> > +ifdef CONFIG_DEBUG_INFO
> > +BOOTCFLAGS     += -g
> > +endif
> > +
> >  ifeq ($(call cc-option-yn, -fstack-protector),y)
> >  BOOTCFLAGS     += -fno-stack-protector
> >  endif
> >
> > _______________________________________________
> > Linuxppc-dev mailing list
> > Linuxppc-dev@ozlabs.org
> > https://ozlabs.org/mailman/listinfo/linuxppc-dev
> >
> 
> 

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
