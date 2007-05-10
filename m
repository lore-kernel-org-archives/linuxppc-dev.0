Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (unknown [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id D96DCDDF0A
	for <linuxppc-dev@ozlabs.org>; Fri, 11 May 2007 02:06:47 +1000 (EST)
Date: Thu, 10 May 2007 18:06:46 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] Mark prop unused in early_init_dt_scan_chosen().
In-Reply-To: <4643404E.30608@freescale.com>
Message-ID: <Pine.LNX.4.62.0705101806130.7750@pademelon.sonytel.be>
References: <20070508171451.GA8893@ld0162-tx32.am.freescale.net>
	<Pine.LNX.4.64.0705092238390.29512@localhost.localdomain>
	<Pine.LNX.4.62.0705100938110.32241@pademelon.sonytel.be>
	<4643404E.30608@freescale.com>
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

On Thu, 10 May 2007, Scott Wood wrote:
> Geert Uytterhoeven wrote:
> > On Wed, 9 May 2007, Kumar Gala wrote:
> > > On Tue, 8 May 2007, Scott Wood wrote:
> > > > -	u32 *prop;
> > > > +	u32 __attribute__((unused)) *prop;
> > > 
> > > is this the desired way to remove warnings related to CONFIG_ options?  I
> > > know in the past we'd wrap it with a #ifdef CONFIG_FOO
> 
> Granted...  in this case, it looked as if there could be potential for using
> it for other things in the future as well.  That, and the extra ifdefs are
> ugly. :-)
> 
> > Exactly my thought.
> > 
> > Another advantage of #ifdef CONFIG_FOO is that if the actual code that uses
> > it
> > goes away, we'll get a warning again. Else in the end we'll be stuck with
> > zillions of unused variables that don't cause warnings...
> 
> Again, granted -- though I'd say the primary problem in that case is functions
> that are too long to determine that by visual inspection alone.
> 
> I agree with Michael Ellerman that it'd be best to just factor the initrd
> stuff out into its own function.

Yes, Michael Ellerman's patch is an even better solution.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Sony Network and Software Technology Center Europe (NSCE)
Geert.Uytterhoeven@sonycom.com ------- The Corporate Village, Da Vincilaan 7-D1
Voice +32-2-7008453 Fax +32-2-7008622 ---------------- B-1935 Zaventem, Belgium
