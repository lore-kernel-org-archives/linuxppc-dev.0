Return-Path: <axboe@kernel.dk>
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:770:15f::2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 661C01007D1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Dec 2011 22:42:44 +1100 (EST)
Message-ID: <4EE5E8AD.9070706@kernel.dk>
Date: Mon, 12 Dec 2011 12:42:37 +0100
From: Jens Axboe <axboe@kernel.dk>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] block/swim3: Locking fixes
References: <1323665859.19891.16.camel@pasglop>
In-Reply-To: <1323665859.19891.16.camel@pasglop>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2011-12-12 05:57, Benjamin Herrenschmidt wrote:
> The old PowerMac swim3 driver has some "interesting" locking issues,
> using a private lock and failing to lock the queue before completing
> requests, which triggered WARN_ONs among others.
> 
> This rips out the private lock, makes everything operate under the
> block queue lock, and generally makes things simpler.
> 
> We used to also share a queue between the two possible instances which
> was problematic since we might pick the wrong controller in some cases,
> so make the queue and the current request per-instance and use
> queuedata to point to our private data which is a lot cleaner.
> 
> We still share the queue lock but then, it's nearly impossible to actually
> use 2 swim3's simultaneously: one would need to have a Wallstreet
> PowerBook, the only machine afaik with two of these on the motherboard,
> and populate both hotswap bays with a floppy drive (the machine ships
> only with one), so nobody cares...
> 
> While at it, add a little fix to clear up stale interrupts when loading
> the driver or plugging a floppy drive in a bay.

Applied for current for-linus branch.

-- 
Jens Axboe
