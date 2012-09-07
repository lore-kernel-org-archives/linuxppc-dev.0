Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [PATCH 4/5] powerpc: Rework set_dabr so it can take a DABRX value
 as well
In-reply-to: <alpine.DEB.2.00.1209070716110.22556@bushbaby.sonytel.be>
References: <1346908671-7464-1-git-send-email-mikey@neuling.org>
 <1346908671-7464-4-git-send-email-mikey@neuling.org>
 <CAMuHMdU=UjkU3BRV7Aouu-m=vKaSPWH93Rkh6L3RWev4oM5jYA@mail.gmail.com>
 <15813.1346989072@neuling.org>
 <alpine.DEB.2.00.1209070716110.22556@bushbaby.sonytel.be>
Date: Fri, 07 Sep 2012 15:43:01 +1000
Message-ID: <25431.1346996581@neuling.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com> wrote:

> 	Hi Mikey,
> 
> On Fri, 7 Sep 2012, Michael Neuling wrote:
> > Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > On Thu, Sep 6, 2012 at 7:17 AM, Michael Neuling <mikey@neuling.org> wrote:
> > > > Rework set_dabr to take a DABRX value as well. We are not actually
> > > > changing any functionality at this stage, just preparing for that.
> > > 
> > > You are changing functionality.
> > 
> > You are right.. I'll fix that up.. Sorry.
> > 
> > > >  #define   DABRX_USER   (1UL << 0)
> > > >  #define   DABRX_KERNEL (1UL << 1)
> > > > +#define   DABRX_HYP    (1UL << 2)
> > > > +#define   DABRX_BTI    (1UL << 3)
> > > > +#define   DABRX_ALL     (DABRX_BTI | DABRX_HYP | DABRX_KERNEL | DABRX_USER)
> > > 
> > > > --- a/arch/powerpc/platforms/cell/beat.c
> > > > +++ b/arch/powerpc/platforms/cell/beat.c
> > > > @@ -136,9 +136,9 @@ ssize_t beat_nvram_get_size(void)
> > > >         return BEAT_NVRAM_SIZE;
> > > >  }
> > > >
> > > > -int beat_set_xdabr(unsigned long dabr)
> > > > +int beat_set_xdabr(unsigned long dabr, unsigned long dabrx)
> > > >  {
> > > > -       if (beat_set_dabr(dabr, DABRX_KERNEL | DABRX_USER))
> > > > +       if (beat_set_dabr(dabr, dabrx))
> > > >                 return -1;
> > > >         return 0;
> > > >  }
> > > 
> > > > --- a/arch/powerpc/platforms/ps3/setup.c
> > > > +++ b/arch/powerpc/platforms/ps3/setup.c
> > > > @@ -184,11 +184,9 @@ early_param("ps3flash", early_parse_ps3flash);
> > > >  #define prealloc_ps3flash_bounce_buffer()      do { } while (0)
> > > >  #endif
> > > >
> > > > -static int ps3_set_dabr(unsigned long dabr)
> > > > +static int ps3_set_dabr(unsigned long dabr, unsigned long dabrx)
> > > >  {
> > > > -       enum {DABR_USER = 1, DABR_KERNEL = 2,};
> > > > -
> > > > -       return lv1_set_dabr(dabr, DABR_KERNEL | DABR_USER) ? -1 : 0;
> > > > +       return lv1_set_dabr(dabr, dabrx) ? -1 : 0;
> > > >  }
> > > 
> > > > -               set_dabr(dabr.address | (dabr.enabled & 7));
> > > > +               set_dabr(dabr.address | (dabr.enabled & 7), DABRX_ALL);
> > > 
> > > Before, beat_set_dabr() and lv1_set_dabr() would have been called with dabrx = 3
> > > (DABRX_KERNEL | DABRX_USER). Now they're called with dabrx = 15
> > > (DABRX_ALL = DABRX_BTI | DABRX_HYP | DABRX_KERNEL | DABRX_USER).
> > > 
> > > No idea what's the impact of this...
> > 
> > Do you know if the ps3 hypervisor will allow us to set DABRX_BTI or
> > DABRX_HYP?  phyp wont.  
> 
> According to the documenation, all bits but DABRX_USER, DABRX_KERNEL, and
> DABRX_BTI must be zero.  This implies DABRX_HYP cannot be set.
> 
> BTW, the requirement that DABRX_USER and DABRX_KERNEL cannot both be zero
> at the same time is also there, cfr. your comment and check in
> pseries_set_xdabr().
> 
> Unfortunately, I cannot test it.

OK thanks, I'll mask appropriately.

Any place we can get a copy of the PS3 HV doc you're quoting from?

Mikey 
