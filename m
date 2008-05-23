Return-Path: <npiggin@suse.de>
Received: from mx1.suse.de (mail.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 75C80DE019
	for <linuxppc-dev@ozlabs.org>; Fri, 23 May 2008 14:40:58 +1000 (EST)
Date: Fri, 23 May 2008 06:40:52 +0200
From: Nick Piggin <npiggin@suse.de>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [patch 1/2] powerpc: rmb fix
Message-ID: <20080523044052.GA13071@wotan.suse.de>
References: <20080521141056.GC8897@wotan.suse.de>
	<1211383623.8297.197.camel@pasglop>
	<20080521153247.GF8897@wotan.suse.de>
	<18486.10385.934128.122054@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <18486.10385.934128.122054@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, May 23, 2008 at 12:14:41PM +1000, Paul Mackerras wrote:
> Nick Piggin writes:
> 
> > More than one device driver does raw/relaxed io accessors and expects the
> > *mb functions to order them.
> 
> Can you point us at an example?

Uh, I might be getting confused because the semantics are completely
different eg. between powerpc and ia64.

There don't seem to actually be read*_relaxed calls that also use rmb
in the same file (although there is no reason why they might not appear).
But I must be thinking of are the raw_read accessors. They aren't ordered
on powerpc, and a few drivers appear to hope rmb() will order them.


 
> I don't think the semantics of the raw accessors are particularly well
> defined (it's not even defined what endianness the data comes back in)
> so I'd be surprised if there was any real definition of their
> behaviour w.r.t. barriers.

I think it is fair to say the intention of the _relaxed variants is
that they require memory barriers for ordering. No idea about raw read
or write but it appears that at least on powerpc and alpha they are
unordered.
