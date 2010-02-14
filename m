Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C83D2B7DB2
	for <linuxppc-dev@ozlabs.org>; Sun, 14 Feb 2010 17:36:18 +1100 (EST)
Subject: Re: [PATCH 3/9] of: protect linux/of.h with CONFIG_OF
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <20100213160242.4767.57641.stgit@angua>
References: <20100213154838.4767.83881.stgit@angua>
	<20100213160242.4767.57641.stgit@angua>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 14 Feb 2010 17:10:34 +1100
Message-ID: <1266127834.16346.60.camel@pasglop>
Mime-Version: 1.0
Cc: sfr@canb.auug.org.au, monstr@monstr.eu, microblaze-uclinux@itee.uq.edu.au,
	devicetree-discuss@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	sparclinux@vger.kernel.org, jeremy.kerr@canonical.com, davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2010-02-13 at 09:02 -0700, Grant Likely wrote:
> From: Jeremy Kerr <jeremy.kerr@canonical.com>
> 
> For platforms that have CONFIG_OF optional, we need to make the contents
> of linux/of.h conditional on CONFIG_OF.
> 
> Signed-off-by: Jeremy Kerr <jeremy.kerr@canonical.com>
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

For now...

In the long run, maybe we want some of the iterators to be empty inlines
returning NULL ?

Cheers,
Ben.

> ---
> 
>  include/linux/of.h |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/include/linux/of.h b/include/linux/of.h
> index 5c7b6a6..48b0ee6 100644
> --- a/include/linux/of.h
> +++ b/include/linux/of.h
> @@ -22,6 +22,8 @@
>  
>  #include <asm/byteorder.h>
>  
> +#ifdef CONFIG_OF
> +
>  typedef u32 phandle;
>  typedef u32 ihandle;
>  
> @@ -194,4 +196,5 @@ extern void of_attach_node(struct device_node *);
>  extern void of_detach_node(struct device_node *);
>  #endif
>  
> +#endif /* CONFIG_OF */
>  #endif /* _LINUX_OF_H */
