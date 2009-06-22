Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id B7376B712A
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 23 Jun 2009 08:26:07 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 10120DDD1C
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Jun 2009 08:26:06 +1000 (EST)
Subject: Re: Boot failure on the powerstation with 2.6.30 latest
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
In-Reply-To: <1245708236.17035.2.camel@mulgrave.site>
References: <1245683801.6901.8.camel@mulgrave.site>
	<4A3FAD31.2060703@linux.vnet.ibm.com>
	<1245708236.17035.2.camel@mulgrave.site>
Content-Type: text/plain
Date: Tue, 23 Jun 2009 08:25:55 +1000
Message-Id: <1245709555.20062.12.camel@pasglop>
Mime-Version: 1.0
Cc: Brian King <brking@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org,
	Pekka Enberg <penberg@cs.helsinki.fi>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> Actually, no, reverting that one doesn't fix it.
> 
> A full run of git bisect turns up this commit as the culprit; I'll make
> a fuss on lkml:

I haven't had the full log of that boot failure, but reverting the patch
Brian suggested won't work well indeed, as I said, from the moment slab
is initialized, page table allocations will use kmem caches which are
initialized by pgtable_cache_init().

So the problem does indeed seem to be another fallover of moving the
allocator initialization earlier.

I'm working from home today but I'll see if I can get somebody in the
office to wire up the powerstation (got disconnected for some reason
last week) for me so I can have a look.

The mutex issue Brian noticed will definitely break _any_ kmem_cache
operation anyway, so that's one bug that need fixing at least (well,
provided Brian analysis is right, I didn't have a chance to look myself
yet :-)

Cheers,
Ben.

> 83b519e8b9572c319c8e0c615ee5dd7272856090 is first bad commit
> commit 83b519e8b9572c319c8e0c615ee5dd7272856090
> Author: Pekka Enberg <penberg@cs.helsinki.fi>
> Date:   Wed Jun 10 19:40:04 2009 +0300
> 
>     slab: setup allocators earlier in the boot sequence
> 
> James
> 
