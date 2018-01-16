Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zLFkg3Pr0zF0Z2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jan 2018 14:16:59 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Michal Suchanek <msuchanek@suse.de>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Philippe
 Ombredanne <pombredanne@nexb.com>, =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>, Thomas Falcon
 <tlfalcon@linux.vnet.ibm.com>, Michal Suchanek <msuchanek@suse.de>, "Tobin
 C. Harding" <me@tobin.cc>, Michael Neuling <mikey@neuling.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/pseries: include linux/types.h in asm/hvcall.h
In-Reply-To: <20180115133003.3447-1-msuchanek@suse.de>
References: <20180115133003.3447-1-msuchanek@suse.de>
Date: Tue, 16 Jan 2018 14:16:58 +1100
Message-ID: <87wp0ia3x1.fsf@concordia.ellerman.id.au>
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

Michal Suchanek <msuchanek@suse.de> writes:

> Commit 6e032b350cd1 ("powerpc/powernv: Check device-tree for RFI flush
> settings") uses u64 in asm/hvcall.h without including linux/types.h
>
> This breaks hvcall.h users that do not include the header themselves.
>
> Fixes: 6e032b350cd1 ("powerpc/powernv: Check device-tree for RFI flush
>     settings")
>
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> ---
>  arch/powerpc/include/asm/hvcall.h | 1 +
>  1 file changed, 1 insertion(+)

Thanks. None of my ~250 defconfig test builds hit this, what config are
you using?

cheers

> diff --git a/arch/powerpc/include/asm/hvcall.h b/arch/powerpc/include/asm/hvcall.h
> index f0461618bf7b..eca3f9c68907 100644
> --- a/arch/powerpc/include/asm/hvcall.h
> +++ b/arch/powerpc/include/asm/hvcall.h
> @@ -353,6 +353,7 @@
>  #define PROC_TABLE_GTSE		0x01
>  
>  #ifndef __ASSEMBLY__
> +#include <linux/types.h>
>  
>  /**
>   * plpar_hcall_norets: - Make a pseries hypervisor call with no return arguments
> -- 
> 2.13.6
