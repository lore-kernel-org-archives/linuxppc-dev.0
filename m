Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [184.105.139.130])
 by lists.ozlabs.org (Postfix) with ESMTP id 3srXqR6zp3zDrWK
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Oct 2016 15:05:39 +1100 (AEDT)
Date: Sat, 08 Oct 2016 00:05:26 -0400 (EDT)
Message-Id: <20161008.000526.415379645974882301.davem@davemloft.net>
To: christophe.jaillet@wanadoo.fr
Cc: qiang.zhao@nxp.com, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] wan/fsl_ucc_hdlc: Fix size used in dma_free_coherent()
From: David Miller <davem@davemloft.net>
In-Reply-To: <1475873927-14999-1-git-send-email-christophe.jaillet@wanadoo.fr>
References: <1475873927-14999-1-git-send-email-christophe.jaillet@wanadoo.fr>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Date: Fri,  7 Oct 2016 22:58:47 +0200

> Size used with 'dma_alloc_coherent()' and 'dma_free_coherent()' should be
> consistent.
> Here, the size of a pointer is used in dma_alloc... and the size of the
> pointed structure is used in dma_free...
> 
> This has been spotted with coccinelle, using the following script:
> ////////////////////
> @r@
> expression x0, x1, y0, y1, z0, z1, t0, t1, ret;
> @@
> 
> *   ret = dma_alloc_coherent(x0, y0, z0, t0);
>     ...
> *   dma_free_coherent(x1, y1, ret, t1);
> 
> 
> @script:python@
> y0 << r.y0;
> y1 << r.y1;
> 
> @@
> if y1.find(y0) == -1:
>  print "WARNING: sizes look different:  '%s'   vs   '%s'" % (y0, y1)
> ////////////////////
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Looks good to me, applied, thanks.
