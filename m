Return-Path: <mgreer@mvista.com>
Received: from zipcode.az.mvista.com (unknown [65.200.49.156])
	by ozlabs.org (Postfix) with ESMTP id E1B89DDF08
	for <linuxppc-dev@ozlabs.org>; Wed, 16 May 2007 04:07:53 +1000 (EST)
Date: Tue, 15 May 2007 11:08:05 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Paul Mackerras <paulus@samba.org>, "Mark A. Greer" <mgreer@mvista.com>,
	linuxppc-dev@ozlabs.org
Subject: Re: Fix bug adding properties with flatdevtree.c's ft_set_prop()
Message-ID: <20070515180805.GC17643@mag.az.mvista.com>
References: <20070514031357.GM6517@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070514031357.GM6517@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, May 14, 2007 at 01:13:57PM +1000, David Gibson wrote:
> ft_set_prop() from flatdevtree.c in the zImage wrapper will either
> replace an existing property in the flat device tree, or add a new
> property definiion if the given property isn't present.
> 
> However, when adding properties, it adds the property definition
> immediately before the node's END_NODE tag, potentially after any
> subnode definitions for the node.  This confuses the kernel flat tree
> parser in prom.c which assumes that all property definitions for a
> node come before all subnode definitions.

Oops. :)

> This patch corrects ft_set_prop() so that it adds new properties
> before the first subnode, instead of before the END_NODE tag.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Acked-by: Mark A. Greer <mgreer@mvista.com>
