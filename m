Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 09BDFDDE1B
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Nov 2007 17:47:54 +1100 (EST)
Subject: Re: [PATCH] [PPC 44x] L2-cache synchronization for ppc44x
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Yuri Tikhonov <yur@emcraft.com>
In-Reply-To: <608329302.20071108021252@emcraft.com>
References: <608329302.20071108021252@emcraft.com>
Content-Type: text/plain
Date: Mon, 26 Nov 2007 17:47:30 +1100
Message-Id: <1196059650.7195.88.camel@pasglop>
Mime-Version: 1.0
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Thu, 2007-11-08 at 02:12 +0300, Yuri Tikhonov wrote:
> This is the updated patch for support synchronization of L2-Cache with the external memory on the ppc44x-based platforms.
> 
>  Differencies against the previous patch-set:
> - remove L2_CACHE config option;
> - introduce the ppc machdep to invalidate L2 cache lines;
> - some code clean-up.
> 
> Signed-off-by: Yuri Tikhonov <yur@emcraft.com>
> Signed-off-by: Pavel Kolesnikov <concord@emcraft.com>

It's almost right :-0

You want something a bit more details than just a
ppc_md.l2cache_inv_range.

I'd suggest you do a separate extcache_ops structure that contains
callbacks for all 3 directions (flush, flush & invalidate, invalidate),
then fill that up accordingly.

It might be a good idea in the long run to do some tricks to avoid a
branch via function pointer since the cache ops are pretty "hot", but if
that ever happens, I'll do that via asm patching tricks I suppose.

Now regarding the line size, I would recommend using the device-tree to
describe the cache instead rather than a config option. The intend is to
be able to build a single binary kernel that can boot multiple variants
of 44x.

I may eventually rewrite your patch around those ideas next week if you
don't feel like doing it -and- I get bored :-)

Cheers,
Ben.
