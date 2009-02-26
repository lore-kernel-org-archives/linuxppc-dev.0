Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 74FD3DDED1
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Feb 2009 22:34:24 +1100 (EST)
Date: Thu, 26 Feb 2009 03:34:06 -0800 (PST)
Message-Id: <20090226.033406.60071032.davem@davemloft.net>
To: anton@samba.org
Subject: Re: [PATCH] Enable hashdist by default on 64bit NUMA
From: David Miller <davem@davemloft.net>
In-Reply-To: <20090226112431.GA25330@kryten>
References: <20090220051956.GE32195@kryten>
	<20090220.000354.198880712.davem@davemloft.net>
	<20090226112431.GA25330@kryten>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Anton Blanchard <anton@samba.org>
Date: Thu, 26 Feb 2009 22:24:32 +1100

> On PowerPC we allocate large boot time hashes on node 0. This leads to
> an imbalance in the free memory, for example on a 64GB box (4 x 16GB
> nodes):
> 
> Free memory:
> Node 0: 97.03%
> Node 1: 98.54%
> Node 2: 98.42%
> Node 3: 98.53%
> 
> If we switch to using vmalloc (like ia64 and x86-64) things are more
> balanced:
> 
> Free memory:
> Node 0: 97.53%
> Node 1: 98.35%
> Node 2: 98.33%
> Node 3: 98.33%
> 
> For many HPC applications we are limited by the free available memory on
> the smallest node, so even though the same amount of memory is used the
> better balancing helps.
> 
> Since all 64bit NUMA capable architectures should have sufficient
> vmalloc space, it makes sense to enable it via CONFIG_64BIT.
> 
> Signed-off-by: Anton Blanchard <anton@samba.org>

Acked-by: David S. Miller <davem@davemloft.net>
