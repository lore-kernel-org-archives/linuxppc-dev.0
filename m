Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from pophost.sonytel.be (vervifontaine.sonytel.be [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id EF83EDDF86
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Apr 2009 17:42:05 +1000 (EST)
Date: Wed, 8 Apr 2009 09:42:02 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH] Quieten arch/powerpc in a allmodconfig build.
In-Reply-To: <1239173283.10104.38.camel@localhost>
Message-ID: <alpine.LRH.2.00.0904080940530.15749@vixen.sonytel.be>
References: <2c4bcf8d1d7083ff53ce5b556765e96676a007fb.1239165378.git.tony@bakeyournoodle.com>
	<1239167335.10104.26.camel@localhost>
	<20090408055126.GG16602@bilbo.ozlabs.org>
	<1239173283.10104.38.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Cc: linuxppc-dev@ozlabs.org, Nathan Lynch <ntl@pobox.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 8 Apr 2009, Michael Ellerman wrote:
> On Wed, 2009-04-08 at 15:51 +1000, Tony Breeds wrote:
> > On Wed, Apr 08, 2009 at 03:08:55PM +1000, Michael Ellerman wrote:
> > 
> > > The getter routines in here could really multiplex their return values
> > > with a negative error code, which I generally prefer, but this works I
> > > guess.
> > 
> > I was hoping someone would notice and suggest it.  tag you're it!
> 
> I meant we /could/ change them, but we could also leave them, it's a bit
> of a coin-flip which is better. Nathan might have an opinion?
> 
> Something like this:
> 
> diff --git a/arch/powerpc/kernel/cacheinfo.c b/arch/powerpc/kernel/cacheinfo.c
> index bb37b1d..9f3a155 100644
> --- a/arch/powerpc/kernel/cacheinfo.c
> +++ b/arch/powerpc/kernel/cacheinfo.c

> -static int cache_size_kb(const struct cache *cache, unsigned int *ret)
> +static int cache_size_kb(const struct cache *cache)
>  {
>         unsigned int size;
          ^^^^^^^^^^^^
`int size', or Roel will come to get you ;-)

>  
> -       if (cache_size(cache, &size))
> -               return -ENODEV;
> +       size = cache_size(cache);
> +       if (size < 0)
              ^^^^^^^^
> +               return size;

I can't check the others, due to lacking context...

With kind regards,

Geert Uytterhoeven
Software Architect

Sony Techsoft Centre Europe
The Corporate Village · Da Vincilaan 7-D1 · B-1935 Zaventem · Belgium

Phone:    +32 (0)2 700 8453
Fax:      +32 (0)2 700 8622
E-mail:   Geert.Uytterhoeven@sonycom.com
Internet: http://www.sony-europe.com/

A division of Sony Europe (Belgium) N.V.
VAT BE 0413.825.160 · RPR Brussels
Fortis · BIC GEBABEBB · IBAN BE41293037680010
