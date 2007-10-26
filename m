Return-Path: <davem@davemloft.net>
Received: from picasso.davemloft.net (unknown [74.93.104.98])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 87786DDDF6
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Oct 2007 20:38:37 +1000 (EST)
Date: Fri, 26 Oct 2007 03:38:03 -0700 (PDT)
Message-Id: <20071026.033803.74739006.davem@davemloft.net>
To: michael@ellerman.id.au
Subject: Re: [PATCH 01/16] Add of_get_next_parent()
From: David Miller <davem@davemloft.net>
In-Reply-To: <80449d4682309dbf8cf80816be4f381fe875f3d1.1193381582.git.michael@ellerman.id.au>
References: <80449d4682309dbf8cf80816be4f381fe875f3d1.1193381582.git.michael@ellerman.id.au>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Michael Ellerman <michael@ellerman.id.au>
Date: Fri, 26 Oct 2007 16:54:31 +1000 (EST)

> Iterating through a device node's parents is simple enough, but dealing
> with the refcounts properly is a little ugly, and replicating that logic
> is asking for someone to get it wrong or forget it all together, eg:
> 
> while (dn != NULL) {
> 	/* loop body */
> 	tmp = of_get_parent(dn);
> 	of_node_put(dn);
> 	dn = tmp;
> }
> 
> So add of_get_next_parent(), inspired by of_get_next_child(). The contract
> is that it returns the parent and drops the reference on the current node,
> this makes the loop look like:
> 
> while (dn != NULL) {
> 	/* loop body */
> 	dn = of_get_next_parent(dn);
> }
> 
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>

Looks good to me:

Acked-by: David S. Miller <davem@davemloft.net>
