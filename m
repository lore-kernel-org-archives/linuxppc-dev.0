Return-Path: <joern@wohnheim.fh-wedel.de>
Received: from moskovskaya.fh-wedel.de (mail.fh-wedel.de [213.39.232.198])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F307467D40
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 28 Jul 2005 19:19:13 +1000 (EST)
Date: Thu, 28 Jul 2005 11:18:37 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Randy Dunlap <rdunlap@xenotime.net>
Message-ID: <20050728091837.GC25033@wohnheim.fh-wedel.de>
References: <1122500059.28777@shark.he.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1122500059.28777@shark.he.net>
Cc: Netdev <netdev@vger.kernel.org>,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>,
	Francois Romieu <romieu@fr.zoreil.com>
Subject: Re: [RFC PATCH 1/4] PHY Abstraction Layer III (now with more
	splitiness)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, 27 July 2005 14:34:19 -0700, Randy Dunlap wrote:
> > 
> > Ok, here I won't agree to disagree with you.  !foo as a check for  
> > NULL is a reasonable idea, but not my style.  If that's the preferred  
> > style for the kernel, I will do that.
> > 
> > But (var == constant) is a style that asks for errors.  By putting  
> > the constant first in these checks, you never run the risk of leaving  
> > a bug like this:
> > 
> > if (dev = NULL)
> >      ...
> > 
> > This kind of error is quite frustrating to detect, and the eye will  
> > often miss it when scanning for errors.  If you follow constant ==  
> > var, though, then the bug looks like this:
> > 
> > if (NULL = dev)
> > 
> > which is instantly caught by the compiler.
> > 
> > Just my 32 cents
> 
> Yes, we know about that argument.  :)

The counter-argument basically goes like this:

1. All relevant compilers (GCC) warn on "if (dev = NULL)", so you will
only miss the bug if you ignore compiler warnings.  Ignoring compiler
warnings is not generally endorsed by the kernel crowd.

2. Very hard to read, "if (NULL = dev)" is.  Reversing the order is a
fun thing to do for small green characters in fantasy and scifi
stories and fairly popular in peotry as well.  But understanding the
meaning of reverse order sentences takes more time.  In the kernel,
peer review is an important aspect and making the code hard to read
hurts peer review.

And maybe you can add another one:

3. Im my personal experience, reverse order comparisons were a good
indicator of buggy code.

Jörn

-- 
Schrödinger's cat is <BLINK>not</BLINK> dead.
-- Illiad
