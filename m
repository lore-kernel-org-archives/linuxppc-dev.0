Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3C2BCDDF53
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Dec 2008 10:11:40 +1100 (EST)
Subject: Re: [PATCH 1/3] add of_find_next_cache_node()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nathan Lynch <ntl@pobox.com>
In-Reply-To: <1228956366-17593-1-git-send-email-ntl@pobox.com>
References: <1228956366-17593-1-git-send-email-ntl@pobox.com>
Content-Type: text/plain
Date: Mon, 15 Dec 2008 10:11:27 +1100
Message-Id: <1229296287.26324.87.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2008-12-10 at 18:46 -0600, Nathan Lynch wrote:
> +       /* OF on pmac has nodes instead of properties named "l2-cache"
> +        * beneath CPU nodes.
> +        */
> +       if (!strcmp(np->type, "cpu"))
> +               for_each_child_of_node(np, child)
> +                       if (!strcmp(child->type, "cache"))
> +                               return child;
> +

pmac has both actually. And the property points to the node. It's a
problem for /proc/device-tree so we rename them iirc, but only in /proc,
ie, they should still be intact in the tree I think.

Cheers,
Ben.
