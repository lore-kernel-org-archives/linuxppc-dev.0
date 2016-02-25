Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CD98C1A0341
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Feb 2016 15:12:30 +1100 (AEDT)
Message-ID: <1456373550.30375.3.camel@ellerman.id.au>
Subject: Re: Problems with swapping in v4.5-rc on POWER
From: Michael Ellerman <mpe@ellerman.id.au>
To: Hugh Dickins <hughd@google.com>, "Aneesh Kumar K.V"
 <aneesh.kumar@linux.vnet.ibm.com>
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org
Date: Thu, 25 Feb 2016 15:12:30 +1100
In-Reply-To: <alpine.LSU.2.11.1602241716220.15121@eggly.anvils>
References: <alpine.LSU.2.11.1602241716220.15121@eggly.anvils>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-02-24 at 18:10 -0800, Hugh Dickins via Linuxppc-dev wrote:

> I've plagiarized the subject from Paulus's "Problems with THP" mail
> last weekend; but my similar problems are on PowerMac G5 baremetal,
> with 4kB pages, not capable of THP and no THP configured in.
> 
> Under heavily swapping load, running kernel builds on tmpfs in limited
> memory, I've been seeing random segfaults too, internal compiler errors
> etc.  Not easily reproduced: sometimes happens in minutes, sometimes
> not for several hours.
> 
> I tried and failed to construct a reproducer for you: my lack of a good
> recipe has deterred me from reporting it, and seeing Paulus's mail on
> THP gave me hope that the answer would come up in that thread; but no,
> that was quickly resolved as a THP issue, since fixed.
> 
> (Mine had appeared to be fixed in v4.5-rc4 anyway; but I guess I
> just didn't try hard enough, it resurfaced on -rc5 immediately.)
> 
> I've seen no sign of such problems on x86.  And I saw no sign of such
> problems on v4.4-rc8-mm1, when I included the fixes to the _PAGE_PTE
> and _PAGE_SWP_SOFT_DIRTY swapoff issues we discussed back then (in
> 33 hours of load, should be good enough; but did see such problems
> a couple of times before including those fixes - I took them to be
> a side-effect of the page flags issue, but now rather doubt that).
> 
> The minutes or hours thing: I wonder if that indicates a missing
> initialization somewhere: that can easily show up soon after booting,
> but then the machine settles into a steady state of reusing the same
> structures, now initialized; until much later something disturbs the
> state and it has to allocate more.  Sheer speculation, but I wonder.

Thanks Hugh.

I do run tests on G5, but obviously not rigorously enough. I kicked off a few
kernel builds on mine and it survived, though once it hits swap it's almost
unusably slow. I'll leave it running overnight and see if I hit anything.

cheers
