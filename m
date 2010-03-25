Return-Path: <srajiv@linux.vnet.ibm.com>
Received: from e24smtp02.br.ibm.com (e24smtp02.br.ibm.com [32.104.18.86])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e24smtp02.br.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A19C6B7CBB
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Mar 2010 15:20:49 +1100 (EST)
Received: from mailhub1.br.ibm.com (mailhub1.br.ibm.com [9.18.232.109])
	by e24smtp02.br.ibm.com (8.14.3/8.13.1) with ESMTP id o2P4cUbR018422
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Mar 2010 01:38:30 -0300
Received: from d24av02.br.ibm.com (d24av02.br.ibm.com [9.8.31.93])
	by mailhub1.br.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o2P4Nvnh884802
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Mar 2010 01:23:57 -0300
Received: from d24av02.br.ibm.com (loopback [127.0.0.1])
	by d24av02.br.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o2P1KgZT014182
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Mar 2010 22:20:42 -0300
Subject: Re: [tpmdd-devel] [PATCH] TPM: Provide a tpm_tis OF driver
From: Rajiv Andrade <srajiv@linux.vnet.ibm.com>
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
In-Reply-To: <20100309200135.GF30462@obsidianresearch.com>
References: <20100309200135.GF30462@obsidianresearch.com>
Content-Type: text/plain
Date: Thu, 25 Mar 2010 01:20:41 -0300
Message-Id: <1269490841.12676.32.camel@blackbox.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, tpmdd-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Just a minor comment

On Tue, 2010-03-09 at 13:01 -0700, Jason Gunthorpe wrote:

> @@ -703,7 +747,17 @@ static int __init init_tis(void)
>  		return rc;
>  	}
> 
> -	return pnp_register_driver(&tis_pnp_driver);
> +#ifdef CONFIG_OF
> +	rc = of_register_platform_driver(&tis_of_driver);
> +	if (rc)
> +		return rc;
> +#endif
> +#ifdef CONFIG_PNP
> +	rc = pnp_register_driver(&tis_pnp_driver);
> +	if (rc)
> +		return rc;
> +#endif
> +	return 0;
>  }
> 

Why not 

+#ifdef CONFIG_OF
+	return of_register_platform_driver(&tis_of_driver);
+#elif CONFIG_PNP
+	return pnp_register_driver(&tis_pnp_driver);
+#endif

?

Other than this it looks nice.

Acked-by: Rajiv Andrade <srajiv@linux.vnet.ibm.com>


Thanks,
Rajiv
