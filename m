Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id BA669DDD09
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Aug 2007 02:17:05 +1000 (EST)
Date: Thu, 30 Aug 2007 11:16:47 -0500
From: Scott Wood <scottwood@freescale.com>
To: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH 2/9] bootwrapper: Add strtoull().
Message-ID: <20070830161647.GA25059@ld0162-tx32.am.freescale.net>
References: <20070829164638.GA31640@ld0162-tx32.am.freescale.net>
	<ab107db1fd4d7e9bc3b461b7f4157100@bga.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ab107db1fd4d7e9bc3b461b7f4157100@bga.com>
Cc: ppcdev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Aug 30, 2007 at 10:52:22AM -0500, Milton Miller wrote:
> On Thu Aug 30 02:46:38 EST 2007, Scott Wood wrote:
> 
> >+               if (*ptr >= '0' && *ptr <= '9' && *ptr < '0' + base)
> >+                       digit = *ptr - '0';
> >+               else if (*ptr >= 'A' && *ptr < 'A' + base - 10)
> >+                       digit = *ptr - 'A' + 10;
> >+               else if (*ptr >= 'a' && *ptr < 'z' + base - 10)
> >+                       digit = *ptr - 'a' + 10;
> >+               else
> >+                       break;
> 
> 'z' should also be 'a' like the 'A' case.

Oops.

> Should we add <= 'Z' like we do '9', or do we not care about bases > 
> 36?  (It really breaks above base 42).

I personally don't care about bases > 16; I only supported up to 36
because it was easy to do so.

-Scott
