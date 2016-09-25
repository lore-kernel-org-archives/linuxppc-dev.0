Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3shc4b31JPzDrHl
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 25 Sep 2016 16:04:31 +1000 (AEST)
Date: Sun, 25 Sep 2016 01:04:01 -0500
From: Scott Wood <oss@buserror.net>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Zhao Qiang <qiang.zhao@nxp.com>, "David S. Miller" <davem@davemloft.net>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Message-ID: <20160925060401.GA30936@home.buserror.net>
References: <20160816062620.41D9C1A2456@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160816062620.41D9C1A2456@localhost.localdomain>
Subject: Re: [v2] soc: fsl/qe: fix Oops on CPM1 (and likely CPM2)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Aug 16, 2016 at 08:26:20AM +0200, Christophe Leroy wrote:
> fixes: 0e6e01ff694ee ("CPM/QE: use genalloc to manage CPM/QE muram")
> Cc: stable@vger.linux.org
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
[snip]
>  	muram_pbase = of_translate_address(np, zero);
>  	if (muram_pbase == (phys_addr_t)OF_BAD_ADDR) {
> -		pr_err("Cannot translate zero through CPM muram node");
> +		pr_err("Cannot translate zero through CPM/QE muram node");
>  		ret = -ENODEV;
>  		goto out_pool;
>  	}
> @@ -83,14 +88,14 @@ int cpm_muram_init(void)
>  		ret = gen_pool_add(muram_pool, r.start - muram_pbase +
>  				   GENPOOL_OFFSET, resource_size(&r), -1);
>  		if (ret) {
> -			pr_err("QE: couldn't add muram to pool!\n");
> +			pr_err("CPM/QE: couldn't add muram to pool!\n");
>  			goto out_pool;
>  		}
>  	}
>  
>  	muram_vbase = ioremap(muram_pbase, max - muram_pbase + 1);
>  	if (!muram_vbase) {
> -		pr_err("Cannot map QE muram");
> +		pr_err("Cannot map CPM/QE muram");
>  		ret = -ENOMEM;
>  		goto out_pool;
>  	}

These string changes are not related to the bugfix.  Particularly since
this is aimed at stable, I'm removing this part of the patch when
applying.

-Scott
