Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xGHy40FJkzDrG1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Jul 2017 20:42:36 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Laurent Vivier <lvivier@redhat.com>, linux-kernel@vger.kernel.org
Cc: David Gibson <david@gibson.dropbear.id.au>, linuxppc-dev@lists.ozlabs.org,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH] powerpc/pseries: Fix of_node_put() underflow during
 pseries remove
In-Reply-To: <20170721145139.9384-1-lvivier@redhat.com>
References: <20170721145139.9384-1-lvivier@redhat.com>
Date: Mon, 24 Jul 2017 20:42:34 +1000
Message-ID: <87tw22jeud.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Laurent Vivier <lvivier@redhat.com> writes:

> As for commit 68baf692c435 ("powerpc/pseries: Fix of_node_put()
> underflow during DLPAR remove"), the call to of_node_put()
> must be removed from pSeries_reconfig_remove_node().
>
> dlpar_detach_node() and pSeries_reconfig_remove_node() call
> of_detach_node(), and thus the node should not be released
> in this case too.
>
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---
>  arch/powerpc/platforms/pseries/reconfig.c | 1 -
>  1 file changed, 1 deletion(-)

Thanks. I'll spare you the swearing about why we have the same bug in
two places.

As for the other fix, I'll add:

Fixes: 0829f6d1f69e ("of: device_node kobject lifecycle fixes")
Cc: stable@vger.kernel.org # v3.15+

cheers

> diff --git a/arch/powerpc/platforms/pseries/reconfig.c b/arch/powerpc/platforms/pseries/reconfig.c
> index e5bf1e8..011ef21 100644
> --- a/arch/powerpc/platforms/pseries/reconfig.c
> +++ b/arch/powerpc/platforms/pseries/reconfig.c
> @@ -82,7 +82,6 @@ static int pSeries_reconfig_remove_node(struct device_node *np)
>  
>  	of_detach_node(np);
>  	of_node_put(parent);
> -	of_node_put(np); /* Must decrement the refcount */
>  	return 0;
>  }
>  
> -- 
> 2.9.4
