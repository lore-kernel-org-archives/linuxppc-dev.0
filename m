Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A9F4E679E7
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Mar 2006 15:26:15 +1100 (EST)
Subject: Re: [PATCH] PowerMac11,2 i2c-bus@0 duplicate dev-tree workaround
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Johannes Berg <johannes@sipsolutions.net>
In-Reply-To: <1143631816.9481.5.camel@localhost>
References: <1143631816.9481.5.camel@localhost>
Content-Type: text/plain
Date: Thu, 30 Mar 2006 15:26:04 +1100
Message-Id: <1143692765.16706.10.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> +		/* so if the workaround is in effect, and we have the right
> +		 * node found, we increase the workaround count (we use the
> +		 * same variable) and then set allnextpp to NULL on the second
> +		 * one around so the node isn't added to the allnodes list */
> +		if (powermac_i2c_bus_0_workaround &&
> +		    strcmp(np->full_name,
> +		           "/ht@0,f2000000/pci@8/mac-io@7/i2c@18000/i2c-bus@0") == 0) {
> +			powermac_i2c_bus_0_workaround++;
> +			if (powermac_i2c_bus_0_workaround == 3)
> +				allnextpp = NULL;
> +		}
> +		if (allnextpp) {
> +			**allnextpp = np;
> +			*allnextpp = &np->allnext;
> +			if (dad != NULL) {
> +				np->parent = dad;
> +				/* we temporarily use the next field as `last_child'*/
> +				if (dad->next == 0)
> +					dad->child = np;
> +				else
> +					dad->next->sibling = np;
> +				dad->next = np;
> +			}
>  		}
>  		kref_init(&np->kref);
>  	}

Hrm... you set allnextpp to NULL ... won't that prevent any further node
from being enqueued in the global node list ?

In fact, I think the workaround should be in prom_init.c when
flattening... easier to skip a node there, and that's also where you are
reasonably sure of getting the nodes in the right order, not when
unflattening. 

Also, you don't even need to test for PowerMac11,2 .. .prom_init.c
already has a machine type, so just test that it's a mac and has this
node duplicated, and if yes, remove the dup. In fact, you could probably
even run a bit of forth with "interpret" to do so before the tree is
even walked though :)

Ben.
