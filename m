Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tD3Kj0ZFkzDvNW
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Nov 2016 09:06:01 +1100 (AEDT)
Date: Wed, 9 Nov 2016 09:05:57 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 1/2] powerpc/64: Fix checksum folding in
 csum_tcpudp_nofold and ip_fast_csum_nofold
Message-ID: <20161108220557.GA28587@fergus.ozlabs.ibm.com>
References: <20161103051055.GA8368@fergus.ozlabs.ibm.com>
 <878tsul9jh.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <878tsul9jh.fsf@concordia.ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Nov 08, 2016 at 06:23:30PM +1100, Michael Ellerman wrote:
> Paul Mackerras <paulus@ozlabs.org> writes:
> 
> > These functions compute an IP checksum by computing a 64-bit sum and
> > folding it to 32 bits (the "nofold" in their names refers to folding
> > down to 16 bits).  However, doing (u32) (s + (s >> 32)) is not
> > sufficient to fold a 64-bit sum to 32 bits correctly.  The addition
> > can produce a carry out from bit 31, which needs to be added in to
> > the sum to produce the correct result.
> >
> > To fix this, we copy the from64to32() function from lib/checksum.c
> > and use that.
> 
> This seems to have been broken since ~forever. Do we just not hit that
> case very often, or do we just incorrectly report checksum failures?

I think there would be about a 1 in a billion chance of hitting it by
chance, though you could probably construct a test case that would hit
it every time.  If you did hit it in real life it would result in a
packet being dropped and presumably retransmitted, and I expect that
the IP header of the retransmitted packet would be sufficiently
different (i.e. different id field or something) that it wouldn't hit
the bug a second time.

> Should it go to stable?

Probably... though nobody has actually noticed a problem in real life
and pinned it down to this.

Paul.
