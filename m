Return-Path: <ak@suse.de>
Received: from mx2.suse.de (ns2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id BD68067B44
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Jun 2006 20:16:43 +1000 (EST)
From: Andi Kleen <ak@suse.de>
To: Mel Gorman <mel@csn.ul.ie>
Subject: Re: [PATCH 0/5] Sizing zones and holes in an architecture independent
	manner V7
Date: Wed, 7 Jun 2006 12:16:24 +0200
References: <20060606134710.21419.48239.sendpatchset@skynet.skynet.ie>
	<200606071145.04938.ak@suse.de>
	<Pine.LNX.4.64.0606071059480.20653@skynet.skynet.ie>
In-Reply-To: <Pine.LNX.4.64.0606071059480.20653@skynet.skynet.ie>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200606071216.24640.ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, davej@codemonkey.org.uk, tony.luck@intel.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	bob.picco@hp.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Right now, x86_64 seems to be the only arch that accounts for the kernel 
> image and memmap as holes so I would consider it to be unusual.

s/unusual/more advanced/

> For memory  
> hot-add, new memmaps are allocated using kmalloc() and are not accounted 
> for as holes. 

At least in the standard (non sparsemem) hotadd they are accounted afaik.

> So, on x86_64, some memmaps are holes and others are not. 
> 
> Why is it a performance regression if the image and memmap is accounted 
> for as holes? How are those regions different from any other kernel 
> allocation or bootmem allocations for example which are not accounted as 
> holes? 

They are comparatively big and cannot be freed.

>If you are sure that it makes a measurable difference to performance,

There was at least one benchmark/use case where it made a significant
difference, can't remember the exact numbers though.

-Andi
