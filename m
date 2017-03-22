Return-Path: <willy@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [65.50.211.133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vp9H00pzYzDq7Z
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Mar 2017 00:18:20 +1100 (AEDT)
Date: Wed, 22 Mar 2017 06:18:06 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Christophe LEROY <christophe.leroy@c-s.fr>, paulus@samba.org,
 mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
Subject: Re: Optimised memset64/memset32 for powerpc
Message-ID: <20170322131805.GA14657@bombadil.infradead.org>
References: <20170320211447.GB5073@bombadil.infradead.org>
 <18c572e8-a269-c76e-b3a1-e745ac20e5a7@c-s.fr>
 <20170321132910.GA4482@bombadil.infradead.org>
 <1490131572.2504.56.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1490131572.2504.56.camel@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Mar 22, 2017 at 08:26:12AM +1100, Benjamin Herrenschmidt wrote:
> On Tue, 2017-03-21 at 06:29 -0700, Matthew Wilcox wrote:
> > 
> > Well, those are the generic versions in the first patch:
> > 
> > http://git.infradead.org/users/willy/linux-dax.git/commitdiff/538b977
> > 6ac925199969bd5af4e994da776d461e7
> > 
> > so if those are good enough for you guys, there's no need for you to
> > do anything.
> > 
> > Thanks for your time!
> 
> I suspect on ppc64 we can do much better, if anything moving 64-bit at
> a time. Matthew, what are the main use cases of these ?

I've only converted two users so far -- zram was the initial inspiration
for this.  It notices when a page has a pattern in it which is
representable as a repetition of an 'unsigned long' (this seems to be
a relatively common thing for userspace to do -- not as common as an
entirely zero page, but common enough to be worth optimising for).  So it
may be doing an entire page worth of this to handle a page fault, or if
there's an I/O to such a page, it will be doing a multiple of 512 bytes.

The other user is sym53c8xx_2; it's an initialisation path thing, and
it saves a few bytes in the driver to call the optimised routine rather
than have its own loop to initialise the array.

I suspect we have additional places in the kernel that could use
memset32/memset64 -- look for loops which store a value which is not
dependent on the loop counter.  They're probably not performance path
though; I'd focus on zram as being the case to optimise for.

There's one other potential user I've been wondering about, which are the
various console drivers.  They use 'memsetw' to blank the entire console
or lines of the console when scrolling, but the only architecture which
ever bothered implementing an optimised version of it was Alpha.

Might be worth it on powerpc actually ... better than a loop calling
cpu_to_le16() on each iteration.  That'd complete the set with a
memset16().
