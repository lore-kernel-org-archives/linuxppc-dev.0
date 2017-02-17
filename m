Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vPpd80WRpzDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Feb 2017 21:08:26 +1100 (AEDT)
Message-ID: <1487326104.5636.47.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: laurentiu.tudor@nxp.com, linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au
Cc: madalin.bucur@nxp.com, aneesh.kumar@linux.vnet.ibm.com
Date: Fri, 17 Feb 2017 04:08:24 -0600
In-Reply-To: <20170216151129.8971-1-laurentiu.tudor@nxp.com>
References: <20170216151129.8971-1-laurentiu.tudor@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [PATCH] powerpc: booke: fix boot crash due to null hugepd
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-02-16 at 09:11 -0600, laurentiu.tudor@nxp.com wrote:
> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> 
> On 32-bit book-e machines, hugepd_ok() does not take
> into account null hugepd values, causing this crash at boot:

Why only 32-bit?

> diff --git a/arch/powerpc/include/asm/nohash/pgtable.h
> b/arch/powerpc/include/asm/nohash/pgtable.h
> index 0cd8a38..e5805ad 100644
> --- a/arch/powerpc/include/asm/nohash/pgtable.h
> +++ b/arch/powerpc/include/asm/nohash/pgtable.h
> @@ -230,7 +230,7 @@ static inline int hugepd_ok(hugepd_t hpd)
>  	return ((hpd_val(hpd) & 0x4) != 0);
>  #else
>  	/* We clear the top bit to indicate hugepd */
> -	return ((hpd_val(hpd) & PD_HUGE) ==  0);
> +	return (hpd_val(hpd) && (hpd_val(hpd) & PD_HUGE) == 0);
>  #endif
>  }
>  

Any reason why this can't go back to being "hpd_val(hpd) > 0"?  Why was nohash
changed to begin with?  I don't expect nohash (or at least fsl-book3e) will
ever have a pagetable that is not native-endian, and "> 0" is consistent with
what the TLB miss code is doing.

Also, the patch that broke this was tagged for stable (which again raises the
question of why an extraneous change was made) so this patch needs to be as
well.

-Scott
