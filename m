Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rT61D1vW0zDqcq
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jun 2016 07:51:28 +1000 (AEST)
Message-ID: <1465854679.3022.31.camel@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: convert 'iommu_alloc failed' messages to
 dynamic debug
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Date: Tue, 14 Jun 2016 07:51:19 +1000
In-Reply-To: <575F290A.2070902@linux.vnet.ibm.com>
References: <1465563831-6565-1-git-send-email-mauricfo@linux.vnet.ibm.com>
 <1465686148.19533.28.camel@kernel.crashing.org>
 <575EB4DE.9080807@linux.vnet.ibm.com>
 <1465853216.3022.26.camel@kernel.crashing.org>
 <575F290A.2070902@linux.vnet.ibm.com>
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

On Mon, 2016-06-13 at 18:43 -0300, Mauricio Faria de Oliveira wrote:
> Hi Ben,
> 
> On 06/13/2016 06:26 PM, Benjamin Herrenschmidt wrote:
> > I've been thinking about this a bit... it might be worthwhile adding
> > a dma_* call to query the approximate size of the IOMMU window, as
> > a way for the device to adjust its requirements dynamically.
> 
> Ok, cool; something like it was one of the options being discussed here.
> 
> What do you mean by 'approximate'? Maybe the size of 'free regions' in 
> the pools? -- not sure because iiuic the window size is static / 2 gig,
> so didn't get why (or of what) to provide an approximation (for).

Approximate wasn't a great choice of word but what I meant is:

 - The size doesn't mean you can do an allocation that size (pools
layout etc..)

 - And it might be shared with another device (though less likely
these days).

> > Another option would be to use a dma_attr for silencing mapping errors
> > which NVME could use provided it does handle them gracefully ...
> 
> Ah, that's new. Interesting. Thanks for suggestion!

Cheers,
Ben.
