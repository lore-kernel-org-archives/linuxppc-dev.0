Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vSmYl05V0zDq5g
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 16:45:47 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/mm: Add translation mode information in
 /proc/cpuinfo
In-Reply-To: <1487499469-15284-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1487499469-15284-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Date: Wed, 22 Feb 2017 16:45:46 +1100
Message-ID: <874lzmn5h1.fsf@concordia.ellerman.id.au>
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

"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:

> With this we have on powernv and pseries /proc/cpuinfo reporting
>
> timebase        : 512000000
> platform        : PowerNV
> model           : 8247-22L
> machine         : PowerNV 8247-22L
> firmware        : OPAL
> translation     : Hash
>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>  arch/powerpc/platforms/powernv/setup.c | 4 ++++
>  arch/powerpc/platforms/pseries/setup.c | 4 ++++
>  2 files changed, 8 insertions(+)
>
> diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platforms/powernv/setup.c
> index d50c7d99baaf..d38571e289bb 100644
> --- a/arch/powerpc/platforms/powernv/setup.c
> +++ b/arch/powerpc/platforms/powernv/setup.c
> @@ -95,6 +95,10 @@ static void pnv_show_cpuinfo(struct seq_file *m)
>  	else
>  		seq_printf(m, "firmware\t: BML\n");
>  	of_node_put(root);
> +	if (radix_enabled())
> +		seq_printf(m, "translation\t: Radix\n");
> +	else
> +		seq_printf(m, "translation\t: Hash\n");
>  }

Can we just call it "MMU" ?

I don't think it's entirely clear what "translation" means here if you
don't already know.

cheers
