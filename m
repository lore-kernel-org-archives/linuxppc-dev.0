Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 4DC4F67B67
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Sep 2006 18:20:13 +1000 (EST)
Date: Sat, 16 Sep 2006 18:20:22 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Vitaly Bordug <vbordug@ru.mvista.com>
Subject: Re: [PATCH 1/7] POWERPC: Add cpm2 stuff support to the fsl_soc.c
Message-Id: <20060916182022.5ef8c0fe.sfr@canb.auug.org.au>
In-Reply-To: <20060915173857.7984.36024.stgit@localhost.localdomain>
References: <20060915213751.128e85f3@localhost.localdomain>
	<20060915173857.7984.36024.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Vitaly,

Just a few nits ...

On Fri, 15 Sep 2006 21:38:57 +0400 Vitaly Bordug <vbordug@ru.mvista.com> wrote:
>
> +#ifdef CONFIG_CPM2
> +#include <asm/cpm2.h>
> +#endif

We normally don't do conditional includes, the include file should
protect its contents (if that is necessary - it usually isn't).

> +		unsigned int *prop = (unsigned int*)get_property(node, "brg-frequency", &size);

get_property returns "const void *" so no cast is necessary, but prop
should be declated "const unsigned int *".

> +		unsigned int *prop = (unsigned int*)get_property(node, "current-speed", &size);

Ditto.

> +static const char *fcc_regs = "fcc_regs";
> +static const char *fcc_regs_c = "fcc_regs_c";
> +static const char *fcc_pram = "fcc_pram";

I think that these could be declared as const char [].

> +		model = (char *)get_property(np, "model", NULL);
> +		mac_addr = (void *)get_property(np, "mac-address", NULL);
> +		ph = (phandle *) get_property(np, "phy-handle", NULL);
> +		phy_addr = (u32 *) get_property(phy, "reg", NULL);
> +		id = (u32 *) get_property(np, "device-id", NULL);

Same comments about const and void * with respect to get_property.  There
are more ...

> +static const char *scc_regs = "regs";
> +static const char *scc_pram = "pram";

const char [] ?

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
