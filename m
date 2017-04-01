Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vw8zG6xXvzDqC4
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  1 Apr 2017 18:25:30 +1100 (AEDT)
Message-ID: <1491031518.2944.62.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: Robin Murphy <robin.murphy@arm.com>, Michael Ellerman
 <mpe@ellerman.id.au>,  roy.pledge@nxp.com, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, madalin.bucur@nxp.com
Date: Sat, 01 Apr 2017 02:25:18 -0500
In-Reply-To: <dfaa1a28-66d8-15fb-7d2d-75e206161770@arm.com>
References: <1490822037-6752-1-git-send-email-roy.pledge@nxp.com>
 <1490822037-6752-3-git-send-email-roy.pledge@nxp.com>
 <b1cd8d44-8c74-ab50-5dc9-1f978cae5bdf@arm.com>
 <871ste5dmw.fsf@concordia.ellerman.id.au>
 <dfaa1a28-66d8-15fb-7d2d-75e206161770@arm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [RFC PATCH 2/5] soc/fsl/qbman: Use shared-dma-pool for QMan
 private memory allocations
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-03-31 at 18:55 +0100, Robin Murphy wrote:
> On 31/03/17 04:27, Michael Ellerman wrote:
> > 
> > Robin Murphy <robin.murphy@arm.com> writes:
> > 
> > > 
> > > Hi Roy,
> > > 
> > > On 29/03/17 22:13, Roy Pledge wrote:
> > > > 
> > > > Use the shared-memory-pool mechanism for frame queue descriptor and
> > > > packed frame descriptor record area allocations.
> > > Thanks for persevering with this - in my opinion it's now looking like
> > > it was worth the effort :)
> > > 
> > > AFAICS the ioremap_wc() that this leads to does appear to give back
> > > something non-cacheable on PPC (assuming "pgprot_noncached_wc" isn't
> > > horrendously misnamed), and "no-map" should rule out any cacheable
> > > linear map alias existing, so it would seem that this approach should
> > > avert Scott's concerns about attribute mismatches.
> > How does 'no-map' translate into something being excluded from the
> > linear mapping?
> Reserved regions marked with "no-map" get memblock_remove()d by
> early_init_dt_alloc_reserved_memory_arch(). As I understand things, the
> linear map should only cover memblock areas, and it would be explicitly
> violating the semantics of "no-map" to still cover such a region.

Discontiguous memory isn't supported on these PPC chips.  Everything up to
memblock_end_of_DRAM() gets mapped -- and if that were to change, the
fragmentation would waste TLB1 entries.

This also breaks compatibility with existing device trees.  I suggest putting
an ifdef in the qbman driver to add the new scheme for non-PPC arches only.

-Scott
