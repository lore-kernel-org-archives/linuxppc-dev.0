Return-Path: <rpjday@mindspring.com>
Received: from rubicon.netdirect.ca (nic.NetDirect.CA [216.16.235.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7D8ABDDE29
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Jul 2007 19:22:07 +1000 (EST)
Date: Mon, 16 Jul 2007 05:20:00 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [patch] use __attribute__ in asm-powerpc
In-Reply-To: <Pine.LNX.4.62.0707161117150.1072@pademelon.sonytel.be>
Message-ID: <Pine.LNX.4.64.0707160519090.5261@localhost.localdomain>
References: <200707142336.10343.vapier@gentoo.org>
	<Pine.LNX.4.62.0707161117150.1072@pademelon.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: paulus@samba.org, Mike Frysinger <vapier@gentoo.org>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 16 Jul 2007, Geert Uytterhoeven wrote:

> On Sat, 14 Jul 2007, Mike Frysinger wrote:
> > Pretty much everyone uses "__attribute__" or "attribute", no one
> > uses "__attribute".  This patch tweaks the three places in asm-powerpc where
> > this comes up.  While only asm-powerpc/types.h is interesting (for userspace),
> > I did asm-powerpc/processor.h as well for consistency.
> >
> > Signed-off-by: Mike Frysinger <vapier@gentoo.org>
> > ---
> > diff --git a/include/asm-powerpc/processor.h b/include/asm-powerpc/processor.h
> > index d947b16..2ce6ea6 100644
> > --- a/include/asm-powerpc/processor.h
> > +++ b/include/asm-powerpc/processor.h
> > @@ -153,9 +153,9 @@ struct thread_struct {
> >  	unsigned long	dabr;		/* Data address breakpoint register */
> >  #ifdef CONFIG_ALTIVEC
> >  	/* Complete AltiVec register set */
> > -	vector128	vr[32] __attribute((aligned(16)));
> > +	vector128	vr[32] __attribute__((aligned(16)));
>
> If the code is not exported to userspace (and thus not subject to
> different compilers), I think the preferred form is plain
> `attribute'.

compiler-gcc.h also defines the common form of the shortcut:

#define __aligned(x)                    __attribute__((aligned(x)))

rday
-- 
========================================================================
Robert P. J. Day
Linux Consulting, Training and Annoying Kernel Pedantry
Waterloo, Ontario, CANADA

http://fsdev.net/wiki/index.php?title=Main_Page
========================================================================
