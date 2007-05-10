Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (unknown [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id 56369DDEBA
	for <linuxppc-dev@ozlabs.org>; Thu, 10 May 2007 17:39:52 +1000 (EST)
Date: Thu, 10 May 2007 09:39:46 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] Mark prop unused in early_init_dt_scan_chosen().
In-Reply-To: <Pine.LNX.4.64.0705092238390.29512@localhost.localdomain>
Message-ID: <Pine.LNX.4.62.0705100938110.32241@pademelon.sonytel.be>
References: <20070508171451.GA8893@ld0162-tx32.am.freescale.net>
	<Pine.LNX.4.64.0705092238390.29512@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 9 May 2007, Kumar Gala wrote:
> On Tue, 8 May 2007, Scott Wood wrote:
> > The prop variable is only referenced when initrd support is
> > turned on.
> >
> > Signed-off-by: Scott Wood <scottwood@freescale.com>
> > ---
> >  arch/powerpc/kernel/prom.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> >
> > diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
> > index caef555..6705459 100644
> > --- a/arch/powerpc/kernel/prom.c
> > +++ b/arch/powerpc/kernel/prom.c
> > @@ -720,7 +720,7 @@ static int __init early_init_dt_scan_chosen(unsigned long node,
> >  					    const char *uname, int depth, void *data)
> >  {
> >  	unsigned long *lprop;
> > -	u32 *prop;
> > +	u32 __attribute__((unused)) *prop;
> 
> is this the desired way to remove warnings related to CONFIG_ options?  I
> know in the past we'd wrap it with a #ifdef CONFIG_FOO

Exactly my thought.

Another advantage of #ifdef CONFIG_FOO is that if the actual code that uses it
goes away, we'll get a warning again. Else in the end we'll be stuck with
zillions of unused variables that don't cause warnings...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Sony Network and Software Technology Center Europe (NSCE)
Geert.Uytterhoeven@sonycom.com ------- The Corporate Village, Da Vincilaan 7-D1
Voice +32-2-7008453 Fax +32-2-7008622 ---------------- B-1935 Zaventem, Belgium
