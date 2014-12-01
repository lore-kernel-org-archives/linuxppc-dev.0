Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BF63E1A0920
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Dec 2014 10:59:51 +1100 (AEDT)
Message-ID: <1417478377.7182.17.camel@kernel.crashing.org>
Subject: Re: [PATCH 2/2] powerpc/mm: don't do tlbie for updatepp request
 with NO HPTE fault
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Tue, 02 Dec 2014 10:59:37 +1100
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
> --- a/arch/powerpc/mm/hash_native_64.c
> +++ b/arch/powerpc/mm/hash_native_64.c
> @@ -283,11 +283,11 @@ static long native_hpte_remove(unsigned long hpte_group)
>  
>  static long native_hpte_updatepp(unsigned long slot, unsigned long newpp,
>                                  unsigned long vpn, int bpsize,
> -                                int apsize, int ssize, int local)
> +                                int apsize, int ssize, unsigned long flags)
>  {
>         struct hash_pte *hptep = htab_address + slot;
>         unsigned long hpte_v, want_v;
> -       int ret = 0;
> +       int ret = 0, local = 0;
>  
>         want_v = hpte_encode_avpn(vpn, bpsize, ssize);
>  
> @@ -322,8 +322,15 @@ static long native_hpte_updatepp(unsigned long slot, unsigned long newpp,
>                 }
>                 native_unlock_hpte(hptep);
>         }
> -       /* Ensure it is out of the tlb too. */
> -       tlbie(vpn, bpsize, apsize, ssize, local);
> +
> +       if (flags & HPTE_LOCAL_UPDATE)
> +               local = 1;
> +       /*
> +        * Ensure it is out of the tlb too if it is not a nohpte fault
> +        */
> +       if (!(flags & HPTE_NOHPTE_UPDATE))
> +               tlbie(vpn, bpsize, apsize, ssize, local);
> +
>         return ret;
>  }

An additional refinement we discussed that I'd like you to test/measure
is to basically always be local for updatepp unless we have a flag that
forces us not to.

That flag would be set by copro faults only.

Can you do something on top of this series ?

Cheers,
Ben.
