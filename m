Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (unknown [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id 0C7A7DDE40
	for <linuxppc-dev@ozlabs.org>; Mon, 21 May 2007 06:39:10 +1000 (EST)
Date: Sun, 20 May 2007 22:39:07 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: 2.6.22-rc2 built on ppc
In-Reply-To: <4650960E.9010707@s5r6.in-berlin.de>
Message-ID: <Pine.LNX.4.62.0705202237320.1803@pademelon.sonytel.be>
References: <20070520112904.GM3253@aragorn.home.lxtec.de>
	<46506EE0.9000405@s5r6.in-berlin.de> <200705201849.29805.arnd@arndb.de>
	<8c9e6fe68260187606a8ad7f402a4fd8@kernel.crashing.org>
	<4650960E.9010707@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Arnd Bergmann <arnd@arndb.de>, ben.collins@ubuntu.com,
	linuxppc-dev@ozlabs.org, linux1394-devel@lists.sourceforge.net,
	Elimar Riesebieter <riesebie@lxtec.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 20 May 2007, Stefan Richter wrote:
> Segher Boessenkool wrote:
> >>> I don't know what's to blame for the warnings --- new gcc versions or
> >>> the change from do { } while (0) to ((void)0)?  Either way, the compiler
> >>> should comprehend that the arguments stuffed into the dma_unmap_single
> >>> macro are _not_ unused by accident; it should stay quiet and optimize
> >>> the unused variables away if run with -Osomething.
> >>
> >> There is not much that the compiler can do by itself, since the macro
> >> expansion happens in the preprocessor.
> > 
> > Even if the compiler could see that the variables are
> > used as macro arguments, this doesn't automatically
> > equate to it being able to infer the variables are
> > unused on purpose.
> 
> Strange.  I believe we had code before with variables that were only
> used in macros that expanded to <nil>, notably debug logging macros
> which were usually configured out.  Perhaps I'm mistaken.

No, they were unused by the macro when DEBUG was not set.
Only when dev_dbg() was converted from a macro to a static inline function
did they start to be used (according to the compiler) all the time.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Sony Network and Software Technology Center Europe (NSCE)
Geert.Uytterhoeven@sonycom.com ------- The Corporate Village, Da Vincilaan 7-D1
Voice +32-2-7008453 Fax +32-2-7008622 ---------------- B-1935 Zaventem, Belgium
