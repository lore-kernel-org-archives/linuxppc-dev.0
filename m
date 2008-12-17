Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EAA3DDDED1
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Dec 2008 03:13:29 +1100 (EST)
Message-Id: <80757AFB-C188-43CC-BBA6-E6446EAA7474@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Guillaume Knispel <gknispel@proformatique.com>
In-Reply-To: <20081209152834.1d6ff291@xilun.lan.proformatique.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH] Fix corruption error in rh_alloc_fixed()
Date: Wed, 17 Dec 2008 10:11:20 -0600
References: <20081209152834.1d6ff291@xilun.lan.proformatique.com>
Cc: linuxppc-dev@ozlabs.org, Pantelis Antoniou <pantelis@embeddedalley.com>,
	Li Yang <leoli@freescale.com>, Timur Tabi <timur@freescale.com>,
	Joakim Tjernlund <joakim.tjernlund@transmode.se>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Dec 9, 2008, at 8:28 AM, Guillaume Knispel wrote:

> There is an error in rh_alloc_fixed() of the Remote Heap code:
> If there is at least one free block blk won't be NULL at the end of  
> the
> search loop, so -ENOMEM won't be returned and the else branch of
> "if (bs == s || be == e)" will be taken, corrupting the management
> structures.
>
> Signed-off-by: Guillaume Knispel <gknispel@proformatique.com>
> ---
> Fix an error in rh_alloc_fixed() that made allocations succeed when
> they should fail, and corrupted management structures.
>
> diff --git a/arch/powerpc/lib/rheap.c b/arch/powerpc/lib/rheap.c
> index 29b2941..45907c1 100644
> --- a/arch/powerpc/lib/rheap.c
> +++ b/arch/powerpc/lib/rheap.c
> @@ -556,6 +556,7 @@ unsigned long rh_alloc_fixed(rh_info_t * info,  
> unsigned long start, int size, co
> 		be = blk->start + blk->size;
> 		if (s >= bs && e <= be)
> 			break;
> +		blk = NULL;
> 	}
>
> 	if (blk == NULL)

applied

- k
