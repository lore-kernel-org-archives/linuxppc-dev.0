Reply-To: <joakim.tjernlund@lumentis.se>
From: "Joakim Tjernlund" <joakim.tjernlund@lumentis.se>
To: "Stephan Linke" <Stephan.Linke@epygi.de>
Cc: "Linuxppc-Embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: 8xx i2c refers to unspecified chip errata
Date: Fri, 11 Oct 2002 14:44:50 +0200
Message-ID: <IGEFJKJNHJDCBKALBJLLEEAPFHAA.joakim.tjernlund@lumentis.se>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <FCEAKDJJAPHPLJFINDAJMENNCJAA.Stephan.Linke@epygi.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

Look in cpm_iic_read() for:
/* flush will invalidate too. */
flush_dcache_range((unsigned long)buf, (unsigned long)(buf+count));

You can't just do invalidate_dcache_range() since it will invalidate more than your buffer
if it's not cache line aligned. Therefore you must flush to memory first and then invalidate.
But you don't need an explicit invalidate_dcache_range() since flush_dcache_range() will flush to
memory AND invalidate.

  Jocke

>
> Hi,
>
> I had a look at you code. Some of the changes I already did in my code. :)
> I couldn't find any thing that looks like it's fixing the memory problem
> that you mentioned. I'm looking for a memory problem by my self and I wonder
> what you might have figured out. Could you tell me more details?
>
> Regards, Stephan
>
> > -----Original Message-----
> > From: owner-linuxppc-embedded@lists.linuxppc.org
> > [mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf Of Joakim
> > Tjernlund
> > Sent: Freitag, 11. Oktober 2002 11:12
> > To: bart@ardistech.com
> > Cc: linuxppc-embedded@lists.linuxppc.org
> > Subject: RE: 8xx i2c refers to unspecified chip errata
> >
> >
> > OK, here it is.
> >
> > Perhaps someone can add it to the ppctree?
> >
> >  Jocke
> >
> > >
> > >
> > > Hi Joakim,
> > >
> > > > Anyway I have fixed the bugs in i2c-algo-8xx.c driver and
> > it's working great for me
> > > > so I think I will stick with it for the time being.
> > > >
> > > Could you please post the fixes on the list? I also might want
> > to use them.
> > >
> > > Thanks,
> > > 	Bart
> > >
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
