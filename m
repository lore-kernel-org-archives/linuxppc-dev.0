Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D27C0DDD04
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Mar 2009 05:34:15 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n2IIYAut024143
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Mar 2009 11:34:11 -0700 (MST)
Date: Wed, 18 Mar 2009 13:34:10 -0500
From: Scott Wood <scottwood@freescale.com>
To: Timur Tabi <timur@freescale.com>
Subject: Re: Confused about CLOCK_TICK_RATE
Message-ID: <20090318183410.GB3410@loki.buserror.net>
References: <49B95BEC.2010404@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <49B95BEC.2010404@freescale.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Mar 12, 2009 at 02:01:00PM -0500, Timur Tabi wrote:
> Can someone explain CLOCK_TICK_RATE to me?  It's defined in
> arch/powerpc/include/asm/timex.h as such:
> 
> #define CLOCK_TICK_RATE	1024000 /* Underlying HZ */
> 
> Every architecture defines this, but some use the better comment
> "Underlying frequency of the HZ timer".
> 
> My question is: why is this a constant? Shouldn't it be a variable,
> perhaps something that is based on tb_ticks_per_usec?

Looks like legacy crud, originally meant to be the PIT input frequency, that
isn't used for much on powerpc.  It was probably chosen so as to make HZ ==
ACTHZ for the supported values of HZ.

-Scott
