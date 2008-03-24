Return-Path: <timur@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6B5C7DDE1A
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Mar 2008 01:54:32 +1100 (EST)
Message-ID: <47E7C05C.2000001@freescale.com>
Date: Mon, 24 Mar 2008 09:53:16 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/2 v2] Driver for Freescale 8610 and 5121 DIU
References: <12059526271941-git-send-email-yorksun@freescale.com>	<12059526274026-git-send-email-yorksun@freescale.com>	<20080320152708.23c6c734.akpm@linux-foundation.org>	<47E3DE6E.2050801@freescale.com>
	<20080321111228.95a7d9ab.akpm@linux-foundation.org>
In-Reply-To: <20080321111228.95a7d9ab.akpm@linux-foundation.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-fbdev-devel@lists.sourceforge.net,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	York Sun <yorksun@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Andrew Morton wrote:

>>> GFP_DMA implies GFP_ATOMIC, but it's appropriate for documentation purposes.
>> So does that mean that "GFP_DMA | GFP_KERNEL" is always wrong?
> 
> No, that's OK too.  It's just that GFP_DMA|GFP_ATOMIC is a bit redundant
> and misleading.  GFP_DMA is already atomic; the only effect of adding
> GFP_ATOMIC to GFP_DMA is to add __GFP_HIGH.
> 
> Don't wory about it ;)

Well, maybe we don't want GFP_ATOMIC then, because I don't think we want
__GFP_HIGH.  Looking at the code, it appears the __GFP_HIGH has nothing to do
with HIGHMEM (which on PowerPC is the not 1-to-1 mapping memory from 0xF000000
to 0xFFFFFFFF).  Further examination of the cools shows the __GFP_HIGH says to
try access the "emergency pool", and I see this code snippet:

	if (alloc_flags & ALLOC_HIGH)
		min -= min / 2;

I guess this means that we reduce the amount of memory that can be available in
order for the allocate to succeed.

Considering that the amount of memory that we allocate is in the order of
megabytes, and it really isn't that important, I would think that we don't want
to touch the emergency pool.  Does that sound right?

-- 
Timur Tabi
Linux kernel developer at Freescale
