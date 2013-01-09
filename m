Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 019B12C0106
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Jan 2013 14:33:19 +1100 (EST)
Message-ID: <1357702376.4838.32.camel@pasglop>
Subject: Re: [PATCH 7/8] mm: use vm_unmapped_area() on powerpc architecture
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michel Lespinasse <walken@google.com>
Date: Wed, 09 Jan 2013 14:32:56 +1100
In-Reply-To: <CANN689EJV_7Q7J4j1ttDxZuqbwD53PAuCHb5DhiE-AVbmNSR7Q@mail.gmail.com>
References: <1357694895-520-1-git-send-email-walken@google.com>
 <1357694895-520-8-git-send-email-walken@google.com>
 <1357697739.4838.30.camel@pasglop>
 <CANN689EJV_7Q7J4j1ttDxZuqbwD53PAuCHb5DhiE-AVbmNSR7Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Rik van Riel <riel@redhat.com>, Tony Luck <tony.luck@intel.com>,
 linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org,
 "James E.J. Bottomley" <jejb@parisc-linux.org>, linux-kernel@vger.kernel.org,
 David Howells <dhowells@redhat.com>, linux-mm@kvack.org,
 linux-alpha@vger.kernel.org, Matt Turner <mattst88@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2013-01-08 at 18:38 -0800, Michel Lespinasse wrote:
> 
> Well no fair, the previous patch (for powerpc as well) has 22
> insertions and 93 deletions :)
> 
> The benefit is that the new code has lower algorithmic complexity, it
> replaces a per-vma loop with O(N) complexity with an outer loop that
> finds contiguous slice blocks and passes them to vm_unmapped_area()
> which is only O(log N) complexity. So the new code will be faster for
> workloads which use lots of vmas.
> 
> That said, I do agree that the code that looks for contiguous
> available slices looks kinda ugly - just not sure how to make it look
> nicer though.

Ok. I think at least you can move that construct:

+               if (addr < SLICE_LOW_TOP) {
+                       slice = GET_LOW_SLICE_INDEX(addr);
+                       addr = (slice + 1) << SLICE_LOW_SHIFT;
+                       if (!(available.low_slices & (1u << slice)))
+                               continue;
+               } else {
+                       slice = GET_HIGH_SLICE_INDEX(addr);
+                       addr = (slice + 1) << SLICE_HIGH_SHIFT;
+                       if (!(available.high_slices & (1u << slice)))
+                               continue;
+               }

Into some kind of helper. It will probably compile to the same thing but
at least it's more readable and it will avoid a fuckup in the future if
somebody changes the algorithm and forgets to update one of the
copies :-)

Cheers,
Ben.
