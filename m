Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 68EAEB70E0
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Sep 2010 20:04:41 +1000 (EST)
Subject: Re: Reserved pages in PowerPC
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ankita Garg <ankita@in.ibm.com>
In-Reply-To: <20100916052311.GC2332@in.ibm.com>
References: <20100916052311.GC2332@in.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 16 Sep 2010 20:04:24 +1000
Message-ID: <1284631464.30449.85.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-mm@kvack.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2010-09-16 at 10:53 +0530, Ankita Garg wrote:
> 
> With some debugging I found that that section has reserved pages. On
> instrumenting the memblock_reserve() and reserve_bootmem() routines, I can see
> that many of the memory areas are reserved for kernel and initrd by the
> memblock reserve() itself. reserve_bootmem then looks at the pages already
> reserved and marks them reserved. However, for the very last section, I see
> that bootmem reserves it but I am unable to find a corresponding reservation
> by the memblock code.

It's probably RTAS (firmware runtime services). I'ts instanciated at
boot from prom_init and we do favor high addresses for it below 1G iirc.

Cheers,
Ben.
