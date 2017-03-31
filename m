Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vvRlW62LbzDqGw
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Mar 2017 14:27:51 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Robin Murphy <robin.murphy@arm.com>, roy.pledge@nxp.com, oss@buserror.net,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org
Cc: madalin.bucur@nxp.com
Subject: Re: [RFC PATCH 2/5] soc/fsl/qbman: Use shared-dma-pool for QMan
 private memory allocations
In-Reply-To: <b1cd8d44-8c74-ab50-5dc9-1f978cae5bdf@arm.com>
References: <1490822037-6752-1-git-send-email-roy.pledge@nxp.com>
 <1490822037-6752-3-git-send-email-roy.pledge@nxp.com>
 <b1cd8d44-8c74-ab50-5dc9-1f978cae5bdf@arm.com>
Date: Fri, 31 Mar 2017 14:27:51 +1100
Message-ID: <871ste5dmw.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Robin Murphy <robin.murphy@arm.com> writes:

> Hi Roy,
>
> On 29/03/17 22:13, Roy Pledge wrote:
>> Use the shared-memory-pool mechanism for frame queue descriptor and
>> packed frame descriptor record area allocations.
>
> Thanks for persevering with this - in my opinion it's now looking like
> it was worth the effort :)
>
> AFAICS the ioremap_wc() that this leads to does appear to give back
> something non-cacheable on PPC (assuming "pgprot_noncached_wc" isn't
> horrendously misnamed), and "no-map" should rule out any cacheable
> linear map alias existing, so it would seem that this approach should
> avert Scott's concerns about attribute mismatches.

How does 'no-map' translate into something being excluded from the
linear mapping?

cheers
