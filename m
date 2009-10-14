Return-Path: <tj@kernel.org>
Received: from hera.kernel.org (hera.kernel.org [140.211.167.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 49301B7063
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 14 Oct 2009 12:49:50 +1100 (EST)
Message-ID: <4AD52E37.80209@kernel.org>
Date: Wed, 14 Oct 2009 10:49:43 +0900
From: Tejun Heo <tj@kernel.org>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: New percpu & ppc64 perfs
References: <1255478358.2347.28.camel@pasglop>
In-Reply-To: <1255478358.2347.28.camel@pasglop>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello, Benjamin.

Benjamin Herrenschmidt wrote:
> So I found (and fixed, though the patch isn't upstream yet) the problem
> that was causing the new percpu to hang when accessing the top of our
> vmalloc space.
> 
> However, I have some concerns about that choice of location for the
> percpu datas.
> 
> Basically, our MMU divides the address space into "segments" (of 256M or
> 1T depending on your processor capabilities) and those segments are SW
> loaded into a relatively small (64 entries) SLB buffer.
> 
> Thus, by moving the per-cpu to the end of the vmalloc space, you
> essentially make it use a different segment from the rest of the vmalloc
> space, which will overall degrade performances by increasing pressure on
> the SLB.
> 
> It would be nicer if we could provide an arch function to provide a
> "preferred" location for the per-cpu data.
> 
> I can easily cook up a patch but wanted to discuss that with you first.
> Any reason why we would keep it within vmalloc space for example ? IE. I
> could move VMALLOC_END to below the per-cpu reserved areas, or are they
> subject to expansion past boot time ?
> 
> Also, how big can they be ? Ie, will the top of the first 256M segment
> good enough or that will risk blowing out of space ? In general,
> machines with 256M segments won't have more than 64 or maybe 128 CPUs I
> believe. Bigger machines will have CPUs that support 1T segments.

Hmm... I don't think 256M segment will be enough.  Percpu area layout
will follow how numa memory is laidd out.  For example, if a machine
has 4 nodes (each one with one cpu) and memory for each node is 1G in
size and 1G apart, the first chunk will be embedded in the linear
mapping area (normal kernel addressable area) and each unit in the
chunk will be apart by between 1G and 2G.  As the first chunk is
embedded in the linear mapped area, this shouldn't cause any extra
overhead.

The vmalloc area is used when the first chunk is filled and another
chunk need to be allocated.  From the second chunk on, vmalloc area is
used to preserve the layout of the first chunk.  ie. Each of them will
span across 8G bytes (they will overlap tho, so even with many dynamic
chunks vm usage will only be slightly over 8G).

The reason why vmalloc area from the top is used is that I didn't want
this congruent allocation to compete with normal vmalloc allocations.
Depending on the numa layout, competition between linear allocation
and congruent allocation may create many unnecessary holes.

For 256M segment, I don't think much can be done but for 1T segment,
just limiting vmalloc area size to 1T should do the trick, no?

Thanks.

-- 
tejun
