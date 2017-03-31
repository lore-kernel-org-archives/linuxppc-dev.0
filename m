Return-Path: <robin.murphy@arm.com>
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 3vvq1J6BFdzDqH6
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  1 Apr 2017 04:56:03 +1100 (AEDT)
Subject: Re: [RFC PATCH 2/5] soc/fsl/qbman: Use shared-dma-pool for QMan
 private memory allocations
To: Michael Ellerman <mpe@ellerman.id.au>, roy.pledge@nxp.com,
 oss@buserror.net, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
References: <1490822037-6752-1-git-send-email-roy.pledge@nxp.com>
 <1490822037-6752-3-git-send-email-roy.pledge@nxp.com>
 <b1cd8d44-8c74-ab50-5dc9-1f978cae5bdf@arm.com>
 <871ste5dmw.fsf@concordia.ellerman.id.au>
Cc: madalin.bucur@nxp.com, Mark Rutland <mark.rutland@arm.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <dfaa1a28-66d8-15fb-7d2d-75e206161770@arm.com>
Date: Fri, 31 Mar 2017 18:55:57 +0100
MIME-Version: 1.0
In-Reply-To: <871ste5dmw.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 31/03/17 04:27, Michael Ellerman wrote:
> Robin Murphy <robin.murphy@arm.com> writes:
> 
>> Hi Roy,
>>
>> On 29/03/17 22:13, Roy Pledge wrote:
>>> Use the shared-memory-pool mechanism for frame queue descriptor and
>>> packed frame descriptor record area allocations.
>>
>> Thanks for persevering with this - in my opinion it's now looking like
>> it was worth the effort :)
>>
>> AFAICS the ioremap_wc() that this leads to does appear to give back
>> something non-cacheable on PPC (assuming "pgprot_noncached_wc" isn't
>> horrendously misnamed), and "no-map" should rule out any cacheable
>> linear map alias existing, so it would seem that this approach should
>> avert Scott's concerns about attribute mismatches.
> 
> How does 'no-map' translate into something being excluded from the
> linear mapping?

Reserved regions marked with "no-map" get memblock_remove()d by
early_init_dt_alloc_reserved_memory_arch(). As I understand things, the
linear map should only cover memblock areas, and it would be explicitly
violating the semantics of "no-map" to still cover such a region.

Robin.

> 
> cheers
> 
