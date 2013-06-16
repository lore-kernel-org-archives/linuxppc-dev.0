Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 2097A2C00A0
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 16 Jun 2013 14:06:25 +1000 (EST)
Message-ID: <1371355567.21896.101.camel@pasglop>
Subject: Re: [PATCH -V10 00/15] THP support for PPC64
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Sun, 16 Jun 2013 14:06:07 +1000
In-Reply-To: <1371353865.21896.94.camel@pasglop>
References: <1370446119-8837-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1371348007.21896.62.camel@pasglop> <1371353865.21896.94.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Alexey Kardashevskiy <aik@au1.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2013-06-16 at 13:37 +1000, Benjamin Herrenschmidt wrote:
> On Sun, 2013-06-16 at 12:00 +1000, Benjamin Herrenschmidt wrote:
> > So at this point, hash_page might *still* see the old pmd. Unless I
> > missed something, you did nothing that will prevent that (the only way
> > to lock against hash_page is really an IPI & wait or to take the PTE's
> > busy and make them !present or something). So as far as I can tell,
> > a concurrent hash_page can still sneak into the hash some "small"
> > entries after you have supposedly flushed them.
> 
> Note that the _PAGE_PRESENT bit is removed eventually ... but much
> later, in __collapse_huge_page_copy() which will also flush the hash, so
> at least we will remove a stale hash entry that would have been added by
> the race above I suppose...  but:
> 
>  - _PAGE_ACCESSED can still potentially be set after it was supposed to
> be stable
> 
>  - The clearing happens *after* copy_user_highpage(), ie, unless I
> missed something here, we potentially still have something writing to
> the 4k page while it's being copied, which is BAD.
> 
> Now, let me know if I did miss something here :-)

An additional issue is that this all collides a bit with Alexey's work
to support TCEs in real mode in KVM, which is necessary to have "usable"
PCI pass-through.

Look at patches http://patchwork.ozlabs.org/patch/248920/ and followup,
he basically walks the page tables here in a slightly different way than
Paul does in H_ENTER. It's more like gup_fast. It will need to handle
concurrent split/collapse etc... as well which it doesn't right now.

I'm considering merging Alexei stuff first (provided I don't find major
problems with it), then you can provide a new THP series on top of it.

While at it, also fix:

 - Some of your patches are bug fixes (like the one about subpage
protection). They need to be either merged in the main patch or put
before the patch that enables THP.

 - I haven't completely yet considered the impact of the demotion of
segments, but neither do you :-) IE. Under some circumstances, we can
demote entire segments from 64K HW pages to 4K HW pages in the SLB. For
example if a driver (such as HCA) sets the 4K_PFN bit in a PTE, this
will happen at hashing time. I don't think your code deals with that at
all, am I correct ? It *might* be that the right approach with those is:

  * If you find a THP in hash_page and the segment size is 4k, fault

  * In do_page_fault, re-check for that condition (or maybe we can make
hash_page return a specific bit that gets ORed into the error_code into
do_page_fault ?) and split huge pages there.

But that's just an idea off the top of my mind, there might be a better
way. Of course this needs to be tested.

BTW. For the subpage protection, similarily, you need to make sure you
properly map the entire segment as "no THP", not just the range
passed-in by the user.

Cheers,
Ben.
 
