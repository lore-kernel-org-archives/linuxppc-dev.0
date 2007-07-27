Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from inet-tsb5.toshiba.co.jp (inet-tsb5.toshiba.co.jp [202.33.96.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E118ADDD0C
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jul 2007 16:12:00 +1000 (EST)
Date: Fri, 27 Jul 2007 15:11:28 +0900 (JST)
Message-Id: <20070727.151128.-1300540472.kouish@swc.toshiba.co.jp>
To: benh@kernel.crashing.org, michael@ellerman.id.au
Subject: Re: [PATCH] xmon consistency clean up
In-Reply-To: <1185365630.21877.4.camel@concordia.ozlabs.ibm.com>
From: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Michael Ellerman <michael@ellerman.id.au> wrote:
> On Wed, 2007-07-25 at 16:21 +1000, Benjamin Herrenschmidt wrote:
> > On Wed, 2007-07-25 at 11:57 +0900, Ishizaki Kou wrote:
> > > This patch cleans up xmon to keep consistency.
> > > 
> > > In xmon, we should use console I/O functions that are named the
same
> > > as user space stdio functions. But commit
> > > 4d404edce30f911004850d472e05a31efd751662 broke this consistency.
> > > 
> > > Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
> > > ---
> > > 
> > > Index: linux-powerpc-git/arch/powerpc/xmon/nonstdio.c
> > >
===================================================================
> > > --- linux-powerpc-git.orig/arch/powerpc/xmon/nonstdio.c
> > > +++ linux-powerpc-git/arch/powerpc/xmon/nonstdio.c
> > > @@ -133,7 +133,7 @@ void xmon_printf(const char *format, ...
> > >         xmon_write(xmon_outbuf, n);
> > >  }
> > >  
> > > -void xmon_puts(const char *str)
> > > +void xmon_fputs(const char *str)
> > >  {
> > >         xmon_write(str, strlen(str)); 
> > 
> > Nah, keep it xmon_puts, since it doesn't take a stream argument and
> > define a "puts" for use by xmon core.
> 
> But then it needs to add a newline .. and we've gone around in a
circle
> again. Funny how the trivialest of patches gets the most review.

In my opinion, our goal is providing stdio functions like fputs to
xmon.c. So, xmon_fputs need not be compatible with fputs because
xmon.c doesn't use it directly.

Best regards,
Kou Ishizaki
