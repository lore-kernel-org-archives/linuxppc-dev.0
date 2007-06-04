Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2DC64DE083
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Jun 2007 08:44:31 +1000 (EST)
Subject: Re: [PATCH 3/4] Add for_each_compatible_node()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <michael@ellerman.id.au>
In-Reply-To: <ddbfea5b1932c224845e3441b115cf7c3e495deb.1180961962.git.michael@ellerman.id.au>
References: <f0cd638495b96585dec513f41335154e60675813.1180961962.git.michael@ellerman.id.au>
	<ddbfea5b1932c224845e3441b115cf7c3e495deb.1180961962.git.michael@ellerman.id.au>
Content-Type: text/plain
Date: Tue, 05 Jun 2007 08:44:23 +1000
Message-Id: <1180997063.31677.83.camel@localhost.localdomain>
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

On Mon, 2007-06-04 at 23:00 +1000, Michael Ellerman wrote:
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> ---
>  include/asm-powerpc/prom.h |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/include/asm-powerpc/prom.h b/include/asm-powerpc/prom.h
> index 6845af9..1122a92 100644
> --- a/include/asm-powerpc/prom.h
> +++ b/include/asm-powerpc/prom.h
> @@ -124,6 +124,9 @@ extern struct device_node *of_find_node_by_type(struct device_node *from,
>  	     dn = of_find_node_by_type(dn, type))
>  extern struct device_node *of_find_compatible_node(struct device_node *from,
>  	const char *type, const char *compat);
> +#define for_each_compatible_node(dn, type, compatible) \
> +	for (dn = of_find_compatible_node(NULL, type, compatible); dn; \
> +	     dn = of_find_compatible_node(dn, type, compatible))
>  extern struct device_node *of_find_node_by_path(const char *path);
>  extern struct device_node *of_find_node_by_phandle(phandle handle);
>  extern struct device_node *of_find_all_nodes(struct device_node *prev);
