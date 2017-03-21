Return-Path: <willy@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [65.50.211.133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vnYZ96CDzzDq7c
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Mar 2017 00:29:21 +1100 (AEDT)
Date: Tue, 21 Mar 2017 06:29:10 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Christophe LEROY <christophe.leroy@c-s.fr>
Cc: paulus@samba.org, benh@kernel.crashing.org, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: Optimised memset64/memset32 for powerpc
Message-ID: <20170321132910.GA4482@bombadil.infradead.org>
References: <20170320211447.GB5073@bombadil.infradead.org>
 <18c572e8-a269-c76e-b3a1-e745ac20e5a7@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <18c572e8-a269-c76e-b3a1-e745ac20e5a7@c-s.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Mar 21, 2017 at 01:23:36PM +0100, Christophe LEROY wrote:
> > It doesn't look free for you as you only store one register each time
> > around the loop in the 32-bit memset implementation:
> > 
> > 1:      stwu    r4,4(r6)
> >         bdnz    1b
> > 
> > (wouldn't you get better performance on 32-bit powerpc by unrolling that
> > loop like you do on 64-bit?)
> 
> In arch/powerpc/lib/copy_32.S, the implementation of memset() is optimised
> when the value to be set is zero. It makes use of the 'dcbz' instruction
> which zeroizes a complete cache line.
> 
> Not much effort has been put on optimising non-zero memset() because there
> are almost none.

Yes, bzero() is much more common than setting an 8-bit pattern.
And setting an 8-bit pattern is almost certainly more common than setting
a 32 or 64 bit pattern.

> Unrolling the loop could help a bit on old powerpc32s that don't have branch
> units, but on those processors the main driver is the time spent to do the
> effective write to memory, and the operations necessary to unroll the loop
> are not worth the cycle added by the branch.
> 
> On more modern powerpc32s, the branch unit implies that branches have a zero
> cost.

Fair enough.  I'm just surprised it was worth unrolling the loop on
powerpc64 and not on powerpc32 -- see mem_64.S.

> A simple static inline C function would probably do the job, based on what I
> get below:
> 
> void memset32(int *p, int v, unsigned int c)
> {
> 	int i;
> 
> 	for (i = 0; i < c; i++)
> 		*p++ = v;
> }
> 
> void memset64(long long *p, long long v, unsigned int c)
> {
> 	int i;
> 
> 	for (i = 0; i < c; i++)
> 		*p++ = v;
> }

Well, those are the generic versions in the first patch:

http://git.infradead.org/users/willy/linux-dax.git/commitdiff/538b9776ac925199969bd5af4e994da776d461e7

so if those are good enough for you guys, there's no need for you to
do anything.

Thanks for your time!
