Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 690831A0567
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Dec 2014 11:39:57 +1100 (AEDT)
Message-ID: <1417480795.31336.4.camel@concordia>
Subject: Re: [PATCH 2/2] powerpc/mm: don't do tlbie for updatepp request
 with NO HPTE fault
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Tue, 02 Dec 2014 11:39:55 +1100
In-Reply-To: <1415026295-25965-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1415026295-25965-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1415026295-25965-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2014-11-03 at 20:21 +0530, Aneesh Kumar K.V wrote:
> upatepp get called for a nohpte fault, when we find from the linux
> page table that the translation was hashed before. In that case
> we are sure that there is no existing translation, hence we could
> avoid doing tlbie.

We are sure there *was* no existing translation. It's possible that since the
nohpte fault occurred the translation has been loaded into the tlb.

Ben says that's OK, because updatepp is only ever relaxing permissions. But
please add some explanation of that to the changelog - it's not obvious.

> @@ -322,8 +322,15 @@ static long native_hpte_updatepp(unsigned long slot, unsigned long newpp,
>  		}
>  		native_unlock_hpte(hptep);
>  	}
> -	/* Ensure it is out of the tlb too. */
> -	tlbie(vpn, bpsize, apsize, ssize, local);
> +
> +	if (flags & HPTE_LOCAL_UPDATE)
> +		local = 1;
> +	/*
> +	 * Ensure it is out of the tlb too if it is not a nohpte fault
> +	 */
> +	if (!(flags & HPTE_NOHPTE_UPDATE))
> +		tlbie(vpn, bpsize, apsize, ssize, local);
> +
>  	return ret;
>  }

The context preceeding this hunk includes this comment:

	/*
	 * We need to invalidate the TLB always because hpte_remove doesn't do
	 * a tlb invalidate. If a hash bucket gets full, we "evict" a more/less
	 * random entry from it. When we do that we don't invalidate the TLB
	 * (hpte_remove) because we assume the old translation is still
	 * technically "valid".
	 */

Which seems out of sync with the code now.

cheers
