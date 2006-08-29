Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-01.arcor-online.net (mail-in-07.arcor-online.net
	[151.189.21.47])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 469AC67B32
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Aug 2006 16:57:28 +1000 (EST)
In-Reply-To: <17651.34629.132793.190742@cargo.ozlabs.ibm.com>
References: <1156786523.28490.52.camel@basalt.austin.ibm.com>
	<17651.34629.132793.190742@cargo.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <06271675-3293-4AF8-ADE3-AE776CCA82C2@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: copy_4K_page() doesn't use dcbtst?
Date: Tue, 29 Aug 2006 08:57:10 +0200
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
	Hollis Blanchard <hollisb@us.ibm.com>,
	xen-ppc-devel <xen-ppc-devel@lists.xensource.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> A stronger argument would be for using dcbz, but IIRC it actually made
> things slower (on POWER4 at least).  I suspect the hardware is
> gathering the stores for the whole of each cache line automatically,
> so using dcbz doesn't provide any benefit.

It seems on 970 at least it still is a nice win.  Do you have any
good benchmarks I could run?

> I did a lot of measurements of memory copy speed on POWER4 (using
> different copy loops, copy sizes, alignments, cache hot/cold cases)
> and the copy_4K_page loop is the fastest I could come up with for
> POWER4.

Yeah, POWER4 is quite a different beast (its memory subsystem,
anyway).  I'm surprised dcbz hurt though; did you schedule it
early enough before the actual data copy?


Segher
