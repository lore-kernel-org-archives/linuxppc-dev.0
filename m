Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vMpzH5TQQzDqBn
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 15:17:15 +1100 (AEDT)
Message-ID: <1487045836.21048.25.camel@neuling.org>
Subject: Re: [PATCH 1/3] powerpc/mm/radix: Update pte update sequence for
 pte clear case
From: Michael Neuling <mikey@neuling.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
Date: Tue, 14 Feb 2017 15:17:16 +1100
In-Reply-To: <1486609101-5231-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1486609101-5231-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-02-09 at 08:28 +0530, Aneesh Kumar K.V wrote:
> In the kernel we do follow the below sequence in different code paths.
> pte =3D ptep_get_clear(ptep)
> ....
> set_pte_at(ptep, pte)
>=20
> We do that for mremap, autonuma protection update and softdirty clearing.=
 This
> implies our optimization to skip a tlb flush when clearing a pte update i=
s
> not valid, because for DD1 system that followup set_pte_at will be done w=
itout
> doing the required tlbflush. Fix that by always doing the dd1 style pte u=
pdate
> irrespective of new_pte value. In a later patch we will optimize the
> application
> exit case.
>=20
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

Tested-by: Michael Neuling <mikey@neuling.org>

> ---
> =C2=A0arch/powerpc/include/asm/book3s/64/radix.h | 12 +++---------
> =C2=A01 file changed, 3 insertions(+), 9 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/book3s/64/radix.h
> b/arch/powerpc/include/asm/book3s/64/radix.h
> index b4d1302387a3..70a3cdcdbe47 100644
> --- a/arch/powerpc/include/asm/book3s/64/radix.h
> +++ b/arch/powerpc/include/asm/book3s/64/radix.h
> @@ -144,16 +144,10 @@ static inline unsigned long radix__pte_update(struc=
t
> mm_struct *mm,
> =C2=A0		=C2=A0* new value of pte
> =C2=A0		=C2=A0*/
> =C2=A0		new_pte =3D (old_pte | set) & ~clr;
> -		/*
> -		=C2=A0* If we are trying to clear the pte, we can skip
> -		=C2=A0* the below sequence and batch the tlb flush. The
> -		=C2=A0* tlb flush batching is done by mmu gather code
> -		=C2=A0*/
> -		if (new_pte) {
> -			asm volatile("ptesync" : : : "memory");
> -			radix__flush_tlb_pte_p9_dd1(old_pte, mm, addr);
> +		asm volatile("ptesync" : : : "memory");
> +		radix__flush_tlb_pte_p9_dd1(old_pte, mm, addr);
> +		if (new_pte)
> =C2=A0			__radix_pte_update(ptep, 0, new_pte);
> -		}
> =C2=A0	} else
> =C2=A0		old_pte =3D __radix_pte_update(ptep, clr, set);
> =C2=A0	asm volatile("ptesync" : : : "memory");
