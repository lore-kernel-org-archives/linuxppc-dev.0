Return-Path: <paulus@bilbo.ozlabs.org>
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id EDC7CDDEDF
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Mar 2009 13:48:09 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18881.45670.404687.859754@cargo.ozlabs.ibm.com>
Date: Thu, 19 Mar 2009 13:48:06 +1100
From: Paul Mackerras <paulus@samba.org>
To: Timur Tabi <timur@freescale.com>
Subject: Re: Confused about CLOCK_TICK_RATE
In-Reply-To: <49B95BEC.2010404@freescale.com>
References: <49B95BEC.2010404@freescale.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Timur Tabi writes:

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

It's used essentially for making small adjustments to ACTHZ and
TICK_NSEC in include/linux/jiffies.h.  The value was chosen so that
ACTHZ == HZ and TICK_NSEC = 1e9 for all common HZ values, since we
can't say at compile time what the decrementer frequency will be.
I believe it's all pretty moot since we changed over to using the
generic time framework anyway.

Paul.
